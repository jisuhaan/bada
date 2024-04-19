package com.ezen.bada.ranking;

import java.util.List;

public interface Service {

	List<RankingBeachDTO> viewTopThree();

	List<RankingBeachDTO> reviewTopThree();
	
	List<RankingBeachDTO> reviewScoreTopThree();
	
	List<RankingBeachDTO> re_visitTopThree();

	List<RankingBBTIDTO> bbtiTopThree();

	List<RankingHashtagDTO> hashtagTopThree();

}
