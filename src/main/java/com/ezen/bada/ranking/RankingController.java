package com.ezen.bada.ranking;

import java.io.IOException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ezen.bada.ranking.Service;
import com.ezen.bada.weathers.Bada_info_DTO;

@Controller
public class RankingController {

	@Autowired
	SqlSession sqlsession;
	
	
	@RequestMapping(value = "/ranking_page")
	public String ranking1(Model mo) {
		com.ezen.bada.weathers.Service service = sqlsession.getMapper(com.ezen.bada.weathers.Service.class);
		com.ezen.bada.ranking.Service ss = sqlsession.getMapper(com.ezen.bada.ranking.Service.class);
		
		
		// 바라는 바다 유저들이 가장 많이 찾아 본 바다 top3 바다
		List<RankingBeachDTO> viewCountlist = ss.viewTopThree();
		for(int i=0;i<viewCountlist.size();i++) {
			Bada_info_DTO bdt = service.getbeachinfo(viewCountlist.get(i).getBeach_code());
			viewCountlist.get(i).setBdt(bdt);
		}
		
		// 후기가 가장 많은 바다 top3
		List<RankingBeachDTO> reviewCountlist = ss.reviewTopThree();
		System.out.println(reviewCountlist.size());
		for(int i=0;i<reviewCountlist.size();i++) {
			Bada_info_DTO bdt = service.getbeachinfo(viewCountlist.get(i).getBeach_code());
			reviewCountlist.get(i).setBdt(bdt);
		}
		
		// 리뷰 별점이 높은 바다 top3
		List<RankingBeachDTO> reviewScorelist = ss.reviewScoreTopThree();
		for(int i=0;i<reviewScorelist.size();i++) {
			Bada_info_DTO bdt = service.getbeachinfo(viewCountlist.get(i).getBeach_code());
			reviewScorelist.get(i).setBdt(bdt);
		}
		
		// 재방문 의사가 높은 바다 top3
		List<RankingBeachDTO> re_visitlist = ss.re_visitTopThree();
		for(int i=0;i<re_visitlist.size();i++) {
			Bada_info_DTO bdt = service.getbeachinfo(viewCountlist.get(i).getBeach_code());
			re_visitlist.get(i).setBdt(bdt);
		}
		
		// 최다 bbti top3
		List<RankingBBTIDTO> topBBTIlist = ss.bbtiTopThree();
		
		// 해시태그 별 추천 바다 top3
		List<RankingHashtagDTO> tophashtaglist = ss.hashtagTopThree();
		
		mo.addAttribute("viewCountlist", viewCountlist);
		mo.addAttribute("reviewCountlist", reviewCountlist);
		mo.addAttribute("reviewScorelist", reviewScorelist);
		mo.addAttribute("re_visitlist", re_visitlist);
		mo.addAttribute("topBBTIlist", topBBTIlist);
		mo.addAttribute("tophashtaglist", tophashtaglist);
		
		return "ranking_page";
	}
	
	@RequestMapping("/pythonBBTI")
	public String pythonBBTI() throws IOException, InterruptedException {
	    String path; // 실행될 파이썬 파일의 경로 설정
	    ProcessBuilder processBuilder; // 실행 객체
	    path = "C:\\이젠디지털12\\spring\\bada\\bada_bbtiOut.py";
	    processBuilder=new ProcessBuilder("python",path);
	    processBuilder.redirectErrorStream(true);
	    Process process=processBuilder.start();
	    int result=process.waitFor(); // 0이면 성공, 나머지는 실패

	    return "redirect:/ranking_page";
	}
	
}
