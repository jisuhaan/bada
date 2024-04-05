package com.ezen.bada.weathers;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;
// 디코딩된 서비스 키를 사용하고, 이를 메소드에서 인코딩 해주는 게 오류 해결의 핵심!!

import com.fasterxml.jackson.databind.ObjectMapper;

public class APIClient {
	ObjectMapper objectMapper = new ObjectMapper();
	
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
            urlBuilder.append(URLEncoder.encode(param.getKey(), "UTF-8")); // 키값을 인코딩
            urlBuilder.append('=');
            urlBuilder.append(URLEncoder.encode(String.valueOf(param.getValue()), "UTF-8")); // 값 인코딩
        }

        // URL 객체로 URL을 호출함
        System.out.println(urlBuilder.toString());
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


	public Map<String, Object> getUltraSrtFcstBeach_API(int beach_num, String currentDateString, String setToThirtyMinutes) {
		Map<String, Object> result = null;
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
            result = getApi(url, params);
            System.out.println("초단기 API 호출 결과: " + result.get("response"));
        } catch (IOException e) {
            e.printStackTrace();
        }
        return result;
		
	}
	
    public Map<String, Object> getVilageFcstBeach_API(int beach_num, String getYesterday) {
    	Map<String, Object> result = null;
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
            result = getApi(url, params);
            System.out.println("단기 API 호출 결과: " + result.get("response"));
        } catch (IOException e) {
            e.printStackTrace();
        }
        return result;
    }
    
	public Map<String, Object> getLCRiseSetInfo_API(double longitude, double latitude, String currentDateString) {
		Map<String, Object> result = null;
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
            result = getApi(url, params);
            System.out.println("일몰 일출 API 호출 결과: " + result.get("response"));
        } catch (IOException e) {
            e.printStackTrace();
        }
        return result;
		
	}
	
	public Map<String, Object> getTwBuoyBeach_API(int beach_num, String searchTime) {
		Map<String, Object> result = null;
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
            result = getApi(url, params);
            System.out.println("수온 API 호출 결과: " + result.get("response"));
        } catch (IOException e) {
            e.printStackTrace();
        }
        return result;
		
	}
	
	// 지점을 어떻게 검색하게 해줄지를 찾아봐야함
	public Map<String, Object> getWeatherWarning_API(String stnId) {
		System.out.println("시이작!!");
		Map<String, Object> result = null;
    	// API 호출
        String url = "https://apis.data.go.kr/1360000/WthrWrnInfoService/getPwnCd"; /*URL*/
        String serviceKey = "QWzzzAb/UIqP2aANBL1yVlNW3plkWGVz5RX3OJRiMV9J+licoY1Dffo51/i5HTDfU00ZpDy2E4/ASt2FgLknaA=="; 

        // 파라미터 맵 구성
        Map<String, Object> params = new HashMap<>();
        params.put("dataType", "JSON");
        params.put("numOfRows", 10);
        params.put("pageNo", 1);
        params.put("stnId", stnId); // 지점은 String
        params.put("serviceKey", serviceKey);

        // API 호출
        try {
            result = getApi(url, params);
            System.out.println("기온 특보 API 호출 결과: " + result.get("response"));
        } catch (IOException e) {
            e.printStackTrace();
        }
        return result;
		
	}



}
