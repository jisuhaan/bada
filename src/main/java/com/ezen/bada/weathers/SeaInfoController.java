package com.ezen.bada.weathers;

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
		
		//해변코드로 db에 마련된 해변정보(주소, 설명 등)들을 불러옵니다.
		Bada_info_DTO bdt = ss.getbeachinfo(beach_code);
		
		//해변코드로 db에 마련된 위도경도를 불러옵니다.
		mo.addAttribute("bdt",bdt);
		System.out.println("불러와진 해변이름 : "+bdt.getBeach_name());
		
		// Bada_default_DTO -> Bada_list 테이블에서 특정 해수욕장 정보 가져오기
		Bada_default_DTO bldt = ss.get_Beach_list_data(beach_code); 
		System.out.println("위도 : "+bldt.getLatitude());
		System.out.println("경도 : "+bldt.getLongitude());
		
	    // API 호출
    	APIClient apiClient = new APIClient();
    	
    	// 초단기 예보는 dto에 저장
    	bldt.setUltraSrtFcstBeach_dto(apiClient.getUltraSrtFcstBeach_API(beach_code, DateDAO.getCurrentDateString(), DateDAO.setToThirtyMinutes()));
    	
    	// 단기 예보(최고 최저 온도)는 dto에 저장
    	bldt.setBada_tmx_n_dto(apiClient.get_bada_tmx_n(beach_code, DateDAO.getYesterdayDateString()));
        
    	// sunset과 sunrise는 dto에 저장
    	bldt.setLc_rise_set_info_dto(apiClient.getLCRiseSetInfo_API(bldt.getLongitude(), bldt.getLatitude(), DateDAO.getCurrentDateString()));
        
        // 현재 수온은 String으로 받음 (+°C)
        String tw = apiClient.getTwBuoyBeach_API(beach_code, (DateDAO.getCurrentDateString()+DateDAO.getCurrentTime()));
        Bada_tw_DTO twdto = new Bada_tw_DTO();
        twdto.setWater_temp(tw);
        bldt.setBada_tw_dto(twdto);
        
        // 기상 특보는 Map에 저장해서 리스트화 -> 추후 수정 가능성 있음
        List<Map<String, String>> itemList = apiClient.getWeatherWarning_API("108");
        String warningString = "없음";
        for(Map<String, String> itemMap : itemList) {
        	if(ss.weatherWarning_search(beach_code, itemMap.get("areaName"))!=null) {
        		warningString = itemMap.get("warnVar")+itemMap.get("warnStress")+" "+itemMap.get("command");
        	}
        }
        System.out.println("경보 확인 문구 : "+warningString);
        
        mo.addAttribute("warningString",warningString);
        mo.addAttribute("bldt",bldt);
        HttpSession session = request.getSession();
	    session.setAttribute("bldt", bldt);
		return "sea_result";
	}
	
	@RequestMapping(value = "/sea_weather_detail")
	public String sea_weather_detail(HttpServletRequest request, Model mo) {
		String beachName = request.getParameter("beachName");
		System.out.println("beachName: "+beachName);
		mo.addAttribute("beachName",beachName);
		
		return "sea_weather_detail";
	}
}
