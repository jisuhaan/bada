
function clickarea(areaid) {

	var mapsvg = document.getElementById('select_map');
	var svgdoc = mapsvg.contentDocument;
	var yessea_area = svgdoc.querySelectorAll('.yessea');
	var select_area = null;
	
	yessea_area.forEach(function(area){
		area.style.fill = '#CDE4F2';
	});
	
	if(areaid == '경인'){
		select_area = svgdoc.getElementById('KR-28');
		select_area2 = svgdoc.getElementById('KR-41');
		select_area.style.fill = '#1B70A6';
		select_area2.style.fill = '#1B70A6';
	}
	else if(areaid == '강원') {
		select_area = svgdoc.getElementById('KR-42');
		select_area.style.fill = '#1B70A6';
	}
	else if(areaid == '부울'){
		select_area = svgdoc.getElementById('KR-26');
		select_area2 = svgdoc.getElementById('KR-31');
		select_area.style.fill = '#1B70A6';
		select_area2.style.fill = '#1B70A6';
	}
	else if(areaid == '충남') {
		select_area = svgdoc.getElementById('KR-44');
		select_area.style.fill = '#1B70A6';
	}
	else if(areaid == '전북') {
		select_area = svgdoc.getElementById('KR-45');
		select_area.style.fill = '#1B70A6';
	}
	else if(areaid == '전남') {
		select_area = svgdoc.getElementById('KR-46');
		select_area.style.fill = '#1B70A6';
	}
	else if(areaid == '경북') {
		select_area = svgdoc.getElementById('KR-47');
		select_area.style.fill = '#1B70A6';
	}
	else if(areaid == '경남') {
		select_area = svgdoc.getElementById('KR-48');
		select_area.style.fill = '#1B70A6';
	}
	else if(areaid == '제주') {
		select_area = svgdoc.getElementById('KR-49');
		select_area.style.fill = '#1B70A6';
	}
	
	
	console.log("svg파일 로드됐니? : "+mapsvg);
	console.log("areaid 들어왔니? : "+areaid);
	console.log("select_area 찾아왔니? : "+select_area);
  
}