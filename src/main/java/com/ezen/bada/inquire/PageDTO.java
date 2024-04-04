package com.ezen.bada.inquire;

public class PageDTO {
             // 현재페이지, 시작페이지, 끝페이지, 레코드총갯수, 페이지당레코드의수, 전체페이지, 쿼리 start, end
	private int nowPage, startPage, endPage, total, cntPerPage, lastPage, start, end;
	private int cntPage=5;  //한 화면에 표시하고자 하는 페이지의 수}
	// ex) 화면에 1,2,3 ▶ 혹은 ◀ 2,3,4 이런 식으로 숫자로 된 페이지는 3개만 띄우고 싶다면? cntPage는 3이 된다.
	
	public PageDTO() {} // 기본 생성자
	public PageDTO(int total, int nowPage, int cntPerPage) { // 인수 생성자
		// 7개의 필드를 초기화 한다. -> 세터 함수 및 자체 메소드 활용
		// 1. 세터 활용
		setNowPage(nowPage); // 현재 페이지 설정
		setCntPerPage(cntPerPage); // 한 페이지에 들어갈 레코드 수 설정
		setTotal(total); // 레코드 총 개수 설정
		
		// 2. 자체 메소드 활용
		calcLastPage(getTotal(), getCntPerPage()); //전체 페이지 수(lastPage) 계산
		calcStartEndPage(getNowPage(), cntPage); // 시작페이지(startPage)와 끝 페이지(endPage) 계산 
		calcStartEnd(getNowPage(), getCntPerPage()); // 쿼리 start, end 설정                 
	}   
	
	// 전체 페이지 수 -> 전체 레코드를 페이지로 묶었을 때 가장 마지막에 나올 페이지 번호
	public void calcLastPage(int total, int cntPerPage) {
		setLastPage((int) Math.ceil((double)total / (double)cntPerPage)); // Math.ceil : 반올림 함수
	}   
	
	//시작페이지와 끝 페이지 
	public void calcStartEndPage(int nowPage, int cntPage) {
		// 1. 화면에 뜨는 끝 페이지 계산
		setEndPage(((int)Math.ceil((double)nowPage / (double)cntPage)) * cntPage);
		if (getLastPage() < getEndPage()) { // 전체 페이지 수보다 마지막 페이지의 수가 크다는 계산이 나오면 그건 오류.
			setEndPage(getLastPage()); // 마지막 페이지가 전체 페이지 수와 같을 수 있도록 재설정
		/* ex) 
		 * cntPage가 2이고, nowPage이자 lastPage는 5로 나왔을 때를 가정하고 계산. 
		 * 화면에는 두 페이지씩 떠야 하지만, 맨 마지막 페이지에서는 숫자 5 하나만 떠야 하는 상황.
		 * 기존 계산식대로라면 endPage가 6이 되지만, 그렇게 하면 전체 페이지보다 커버리기 때문에
		 * 이럴 때의 예외처리를 위해 끝페이지를 전체페이지수로 재설정 하는 것.
		*/
		}
		
		// 2. 화면에 뜨는 시작 페이지 계산
		setStartPage(getEndPage() - cntPage + 1);
		if(getStartPage() < 1) { // 시작 페이지가 1보다 작다는 계산이 나와도, 무조건 1로 재설정 될 수 있도록
		   setStartPage(1);
	   /* ex) 
		 * cntPage가 2 이상인데, 게시글 수 부족으로 현재 페이지도 1, endPage도 1인 경우
		 * 기존 계산식대로라면 startPage가 마이너스가 되지만 그것은 불가능하므로, 예외처리
		*/
	   }
	}              
	
	//DB쿼리에 정의할  start,end 
	public void calcStartEnd(int nowPage, int cntPerPage) {
	setEnd(nowPage * cntPerPage);
	setStart(getEnd() - cntPerPage + 1);
	/* ex) 현재 페이지가 2, cntPerPage는 5라고 가정
	 * 2 페이지의 끝 레코드는 2*5인 10번째 레코드
	 * 2 페이지의 시작 레코드는 10-5+1인 6번째 레코드 */
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