//시계메인//

function setclock() {

	var d = new Date();
	var hour = d.getHours();
	var min = d.getMinutes();
	var sec = d.getSeconds();
	var year = d.getFullYear();
	var month = d.getMonth()+1;
	var date = d.getDate();
	var weeknum = d.getDay();
	
	if(hour<10){
		hour = "0"+hour;
	}
	
	if(min<10){
		min = "0"+min;
	}
	
	if(sec<10){
		sec = "0"+sec;
	}

	
	document.getElementById("time").innerHTML = hour + ":" + min + ":" + sec;
	document.getElementById("date").innerHTML = year + "년 " + month + "월 " + date + "일";

}
