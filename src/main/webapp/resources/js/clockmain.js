//시계메인//

function setclock() {

	var d = new Date();
	var hour = d.getHours();
	var year = d.getFullYear();
	var month = d.getMonth()+1;
	var date = d.getDate();
	var weeknum = d.getDay();
	
	if(hour<10){
		hour = "0"+hour;
	}

	
	document.getElementById("clock_by_hour").innerHTML = year + "년 " + month + "월 " + date + "일  " + hour + "시" ;
	
}

window.onload = function() {

	setclock();
	setInterval(setclock,3600000);

}
