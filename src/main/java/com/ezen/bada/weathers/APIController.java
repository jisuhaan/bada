package com.ezen.bada.weathers;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class APIController {
   
    @Autowired
    SqlSession sqlsession;

    ObjectMapper objectMapper = new ObjectMapper();

    //  연습용. 나중에 삭제
    @RequestMapping(value = "/sea_search")
    public String sea_search() {
//    	System.out.println("Current Date: " + DateDAO.getCurrentDateString());
//        System.out.println("Yesterday Date: " + DateDAO.getYesterdayDateString());
//        System.out.println("Current Time: " + DateDAO.getCurrentTime());
//        System.out.println("Current Time (Rounded to 30 minutes): " + DateDAO.setToThirtyMinutes());
//        System.out.println("Current Time (Rounded to the next hour): " + DateDAO.setToTopOfHour());
//    	
//        // API 호출
    	APIClient apiClient = new APIClient();
//    	
//    	// 초단기 예보는 dto에 저장
//    	UltraSrtFcstBeach_DTO udto = apiClient.getUltraSrtFcstBeach_API(1, DateDAO.getCurrentDateString(), DateDAO.setToThirtyMinutes());
//    	
//    	// 단기 예보(최고 최저 온도)는 dto에 저장
//    	Bada_tmx_n_DTO vdto = apiClient.get_bada_tmx_n(1, DateDAO.getYesterdayDateString(), 2300); // 단기 예보
//        
//    	// sunset과 sunrise는 dto에 저장
//    	LC_Rise_Set_Info_DTO ldto = apiClient.getLCRiseSetInfo_API(129.431, 36.5988083333333, DateDAO.getCurrentDateString());
//        
//        // 현재 수온은 String으로 받음 (+°C)
//        String tw = apiClient.getTwBuoyBeach_API(1, (DateDAO.getCurrentDateString()+DateDAO.getCurrentTime()));
//    	
        // 기상 특보는 Map에 저장해서 리스트화 -> 추후 수정 가능성 있음
//        apiClient.getWeatherWarning_API("108");
    	
//        Map<String, Map<String, VilageFcstBeach_DTO>> getWeatherForecastMap = apiClient.getWeatherForecast(1, DateDAO.setForecastDate().get("date"), DateDAO.setForecastDate().get("time"));
//        System.out.println(getWeatherForecastMap.keySet());
//    	apiClient.getWthrDataList_API(108, "20240215");
        return "sea_search";
    }
    

	@RequestMapping(value = "/sea_weather_detail")
	public String sea_weather_detail(HttpServletRequest request, Model mo, @RequestParam("beach_code") int beach_code) {
		// 지난 해 바다 날씨 검색할 때 beach_code 필요 
		mo.addAttribute("beach_code",beach_code);
		
		APIClient apiClient = new APIClient();
		// 3일치 가져오기
		Map<String, Map<String, VilageFcstBeach_DTO>> getWeatherForecastMap = apiClient.getWeatherForecast(beach_code, DateDAO.setForecastDate().get("date"), DateDAO.setForecastDate().get("time"));
		if (getWeatherForecastMap.isEmpty()) {
		    // 맵이 비어 있는 경우
			mo.addAttribute("errorMessage","단기 예보 API 응답 없음");
		} else {
		    // 맵이 비어 있지 않은 경우
			mo.addAttribute("groupedData",getWeatherForecastMap);
		}
		// 3개년치 가져오기
		Map<String, getWthrDataList_DTO> getWthrDataListMap = new LinkedHashMap<String, getWthrDataList_DTO>();
		Service ss = sqlsession.getMapper(Service.class);
		int pointcode = ss.getPointcode(beach_code);

		try {
		    for (int i = 1; i < 4; i++) {
		        System.out.println(i + "번째 시도");
		        String setStringDate = LocalDate.now().minusYears(i).format(DateTimeFormatter.ofPattern("yyyyMMdd"));
		        getWthrDataList_DTO gdto = apiClient.getWthrDataList_API(pointcode, setStringDate);
		        String wh = apiClient.getWhBuoyBeach_API(beach_code, (setStringDate + DateDAO.getCurrentTime()));
		        System.out.println("파고는? " + wh);
		        gdto.setWh(wh);
		        getWthrDataListMap.put(setStringDate, gdto);
		    }
		    mo.addAttribute("dataListMap", getWthrDataListMap);
		} catch (Exception e) {
			mo.addAttribute("errorMessage","종관기상관측 API 응답 없음");
		}
		
		return "sea_weather_detail";
	}
    
	@ResponseBody
	@RequestMapping(value = "/getWthrDataList_DTO", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
	public String getWthrDataList_DTO(@RequestBody String jsonDataString) {
	    try {
	        String objectreturn = "";
	        List<getWthrDataList_DTO> list = new ArrayList<>();

	        objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
	        JsonNode jsonNode = objectMapper.readTree(jsonDataString);
	        System.out.println(jsonNode);

	        int beach_code = Integer.parseInt(jsonNode.get("beach_code").asText());
	        String monthInput = jsonNode.get("monthInput").asText();
	        String dayInput = jsonNode.get("dayInput").asText();
	        int setYear = Integer.parseInt(jsonNode.get("currentYear").asText());

	        
	        
	        Service ss = sqlsession.getMapper(Service.class);
	        int pointcode = ss.getPointcode(beach_code);
	        System.out.println(pointcode);

	        if (Integer.parseInt(monthInput + dayInput) >= Integer.parseInt(DateDAO.getCurrentDateString().substring(4))) {
	            setYear = setYear - 1;
	        }

	        APIClient apiClient = new APIClient();

	        for (int i = 0; i < 3; i++) {
	            System.out.println((i + 1) + "번째 시도");
	            String setStringYear = String.valueOf(setYear);
	            getWthrDataList_DTO gdto = apiClient.getWthrDataList_API(pointcode, setStringYear + monthInput + dayInput);
	            String wh = apiClient.getWhBuoyBeach_API(pointcode, (setStringYear + monthInput + dayInput + DateDAO.getCurrentTime()));
	            System.out.println("파고는? " + wh);
	            gdto.setWh(wh);
	            list.add(gdto);
	            setYear = setYear - 1;
	        }

	        objectreturn = objectMapper.writeValueAsString(list);
	        System.out.println("objectreturn: " + objectreturn);
	        return objectreturn;
	    } catch (Exception e) {
	        // 예외 처리
	        String errorMessage = "종관기상관측 API 응답 없음";
	        System.err.println(errorMessage + ": " + e.getMessage());
	        e.printStackTrace();
	        return errorMessage;
	    }
	}
}

