package com.ezen.bada.weathers;

import java.util.ArrayList;
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
	public String sea_weather_detail(HttpServletRequest request, Model mo) {
		
		int beach_code = Integer.parseInt(request.getParameter("beach_code"));
		mo.addAttribute("beach_code",beach_code);
		
		APIClient apiClient = new APIClient();
		Map<String, Map<String, VilageFcstBeach_DTO>> getWeatherForecastMap = apiClient.getWeatherForecast(beach_code, DateDAO.setForecastDate().get("date"), DateDAO.setForecastDate().get("time"));
		mo.addAttribute("groupedData",getWeatherForecastMap);
		
		return "sea_weather_detail";
	}
    
    @ResponseBody
    @RequestMapping(value = "/getWthrDataList_DTO", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
    // http에서 json 깨짐 문제는 produces = "application/json; charset=UTF-8" 추가해서 해결
    public String getWthrDataList_DTO(@RequestBody String jsonDataString) {
        // JSON 데이터를 받아올 때엔 @RequestParam보다 @RequestBody를 주로 사용

        String objectreturn = "";
        List<getWthrDataList_DTO> list = new ArrayList<getWthrDataList_DTO>();
        
        try {
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
            
            if(Integer.parseInt(monthInput+dayInput) > Integer.parseInt(DateDAO.getCurrentDateString().substring(4)))
            {
            	setYear=setYear-1;
            }
            
            APIClient apiClient = new APIClient();
            
            for(int i=0;i<3;i++) {
            	System.out.println((i+1)+"번째 시도");
            	String setStringYear = String.valueOf(setYear);
            	getWthrDataList_DTO gdto = apiClient.getWthrDataList_API(pointcode, setStringYear+monthInput+dayInput);
  
            	list.add(gdto);
            	setYear=setYear-1;
            }
            
            objectreturn = objectMapper.writeValueAsString(list);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        System.out.println("objectreturn: "+objectreturn);
        return objectreturn; 
    }

}

