package com.ezen.bada.ranking;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class RankingController {

	@Autowired
	SqlSession sqlsession;
	
	
	@RequestMapping(value = "/ranking_page")
	public String ranking1() {
		
		return "ranking_page";
	}
	
}
