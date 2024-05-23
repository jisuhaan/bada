package com.ezen.bada.weathers;


import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class SeaInfoController {
	
	@Autowired
	SqlSession sqlsession;

	@RequestMapping(value = "/sea_info")
	public String sea_info1() {
			
		return "sea_info";

	}
	
	@RequestMapping(value = "/search_city")
	public String sea_main_search1(HttpServletRequest request, Model mo) {
		
		String city = request.getParameter("city");
		Service ss = sqlsession.getMapper(Service.class);
		System.out.println("시군이름은? : "+city);
		
		ArrayList<Bada_info_DTO> list = ss.getcitybeach(city);
		System.out.println("시군 바다리스트 : "+list);
		mo.addAttribute("list",list);
		
		return "search_city";	
	}

	//지역에 해당하는 바다 이름 리스트를 뽑아옵니다.
	@ResponseBody
	@RequestMapping(value = "/bada_listup", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	public String sea_info2(String area) throws JsonProcessingException {
	   
		Service ss = sqlsession.getMapper(Service.class);
		System.out.println("지역 뽑혀왔니? : "+area);
		   
		List<Bada_default_DTO> badalist;
		   
		if(area.equals("부울")) { 
			String area1 = "부산";
			String area2 = "울산";
			System.out.println("area1 : "+area1+", area2 : "+area2);
			badalist = ss.getbadalist2(area1,area2);   
		}
		   
		else if(area.equals("경인")) {
			String area1 = "경기";
			String area2 = "인천";
			badalist = ss.getbadalist2(area1,area2);
		}
		   
		else {
			badalist = ss.getbadalist(area);
		}
		   
		ObjectMapper om =  new ObjectMapper();
		String bada_list = om.writeValueAsString(badalist);
			  
		System.out.println("바다리스트 뽑혀왔니? : "+badalist);
		System.out.println("json화 되었니? : "+bada_list);
		
		return bada_list;
   }
	   
	   
	//지역별 해수욕장 리스트에서 해수욕장을 선택하면, 해당 해수욕장 기본 정보 페이지로 이동합니다
	@RequestMapping(value = "/sea_result")
	public String sea_info3(HttpServletRequest request, Model mo) {
		
		int beach_code = Integer.parseInt(request.getParameter("beach_code"));
		Service ss = sqlsession.getMapper(Service.class);
		ss.viewcountUp(beach_code);
		
		//해변코드로 db에 마련된 해변정보(주소, 설명 등)들을 불러옵니다.
		Bada_info_DTO bdt = ss.getbeachinfo(beach_code);
		
		//해변코드로 db에 마련된 개폐장정보를 가져오고 attribute
		Date currentDate = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("MMdd");
        String dateString = sdf.format(currentDate);
        int currentDateInt = Integer.parseInt(dateString);
        System.out.println("현재날짜"+currentDateInt);
        
        String startday = ss.startday(beach_code);
        int startd = Integer.parseInt(startday);
        String endday = ss.endday(beach_code);
        int endd = Integer.parseInt(endday);
        String openstate= "";
        
        if (currentDateInt >= startd && currentDateInt <= endd) {
            // 개장중
        	openstate = "개장중";
        } else {
            // 개장전
        	openstate = "개장전";
        }
        mo.addAttribute("openstate",openstate);
        System.out.println("개장여부"+openstate);
		
		
		//해변코드로 db에 마련된 위도경도를 불러옵니다.
		mo.addAttribute("bdt",bdt);
		System.out.println("불러와진 해변이름 : "+bdt.getBeach_name());
		
		// Bada_default_DTO -> Bada_list 테이블에서 특정 해수욕장 정보 가져오기
		Bada_default_DTO bldt = ss.get_Beach_list_data(beach_code); 
		System.out.println("위도 : "+bldt.getLatitude());
		System.out.println("경도 : "+bldt.getLongitude());
		
		//해시태그 베스트 3
		List<String> hashtags = ss.gethashtags(beach_code);
		System.out.println("가져온 hashtags = " + hashtags);
		mo.addAttribute("hashtags",hashtags);
		
	    // API 호출
    	handleAPICalls(bldt, beach_code, mo);
    	
    	mo.addAttribute("bldt",bldt);
        HttpSession session = request.getSession();
	    session.setAttribute("choicebeach", bldt);
		return "sea_result";
	}
	
	 public void handleAPICalls(Bada_default_DTO bldt, int beach_code, Model mo) {
        APIClient apiClient = new APIClient();
        Service ss = sqlsession.getMapper(Service.class);
        String errorMessage;

        try {
        	UltraSrtFcstBeach_DTO uldto = apiClient.getUltraSrtFcstBeach_API(beach_code, DateDAO.setToThirtyMinutes().get("date"), DateDAO.setToThirtyMinutes().get("time"));
            bldt.setUltraSrtFcstBeach_dto(uldto);
        } catch (Exception e) {
            errorMessage = "초단기 예보를 가져오는 도중 오류가 발생했습니다";
            handleAPIException(errorMessage, e, mo);
            bldt.setUltraSrtFcstBeach_dto(new UltraSrtFcstBeach_DTO(
            		"-", "-", "-", 
        	        "-", "-", "-",
        	        "-", "-", "-", 
        	        "-", "-", "-"));
        }

        try {
            bldt.setBada_tmx_n_dto(apiClient.get_bada_tmx_n(beach_code, DateDAO.getYesterdayDateString(), "2300"));
        } catch (Exception e) {
            errorMessage = "단기 예보를 가져오는 도중 오류가 발생했습니다";
            handleAPIException(errorMessage, e, mo);
            bldt.setBada_tmx_n_dto(new Bada_tmx_n_DTO("-", "-"));
        }

        try {
            bldt.setLc_rise_set_info_dto(apiClient.getLCRiseSetInfo_API(bldt.getLongitude(), bldt.getLatitude(), DateDAO.getCurrentDateString()));
        } catch (Exception e) {
            errorMessage = "sunset과 sunrise를 가져오는 도중 오류가 발생했습니다";
            handleAPIException(errorMessage, e, mo);
            bldt.setLc_rise_set_info_dto(new LC_Rise_Set_Info_DTO("-", "-"));
        }

        Bada_tw_DTO twdto = new Bada_tw_DTO();

        try {
            String tw = apiClient.getTwBuoyBeach_API(beach_code, (DateDAO.getCurrentDateString() + DateDAO.getCurrentTime()));
            twdto.setWater_temp(tw);
            bldt.setBada_tw_dto(twdto);
            System.out.println("수온아 제발 나와라 11: "+bldt.getBada_tw_dto().getWater_temp());
        } catch (Exception e) {
            errorMessage = "현재 수온을 가져오는 도중 오류가 발생했습니다";
            handleAPIException(errorMessage, e, mo);
            twdto.setWater_temp("-");
            bldt.setBada_tw_dto(twdto);
        }

        try {
            String wh = apiClient.getWhBuoyBeach_API(beach_code, (DateDAO.getCurrentDateString() + DateDAO.getCurrentTime()));
            twdto.setWater_height(wh);
            bldt.setBada_tw_dto(twdto);
        } catch (Exception e) {
            errorMessage = "현재 파고를 가져오는 도중 오류가 발생했습니다";
            handleAPIException(errorMessage, e, mo);
            twdto.setWater_height("-");
            bldt.setBada_tw_dto(twdto);
        }

        try {
            List<Map<String, String>> itemList = apiClient.getWeatherWarning_API("108");
            String warningString = "없음";
            for (Map<String, String> itemMap : itemList) {
                if (ss.weatherWarning_search(beach_code, itemMap.get("areaName")) != null) {
                    warningString = itemMap.get("warnVar") + itemMap.get("warnStress") + " " + itemMap.get("command");
                }
            }
            System.out.println("경보 확인 문구 : " + warningString);
            mo.addAttribute("warningString", warningString);
        } catch (Exception e) {
            errorMessage = "기상 특보를 가져오는 도중 오류가 발생했습니다";
            handleAPIException(errorMessage, e, mo);
        }

        List<String> resultString = null;

        try {
            int pointcode = ss.getPointcode(beach_code);
            resultString = apiClient.getWthrWrnMsg_API(pointcode);
            for (String alert : resultString) {
                System.out.println("특보 현황: " + alert);
            }
            mo.addAttribute("WthrWrnMsg", resultString);
        } catch (Exception e) {
            errorMessage = "기상 특보 현황을 가져오는 도중 오류가 발생했습니다";
            handleAPIException(errorMessage, e, mo);
        }

        try {
            String result = apiClient.calculateWeatherIndex(bldt.getUltraSrtFcstBeach_dto().getSky(), bldt.getUltraSrtFcstBeach_dto().getRn1(), Double.parseDouble(bldt.getUltraSrtFcstBeach_dto().getWsd()), Double.parseDouble(bldt.getBada_tw_dto().getWater_height()), resultString);
            System.out.println("바다여행지수: "+ result);
            mo.addAttribute("travelIndex", result);
        } catch (Exception e) {
            errorMessage = "바다여행 지수를 계산하는 도중 오류가 발생했습니다";
            handleAPIException(errorMessage, e, mo);
        }
    }

    private static void handleAPIException(String errorMessage, Exception e, Model mo) {
        System.err.println(errorMessage + ": " + e.getMessage());
        e.printStackTrace();
        mo.addAttribute("errorMessage", errorMessage);
    }
	
	//메인 서치바
	@ResponseBody
	@RequestMapping(value = "main_search")
	public String main_search(HttpServletRequest request) {
		
		String area = request.getParameter("area");
		System.out.println("area 가져왔니? : "+area);
		String result = null;
		Service ss = sqlsession.getMapper(Service.class);
		
		String category = ss.searchwhere(area);
		System.out.println("area 카테고리 : "+category);
		
		if(category.equals("state")) {
			result=area;
		}
		else if(category.equals("city")) {
			result="city";
		}
		else if(category.equals("")||category==null) {
			result="no";
		}
		
		
		return result;
	}
}
