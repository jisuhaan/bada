package com.ezen.bada.member;

public class PageDTO {
	//   현재페이지,	시작페이지,	  끝페이지,   레코드총갯수,	페이지당레코드의수,	전체페이지,		쿼리 start,  end
	private int nowPage,  startPage,   endPage,  total, 	cntPerPage, 	lastPage,    start,    end;
	private int cntPage=3;  //한 화면에 표시하고자 하는 페이지
	public PageDTO() {}
	public PageDTO(int total, int nowPage, int cntPerPage) {
			  // 총게시물수 , 현재 페이지  ,	페이지당 표시할 수 있는 레코드 수
				// 24 ,	 1	, 	10
	setNowPage(nowPage); // 현재 페이지 설정
	setCntPerPage(cntPerPage); // 한 페이지에 들어갈 레코드 수 설정
	setTotal(total); // 레코드 총 개수 설정
	
	//자체 메소드 활용
	calcLastPage(getTotal(), getCntPerPage());
	//			24		,	10 = 3 (LastPage) // 전체 페이지 수 계산
	calcStartEndPage(getNowPage(), cntPage);
				// 1		,	3 = 1 // EndPage = 3 , 	StartPage =1
	calcStartEnd(getNowPage(), getCntPerPage());
			//	1		,		5		= // End =5 , Start =1
	}  
	
	//전체 페이지 수
	public void calcLastPage(int total, int cntPerPage) {
	setLastPage((int) Math.ceil((double)total / (double)cntPerPage));
	   //6
	}
	
	
	//시작페이지와 끝 페이지 
	public void calcStartEndPage(int nowPage, int cntPage) {
	setEndPage(((int)Math.ceil((double)nowPage / (double)cntPage)) * cntPage);
	//3
	
	if (getLastPage() < getEndPage()) {
	//	6   		<  1
	setEndPage(getLastPage());
	}
	
	
	setStartPage(getEndPage() - cntPage + 1); 
	
	//			1			-	3	+1 =-1
	if(getStartPage()<1) {
	setStartPage(1);
	}
	}             
	
	
	//DB쿼리에 정의할  start,end 
	public void calcStartEnd(int nowPage, int cntPerPage) {
	setEnd(nowPage * cntPerPage);
	//1		*		5	=5
	setStart(getEnd() - cntPerPage + 1);
		// 5	-	5		+ 1 = 1
	}
	        
	public int getNowPage() {
	return nowPage;   
	}
	public void setNowPage(int nowPage) {
	this.nowPage = nowPage;   
	}
	public int getStartPage() {   
	return startPage;
	}
	public void setStartPage(int startPage) {
	this.startPage = startPage;
	}
	public int getEndPage() {
	return endPage;
	}
	public void setEndPage(int endPage) {
	this.endPage = endPage;
	}
	public int getTotal() {
	return total;
	}
	public void setTotal(int total) {
	this.total = total;
	}
	public int getCntPerPage() {
	return cntPerPage;
	}
	public void setCntPerPage(int cntPerPage) {
	this.cntPerPage = cntPerPage;
	}
	public int getLastPage() {
	return lastPage;
	}
	public void setLastPage(int lastPage) {
	this.lastPage = lastPage;
	}
	public int getStart() {
	return start;
	}
	public void setStart(int start) {
	this.start = start;
	}
	public int getEnd() {
	return end;
	}
	public void setEnd(int end) {
	this.end = end;
	}
	public int getCntPage() {
	return cntPage;
	}
	public void setCntPage(int cntPage) {
	this.cntPage = cntPage;
	}
}
