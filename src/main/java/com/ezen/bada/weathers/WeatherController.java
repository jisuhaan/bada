package com.ezen.bada.weathers;

import java.time.LocalDate;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
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
	public String weather_beachName(String beachName) {
		Service service = sqlsession.getMapper(Service.class);
		Integer beach_code = service.weather_beachName(beachName);
		
		// 현재 일자
		LocalDate currentDate = LocalDate.now();
		String formattedDate = currentDate.toString().replace("-", "");
		
		// API 호출 및 데이터 가져오기
		
		
        String url = "https://apis.data.go.kr/1360000/BeachInfoservice/getVilageFcstBeach";
        String serviceKey = "B%2FjB9zSDNXmD%2FXHL4TiuFXHV9jxUC25w4PAGH8so7F6tga0RNmO%2FSD2wzjE9Jh5F1lWPbDhOqYYjsvkQTcHAig%3D%3D";
        String queryParams = "?serviceKey=" + serviceKey + "&numOfRows=12&pageNo=1&dataType=JSON&base_date=" + formattedDate + "&base_time=0800&beach_num=" + beach_code;

        // Spring 프레임워크에서 제공하는 HTTP 통신을 간편하게 처리하기 위한 클래스
        RestTemplate restTemplate = new RestTemplate();
        String result = restTemplate.getForObject(url + queryParams, String.class);

        // API 응답 확인용
        System.out.println("결과값 : "+result);
        
        // JSON 데이터를 Java 객체로 매핑하기 위해 Jackson 라이브러리 사용함
        // 중첩된 JSON 데이터에서 특정 필드를 추출할 때엔 JsonNode가 더 적절
        JsonNode rootNode;
        String objectreturn = "";
        try {
        // Jackson 라이브러리의 ObjectMapper를 사용하여 JSON 문자열 result를 읽어서 트리 구조로 변환하는 작업을 수행    
        //	변환된 JsonNode 객체는 JSON 데이터의 계층 구조를 유지하면서 각각의 요소에 접근할 수 있는 메서드를 제공	
        	rootNode = objectMapper.readTree(result);

            // 필요한 필드 추출
            JsonNode items = rootNode.path("response").path("body").path("items").path("item");
            
            Bada_list_DTO dto = new Bada_list_DTO();
    		System.out.println("아이템스: "+items);
            // item 배열 안에 있는 필드들을 추출하여 처리
            for (JsonNode item : items) {
            	System.out.println("아이템: "+item);
                String beachNum = item.path("beachNum").asText();
                String baseDate = item.path("baseDate").asText();
                String baseTime = item.path("baseTime").asText();
                
                // API에서 가져온 데이터는 문자열로 처리
                String pop = item.path("POP").asText();
                String pty = item.path("PTY").asText();
                String pcp = item.path("PCP").asText();
                String reh = item.path("REH").asText();
                String sno = item.path("SNO").asText();
                String sky = item.path("SKY").asText();
                String tmp = item.path("TMP").asText();
                String tmn = item.path("TMN").asText();
                String tmx = item.path("TMX").asText();
                String uuu = item.path("UUU").asText();
                String vvv = item.path("VVV").asText();
                String wav = item.path("WAV").asText();
                String vec = item.path("VEC").asText();
                String wsd = item.path("WSD").asText();
                
                System.out.println("wsd: "+wsd);
                dto.setBeach(beachName);
                dto.setBaseTime(baseDate);
                dto.setBaseTime(baseTime);
                
                dto.setSky(convertSky(sky));
                dto.setPty(convertPty(pty));
                
                dto.setPop(pop);
                dto.setPcp(pcp);
                dto.setReh(reh);
                dto.setSno(sno);
                dto.setTmp(tmp);
                dto.setTmn(tmn);
                dto.setTmx(tmx);
                dto.setUuu(uuu);
                dto.setVvv(vvv);
                dto.setWav(wav);
                dto.setVec(vec);
                dto.setWsd(wsd);               
            }
            // DTO 객체를 JSON 형태로 변환
            objectreturn = objectMapper.writeValueAsString(dto);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        return objectreturn; 
    }

	private String convertPty(String pty) {
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
