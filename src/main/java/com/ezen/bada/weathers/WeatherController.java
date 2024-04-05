package com.ezen.bada.weathers;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
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
    

     public Map<String, Object> getApi(String stringURL, Map<String, Object> params) throws IOException {
         // 파라미터를 URL에 추가하고 시작
         StringBuilder urlBuilder = new StringBuilder(stringURL);
         urlBuilder.append("?"); // 쿼리 스트링 시작

         // params는 파라미터 키와 값들이 들어있는 Map
         for (Map.Entry<String, Object> param : params.entrySet()) {
            // urlBuilder의 마지막 문자가 '?'인지 확인. *urlBuilder.length() - 1 : 문자열의 마지막 인덱스
             if (urlBuilder.charAt(urlBuilder.length() - 1) != '?') {
                 urlBuilder.append('&'); // 파라미터 구분자 추가
             }
             urlBuilder.append(URLEncoder.encode(param.getKey(), "UTF-8")); // 키 인코딩
             urlBuilder.append('=');
             urlBuilder.append(URLEncoder.encode(String.valueOf(param.getValue()), "UTF-8")); // 값 인코딩
         }

         // URL 객체로 URL을 호출함
         URL url = new URL(urlBuilder.toString());
         HttpURLConnection con = (HttpURLConnection) url.openConnection();
         con.setRequestMethod("GET");

         // 서버로부터 응답을 받아오기 위해 BufferedReader를 사용
         BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
         // 한 줄씩 읽어서 StringBuffer에 추가
         String line;
         StringBuffer sb = new StringBuffer();
         while ((line = in.readLine()) != null) {
             sb.append(line);
         }
         in.close(); // 입력 스트림 끝

         // StringBuffer에 저장된 내용을 String으로 변환
         String text = sb.toString();

         // 예시로 그대로 text를 반환하도록 함
         Map<String, Object> result = new HashMap<>();
         result.put("response", text);
         return result;
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
    @RequestMapping(value = "/saveWeatherInfoToDTO", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
    public String saveWeatherInfoToDTO(@RequestBody String jsonData) {
        String objectreturn = "";
  
        objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
        try {
			JsonNode jsonNode = objectMapper.readTree(jsonData);
			
			String ultraSrtFcstBeachData = jsonNode.get("ultraSrtFcstBeachData").asText();
			String vilageFcstBeachData = jsonNode.get("vilageFcstBeachData").asText();
			String LCRiseSetInfoData = jsonNode.get("LCRiseSetInfoData").asText();
			
			
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
            ArrayList<Bada_list_DTO> forecastList = new ArrayList<Bada_list_DTO>();
            JsonNode arrayNode = objectMapper.readTree(forecastNode);
            for(JsonNode node : arrayNode) {
                Bada_list_DTO dto = objectMapper.readValue(node.toString(), Bada_list_DTO.class);
                
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
