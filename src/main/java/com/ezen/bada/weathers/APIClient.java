package com.ezen.bada.weathers;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.SocketTimeoutException;
import java.net.URL;
import java.net.URLEncoder;
import java.text.ChoiceFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.ibatis.session.SqlSession;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.w3c.dom.NodeList;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationFeature;
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
	@Autowired
    SqlSession sqlsession;
	
	ObjectMapper objectMapper = new ObjectMapper();
	
	
    public String getApi(String stringURL, Map<String, Object> params) throws IOException {
    	final int maxRetries = 3; // 최대 재시도 횟수
        final int retryIntervalMillis = 1000; // 재시도 간격 (밀리초)

        // 최대 재시도 횟수만큼 반복
        for (int retry = 0; retry < maxRetries; retry++) {
            try {
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
		        HttpURLConnection con = (HttpURLConnection) url.openConnection();
		        con.setRequestMethod("GET");
		        // Socket Timeout Exception 오류 방지 위하여 Timeout 설정
		        con.setConnectTimeout(15000); // 연결 시간 초과 설정 (15초)
		        con.setReadTimeout(15000); // 읽기 시간 초과 설정 (15초)
		        
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
        } catch (SocketTimeoutException e) {
            // SocketTimeoutException 예외 처리
            System.out.println("SocketTimeoutException 발생");
            if (retry < maxRetries - 1) {
                // 재시도 가능한 경우, 재시도 간격을 두고 스레드 방식으로 재시도
                System.out.println("재시도 #" + (retry + 1));
                try {
                    Thread.sleep(retryIntervalMillis); // 재시도 간격 대기
                } catch (InterruptedException ex) {
                    Thread.currentThread().interrupt();
                }
            } else {
                // 최대 재시도 횟수를 초과한 경우, null 반환
                System.out.println("재시도 횟수를 초과했습니다.");
                return null;
            }
        } catch (IOException e) {
            // 다른 IOException 예외 처리
            e.printStackTrace();
            return null;
        }
    }
    return null; // 최대 재시도 횟수를 초과한 경우에도 null 반환

    }


    public UltraSrtFcstBeach_DTO getUltraSrtFcstBeach_API(int beach_num, String currentDateString, String setToThirtyMinutes) {
        // 기본값으로 초기화된 DTO 객체
        UltraSrtFcstBeach_DTO dto = new UltraSrtFcstBeach_DTO(
			"-", "-", "-", 
	        "-", "-", "-",
	        "-", "-", "-", 
	        "-", "-", "-"
        );
        
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
        
        final int maxRetries = 3; // 최대 재시도 횟수
        // 최대 재시도 횟수만큼 반복
        for (int retry = 0; retry < maxRetries; retry++) {
            try {
                // API 호출
            	String text = getApi(url, params);
                if (text != null) {
                    System.out.println("초단기 API 호출 결과: " + text);

                    JsonNode rootNode = objectMapper.readTree(text);
                    String resultCode = rootNode.path("response").path("header").path("resultCode").asText();
    	            if(resultCode.equals("00")){
	                    JsonNode itemNode = rootNode.path("response").path("body").path("items").path("item");
	                    
	                    String fcstDate = itemNode.get(0).path("fcstDate").asText();
	                    String fcstTime = itemNode.get(0).path("fcstTime").asText();
	                    
	                    JSONObject jsonObject = new JSONObject();
	                    jsonObject.put("fcstTime", fcstTime);
	                    jsonObject.put("fcstDate", fcstDate);
	                    for(JsonNode item : itemNode) {
	                        if(item.path("fcstTime").asText().equals(fcstTime)) {
	                            jsonObject.put(item.path("category").asText(), item.path("fcstValue").asText());
	                        }
	                    }
	                    System.out.println(jsonObject.toString());
	                    if (jsonObject.length() != 0) {
	                    	dto = objectMapper.readValue(jsonObject.toString(), UltraSrtFcstBeach_DTO.class);
			            }
	                    System.out.println("초단기 최근 시간 dto : "+dto.getFcstTime());
    	            }    
                    break; // 성공적으로 API 호출 및 처리를 완료하면 반복문 종료
                }
            } catch (JsonParseException e) {
                // JsonParseException 발생 시 재시도
                e.printStackTrace();
                if (retry < maxRetries - 1) {
                    // 최대 재시도 횟수를 초과하지 않았을 경우에만 다시 시도
                	System.out.println("JSon이 아닌 형식의 데이터가 들어옴. 재시작 "+(retry+1)+"번째");
                    continue;
                } else {
                    // 최대 재시도 횟수를 초과한 경우에는 그냥 null 반환
                    return dto;
                }
            } catch (Exception e) {
                // 기타 예외 발생 시 로깅
                e.printStackTrace();
                if (retry < maxRetries - 1) {
                    // 최대 재시도 횟수를 초과하지 않았을 경우에만 다시 시도
                	System.out.println("기타 예외 발생. 재시작 "+(retry+1)+"번째");
                    continue;
                } else {
                    // 최대 재시도 횟수를 초과한 경우에는 그냥 null 반환
                    return dto;
                }
            }
        }
        return dto;
    }


    public String getVilageFcstBeach_API(int beach_num, String getday, String basetime, int day) {
    	int nor = 290*day;
    	String text = null;
    	// API 호출
        String url = "http://apis.data.go.kr/1360000/BeachInfoservice/getVilageFcstBeach"; /*URL*/
        String serviceKey = "QWzzzAb/UIqP2aANBL1yVlNW3plkWGVz5RX3OJRiMV9J+licoY1Dffo51/i5HTDfU00ZpDy2E4/ASt2FgLknaA=="; /*Service Key*/

        // 파라미터 맵 구성
        Map<String, Object> params = new HashMap<>();
        params.put("serviceKey", serviceKey);
        params.put("numOfRows", Integer.toString(nor));
        params.put("pageNo", "1");
        params.put("dataType", "JSON");
        params.put("base_date", getday);
        params.put("base_time", basetime);
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
		LC_Rise_Set_Info_DTO dto = new LC_Rise_Set_Info_DTO("한국천문연구원_출몰시각 API 응답 없음", "한국천문연구원_출몰시각 API 응답 없음");
		
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
        	String text = getApi(url, params);
        	if (text != null) {
	            System.out.println("일몰 일출 API 호출 결과: " + text);
	            String sunset = parseXml(text, "sunset");
	            String sunrise = parseXml(text, "sunrise");
	            
	            dto.setSunrise(sunrise);
	            dto.setSunset(sunset);
	            System.out.println("sunset: " + sunset + " / sunrise: " + sunrise);
        	}
    	} catch (IOException e) {
            e.printStackTrace();
        }
        return dto;
		
	}
	
	public String getTwBuoyBeach_API(int beach_num, String searchTime) {
	    String tw = "-";
	    String text = null;
	    final int maxRetries = 3; // 최대 재시도 횟수
	    
	    // API 호출
	    String url = "http://apis.data.go.kr/1360000/BeachInfoservice/getTwBuoyBeach"; /*URL*/
	    String serviceKey = "QWzzzAb/UIqP2aANBL1yVlNW3plkWGVz5RX3OJRiMV9J+licoY1Dffo51/i5HTDfU00ZpDy2E4/ASt2FgLknaA=="; 

	    // 파라미터 맵 구성
	    Map<String, Object> params = new HashMap<>();
	    params.put("dataType", "JSON");
	    params.put("searchTime", searchTime);
	    params.put("beach_num", beach_num);
	    params.put("serviceKey", serviceKey);

	    // 최대 재시도 횟수만큼 반복
	    for (int retry = 0; retry < maxRetries; retry++) {
	        try {
	            text = getApi(url, params);
	            
	            JsonNode rootNode = objectMapper.readTree(text);
	            String resultCode = rootNode.path("response").path("header").path("resultCode").asText();
	            if(resultCode.equals("00")){
	            	// tm과 tw 추출
		            JsonNode itemNode = rootNode.path("response").path("body").path("items").path("item").get(0);
		            String tm = itemNode.path("tm").asText();
		            tw = itemNode.path("tw").asText();
		            
		            System.out.println("수온 측정 시간 tm: " + tm);
		            System.out.println("수온 tw: " + tw);
	            }
	            
	            break; // 성공적으로 API 호출 및 처리를 완료하면 반복문 종료
	        } catch (JsonParseException e) {
	            // JSON 파싱 예외 처리
	            e.printStackTrace();
	            if (retry < maxRetries - 1) {
	                // 최대 재시도 횟수를 초과하지 않았을 경우에만 다시 시도
	            	System.out.println("JSon이 아닌 형식의 데이터가 들어옴. 재시작 "+(retry+1)+"번째");
	                continue;
	            } else {
	                return tw;
	            }
	        } catch (IOException e) {
	            // IO 예외 처리
	            e.printStackTrace();
	            if (retry < maxRetries - 1) {
	                // 최대 재시도 횟수를 초과하지 않았을 경우에만 다시 시도
	                continue;
	            } else {
	                return tw;
	            }
	        }
	    }
	    return tw + "°C";
	}

	
	// 파고
	public String getWhBuoyBeach_API(int beach_num, String searchTime) {
	    String wh = "-";
	    String text = null;
	    final int maxRetries = 3; // 최대 재시도 횟수
	    
	    // API 호출
	    String url = "http://apis.data.go.kr/1360000/BeachInfoservice/getWhBuoyBeach"; /*URL*/
	    String serviceKey = "QWzzzAb/UIqP2aANBL1yVlNW3plkWGVz5RX3OJRiMV9J+licoY1Dffo51/i5HTDfU00ZpDy2E4/ASt2FgLknaA=="; 

	    // 파라미터 맵 구성
	    Map<String, Object> params = new HashMap<>();
	    params.put("dataType", "JSON");
	    params.put("searchTime", searchTime);
	    params.put("beach_num", beach_num);
	    params.put("serviceKey", serviceKey);

	    // 최대 재시도 횟수만큼 반복
	    for (int retry = 0; retry < maxRetries; retry++) {
	        try {
	            text = getApi(url, params);
	            
	            JsonNode rootNode = objectMapper.readTree(text);
	            String resultCode = rootNode.path("response").path("header").path("resultCode").asText();
	            if(resultCode.equals("00")){
	            	// tm과 wh 추출
		            JsonNode itemNode = rootNode.path("response").path("body").path("items").path("item").get(0);
		            String tm = itemNode.path("tm").asText();
		            wh = itemNode.path("wh").asText();
		            
		            System.out.println("파고 측정 시간 tm: " + tm);
		            System.out.println("파고 wh: " + wh);
	            }
	            break; // 성공적으로 API 호출 및 처리를 완료하면 반복문 종료
	        } catch (JsonParseException e) {
	            // JSON 파싱 예외 처리
	            e.printStackTrace();
	            if (retry < maxRetries - 1) {
	                // 최대 재시도 횟수를 초과하지 않았을 경우에만 다시 시도
	            	System.out.println("JSon이 아닌 형식의 데이터가 들어옴. 재시작 "+(retry+1)+"번째");
	                continue;
	            } else {
	                // 최대 재시도 횟수를 초과한 경우에는 그냥 null 반환
	                return wh;
	            }
	        } catch (IOException e) {
	            // IO 예외 처리
	            e.printStackTrace();
	            if (retry < maxRetries - 1) {
	                // 최대 재시도 횟수를 초과하지 않았을 경우에만 다시 시도
	                continue;
	            } else {
	                // 최대 재시도 횟수를 초과한 경우에는 그냥 null 반환
	                return wh;
	            }
	        }
	    }
	    return wh;
	}
	
	// 기상 특보 코드 조회
	public List<Map<String, String>> getWeatherWarning_API(String stnId) {
	    // API 호출
	    String url = "http://apis.data.go.kr/1360000/WthrWrnInfoService/getPwnCd"; /*URL*/
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
	    final int maxRetries = 3; // 최대 재시도 횟수
	    for (int retry = 0; retry < maxRetries; retry++) {
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
	            break; // 성공적으로 API 호출 및 처리를 완료하면 반복문 종료
	        } catch (Exception e) {
	            // IO 예외 처리
	            e.printStackTrace();
	            if (retry < maxRetries - 1) {
	                // 최대 재시도 횟수를 초과하지 않았을 경우에만 다시 시도
	                continue;
	            } else {
	                // 최대 재시도 횟수를 초과한 경우에는 그냥 null 반환
	                return null;
	            }
	        }
	    }
	    return itemList;
	}

	// 기상 특보 당장의 현황
	public List<String> getWthrWrnMsg_API(int stnId) {
	    // API 호출
	    String url = "http://apis.data.go.kr/1360000/WthrWrnInfoService/getWthrWrnMsg"; /*URL*/
	    String serviceKey = "QWzzzAb/UIqP2aANBL1yVlNW3plkWGVz5RX3OJRiMV9J+licoY1Dffo51/i5HTDfU00ZpDy2E4/ASt2FgLknaA=="; 

	    // 파라미터 맵 구성
	    Map<String, Object> params = new HashMap<>();
	    params.put("dataType", "JSON");
	    params.put("numOfRows", 100);
	    params.put("pageNo", 1);
	    params.put("serviceKey", serviceKey);
	    params.put("stnId", stnId);

	    // API 호출
	    String itemresult = null;
	    List<String> alerts = new ArrayList<>();
	    final int maxRetries = 3; // 최대 재시도 횟수
	    for (int retry = 0; retry < maxRetries; retry++) {
	        try {
	            String text = getApi(url, params);
	            System.out.println("기온 특보 API 호출 결과: " + text);
	        
	            JsonNode rootNode = objectMapper.readTree(text);
	            // 결과 코드 확인. 정상이면 00, 데이터가 없으면 03
	            JsonNode headerNode = rootNode.path("response").path("header");
	            String resultCode = headerNode.path("resultCode").asText();
	            if (resultCode.equals("00")) {
	                // 현황 문장 뽑아오기
	                JsonNode itemNode = rootNode.path("response").path("body").path("items").path("item").get(0).path("t6");
	                itemresult = itemNode.toString();
	                String[] words = itemresult.split(" ");
	                for (String word : words) {
	                    if (word.contains("주의보")) {
	                        alerts.add(word);
	                    }
	                }
	                System.out.println(words);
	            }
	            break; // 성공적으로 API 호출 및 처리를 완료하면 반복문 종료
	        } catch (Exception e) {
	            // IO 예외 처리
	            e.printStackTrace();
	            if (retry < maxRetries - 1) {
	                // 최대 재시도 횟수를 초과하지 않았을 경우에만 다시 시도
	                continue;
	            } else {
	                // 최대 재시도 횟수를 초과한 경우에는 그냥 null 반환
	                return null;
	            }
	        }
	    }
	    return alerts;
	}

	// 다른 연도의 기상 정보를 검색해오는 API
	public getWthrDataList_DTO getWthrDataList_API(int stnIds, String currentDateString) {
	    // API 호출
	    String url = "http://apis.data.go.kr/1360000/AsosDalyInfoService/getWthrDataList"; /*URL*/
	    String serviceKey = "QWzzzAb/UIqP2aANBL1yVlNW3plkWGVz5RX3OJRiMV9J+licoY1Dffo51/i5HTDfU00ZpDy2E4/ASt2FgLknaA=="; 

	    // 파라미터 맵 구성
	    Map<String, Object> params = new HashMap<>();
	    params.put("dataType", "JSON");
	    params.put("numOfRows", 10);
	    params.put("pageNo", 1);
	    params.put("dataCd", "ASOS");
	    params.put("dateCd", "DAY");
	    params.put("startDt", currentDateString);
	    params.put("endDt", currentDateString);
	    params.put("stnIds", stnIds);
	    params.put("serviceKey", serviceKey);

	    // API 호출
	    getWthrDataList_DTO dto = new getWthrDataList_DTO(
	            "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", new HashSet<String>()
	    	    );
	    final int maxRetries = 3; // 최대 재시도 횟수
	    for (int retry = 0; retry < maxRetries; retry++) {
	        try {
	            String text = getApi(url, params);        
	            JsonNode rootNode = objectMapper.readTree(text);
	            String resultCode = rootNode.path("response").path("header").path("resultCode").asText();
	            if(resultCode.equals("00")){
		            JsonNode itemNode = rootNode.path("response").path("body").path("items").path("item").get(0);
		            objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		            dto = objectMapper.readValue(itemNode.toString(), getWthrDataList_DTO.class);
		            String data = dto.getIscs();
		            dto.setAvgTca(convertavgTca(Double.parseDouble(dto.getAvgTca())));
		            if(data==null || data.equals("") || data.isEmpty()) {}
		            else {
		                Set<String> dataSet = new HashSet<>();
		                Pattern pattern = Pattern.compile("\\{([^\\(\\)\\{\\}0-9a-zA-Z]+)\\}"); // 중괄호 안에 숫자, 영어가 포함 안 된 항목
		                Matcher matcher = pattern.matcher(data);
		                while (matcher.find()) {
		                    dataSet.add(matcher.group(1));
		                }
		                dto.setPtySet(dataSet);
		            }
		            System.out.println(dto.toString());
	            }
	            break; // 성공적으로 API 호출 및 처리를 완료하면 반복문 종료
	        } catch (Exception e) {
	            // IO 예외 처리
	            e.printStackTrace();
	            if (retry < maxRetries - 1) {
	                // 최대 재시도 횟수를 초과하지 않았을 경우에만 다시 시도
	                continue;
	            } else {
	                // 최대 재시도 횟수를 초과한 경우에는 그냥 null 반환
	                return null;
	            }
	        }
	    }
	    return dto;
	}

	// 당일의 최저, 최고 기온을 구하는 메소드 
	public Bada_tmx_n_DTO get_bada_tmx_n(int beach_num, String getYesterday, String basetime) {
	    String text = getVilageFcstBeach_API(beach_num, DateDAO.getYesterdayDateString(), basetime, 1);
	    Bada_tmx_n_DTO dto = new Bada_tmx_n_DTO("-", "-");
	     
	    final int maxRetries = 3; // 최대 재시도 횟수
	    for (int retry = 0; retry < maxRetries; retry++) {
	        try {
	        	if (text != null) {
	        		JsonNode rootNode = objectMapper.readTree(text);
	        		String resultCode = rootNode.path("response").path("header").path("resultCode").asText();
		            if(resultCode.equals("00")){
			            JsonNode itemNode = rootNode.path("response").path("body").path("items").path("item");
			            JSONObject jsonObject = new JSONObject();
			            for (JsonNode item : itemNode) {
			                String category = item.path("category").asText();
			                if (category.equals("TMN") || category.equals("TMX")) {
			                    jsonObject.put(item.path("category").asText(), item.path("fcstValue").asText()); 
			                }
			            }   
	
			    	    System.out.println("최저 최고 기온 dto 씌우기 전 jsonObject: " + jsonObject);
			    	    if (jsonObject.length() != 0) {
			    	    	dto = objectMapper.readValue(jsonObject.toString(), Bada_tmx_n_DTO.class);
			            }
		            }
		            break; // 성공적으로 API 호출 및 처리를 완료하면 반복문 종료
	        	}   
	        } catch (JsonParseException e) {
	            e.printStackTrace();
	            if (retry < maxRetries - 1) {
	                // 최대 재시도 횟수를 초과하지 않았을 경우에만 다시 시도
	                continue;
	            } else {
	                // 최대 재시도 횟수를 초과한 경우에는 그냥 null 반환
	                return dto;
	            }
	        } catch (JsonMappingException e) {
	            // JSON 매핑 예외 처리
	            e.printStackTrace();
	        } catch (JsonProcessingException e) {
	            // JSON 처리 예외 처리
	            e.printStackTrace();
	        } 
	    }
	    return dto;
	}

	// 현재 시간부터 모레의 날씨 정보까지 가져와서 리스트화하기 -> 자세히 보기
	public Map<String, Map<String, VilageFcstBeach_DTO>> getWeatherForecast(int beach_num, String getCurrentDateString, String basetime) {
	    // 최종!! 날짜와 시간 별로 구분된 데이터를 그룹화하는 맵 + LinkedHashMap으로 순서 유지
	    Map<String, Map<String, VilageFcstBeach_DTO>> groupedData = new LinkedHashMap<>();
	    VilageFcstBeach_DTO dto = new VilageFcstBeach_DTO(
	            "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-"
	    	    );
	    final int maxRetries = 3; // 최대 재시도 횟수
	    for (int retry = 0; retry < maxRetries; retry++) {
	        try {
	            // 요청 api의 String 결과
	            String text = getVilageFcstBeach_API(beach_num, getCurrentDateString, basetime, 3);
	            if (text != null) {
	                JsonNode rootNode = objectMapper.readTree(text);
	                String resultCode = rootNode.path("response").path("header").path("resultCode").asText();
		            if(resultCode.equals("00")){
		                JsonNode itemNode = rootNode.path("response").path("body").path("items").path("item");
	
		                // 날짜를 기준으로 데이터를 그룹화하는 맵 + LinkedHashMap으로 순서 유지
		                Map<String, List<JsonNode>> dateGroupedData = new LinkedHashMap<>();
		                // 날자 기준 데이터를 그룹화
		                for (JsonNode item : itemNode) {
		                    String fcstDate = item.get("fcstDate").asText();
		                    dateGroupedData.putIfAbsent(fcstDate, new ArrayList<>()); // groupedData에 해당 키가 존재하지 않으면 새로운 리스트를 만들고, 아니라면 null을 반환
		                    dateGroupedData.get(fcstDate).add(item);
		                }
		                for(String key : dateGroupedData.keySet()) { // dateGroupedData의 키 값(날짜 정보들) 세트로 반복
		                    List<JsonNode> itemList = dateGroupedData.get(key); // 키의 밸류값을 가져옴(날짜 별로 저장된 jsonnode 모음)
		                    // 시간을 기준으로 노드를 한 번 더 그룹화하는 맵 + 순서 유지
		                    Map<String, List<JsonNode>> timeGroupedData = new LinkedHashMap<>();
		                    // 시간 별로 node 묶어주기
		                    for (JsonNode node : itemList) {
		                        String fcstTime = node.get("fcstTime").asText();
		                        timeGroupedData.putIfAbsent(fcstTime, new ArrayList<>());
		                        timeGroupedData.get(fcstTime).add(node);
		                    }
		                    
		                    // 시간 별 쌍을 저장할 map 만들어주기
		                    Map<String, VilageFcstBeach_DTO> timeObjectData = new LinkedHashMap<>();
		                    // 시간 별로 category랑 value 쌍 만들어주기
		                    for(String time : timeGroupedData.keySet()) {
		                        
		                        JSONObject jsonObject = new JSONObject();
		                        jsonObject.put("fcstTime", time);
		                        jsonObject.put("fcstDate", key);
		                        
		                        for(JsonNode item : timeGroupedData.get(time)) {
		                            jsonObject.put(item.path("category").asText(), item.path("fcstValue").asText());
		                        }
		                        // 오류 방지 차원
		                        objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		                        if(jsonObject.length()!=0) {
		                        	dto = objectMapper.readValue(jsonObject.toString(), VilageFcstBeach_DTO.class);
		                        }
		                        System.out.println("jsonObject: " + jsonObject);
		                        timeObjectData.put(time, dto);
		                    }
		                    groupedData.put(key, timeObjectData);
		                }
		            }
	            }
	            break; // 성공적으로 API 호출 및 처리를 완료하면 반복문 종료
	        } catch (JsonParseException e) {
	            // IO 예외 처리
	            e.printStackTrace();
	            if (retry < maxRetries - 1) {
	                // 최대 재시도 횟수를 초과하지 않았을 경우에만 다시 시도
	                continue;
	            } else {
	                // 최대 재시도 횟수를 초과한 경우에는 그냥 null 반환
	                return null;
	            }
	        } catch (JsonMappingException e) {
	            // JSON 매핑 예외 처리
	            e.printStackTrace();
	        } catch (JsonProcessingException e) {
	            // JSON 처리 예외 처리
	            e.printStackTrace();
	        } 
	    }   
	    return groupedData;
	}
	
	
	// 3개년치 정보 가져오기
	public Map<String, getWthrDataList_DTO> getThreeYearWeatherForecast(int pointcode, int beach_code) {
		Map<String, getWthrDataList_DTO> getWthrDataListMap = new LinkedHashMap<String, getWthrDataList_DTO>();		
		for (int i = 1; i < 4; i++) {
	        String setStringDate = LocalDate.now().minusYears(i).format(DateTimeFormatter.ofPattern("yyyyMMdd"));
	        getWthrDataList_DTO gdto = getWthrDataList_API(pointcode, setStringDate);
	        String wh = getWhBuoyBeach_API(beach_code, (setStringDate + DateDAO.getCurrentTime()));
	        System.out.println("파고는? " + wh);
	        gdto.setWh(wh);
	        getWthrDataListMap.put(setStringDate, gdto);
	    }
		return getWthrDataListMap;
	}
	
	// 3개년 날씨 정보 검색하기
	public List<getWthrDataList_DTO> searchThreeYearWeatherForecast(int beach_code, int pointcode, String monthInput, String dayInput, int setYear) {
		List<getWthrDataList_DTO> list = new ArrayList<getWthrDataList_DTO>();
		
		if (Integer.parseInt(monthInput + dayInput) >= Integer.parseInt(DateDAO.getCurrentDateString().substring(4))) {
            setYear = setYear - 1;
        }

        for (int i = 0; i < 3; i++) {
            System.out.println((i + 1) + "번째 시도");
            String setStringYear = String.valueOf(setYear);
            getWthrDataList_DTO gdto = getWthrDataList_API(pointcode, setStringYear + monthInput + dayInput);
            String wh = getWhBuoyBeach_API(pointcode, (setStringYear + monthInput + dayInput + DateDAO.getCurrentTime()));
            System.out.println("파고는? " + wh);
            gdto.setWh(wh);
            list.add(gdto);
            setYear = setYear - 1;
        }
		return list;
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
            
            // response.header.resultCode 값을 가져옴
	        String resultCode = getValueByTagName(rootElement, "resultCode");

	        // resultCode가 "00"이 아니면 null 반환
	        if (!"00".equals(resultCode)) {
	            return null;
	        } else {
	        	return getValueByTagName(rootElement, keyword);
	        }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
		return null;
    }

	// 특정 태그 이름을 가진 노드의 값을 반환하는 메서드
	private String getValueByTagName(Element element, String tagName) {
	    NodeList nodeList = element.getElementsByTagName(tagName);
	    // 특정 태그 이름을 가진 모든 노드를 선택하여 리스트를 반환
        // 이후 모든 종류의 노드들 중, 엘리먼트 노드만 선택
	    for (int i = 0; i < nodeList.getLength(); i++) {
	        Node node = nodeList.item(i);
	        if (node.getNodeType() == Node.ELEMENT_NODE) {
	            return node.getTextContent().trim();
	        }
	    }
	    return null;
	}
	
	private String convertavgTca(double avgTca) {
		double pattern [] = {0,3,6,9};
		String result [] = {"맑음", "구름 조금", "구름 많음", "흐림"};
		ChoiceFormat cf = new ChoiceFormat(pattern, result);
		
		return cf.format(avgTca);
		
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

    public String calculateWeatherIndex(String sky, String rain, double wind, double wave, List<String> resultString) {
        double rn1 = 
        		rain.equals("강수없음") ? 0 : 
        		rain.equals("1mm 미만") ? 0.5 : 
        		rain.equals("50mm 이상") ? 50 : 
        		Double.parseDouble(rain.substring(0, rain.length() - 2));

    	int score = 0;
    	
        for (int i = 0; i < 1; i++) { // 한 번만 반복
            // 하늘 상태에 따른 점수 계산
            if (sky.equals("1")) {
                score += 4;
            } else if (sky.equals("3")) {
                score += 2;
            } else {
                score += 1; // 기타 경우에 대해 가장 낮은 점수 부여
            }
            System.out.println("하늘점수: "+score);
            // 강수량에 따른 점수 계산
            if (rn1 >= 10) {
                score = 0;
                break; // 바로 반복문 종료
            } else if (rn1 >= 5) {
                score += 2;
            } else if (rn1 >= 1) {
                score += 3;
            } else if (rn1 == 0){
                score += 5;
            } else {
                score += 4;
            }
            System.out.println("강수량점수: "+score);
            // 바람에 따른 점수 계산
            if (wind < 1.6) {
                score += 5;
            } else if (wind < 3.4) {
                score += 4;
            } else if (wind < 5.5) {
                score += 3;
            } else if (wind < 8) {
                score += 2;
            } else {
                score = 0;
                break; // 바로 반복문 종료
            }
            System.out.println("바람점수: "+score);
            // 파고에 따른 점수 계산
            if (wave >= 3) {
                score = 0;
                break; // 바로 반복문 종료
            } else if (wave >= 2) {
                score += 2;
            } else if (wave >= 1) {
                score += 3;
            } else if (wave >= 0.5) {
                score += 4;
            } else {
                score += 5;
            }
        }

        System.out.println("총점수: "+score);
        // 최종 날씨 지수 계산
        String weatherIndex = convertToChoiceFormat(score);
        
        // 특보 현황에 따라 바다 여행 지수 반환 결정
    	if(!resultString.isEmpty() || resultString != null) {
        	for(String wrn : resultString) {
        		weatherIndex = 
    				wrn.contains("풍랑") ? "매우 나빠" : 
					wrn.contains("강풍") ? "매우 나빠" : 
					wrn.equals("폭염주의보") ? "나빠" :
					wrn.equals("폭염경보") ? "매우 나빠" : 
					wrn.contains("호우") ? "매우 나빠" : 
					wrn.contains("대설") ? "매우 나빠" : 
					wrn.contains("한파") ? "매우 나빠" : 
					wrn.contains("폭풍해일") ? "매우 나빠" : 									
					wrn.contains("태풍") ? "매우 나빠" : 	
						weatherIndex;
        	}
        }
        return weatherIndex;
    }


    // 날씨 지수를 초이스 포맷으로 변환하는 메서드
    private String convertToChoiceFormat(int score) {
        String result = "";

        if (score >= 19) {
            result = "매우 좋아";
        } else if (score >= 15) {
            result = "좋아";
        } else if (score >= 11) {
            result = "그저그래";
        } else if (score >= 7) {
            result = "나빠";
        } else {
            result = "매우 나빠";
        }

        return result;
    }

}
