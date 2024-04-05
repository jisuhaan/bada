package com.ezen.bada.weathers;

import org.apache.ibatis.session.SqlSession;
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
    	System.out.println("Current Date: " + DateDAO.getCurrentDateString());
        System.out.println("Yesterday Date: " + DateDAO.getYesterdayDateString());
        System.out.println("Current Time: " + DateDAO.getCurrentTime());
        System.out.println("Current Time (Rounded to 30 minutes): " + DateDAO.setToThirtyMinutes());
        System.out.println("Current Time (Rounded to the next hour): " + DateDAO.setToTopOfHour());
    	
        // API 호출
    	APIClient apiClient = new APIClient();
    	apiClient.getUltraSrtFcstBeach_API(1, DateDAO.getCurrentDateString(), DateDAO.setToThirtyMinutes());
    	apiClient.getVilageFcstBeach_API(1, DateDAO.getYesterdayDateString()); // 단기 예보
        apiClient.getLCRiseSetInfo_API(129.431, 36.5988083333333, DateDAO.getCurrentTime());
        apiClient.getTwBuoyBeach_API(1, (DateDAO.getCurrentDateString()+DateDAO.getCurrentTime()));
    	apiClient.getWeatherWarning_API("108");
    	return "sea_search";
    }



}

