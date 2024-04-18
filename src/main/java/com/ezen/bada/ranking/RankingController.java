package com.ezen.bada.ranking;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ezen.bada.ranking.Service;

@Controller
public class RankingController {

	@Autowired
	SqlSession sqlsession;
	
	
	@RequestMapping(value = "/ranking_page")
	public String ranking1() {
		Service ss = sqlsession.getMapper(Service.class);
		
		// 가장 많이 본 top3 바다
		List<RankingBeachDTO> viewlist = ss.viewTopThree();
		System.out.println(viewlist.size());
		for(int i=0;i<viewlist.size();i++) {
			System.out.println(viewlist.get(i).getBeach());
		}
		return "ranking_page";
	}
	
}
