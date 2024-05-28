package com.ezen.bada.ranking;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ezen.bada.weathers.Bada_info_DTO;
import com.fasterxml.jackson.databind.ObjectMapper;

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
		
		mo.addAttribute("viewCountlist", viewCountlist);
		mo.addAttribute("reviewCountlist", reviewCountlist);
		mo.addAttribute("reviewScorelist", reviewScorelist);
		mo.addAttribute("re_visitlist", re_visitlist);
		mo.addAttribute("topBBTIlist", topBBTIlist);
		
		return "ranking_page";
	}
	
	@ResponseBody
	@RequestMapping(value = "/hashrank", method=RequestMethod.GET, produces = "application/json; charset=UTF-8")
	public String hashrank(String hashtag) {
		
		Service ss = sqlsession.getMapper(Service.class);
		
		List<RankingHashtagDTO> tophashtaglist = ss.hashtagTopThree(hashtag);
		ObjectMapper mapper = new ObjectMapper();
		String jsonList = "";
	    try {
	        jsonList = mapper.writeValueAsString(tophashtaglist);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
		
		return jsonList;
	}

	@ResponseBody
	@RequestMapping(value = "/generateGraph", method=RequestMethod.GET)
    public String generateGraph() throws IOException, InterruptedException {
		
	    // 경로 설정
	    String imgDirStr = "C:\\이젠디지탈12\\spring\\bada\\src\\main\\webapp\\resources\\image";
	    Path imgDirPath = Paths.get(imgDirStr);

	    // 해당 경로에 있는 파일들을 확인하고 graph_image.png 파일이 있는지 여부를 판단
	    boolean graphImageExists = Files.exists(imgDirPath.resolve("graph_image.png"));

	    // graph_image.png 파일이 이미 존재하면 삭제
	    if(graphImageExists) {
	        Files.delete(imgDirPath.resolve("graph_image.png"));
	    }

	    // Python 스크립트 경로 설정
	    String scriptPath = "C:\\이젠디지탈12\\spring\\bada\\bada_bbtiOut.py";
	    ProcessBuilder processBuilder = new ProcessBuilder("python", scriptPath);
	    processBuilder.redirectErrorStream(true);
	    Process process = processBuilder.start();
	    int result = process.waitFor();

	    // Assuming the graph image is saved to ./resources/image/graph_image.png
	    String imgRelativePath = "./resources/image/graph_image.png";

	    // 이미지의 상대 경로 반환
	    return imgRelativePath;

    }
	
}
