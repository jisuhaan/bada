package com.ezen.bada.weathers;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.SocketTimeoutException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.json.JSONObject;
import org.w3c.dom.NodeList;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.DocumentBuilder;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.w3c.dom.Node;
import org.xml.sax.InputSource;
import java.io.StringReader;


//디코딩된 서비스 키를 사용하고, 이를 메소드에서 인코딩 해주는 게 오류 해결의 핵심!!
public class APIClient {
	ObjectMapper objectMapper = new ObjectMapper();
	
    public String getApi(String stringURL, Map<String, Object> params) throws IOException {
        // 파라미터를 URL에 추가하고 시작
        StringBuilder urlBuilder = new StringBuilder(stringURL);
        
        urlBuilder.append("?"); // 쿼리 스트링 시작

        // params는 파라미터 키와 값들이 들어있는 Map
        for (Map.Entry<String, Object> param : params.entrySet()) {
        	// urlBuilder의 마지막 문자가 '?'인지 확인. *urlBuilder.length() - 1 : 문자열의 마지막 인덱스
            if (urlBuilder.charAt(urlBuilder.length() - 1) != '?') {
                urlBuilder.append('&'); // 파라미터 구분자 추가
            }
            urlBuilder.append(URLEncoder.encode(param.getKey(), "UTF-8")); // 키값을 인코딩
            urlBuilder.append('=');
            urlBuilder.append(URLEncoder.encode(String.valueOf(param.getValue()), "UTF-8")); // 값 인코딩
        }

        // URL 객체로 URL을 호출함
        System.out.println(urlBuilder.toString()); // Url이 잘 만들었는지 확인차
        
        URL url = new URL(urlBuilder.toString());
    
        try {
	        HttpURLConnection con = (HttpURLConnection) url.openConnection();
	        con.setRequestMethod("GET");
	
	        // Socket Timeout Exception 오류 방지 위하여 Timeout 설정 (20초로 설정)
	        con.setConnectTimeout(20000); // 연결 시간 초과 설정 (20초)
	        con.setReadTimeout(20000); // 읽기 시간 초과 설정 (20초)
	        
	        // 서버로부터 응답을 받아오기 위해 BufferedReader를 사용
	        BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
	        // 한 줄씩 읽어서 StringBuffer에 추가
	        String line;
	        StringBuffer sb = new StringBuffer();
	        while ((line = in.readLine()) != null) {
	            sb.append(line);
	        }
	        in.close(); // 입력 스트림 끝. BufferedReader는 명시적으로 닫아주어야 한다.
	
	        // StringBuffer에 저장된 내용을 String으로 변환
	        String text = sb.toString();
	
	        // 예시로 그대로 text를 반환하도록 함
	        Map<String, Object> result = new HashMap<>();
	        result.put("response", text);
	        return text;
        }catch (SocketTimeoutException e) {
            System.out.println("SocketTimeoutException 발생");
            return null; 
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }


	public UltraSrtFcstBeach_DTO getUltraSrtFcstBeach_API(int beach_num, String currentDateString, String setToThirtyMinutes) {
		UltraSrtFcstBeach_DTO dto = null;
		String text = null;
		Map<String, Object> result = new HashMap<>();
    	// API 호출
        String url = "http://apis.data.go.kr/1360000/BeachInfoservice/getUltraSrtFcstBeach"; /*URL*/
        String serviceKey = "QWzzzAb/UIqP2aANBL1yVlNW3plkWGVz5RX3OJRiMV9J+licoY1Dffo51/i5HTDfU00ZpDy2E4/ASt2FgLknaA=="; 

        // 파라미터 맵 구성
        Map<String, Object> params = new HashMap<>();
        params.put("serviceKey", serviceKey);
        params.put("numOfRows", "60");
        params.put("pageNo", "1");
        params.put("dataType", "JSON");
        params.put("base_date", currentDateString);
        params.put("base_time", setToThirtyMinutes);
        params.put("beach_num", beach_num);

        // API 호출
        try {
        	text = getApi(url, params);
            System.out.println("초단기 API 호출 결과: " + text);
            
            JsonNode rootNode = objectMapper.readTree(text);
            JsonNode itemNode = rootNode.path("response").path("body").path("items").path("item");
            
            String fcstDate = itemNode.get(0).path("fcstDate").asText();
            String fcstTime = itemNode.get(0).path("fcstTime").asText();
            
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("fcstTime", fcstTime);
            jsonObject.put("fcstDate", fcstDate);
            for(JsonNode item : itemNode) {
            	if(item.path("fcstTime").asText().equals(fcstTime)) {
            		// 1. 맵에 저장하기
            		result.put(item.path("category").asText(), item.path("fcstValue").asText());
            		// 2. json으로 저장하기
            		jsonObject.put(item.path("category").asText(), item.path("fcstValue").asText());
            	}
            }
            System.out.println(jsonObject.toString());
            dto = objectMapper.readValue(jsonObject.toString(), UltraSrtFcstBeach_DTO.class);
 
        } catch (IOException e) {
            e.printStackTrace();
        }
        return dto;
		
	}

    public String getVilageFcstBeach_API(int beach_num, String getYesterday) {
    	String text = null;
    	// API 호출
        String url = "http://apis.data.go.kr/1360000/BeachInfoservice/getVilageFcstBeach"; /*URL*/
        String serviceKey = "QWzzzAb/UIqP2aANBL1yVlNW3plkWGVz5RX3OJRiMV9J+licoY1Dffo51/i5HTDfU00ZpDy2E4/ASt2FgLknaA=="; /*Service Key*/

        // 파라미터 맵 구성
        Map<String, Object> params = new HashMap<>();
        params.put("serviceKey", serviceKey);
        params.put("numOfRows", "290");
        params.put("pageNo", "1");
        params.put("dataType", "JSON");
        params.put("base_date", getYesterday);
        params.put("base_time", "2300");
        params.put("beach_num", beach_num);

        // API 호출
        try {
        	text = getApi(url, params);
            
        } catch (IOException e) {
            e.printStackTrace();
        }
        return text;
    }
    
	public LC_Rise_Set_Info_DTO getLCRiseSetInfo_API(double longitude, double latitude, String currentDateString) {
		LC_Rise_Set_Info_DTO dto = new LC_Rise_Set_Info_DTO();
		String text = null;
		Map<String, Object> result = new HashMap<>();
    	// API 호출
        String url = "http://apis.data.go.kr/B090041/openapi/service/RiseSetInfoService/getLCRiseSetInfo"; /*URL*/
        String serviceKey = "QWzzzAb/UIqP2aANBL1yVlNW3plkWGVz5RX3OJRiMV9J+licoY1Dffo51/i5HTDfU00ZpDy2E4/ASt2FgLknaA=="; 

        // 파라미터 맵 구성
        Map<String, Object> params = new HashMap<>();
        params.put("serviceKey", serviceKey);
        params.put("longitude", longitude);
        params.put("latitude", latitude);
        params.put("locdate", currentDateString);
        params.put("dnYn", "y");

        // API 호출
        try {
        	text = getApi(url, params);
            System.out.println("일몰 일출 API 호출 결과: " + text);
            String sunset = parseXml(text, "sunset");
            String sunrise = parseXml(text, "sunrise");
            
            dto.setSunrise(sunrise);
            dto.setSunset(sunset);
            System.out.println("sunset: " + sunset + " / sunrise: " + sunrise);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return dto;
		
	}
	
	public String getTwBuoyBeach_API(int beach_num, String searchTime) {
		String tw = null;
		String text = null;
		
    	// API 호출
        String url = "http://apis.data.go.kr/1360000/BeachInfoservice/getTwBuoyBeach"; /*URL*/
        String serviceKey = "QWzzzAb/UIqP2aANBL1yVlNW3plkWGVz5RX3OJRiMV9J+licoY1Dffo51/i5HTDfU00ZpDy2E4/ASt2FgLknaA=="; 

        // 파라미터 맵 구성
        Map<String, Object> params = new HashMap<>();
        params.put("dataType", "JSON");
        params.put("searchTime", searchTime);
        params.put("beach_num", beach_num);
        params.put("serviceKey", serviceKey);

        // API 호출
        try {
        	text = getApi(url, params);
            
            JsonNode rootNode = objectMapper.readTree(text);
            // tm과 tw 추출
            JsonNode itemNode = rootNode.path("response").path("body").path("items").path("item").get(0);
            String tm = itemNode.path("tm").asText();
            tw = itemNode.path("tw").asText();
            
            System.out.println("수온 측정 시간 tm: " + tm);
            System.out.println("수온 tw: " + tw);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return tw + "°C";
	}
	
	public List<Map<String, String>> getWeatherWarning_API(String stnId) {
    	// API 호출
        String url = "https://apis.data.go.kr/1360000/WthrWrnInfoService/getPwnCd"; /*URL*/
        String serviceKey = "QWzzzAb/UIqP2aANBL1yVlNW3plkWGVz5RX3OJRiMV9J+licoY1Dffo51/i5HTDfU00ZpDy2E4/ASt2FgLknaA=="; 

        // 파라미터 맵 구성
        Map<String, Object> params = new HashMap<>();
        params.put("dataType", "JSON");
        params.put("numOfRows", 100);
        params.put("pageNo", 1);
        params.put("stnId", stnId); // 지점은 String
        params.put("serviceKey", serviceKey);

        // API 호출
        List<Map<String, String>> itemList = new ArrayList<Map<String, String>>();
        try {
        	String text = getApi(url, params);
            System.out.println("기온 특보 API 호출 결과: " + text);
        
            JsonNode rootNode = objectMapper.readTree(text);
            // tm과 tw 추출
            JsonNode itemNode = rootNode.path("response").path("body").path("items").path("item");
            for (JsonNode node : itemNode) {
                Map<String, String> itemMap = new HashMap<>();
                String areaName = node.path("areaName").asText();
                String warnVar = convertWarnVar(node.path("warnVar").asText());
                String warnStress = convertWarnStress(node.path("warnStress").asText());
                String command = convertCommand(node.path("command").asText());
                
                itemMap.put("areaName", areaName);
                itemMap.put("warnVar", warnVar);
                itemMap.put("warnStress", warnStress);
                itemMap.put("command", command);
                itemList.add(itemMap);
            }
            System.out.println(itemList);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return itemList;
		
	}

	// 당일의 최저, 최고 기온을 구하는 메소드 
	public Bada_tmx_n_DTO get_bada_tmx_n(int beach_num, String getYesterday) {
		String text = getVilageFcstBeach_API(beach_num, DateDAO.getYesterdayDateString());
		Bada_tmx_n_DTO dto = null;
		JsonNode rootNode;
		try {
			rootNode = objectMapper.readTree(text);
			JsonNode itemNode = rootNode.path("response").path("body").path("items").path("item");
	        
	        JSONObject jsonObject = new JSONObject();
	        
	        for (JsonNode item : itemNode) {
	            String category = item.path("category").asText();
	            if (category.equals("TMN") || category.equals("TMX")) {
	            	jsonObject.put(item.path("category").asText(), item.path("fcstValue").asText()); 
	            }
	        }   
	        dto = objectMapper.readValue(jsonObject.toString(), Bada_tmx_n_DTO.class);
	        System.out.println("jsonObject: " + jsonObject);
	        
		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return dto;
	}
	
	// xml을 파싱하는 메소드
	public String parseXml(String xmlString, String keyword) {
		try {
			// xmlString을 파싱하여 Document 객체로 변환하는 것이 관건!
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document document = builder.parse(new InputSource(new StringReader(xmlString)));
            
            // 루트 엘리먼트 가져오기
            Element rootElement = document.getDocumentElement();
            
            // 특정 태그 이름을 가진 모든 노드를 선택하여 리스트를 반환
            // 이후 모든 종류의 노드들 중, 엘리먼트 노드만 선택
            NodeList sunriseList = rootElement.getElementsByTagName(keyword); // 주어진 태그 이름을 가진 모든 종류의 노드 반환
            for (int i = 0; i < sunriseList.getLength(); i++) {
                Node node = sunriseList.item(i);
                if (node.getNodeType() == Node.ELEMENT_NODE) {// ELEMENT_NODE일 때에만 요소를 가져오도록
                	Element element = (Element) node;
                    System.out.println("노트 텍스트: " + element.getTextContent());
                    // 요소 노드에 쌓인 텍스트 노드를 가져온다.
                    return element.getTextContent();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
		return null;
    }
    
    private String convertWarnVar(String warnVar) {
        switch (warnVar) {
            case "1":
                return "강풍";
            case "2":
                return "호우";
            case "3":
                return "한파";
            case "4":
                return "건조";
            case "5":
                return "폭풍·해일";
            case "6":
                return "풍랑";
            case "7":
                return "태풍";
            case "8":
                return "대설";
            case "9":
                return "황사";
            case "12":
                return "폭염";
            default:
                return "정보 미정";
        }
    }

    private String convertWarnStress(String warnStress) {
        switch (warnStress) {
            case "0":
                return "주의보";
            case "1":
                return "경보";
            default:
                return "정보 미정";
        }
    }
    
    private String convertCommand(String command) {
        switch (command) {
            case "1":
                return "발표";
            case "2":
                return "해제";
            case "3":
                return "연장";
            case "6":
                return "정정";
            case "7":
                return "변경발표";
            case "8":
                return "변경해제";
            default:
                return "";
        }
    }



}
