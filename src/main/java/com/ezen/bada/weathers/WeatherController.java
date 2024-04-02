package com.ezen.bada.weathers;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
   
   @RequestMapping(value = "/sea_search")
   public String sea_search() {
      return "sea_search";
   }

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
   @RequestMapping(value = "/weather_beach_DTO", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
   // http에서 json 깨짐 문제는 produces = "application/json; charset=UTF-8" 추가해서 해결
   public String weather_beach_DTO(@RequestBody String jsonDataString) {
      String objectreturn = "";
      try {
      // JSON 문자열을 JsonNode로 파싱
      JsonNode jsonNode = objectMapper.readTree(jsonDataString);
      String beach = jsonNode.get("beachName").asText();
      System.out.println("beach: "+beach);
      String forecastNode = jsonNode.get("forecast").asText();
      System.out.println("forecastNode: "+forecastNode);
      String twBuoyNode = jsonNode.get("twBuoy").asText();
      System.out.println("twBuoyNode: "+twBuoyNode);
      Service service = sqlsession.getMapper(Service.class);
         Bada_default_DTO bdto= service.weather_beach_defaultInfo(beach);
       System.out.println("변환된 DTO 객체 1: " + bdto.toString());
      
      // JSON 데이터를 받아올 때엔 @RequestParam보다 @RequestBody를 주로 사용
        
        System.out.println("넘어온 값: "+jsonDataString);
        
        // Jackson 라이브러리의 ObjectMapper를 사용하여 JSON 문자열 result를 읽어서 트리 구조로 변환하는 작업을 수행    
        // 변환된 JsonNode 객체는 JSON 데이터의 계층 구조를 유지하면서 각각의 요소에 접근할 수 있는 메서드를 제공   
           objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
           
           Bada_list_DTO dto = objectMapper.readValue(forecastNode, Bada_list_DTO.class);
           
           dto.setSky(convertSky(dto.getSky()));
           dto.setPty(convertPty(dto.getPty()));
              
           System.out.println("변환 완료 : "+dto.getSky());
           System.out.println("변환된 DTO 객체 2: " + dto.toString());
           
           Bada_tw_DTO tdto = objectMapper.readValue(twBuoyNode, Bada_tw_DTO.class);
           
           bdto.setBada_list_dto(dto);
           bdto.setBada_tw_dto(tdto);

            // DTO 객체를 JSON 형태로 변환
            objectreturn = objectMapper.writeValueAsString(bdto);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
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