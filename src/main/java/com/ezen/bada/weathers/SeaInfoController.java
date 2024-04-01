package com.ezen.bada.weathers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class SeaInfoController {
	
	@Autowired
	SqlSession sqlsession;
	
	   @RequestMapping(value = "/sea_info")
	   public String sea_info1() {
	      return "sea_info";
	   }

	   
	   //지역에 해당하는 바다 이름 리스트를 뽑아옵니다.
	   @ResponseBody
	   @RequestMapping(value = "/bada_listup", method = RequestMethod.GET)
	   public String sea_info2(String area) throws JsonProcessingException {
		   
		   Service ss = sqlsession.getMapper(Service.class);
		   
		   System.out.println("지역 뽑혀왔니? : "+area);
		   
		   List<Bada_default_DTO> badalist;
		   
		   if(area.equals("부울")) { 
			   String area1 = "부산";
			   String area2 = "울산";
			   System.out.println("area1 : "+area1+", area2 : "+area2);
			   badalist = ss.getbadalist2(area1,area2);   
		   }
		   
		   else if(area.equals("경인")) {
			   String area1 = "경기";
			   String area2 = "인천";
			   badalist = ss.getbadalist2(area1,area2);
		   }
		   
		   else {
			   badalist = ss.getbadalist(area);
		   }
		   
		   ObjectMapper om =  new ObjectMapper();
		   String bada_list = om.writeValueAsString(badalist);
		  
		   System.out.println("바다리스트 뽑혀왔니? : "+badalist);
		   System.out.println("json화 되었니? : "+bada_list);
		   
	      return bada_list;
	   }
	
}
