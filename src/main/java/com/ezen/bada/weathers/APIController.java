package com.ezen.bada.weathers;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

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
//        // API 호출
//    	APIClient apiClient = new APIClient();
//		// 삼봉 3일치 가져오기
//		Map<String, Map<String, VilageFcstBeach_DTO>> getWeatherForecastMap = apiClient.getWeatherForecast(55, DateDAO.setForecastDate().get("date"), DateDAO.setForecastDate().get("time"));
//		
//		
//		List<Integer> temperatureList = new ArrayList<>();
//
//	    int loopCount = 0; // 바깥 루프를 제어하기 위한 카운터
//
//	    // weatherForecastMap에서 바깥의 키값이 딱 3개만 필요하므로, 그에 맞게 반복합니다.
//	    for (Map.Entry<String, Map<String, VilageFcstBeach_DTO>> entry : getWeatherForecastMap.entrySet()) {
//	        if (loopCount >= 3) { // 3번 반복하고 나면 종료합니다.
//	            break;
//	        }
//	        loopCount++; // 카운터 증가
//
//	        // 날짜별 맵에서 시간별 DTO를 가져와서 TMP 값을 추출합니다.
//	        Map<String, VilageFcstBeach_DTO> timeMap = entry.getValue();
//	        for (VilageFcstBeach_DTO dto : timeMap.values()) {
//	            // DTO에서 TMP 값을 가져와서 리스트에 추가합니다.
//	            temperatureList.add(Integer.parseInt(dto.getTmp()));
//	        }
//	    }
//	    System.out.println("삼봉 해수욕장의 기온 배열 : "+temperatureList);
//	    System.out.println("삼봉 해수욕장의 기온 배열 사이즈 : "+temperatureList.size());
//	    // 사이즈에서 -48+1 하면 다음날
//	    // 사이즈에서 -24+1 하면 모레
        return "sea_search";
    }
    

	@RequestMapping(value = "/sea_weather_detail")
	public String sea_weather_detail(HttpServletRequest request, Model mo, @RequestParam("beach_code") int beach_code) throws JsonProcessingException {
		// 지난 해 바다 날씨 검색할 때 beach_code 필요 
		mo.addAttribute("beach_code",beach_code);
		String errorMessage;
		
		APIClient apiClient = new APIClient();
		
		// 1. 3일치 맵 가져오기
		try{
			Map<String, Map<String, VilageFcstBeach_DTO>> getWeatherForecastMap = apiClient.getWeatherForecast(beach_code, DateDAO.setForecastDate().get("date"), DateDAO.setForecastDate().get("time"));

			if (Objects.nonNull(getWeatherForecastMap) && !getWeatherForecastMap.isEmpty()) {
				String json = objectMapper.writeValueAsString(getWeatherForecastMap);
				mo.addAttribute("ForecastMapJson",json);
				mo.addAttribute("groupedData",getWeatherForecastMap);
			}
		} catch (Exception e) {
			errorMessage = "단기 예보 API를 가져오는 도중 오류가 발생했습니다";
            handleAPIException(errorMessage, e, mo);
		}
		
		// 2. 3개년치 맵 가져오기
		try {
			Service ss = sqlsession.getMapper(Service.class);
			int pointcode = ss.getPointcode(beach_code);
			Map<String, getWthrDataList_DTO> getWthrDataListMap = apiClient.getThreeYearWeatherForecast(pointcode, beach_code);
			mo.addAttribute("dataListMap", getWthrDataListMap);
		} catch (Exception e) {
			errorMessage = "종관기상관측 API를 가져오는 도중 오류가 발생했습니다";
            handleAPIException(errorMessage, e, mo);
		}
		
		return "sea_weather_detail";
	}
    
	@ResponseBody
	@RequestMapping(value = "/getWthrDataList_DTO", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
	public String getWthrDataList_DTO(@RequestBody String jsonDataString) {
	    try {
	    	APIClient apiClient = new APIClient();
	    	objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
	        JsonNode jsonNode = objectMapper.readTree(jsonDataString);
	    	
	        int beach_code = Integer.parseInt(jsonNode.get("beach_code").asText());
	        String monthInput = jsonNode.get("monthInput").asText();
	        String dayInput = jsonNode.get("dayInput").asText();
	        int setYear = Integer.parseInt(jsonNode.get("currentYear").asText());
	        
	        Service ss = sqlsession.getMapper(Service.class);
	        int pointcode = ss.getPointcode(beach_code);

	        List<getWthrDataList_DTO> list = apiClient.searchThreeYearWeatherForecast(beach_code, pointcode, monthInput, dayInput, setYear);
	        String objectreturn = objectMapper.writeValueAsString(list);
	        return objectreturn;
	    } catch (Exception e) {
	        // 예외 처리
	        String errorMessage = "종관기상관측 API 응답 없음";
	        System.err.println(errorMessage + ": " + e.getMessage());
	        e.printStackTrace();
	        return errorMessage;
	    }
	}
	
	private static void handleAPIException(String errorMessage, Exception e, Model mo) {
        System.err.println(errorMessage + ": " + e.getMessage());
        e.printStackTrace();
        mo.addAttribute("errorMessage", errorMessage);
    }
}

