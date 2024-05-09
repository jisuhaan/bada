package com.ezen.bada.inquire;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import com.ezen.bada.member.MemberDTO;



@Controller
public class InquireController {
	
	
	@Autowired
	SqlSession sqlsession;
	   
	String imagepath="C:\\coding\\spring\\bada\\src\\main\\webapp\\resources\\image_user";
	
	
	
	//문의글 입력창을 띄우기 위해 정보를 가져옴
	@RequestMapping(value = "/inquire_input")
	public String inquireinput(HttpServletRequest request, Model mo, HttpServletResponse response) throws IOException {
	      
		Service ss = sqlsession.getMapper(Service.class);
		HttpSession hs = request.getSession();
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		if (hs.getAttribute("loginstate") == null) {
		    out.print("<script type='text/javascript'> alert('로그인이 필요합니다.');");
		    out.print("window.location.href='login';");
		    out.print("</script>");
		    out.flush();
		    
		    return null;
		}
		else {
			boolean loginstate = (boolean) hs.getAttribute("loginstate");
			
			if(loginstate) {
				
				String loginid = (String) hs.getAttribute("loginid");
				MemberDTO dto = ss.input_info(loginid);
				mo.addAttribute("dto", dto);
				
				return "inquire_input";
			}
			else {
				out.println("<script>alert('로그인한 회원만 이용 가능합니다.'); location.href='login';</script>");
			    out.flush();
			    
			    return null;
			}
		}
	}
	
	
	
	//입력한 문의글을 저장
	@RequestMapping(value = "/inquire_save", method = RequestMethod.POST)
	public String inquiresave(MultipartHttpServletRequest mul) throws IOException {
	    
	    String title = mul.getParameter("title");
	    String category = mul.getParameter("category");
	    String name = mul.getParameter("name");
	    String id = mul.getParameter("id");
	    // 작성 일자는 DB에서 지정
	    String pic1=null, pic2=null, pic3=null, pic4=null, pic5=null;
		String content = mul.getParameter("content");
		String secret = mul.getParameter("secret");
		String secret_pw = mul.getParameter("secret_pw");
		
		MultipartFile mf1=mul.getFile("pic1");
		
		if(mf1 != null && !mf1.isEmpty()) {
			pic1=mf1.getOriginalFilename();
			pic1=filesave1(pic1, mf1.getBytes());
			}
		else {pic1="nope";}
		
		MultipartFile mf2=mul.getFile("pic2");
		if(mf2 != null && !mf2.isEmpty()) {
			pic2=mf2.getOriginalFilename();
			pic2=filesave2(pic2, mf2.getBytes());
			}
		else {pic2="nope";}
		
		MultipartFile mf3=mul.getFile("pic3");
		if(mf3 != null && !mf3.isEmpty()) {
			pic3=mf3.getOriginalFilename();
			pic3=filesave3(pic3, mf3.getBytes());
			}
		else {pic3="nope";}
		
		MultipartFile mf4=mul.getFile("pic4");
		if(mf4 != null && !mf4.isEmpty()) {
			pic4=mf4.getOriginalFilename();
			pic4=filesave4(pic4, mf4.getBytes());
			}
		else {pic4="nope";}
		
		MultipartFile mf5=mul.getFile("pic5");
		if(mf5 != null && !mf5.isEmpty()) {
			pic5=mf5.getOriginalFilename();
			pic5=filesave5(pic5, mf5.getBytes());
			}
		else {pic5="nope";}
	    
	    if(secret.equals("n")) {secret_pw="free";}

	    Service ss = sqlsession.getMapper(Service.class);
	    ss.inquire_save(title, category, name, id, pic1, pic2, pic3, pic4, pic5, content, secret, secret_pw);

	    return "main";
	}
	//문의글에 넣은 사진들에 별개의 랜덤 문자를 넣음(동일한 이름의 파일이 들어간 경우 구분을 위해)
	private String filesave5(String pic5, byte[] bytes) throws IOException {
		UUID ud=UUID.randomUUID();
		String what5=ud.toString()+"_"+pic5;
		File filename=new File(imagepath+"\\"+what5);
		FileCopyUtils.copy(bytes, filename);
		
		return what5;
	}
	private String filesave4(String pic4, byte[] bytes) throws IOException {
		UUID ud=UUID.randomUUID();
		String what4=ud.toString()+"_"+pic4;
		File filename=new File(imagepath+"\\"+what4);
		FileCopyUtils.copy(bytes, filename);
		
		return what4;
	}
	private String filesave3(String pic3, byte[] bytes) throws IOException {
		UUID ud=UUID.randomUUID();
		String what3=ud.toString()+"_"+pic3;
		File filename=new File(imagepath+"\\"+what3);
		FileCopyUtils.copy(bytes, filename);
		
		return what3;
	}
	private String filesave2(String pic2, byte[] bytes) throws IOException {
		UUID ud=UUID.randomUUID();
		String what2=ud.toString()+"_"+pic2;
		File filename=new File(imagepath+"\\"+what2);
		FileCopyUtils.copy(bytes, filename);
		
		return what2;
	}
	private String filesave1(String pic1, byte[] bytes) throws IOException {
		UUID ud=UUID.randomUUID();
		String what1=ud.toString()+"_"+pic1;
		File filename=new File(imagepath+"\\"+what1);
		FileCopyUtils.copy(bytes, filename);
		
		return what1;
	}


	
	//저장된 문의 사항을 목록화 해서 출력
	@RequestMapping(value="/inquire_listout")
    public String page(HttpServletRequest request, Model mo) {
		
		String sort=request.getParameter("sort");
		if(sort==null || sort.isEmpty()) {sort="latest";}
		
		// 맨 처음 아웃 페이지를 들어갔을 때, 
		// 사용자 화면에 떠야 할 1) 현재 페이지 위치와 2) 페이지 당 들어가는 레코드 수 설정 -> 눌 값일 때마다 적절한 초기화 해주기
	    String nowPage=request.getParameter("nowPage");
	    String cntPerPage=request.getParameter("cntPerPage");
	  /* String 클래스는 객체이기 때문에 == null을 사용 가능하지만, int같은 기본 자료형은 불가하므로,
	   * if문에서 null 확인을 위해 위에서는 String으로 받고, 인수로 넣기 직전에 intger로 변환해줘야 한다.
	   */ 
	    if(nowPage==null && cntPerPage == null) {
	       nowPage="1";
	       cntPerPage="5";
	    }
	    else if(nowPage==null) {        nowPage="1";
	    }
	    else if(cntPerPage==null) {
	       cntPerPage="5";
	    }      
	    
	    // 3) 전체 게시글 수 DB에서 구해오기
	    Service ss = sqlsession.getMapper(Service.class);
	    int total=ss.inquire_list_total();
	     
	    // 생성자로 나머지 페이지 처리에 필요한 필드값들도 모두 계산
	    // 3가지 인수 넣어주기
	    PageDTO dto=new PageDTO(total,Integer.parseInt(nowPage),Integer.parseInt(cntPerPage));
	    mo.addAttribute("paging",dto);
	    // 리스트 안에 특정 페이지마다 출력될 5개 묶음의 레코드 모음 저장
	    
	    if(sort.equals("latest")) {
	    	mo.addAttribute("list",ss.page_inquire_listout_latest(dto));
	    	mo.addAttribute("sort", sort);
	    }
	    else {
	    	mo.addAttribute("list",ss.page_inquire_listout_popular(dto));
	    	mo.addAttribute("sort", sort);
	    }
	    
	    ArrayList<InquireDTO2> list2=ss.inquire_best3();
		mo.addAttribute("list2", list2);
		
	    return "inquire_listout";
    }
	
	
	
	//문의글을 클릭 시, 비밀글인지 아닌지를 판별하고 비밀글일 시 비밀번호부터 입력하도록 함
	@RequestMapping(value = "/inquire_secret_yn")
	public String inquire_secret_yn(HttpServletRequest request, Model mo) {
		int inquire_num=Integer.parseInt(request.getParameter("inquire_num"));
		String secret=request.getParameter("secret");
		
		Service ss=sqlsession.getMapper(Service.class);
		InquireDTO dto=ss.inquire_detail(inquire_num);
		mo.addAttribute("dto", dto);
		
		if(secret.equals("y")) {return "inquire_secret_yn";}
		else {return "redirect:/to_inquire_detail?inquire_num=" + inquire_num;}
		
	}
	
	
	
	//문의글 디테일 화면(전체 내용 출력 화면)
	@RequestMapping(value = "/to_inquire_detail")
	public String inquire_detail(HttpServletRequest request,Model mo) {
		int inquire_num=Integer.parseInt(request.getParameter("inquire_num"));
		
		Service ss=sqlsession.getMapper(Service.class);
		ss.inquire_updatecnt(inquire_num);
		InquireDTO dto=ss.inquire_detail(inquire_num);
		mo.addAttribute("dto", dto);
		
		//댓글 출력
		ArrayList<Inquire_reply_DTO> list=ss.inquire_reply_out(inquire_num);
		mo.addAttribute("list", list);
		
		return "inquire_detail";
	}
	
	
	
	
	
	//문의글을 검색
	@RequestMapping(value="/inquire_search")
    public String inquire_search(HttpServletRequest request, Model mo) {
		
		String keyword=request.getParameter("search_keyword");
		String value=request.getParameter("search_value");
		String category=request.getParameter("category");
		String i_date=request.getParameter("i_date");
		Service ss = sqlsession.getMapper(Service.class);
		ArrayList<InquireDTO> list;
	      
	         if(category.equals("") && i_date.equals("")) { //카테고리와 날짜를 모두 입력하지 않은 경우
	            list=ss.inquire_search_out1(keyword, value);
	         }//내부 if문 끝
	         else if(category.equals("")) { //카테고리는 입력하지 않고 날짜는 입력한 경우
	            list=ss.inquire_search_out2(keyword, value, i_date);
	         }//내부 else if문 끝
	         else if(i_date.equals("")) { //카테고리는 입력하고 날짜는 입력하지 않은 경우
	            list=ss.inquire_search_out3(keyword, value, category);
	         }//내부 else if문2 끝
	         else { //카테고리와 날짜를 모두 입력한 경우
	            list=ss.inquire_search_out4(keyword, value, category, i_date);
	         }//내부 else문 끝
	      
	      
	    mo.addAttribute("list", list);
	    
	    return "inquire_search_view";
    }
	
	
	
	
	
	//문의글을 삭제(작성자, 관리자만 허용)하는 경우, 그리고 문의글 삭제 시 문의글에 달린 답변도 자동삭제, 문의글에 첨부돼 있던 사진도 자동 삭제
	@RequestMapping(value = "inquire_delete")
	public String inquire_delete(HttpServletRequest request) {
		
		int inquire_num = Integer.parseInt(request.getParameter("inquire_num"));
	    Service ss = sqlsession.getMapper(Service.class);
	    InquireDTO idto = ss.all_photo(inquire_num);
	     
	    List<String> photoPaths = Arrays.asList(idto.getPic1(), idto.getPic2(), 
									    		 idto.getPic3(), idto.getPic4(), 
									    		 idto.getPic5());
		for(String pics : photoPaths) {
			
			if(pics != null && !pics.equals("nope")) 
			{File file = new File(imagepath+"\\"+pics);
				
				if(file.exists()) {file.delete();}
			}
		}
	    ss.inquire_delete(inquire_num); //문의글 삭제
	    ss.inquire_reply_delete_when_inquire_delete(inquire_num); //문의글 삭제 시 거기에 달린 답변도 함께 삭제
	     
	    //해당 문의글의 답 여부(댓글 갯수) 수정
		int reply_count=0;
		reply_count= ss.inquire_reply_count(inquire_num);
		if(reply_count==0) {System.out.println("답이 없네");} //답 갯수가 0인 경우
		else {ss.inquire_reply_check(inquire_num);} //

		return "redirect:/inquire_listout?sort=latest";
	}
	
	
	
	  
	  
	//문의글을 수정하는 경우, 수정을 위해 기존 글 등에 대한 데이터를 가져옴
	@RequestMapping(value = "inquire_modify")
	public String inquire_modify(HttpServletRequest request, Model mo) {

	     int inquire_num = Integer.parseInt(request.getParameter("inquire_num"));
	     Service ss = sqlsession.getMapper(Service.class);
	     
	     InquireDTO dto = ss.inquire_modify_view(inquire_num);
	     List<String> photoList = Arrays.asList(dto.getPic1(), dto.getPic2(), dto.getPic3(), dto.getPic4(), dto.getPic5());
	     mo.addAttribute("dto", dto);
	     mo.addAttribute("photoList", photoList);
	     
	     return "inquire_modify_view";
	}
	  
	  
	  
	//문의글을 수정하는 경우에 대한 저장. 우선은 사진을 제외한 내용의 저장.
	@RequestMapping(value = "inquire_modify_save", method = RequestMethod.POST)
	public String inquire_modify_save(MultipartHttpServletRequest mul, Model mo) throws IllegalStateException, IOException {
		  
		Service ss = sqlsession.getMapper(Service.class);
		  
		int inquire_num = Integer.parseInt(mul.getParameter("inquire_num"));
		String title=mul.getParameter("title");
		String category = mul.getParameter("category");
		String content = mul.getParameter("content");
		String secret = mul.getParameter("secret");
		String secret_pw = mul.getParameter("secret_pw");
		
		boolean new_photos = false;
	    for (int i = 1; i <= 5; i++) {
	        MultipartFile file = mul.getFile("pic" + i);
	        if (file != null && !file.isEmpty()) {
	        	new_photos = true;
	            break; // 새로운 파일이 하나라도 있으면 반복 종료
	        }
	    }
	    if (new_photos) {
	    	InquireDTO idto = ss.all_photo(inquire_num);
		    List<String> photoPaths = Arrays.asList(idto.getPic1(), idto.getPic2(), 
										    		 idto.getPic3(), idto.getPic4(), 
										    		 idto.getPic5());
			for(String pics : photoPaths) {
				if(pics != null && !pics.equals("nope"))
				{File file = new File(imagepath+"\\"+pics);
					
					if(file.exists()) {file.delete();}
				}
			}
	        modi_photos(mul, inquire_num, ss);
	    }
		ss.inquire_modify_save(title, category, content, secret, secret_pw, inquire_num);
		
		//디테일에 가져가는 정보
		InquireDTO dto=ss.inquire_detail(inquire_num);
		mo.addAttribute("dto", dto);
		
		ArrayList<Inquire_reply_DTO> list=ss.inquire_reply_out(inquire_num);
		mo.addAttribute("list", list);
		
		return "inquire_detail";
	}
	//문의글을 수정하는 경우, 사진 수정을 한 경우
	private void modi_photos(MultipartHttpServletRequest mul, int inquire_num, Service ss) throws IllegalStateException, IOException {
		
		String[] change_photo = new String[5];
	    for (int i = 1; i <= 5; i++) {
	        MultipartFile file = mul.getFile("pic" + i);
	        if (file != null && !file.isEmpty()) {
	            UUID ud = UUID.randomUUID();
	            String fileName = ud.toString() + "_" + file.getOriginalFilename();
	            File newFile = new File(imagepath + "\\" + fileName);
	            file.transferTo(newFile);
	            change_photo[i - 1] = fileName; 
	        } else {
	        	change_photo[i - 1] = "nope";
	        }
	    }
	    
	    Map<String, Object> params = new HashMap<>();
	    params.put("inquire_num", inquire_num);
	    params.put("change_photo", change_photo);
	    ss.update_photo(params);
		
	}
	
	
	
	
	
	//문의글 댓글(관리자 답) 파트
	//문의글에 댓글(관리자 답)을 작성한 경우 저장
	@RequestMapping(value = "/inquire_reply_save", method = RequestMethod.POST)
	public String inquire_reply_save(HttpServletRequest request, Model mo) throws IOException {
	      
		int inquire_num=Integer.parseInt(request.getParameter("inquire_num"));
		String content=request.getParameter("content");
		Service ss=sqlsession.getMapper(Service.class);
		  
		//댓글 저장
		ss.inquire_reply_save(inquire_num, content, inquire_num);
			
		//댓글 출력
		ArrayList<Inquire_reply_DTO> list=ss.inquire_reply_out(inquire_num);
		mo.addAttribute("list", list);
	
		//해당 글에 답 여부(댓글 갯수) 수정
		int reply_count=0;
		reply_count= ss.inquire_reply_count(inquire_num);
		if(reply_count==0) {System.out.println("답이 없네");} //답 갯수가 0인 경우
		else {ss.inquire_reply_check(inquire_num);} //
			
		//디테일에 가져가는 정보
		InquireDTO dto=ss.inquire_detail(inquire_num);
		mo.addAttribute("dto", dto);
		
		return "inquire_detail";
	}
	
	
	
	
	
	//문의글에 달린 답을 삭제하는 경우(답변 여부도 함께 변경)
	@RequestMapping(value = "inquire_reply_delete")
	public String inquire_reply_delete(HttpServletRequest request, Model mo) {

		int inquire_reply_num = Integer.parseInt(request.getParameter("inquire_reply_num"));
		int inquire_num = Integer.parseInt(request.getParameter("inquire_num"));
		 
		Service ss = sqlsession.getMapper(Service.class);
		 
		ss.inquire_reply_delete(inquire_reply_num);
		 
		ArrayList<Inquire_reply_DTO> list=ss.inquire_reply_out(inquire_num);
		mo.addAttribute("list", list);
	     
	   //해당 문의글의 답 여부(댓글 갯수) 수정
		int reply_count=0;
		reply_count= ss.inquire_reply_count(inquire_num);
		if(reply_count==0) {System.out.println("답이 없네");} //답 갯수가 0인 경우
		else {ss.inquire_reply_check(inquire_num);} //
			
		//문의글 디테일에 가져가는 정보
		InquireDTO dto=ss.inquire_detail(inquire_num);
		mo.addAttribute("dto", dto);
		
		return "inquire_detail";
	}
	  
	
	
	  
	  
	//문의글에 달린 답을 수정하는 경우
	@RequestMapping(value = "inquire_reply_modify")
	public String inquire_reply_modify(HttpServletRequest request, Model mo) {

	    int inquire_reply_num = Integer.parseInt(request.getParameter("inquire_reply_num"));
	  	int inquire_num = Integer.parseInt(request.getParameter("inquire_num"));
	  	String newcontent = request.getParameter("newcontent");
	  	 
	    Service ss = sqlsession.getMapper(Service.class);
	    
	    ss.inquire_reply_modify(newcontent, inquire_reply_num);
	    
	    ArrayList<Inquire_reply_DTO> list=ss.inquire_reply_out(inquire_num);
		mo.addAttribute("list", list);
		
		//문의글 디테일에 가져가는 정보
		InquireDTO dto=ss.inquire_detail(inquire_num);
		mo.addAttribute("dto", dto);
		
		return "inquire_detail";
	}
	
	
	
	
	
	//문의글의 추천과 신고
	//문의글에 추천을 누른 경우 추천 수 증가 및 추천 시 중복 방지
	@RequestMapping(value = "/inquire_recommand")
	public String inquire_recommand(HttpServletRequest request, Model mo, HttpServletResponse response) throws IOException, ServletException {
		int inquire_num=Integer.parseInt(request.getParameter("inquire_num"));
		String loginid=request.getParameter("loginid");
		
		Service ss=sqlsession.getMapper(Service.class);
		int rec_id_co=ss.inquire_rec_id(inquire_num, loginid);
		
		if(rec_id_co==0) {
		ss.inquire_recommand(loginid, inquire_num);
		InquireDTO dto=ss.inquire_detail(inquire_num);
		mo.addAttribute("dto", dto);
		}
		
		else {
	        InquireDTO dto=ss.inquire_detail(inquire_num);
			mo.addAttribute("dto", dto);
			ArrayList<Inquire_reply_DTO> list=ss.inquire_reply_out(inquire_num);
			mo.addAttribute("list", list);
		}
		
		return "inquire_detail";
	}
		
	
	
		
		
	//문의글을 신고할 시 보이는 신고 화면에 데이터를 넣어줌
	@RequestMapping(value = "/inquire_report_view")
	public String inquire_report_view(HttpServletRequest request,Model mo) {
		int inquire_num=Integer.parseInt(request.getParameter("inquire_num"));
		String loginid=request.getParameter("loginid");
		
		Service ss=sqlsession.getMapper(Service.class);
		
		MemberDTO mdto = ss.input_info(loginid);
		mo.addAttribute("mdto", mdto);
		
		InquireDTO idto=ss.inquire_detail(inquire_num);
		mo.addAttribute("idto", idto);
		
		String ban_id=idto.getId();
		int ban_user_number=ss.ban_user_number(ban_id);
		mo.addAttribute("ban_user_number", ban_user_number);
		
		return "inquire_report_view";
	}
		

	
	//문의글을 신고할 시 중복 신고가 허용되지 않도록 DB에서 신고 정보를 찾아봄
	@ResponseBody
	@RequestMapping(value = "/inquire_ban_check", method = RequestMethod.POST)
	public String inquire_ban_check(HttpServletRequest request) throws IOException {
      
        String id = request.getParameter("id");
        int ban_inquire_num=Integer.parseInt(request.getParameter("ban_inquire_num"));
        String category = request.getParameter("category");
        String content = request.getParameter("content");
        
        Service ss=sqlsession.getMapper(Service.class);
        String inquire_check="";
        String result="";
        inquire_check=ss.inquire_ban_check(id, ban_inquire_num, category, content); //동일한 사람이 동일한 글을 동일한 사유로 여러번 신고할 수 없도록 중복 방지
        
        if (inquire_check==null) {result="ok";}
        else {result="nope";}
        
        return result;
	}
	
	
	
	//중복 신고가 아닌 경우 신고 내역 저장
	@RequestMapping(value = "/inquire_ban_save", method = RequestMethod.POST)
	public String inquire_ban_save(HttpServletRequest request, Model mo, HttpServletResponse response) throws IOException {
      
      	String title = request.getParameter("title");
        String name = request.getParameter("name");
        String id = request.getParameter("id");
        int ban_inquire_num=Integer.parseInt(request.getParameter("ban_inquire_num"));
        String ban_name = request.getParameter("ban_name");
        String ban_id = request.getParameter("ban_id");
        String category = request.getParameter("category");
        String content = request.getParameter("content");
        int ban_user_number=Integer.parseInt(request.getParameter("ban_user_number"));

        Service ss=sqlsession.getMapper(Service.class);
        ss.inquire_ban_save(title, name, id, ban_inquire_num, ban_name, ban_id, category, content, ban_user_number);
        
        InquireDTO dto=ss.inquire_detail(ban_inquire_num);
		mo.addAttribute("dto", dto);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
	    out.print("<script type='text/javascript'>");
	    out.print("window.opener.location.href='inquire_listout?sort=latest'; window.close();");
	    out.print("</script>");
	    out.flush();
    
	    return null;
	}
	
	
	
	
	
	//관리자에게만 보이는 신고내역 페이지
	@RequestMapping(value="/inquire_ban_listout")
	public String inquire_ban_listout(HttpServletRequest request, Model mo) {
		// 맨 처음 아웃 페이지를 들어갔을 때, 
		// 사용자 화면에 떠야 할 1) 현재 페이지 위치와 2) 페이지 당 들어가는 레코드 수 설정 -> 눌 값일 때마다 적절한 초기화 해주기
	    String nowPage=request.getParameter("nowPage");
	    String cntPerPage=request.getParameter("cntPerPage");
	  /* String 클래스는 객체이기 때문에 == null을 사용 가능하지만, int같은 기본 자료형은 불가하므로,
	   * if문에서 null 확인을 위해 위에서는 String으로 받고, 인수로 넣기 직전에 intger로 변환해줘야 한다.
	   */ 
	    if(nowPage==null && cntPerPage == null) {
	       nowPage="1";
	       cntPerPage="5";
	    }
	    else if(nowPage==null) {        nowPage="1";
	    }
	    else if(cntPerPage==null) {
	       cntPerPage="5";
	    }      
	    
	    // 3) 전체 게시글 수 DB에서 구해오기
	    Service ss = sqlsession.getMapper(Service.class);
	    int total=ss.inquire_ban_list_total();
	     
	    // 생성자로 나머지 페이지 처리에 필요한 필드값들도 모두 계산
	    // 3가지 인수 넣어주기
	    PageDTO dto=new PageDTO(total,Integer.parseInt(nowPage),Integer.parseInt(cntPerPage));
	    mo.addAttribute("paging",dto);
	    // 리스트 안에 특정 페이지마다 출력될 5개 묶음의 레코드 모음 저장
	    mo.addAttribute("list",ss.page_inquire_ban_listout(dto));
	    return "inquire_ban_listout";
	}
	
	
	
	//관리자에게만 보이는 신고 상세 내역 페이지
	@RequestMapping(value="/inquire_ban_detail")
	public String inquire_ban_detail(HttpServletRequest request, Model mo) {
		
		int i_banned_num=Integer.parseInt(request.getParameter("i_banned_num"));
		String ban_id=request.getParameter("ban_id");
		
		Service ss=sqlsession.getMapper(Service.class);
		//신고 내역 상세
		Inquire_ban_DTO dto=ss.inquire_ban_detail(i_banned_num);
		mo.addAttribute("dto", dto);
		
		//신고당한 사람과 동일한 아이디의 레코드 갯수
		int ban_count=ss.inquire_ban_count(ban_id);
		mo.addAttribute("ban_count", ban_count);
		
		//신고당한 사람과 동일한 아이디의 레코드를 모두 가져옴
		ArrayList<Inquire_ban_DTO2> dto2=ss.inquire_dan_list2(ban_id);
		mo.addAttribute("dto2", dto2);
		
	    return "inquire_ban_detail";
	}
	
	
	
	
	
	//관리자 권한에서 신고 내역 삭제
	@RequestMapping(value="/inquire_ban_delete")
	public String inquire_ban_delete(HttpServletRequest request) {
		
		int i_banned_num=Integer.parseInt(request.getParameter("i_banned_num"));
		
		Service ss=sqlsession.getMapper(Service.class);
		ss.inquire_ban_delete(i_banned_num);
		
		return "redirect:/inquire_ban_listout";
	}

	
	
	
	
	//1:1문의 파트
	//1:1문의 입력창
	@RequestMapping(value = "/inquire_personal_view")
	public String inquire_personal_view(HttpServletRequest request, Model mo, HttpServletResponse response) throws IOException {
		
		Service ss = sqlsession.getMapper(Service.class);
		HttpSession hs = request.getSession();
		response.setContentType("text/html; charset=UTF-8");
		
		if (hs.getAttribute("loginstate") == null) {
		   String loginid="nope";
		   String email="nope";
		   mo.addAttribute("loginid", loginid);
		   mo.addAttribute("email",email);
		   
		   return "inquire_personal_view";
		}
		
		else {
			boolean loginstate = (boolean) hs.getAttribute("loginstate");
			if(loginstate) {
				String loginid = (String) hs.getAttribute("loginid");
				MemberDTO dto = ss.inquire_personal_view(loginid);
				mo.addAttribute("dto", dto);
				
				return "inquire_personal_view";
			}
			else {
				String loginid="nope";
				String email="nope";
				mo.addAttribute("loginid", loginid);
				mo.addAttribute("email",email);
			   
				return "inquire_personal_view";
			}
		}
	}
		
		
	
	
		
	//입력한 1:1 문의글을 저장
	@RequestMapping(value = "/inquire_personal_save", method = RequestMethod.POST)
	public String inquire_personal_save(MultipartHttpServletRequest mul) throws IOException {
	    
	    String title = mul.getParameter("title");
	    String name = mul.getParameter("name");
	    String id = mul.getParameter("id");
	    String email = mul.getParameter("email");
	    String category = mul.getParameter("category");
	    String content = mul.getParameter("content");
	    // 작성 일자는 DB에서 지정
	    String pic1=null, pic2=null, pic3=null, pic4=null, pic5=null;
		
		MultipartFile mf1=mul.getFile("pic1");
		if(mf1 != null && !mf1.isEmpty()) {
			pic1=mf1.getOriginalFilename();
			pic1=filesavee1(pic1, mf1.getBytes());
			}
		else {pic1="nope";}
		
		MultipartFile mf2=mul.getFile("pic2");
		if(mf2 != null && !mf2.isEmpty()) {
			pic2=mf2.getOriginalFilename();
			pic2=filesavee2(pic2, mf2.getBytes());
			}
		else {pic2="nope";}
		
		MultipartFile mf3=mul.getFile("pic3");
		if(mf3 != null && !mf3.isEmpty()) {
			pic3=mf3.getOriginalFilename();
			pic3=filesavee3(pic3, mf3.getBytes());
			}
		else {pic3="nope";}
		
		MultipartFile mf4=mul.getFile("pic4");
		if(mf4 != null && !mf4.isEmpty()) {
			pic4=mf4.getOriginalFilename();
			pic4=filesavee4(pic4, mf4.getBytes());
			}
		else {pic4="nope";}
		
		MultipartFile mf5=mul.getFile("pic5");
		if(mf5 != null && !mf5.isEmpty()) {
			pic5=mf5.getOriginalFilename();
			pic5=filesavee5(pic5, mf5.getBytes());
			}
		else {pic5="nope";}

	    Service ss = sqlsession.getMapper(Service.class);
	    ss.inquire_personal_save(title, name, id, email, category, content, pic1, pic2, pic3, pic4, pic5);
	    
	    EmailSender.sendEmail1(name, email, title, category, content); //이메일 송신하는 자바 파일 불러옴

	    return "main";
	}
	//1:1 문의글에 넣은 사진들에 별개의 랜덤 문자를 넣음(동일한 이름의 파일이 들어간 경우 구분을 위해)
	private String filesavee5(String pic5, byte[] bytes) throws IOException {
		UUID ud=UUID.randomUUID();
		String what5=ud.toString()+"_"+pic5;
		File filename=new File(imagepath+"\\"+what5);
		FileCopyUtils.copy(bytes, filename);
		
		return what5;
	}
	private String filesavee4(String pic4, byte[] bytes) throws IOException {
		UUID ud=UUID.randomUUID();
		String what4=ud.toString()+"_"+pic4;
		File filename=new File(imagepath+"\\"+what4);
		FileCopyUtils.copy(bytes, filename);
		
		return what4;
	}
	private String filesavee3(String pic3, byte[] bytes) throws IOException {
		UUID ud=UUID.randomUUID();
		String what3=ud.toString()+"_"+pic3;
		File filename=new File(imagepath+"\\"+what3);
		FileCopyUtils.copy(bytes, filename);
		
		return what3;
	}
	private String filesavee2(String pic2, byte[] bytes) throws IOException {
		UUID ud=UUID.randomUUID();
		String what2=ud.toString()+"_"+pic2;
		File filename=new File(imagepath+"\\"+what2);
		FileCopyUtils.copy(bytes, filename);
		
		return what2;
	}
	private String filesavee1(String pic1, byte[] bytes) throws IOException {
		UUID ud=UUID.randomUUID();
		String what1=ud.toString()+"_"+pic1;
		File filename=new File(imagepath+"\\"+what1);
		FileCopyUtils.copy(bytes, filename);
		
		return what1;
	}
		
		
		
	//저장된 1:1 문의 사항을 목록화 해서 출력
	@RequestMapping(value="/inquire_personal_out")
	public String inquire_personal_out(HttpServletRequest request, Model mo) {
		// 맨 처음 아웃 페이지를 들어갔을 때, 
		// 사용자 화면에 떠야 할 1) 현재 페이지 위치와 2) 페이지 당 들어가는 레코드 수 설정 -> 눌 값일 때마다 적절한 초기화 해주기
	    String nowPage=request.getParameter("nowPage");
	    String cntPerPage=request.getParameter("cntPerPage");
	  /* String 클래스는 객체이기 때문에 == null을 사용 가능하지만, int같은 기본 자료형은 불가하므로,
	   * if문에서 null 확인을 위해 위에서는 String으로 받고, 인수로 넣기 직전에 intger로 변환해줘야 한다.
	   */ 
	    if(nowPage==null && cntPerPage == null) {
	       nowPage="1";
	       cntPerPage="5";
	    }
	    else if(nowPage==null) {        nowPage="1";
	    }
	    else if(cntPerPage==null) {
	       cntPerPage="5";
	    }      
	    
	    // 3) 전체 게시글 수 DB에서 구해오기
	    Service ss = sqlsession.getMapper(Service.class);
	    int total_personal=ss.inquire_list_total_personal();
	     
	    // 생성자로 나머지 페이지 처리에 필요한 필드값들도 모두 계산
	    // 3가지 인수 넣어주기
	    PageDTO dto=new PageDTO(total_personal,Integer.parseInt(nowPage),Integer.parseInt(cntPerPage));
	    mo.addAttribute("paging", dto);
	    // 리스트 안에 특정 페이지마다 출력될 5개 묶음의 레코드 모음 저장
	    
	    mo.addAttribute("list", ss.inquire_personal_out_page(dto));
		
	    return "inquire_personal_out";
	}
		
		
		
	//1:1 문의글 디테일 화면(전체 내용 출력 화면)
	@RequestMapping(value = "/inquire_personal_detail")
	public String inquire_personal_detail(HttpServletRequest request, Model mo) {
		int ip_num=Integer.parseInt(request.getParameter("ip_num"));
		
		Service ss=sqlsession.getMapper(Service.class);
		Inquire_personal_DTO dto=ss.inquire_personal_detail(ip_num);
		mo.addAttribute("dto", dto);
		
		//기존에 보낸 답을 댓글 형식으로 출력(그러나 형식만 댓글일 뿐 일단 답을 보내면 메일로 바로 보내져 있음)
		ArrayList<Inquire_personal_reply_DTO> list=ss.inquire_personal_reply_out(ip_num);
		mo.addAttribute("list", list);
		
		return "inquire_personal_detail";
	}
		
		
		
	
	
	//관리자 권한에서 1:1 문의 내역 삭제
	@RequestMapping(value="/inquire_personal_delete")
    public String inquire_personal_delete(HttpServletRequest request) {
		
		int ip_num =Integer.parseInt(request.getParameter("ip_num"));
		
		Service ss=sqlsession.getMapper(Service.class);
		Inquire_personal_DTO idto = ss.personal_all_photo(ip_num);
	     
	     List<String> photoPaths = Arrays.asList(idto.getPic1(), idto.getPic2(), 
									    		 idto.getPic3(), idto.getPic4(), 
									    		 idto.getPic5());
		for(String pics : photoPaths) {
			if(pics != null && !pics.equals("nope")) 
			{File file = new File(imagepath+"\\"+pics);
				
				if(file.exists()) {file.delete();} //사진 삭제
			}
		}
		ss.inquire_personal_delete(ip_num); //1:1문의 삭제
		
		ss.inquire_personal_reply_delete(ip_num); //문의글 삭제 시 거기에 달린 답변도 함께 삭제
		
		//해당 문의에 대한 답 여부(답 갯수) 수정
		int reply_count=0;
		reply_count= ss.inquire_personal_reply_count(ip_num);
		if(reply_count==0) {System.out.println("답이 없네");} //답 갯수가 0인 경우
		else {ss.inquire_personal_tf_update(ip_num);} //답이 1개 이상인 경우 답 여부를 수정하도록
		
		return "redirect:/inquire_personal_out";
	}


	
	

	//1:1 문의에 답을 보내고 저장하고 댓글 형식으로 출력하기
	//1:1 문의에 대한 답은 홈페이지 내에서 삭제/수정해도 실제로 메일이 삭제/수정되지 않으므로 별도의 삭제/수정 기능은 넣지 않았음
	//그러나 해당 1:1문의를 삭제하면 자동으로 답도 함께 삭제 되는 형식으로 구성
	@RequestMapping(value = "/inquire_personal_reply", method = RequestMethod.POST)
	public String inquire_personal_reply(HttpServletRequest request, Model mo) throws IOException {
		  
		int ip_num =Integer.parseInt(request.getParameter("ip_num"));
		String title = request.getParameter("title");
	    String name = request.getParameter("name");
	    String email = request.getParameter("email");
	    String category = request.getParameter("category");
	    String content = request.getParameter("content");
	    String reply = request.getParameter("reply"); //답 내용
	    
	    Service ss=sqlsession.getMapper(Service.class);
	    
	    //답 내용을 테이블에 저장
		ss.inquire_personal_reply_save(reply, ip_num);
		
		//테이블에 답 내용을 저장한 직후 메일로 답변이 보내지도록 함
		EmailSender.sendEmail2(name, email, title, category, content, reply);
		
		//해당 문의에 대한 답 여부(답 갯수) 수정
		int reply_count=0;
		reply_count= ss.inquire_personal_reply_count(ip_num);
		if(reply_count==0) {System.out.println("답이 없네");} //답 갯수가 0인 경우
		else {ss.inquire_personal_tf_update(ip_num);} //답이 1개 이상인 경우 답 여부를 수정하도록
			
		//1:1문의 디테일에 가져가는 정보
		//1. 다시 디테일로 넘어가는 것
		Inquire_personal_DTO dto=ss.inquire_personal_detail(ip_num);
		mo.addAttribute("dto", dto);
		//2. 기존에 보낸 답을 댓글 형식으로 출력(그러나 형식만 댓글일 뿐 일단 답을 보내면 메일로 바로 보내져 있음)
		ArrayList<Inquire_personal_reply_DTO> list=ss.inquire_personal_reply_out(ip_num);
		mo.addAttribute("list", list);
	    
		return "inquire_personal_detail";
	}
	
	
	
	
	
	//이벤트란 파트
	//문의 토글의 이벤트란
	@RequestMapping(value = "/notice_event")
	public String eventpage1(Model mo) {
	  
	  Service ss=sqlsession.getMapper(Service.class);
	  ArrayList<Notice_DTO>list = ss.notice();
	  mo.addAttribute("list", list);
	  
	  ArrayList<Event_DTO>list2 = ss.event();
	  mo.addAttribute("list2", list2);
	  
	  return "notice_event";
	}
	  
	
	
	//알림란  
	@RequestMapping(value = "/notice")
	public String notice_show(HttpServletRequest request,Model mo) {
  
		int notice_num = Integer.parseInt(request.getParameter("notice_num"));
		mo.addAttribute("notice_num", notice_num);
  
		return "notice_view";		  
	}
		  
		
	
	//진행 중인 이벤트
	@RequestMapping(value = "/event")
	public String event_show(HttpServletRequest request,Model mo) {
	  
		int event_num = Integer.parseInt(request.getParameter("event_num"));
		Service ss=sqlsession.getMapper(Service.class);
		String photo = ss.event_photo(event_num);
		mo.addAttribute("photo", photo);
  
		return "event_view";		  
	}

	
		  
}
