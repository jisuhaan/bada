package com.ezen.bada.weathers;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class APIController {
   
    @Autowired
    SqlSession sqlsession;

    ObjectMapper objectMapper = new ObjectMapper();
   
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
    	
        Map<String, Map<String, JSONObject>> getWeatherForecastMap = apiClient.getWeatherForecast(1, DateDAO.setForecastDate().get("date"), DateDAO.setForecastDate().get("time"));
        System.out.println(getWeatherForecastMap.keySet());
        return "sea_search";
    }

}

