package com.ezen.bada.weathers;

import java.text.ChoiceFormat;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

public class DateDAO {
	// LocalDate 클래스 사용
    // 현재 날짜를 문자열로 변환 (yyyyMMdd 형식)
    public static String getCurrentDateString() {
        return LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
    }

    // 어제 날짜를 문자열로 변환 (yyyyMMdd 형식)
    public static String getYesterdayDateString() {
        return LocalDate.now().minusDays(1).format(DateTimeFormatter.ofPattern("yyyyMMdd"));
    }

    // LocalTime 클래스 사용
    // 현재 시간
    public static String getCurrentTime() {
        return LocalTime.now().format(DateTimeFormatter.ofPattern("HHmm"));
    }
    
    // 현재 시간을 분 단위로 반올림한 뒤 30분 단위로 설정
    public static String setToThirtyMinutes() {
        LocalTime currentTime = LocalTime.now();
        int minutes = currentTime.getMinute();
        if(minutes > 30)
        {
        	currentTime =  currentTime.withMinute(30);
        }
        else {
        	currentTime =  currentTime.minusHours(1).withMinute(30);
        }
        return currentTime.format(DateTimeFormatter.ofPattern("HHmm"));
    }

    // 현재 시간을 분 단위로 반올림한 뒤 다음 시간의 정각으로 설정
    public static String setToTopOfHour() {
        LocalTime currentTime = LocalTime.now();
        int minutes = currentTime.getMinute();
        int newHour = (minutes > 30) ? currentTime.getHour() + 1 : currentTime.getHour();
        currentTime = LocalTime.of(newHour, 0);
        return currentTime.format(DateTimeFormatter.ofPattern("HHmm"));
    }
    
    public static Map<String, String> setForecastDate(){
    	Map<String, String> datemap = new HashMap<String, String>();
    	
    	double [] limit = {0, 200, 500, 800, 1100, 1400, 1700, 2000, 2300};
    	String [] basetime = {"2300","0200","0500","0800","1100","1400","1700","2000","2300"};
    	ChoiceFormat cf = new ChoiceFormat(limit, basetime);

    	int getCurrentTime = Integer.parseInt(getCurrentTime());
    	String setDate = getCurrentDateString();
    	if (getCurrentTime < limit[1]) {
    		setDate = getYesterdayDateString();
    	}
    	
    	datemap.put("date", setDate);
    	datemap.put("time", cf.format(getCurrentTime));
    	System.out.println(datemap.get("date"));
    	System.out.println(datemap.get("time"));
		return datemap;
    }
}
