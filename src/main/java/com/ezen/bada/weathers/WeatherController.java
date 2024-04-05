package com.ezen.bada.weathers;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class WeatherController {
   
    @Autowired
    SqlSession sqlsession;

    ObjectMapper objectMapper = new ObjectMapper();
 
    @ResponseBody
    @RequestMapping(value = "/weather_beachName", method = RequestMethod.GET)
    public String weather_beachName(@RequestParam String beachName) {
        // @RequestParam : request.getParameter()의 역할.
        Service service = sqlsession.getMapper(Service.class);
        int beach_code = service.weather_beachName(beachName);

        // JSON 형식의 문자열 생성
        String jsonResponse = "{\"beach_code\": " + beach_code + "}";
       
        return jsonResponse;
    }
    	

    @ResponseBody
    @RequestMapping(value = "/saveWeatherInfoToDTO", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
    public String saveWeatherInfoToDTO(@RequestBody String jsonData, HttpServletRequest request, Model mo) {
        System.out.println("시이작!!!");
        // 사이트가 간직하고 있는 bldt 정보 가져오기
        HttpSession session = request.getSession();
        Bada_default_DTO bldt = (Bada_default_DTO) session.getAttribute("bldt");
        
    	String objectreturn = "";
  
        objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
        try {
        	// 가져온 jsonData 풀어주기
			JsonNode jsonNode = objectMapper.readTree(jsonData);
			
			// jsonData 분리
			String ultraSrtFcstBeachData = jsonNode.get("ultraSrtFcstBeachData").asText(); // 초단기
			String vilageFcstBeachData = jsonNode.get("vilageFcstBeachData").asText(); // 최고, 최저
			String LCRiseSetInfoData = jsonNode.get("LCRiseSetInfoData").asText(); // 일출, 일몰
			
			// dto에 저장
			UltraSrtFcstBeach_DTO usfb = objectMapper.readValue(ultraSrtFcstBeachData, UltraSrtFcstBeach_DTO.class);
			usfb.setSky(convertSky(usfb.getSky()));
			usfb.setPty(convertPty(usfb.getPty()));
			Bada_tmx_n_DTO tmxn = objectMapper.readValue(vilageFcstBeachData, Bada_tmx_n_DTO.class);
			LC_Rise_Set_Info_DTO lcrs = objectMapper.readValue(LCRiseSetInfoData, LC_Rise_Set_Info_DTO.class);
			
			bldt.setUltraSrtFcstBeach_dto(usfb);
			bldt.setBada_tmx_n_dto(tmxn);
			bldt.setLc_rise_set_info_dto(lcrs);
			
			objectreturn = objectMapper.writeValueAsString(bldt);
			
			
		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        return objectreturn;
    }
   
    @ResponseBody
    @RequestMapping(value = "/weather_beach_DTO", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
    // http에서 json 깨짐 문제는 produces = "application/json; charset=UTF-8" 추가해서 해결
    public String weather_beach_DTO(@RequestBody String jsonDataString) {
        // JSON 데이터를 받아올 때엔 @RequestParam보다 @RequestBody를 주로 사용

        String objectreturn = "";
        try {
            // JSON 문자열을 JsonNode로 파싱
            // Jackson 라이브러리의 ObjectMapper를 사용하여 JSON 문자열 result를 읽어서 트리 구조로 변환하는 작업을 수행    
            // 변환된 JsonNode 객체는 JSON 데이터의 계층 구조를 유지하면서 각각의 요소에 접근할 수 있는 메서드를 제공
            objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            JsonNode jsonNode = objectMapper.readTree(jsonDataString);
      
            String beach = jsonNode.get("beachName").asText();
      
            String forecastNode = jsonNode.get("forecast").asText();
            ArrayList<VilageFcstBeach_DTO> forecastList = new ArrayList<VilageFcstBeach_DTO>();
            JsonNode arrayNode = objectMapper.readTree(forecastNode);
            for(JsonNode node : arrayNode) {
            	VilageFcstBeach_DTO dto = objectMapper.readValue(node.toString(), VilageFcstBeach_DTO.class);
                
                dto.setSky(convertSky(dto.getSky()));
                dto.setPty(convertPty(dto.getPty()));
                
                forecastList.add(dto);
            }

            String twBuoyNode = jsonNode.get("twBuoy").asText();
            System.out.println("twBuoyNode: "+twBuoyNode);
      
            Service service = sqlsession.getMapper(Service.class);
            Bada_default_DTO bdto= service.weather_beach_defaultInfo(beach);
            System.out.println("변환된 DTO 객체 1: " + bdto.toString());
           
            Bada_tw_DTO tdto = objectMapper.readValue(twBuoyNode, Bada_tw_DTO.class);
           
            bdto.setBada_list_dto(forecastList);
            bdto.setBada_tw_dto(tdto);

            // DTO 객체를 JSON 형태로 변환
            objectreturn = objectMapper.writeValueAsString(bdto);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        System.out.println("objectreturn: "+objectreturn);
        return objectreturn; 
    }

    private String convertPty(String pty) {
        System.out.println("pty의 값: "+pty);
        switch (pty) {
            case "0":
                return "없음";
            case "1":
                return "비";
            case "2":
                return "비/눈";
            case "3":
                return "눈";
            case "4":
                return "소나기";
            case "5":
                return "빗방울";
            case "6":
                return "빗방울눈날림";
            case "7":
                return "눈날림";
            default:
                return "정보 미정";
        }
    }

    private String convertSky(String sky) {
        System.out.println("sky의 값: "+sky);
        switch (sky) {
            case "1":
                return "맑음";
            case "3":
                return "구름많음";
            case "4":
                return "흐림";
            default:
                return "정보 미정";
        }
    }
}
