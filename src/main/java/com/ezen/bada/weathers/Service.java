package com.ezen.bada.weathers;

import java.util.List;

public interface Service {

	int weather_beachName(String beachName);

	Bada_default_DTO weather_beach_defaultInfo(String beach_code);

	List<Bada_default_DTO> getbadalist(String area);

	List<Bada_default_DTO> getbadalist2(String area1, String area2);

	Bada_info_DTO getbeachinfo(int beach_code);

	double getbeachlat(int beach_code);

	double getbeachlog(int beach_code);
	
	Bada_default_DTO get_Beach_list_data(int beach_code);

}
