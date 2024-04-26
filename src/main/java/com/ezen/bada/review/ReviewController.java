package com.ezen.bada.review;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ezen.bada.inquire.InquireDTO;
import com.ezen.bada.inquire.Inquire_reply_DTO;
import com.ezen.bada.member.MemberDTO;
import com.fasterxml.jackson.databind.ObjectMapper;


@Controller
public class ReviewController {
	
	@Autowired
	SqlSession sqlsession;
	
	String image_path="C:\\이젠디지탈12\\spring\\bada\\src\\main\\webapp\\resources\\image_user";
	
	@RequestMapping(value = "review_input")
	public String review1(HttpServletRequest request, Model mo, HttpServletResponse response) throws IOException {

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
				List<BeachDTO> beachList = ss.getBeachList();
				    
				mo.addAttribute("dto", dto);
				mo.addAttribute("beachList", beachList);
				
				return "review_input";
				
			}
			
			else {
			
				out.println("<script>alert('로그인한 회원만 이용 가능합니다.'); location.href='login';</script>");
			    out.flush();
			    
			    return null;
				
			}
	     
	    }

	}
	
	
	@RequestMapping(value = "review_save", method = RequestMethod.POST)
	public String review2(MultipartHttpServletRequest mul) throws IOException {

		String id = mul.getParameter("id");
		String name = mul.getParameter("name");
		String visit_day = mul.getParameter("visit_day");
		String beach_code = mul.getParameter("beach");
		String review_title = mul.getParameter("review_title");
		String review_contents = mul.getParameter("review_contents");
		String review_score = mul.getParameter("review_score");
		String hashtags = mul.getParameter("hashtags");
		String re_visit = mul.getParameter("re_visit");
		
		MultipartFile tf = mul.getFile("thumb_nail");
		
		String t_name;
		if (tf != null && !tf.isEmpty()) {
		    t_name = System.currentTimeMillis() + "_" + tf.getOriginalFilename();
		    tf.transferTo(new File(image_path + File.separator + t_name));
		} else {
		    t_name = "no"; // 썸네일 파일이 없는 경우 "no" 저장
		}

		System.out.println("썸네일 명 : "+t_name);
		
		 String[] fileNames = new String[5];
	        
	        for (int i = 1; i <= 5; i++) {
	            MultipartFile file = mul.getFile("pic" + i);
	            if (file != null && !file.isEmpty()) {
	                String filename = System.currentTimeMillis() + "_" + file.getOriginalFilename();
	                file.transferTo(new File(image_path + File.separator + filename));
	                fileNames[i - 1] = filename; // 파일 이름을 배열에 저장
	            } else {
	                fileNames[i - 1] = "no"; // 파일이 없는 경우 -> null 저장시 오류 발생
	            }
	        }
	   
	    
	    Service ss = sqlsession.getMapper(Service.class);
	    ss.review_save(id,name,visit_day,review_title,review_contents,fileNames,
	    		t_name,review_score,hashtags,beach_code,re_visit);
	        
		
	    
	    return "main";
	}
	
	@RequestMapping(value = "review_input2")
	public String review2(HttpServletRequest request, HttpServletResponse response, Model mo) throws IOException {
		

			
		return "review_input2";
			
	}
	
	@RequestMapping(value = "bada_review")
	public String review3(HttpServletRequest request, Model mo) {
		
		String area = request.getParameter("area");
		mo.addAttribute("area",area);
		
		System.out.println("지역뽑혀왔니 : "+area);
		//아이디,닉네임 넣기
		HttpSession hs = request.getSession();
		String id = null;
		String name = null;
		Service ss = sqlsession.getMapper(Service.class);
		
		if(hs.getAttribute("loginid")!=null) {
			id = (String) hs.getAttribute("loginid");
			name = ss.getnickname(id);
		}
		else {
			id = "*badalove123*";
			name = "*익명*";
		}
		
		mo.addAttribute("id", id);
		mo.addAttribute("name", name);
		
		ArrayList<AllBoardDTO> list = new ArrayList<AllBoardDTO>();
		
		//리뷰슬라이드 6개 넣기(최신순)
		if(area.equals("전국")) {
			list = ss.picknewrec6();
		}
		else if(area.equals("경기인천")||area.equals("부산울산")) {
			String area1 = area.substring(0,2);
			String area2 = area.substring(2);
			list = ss.picknewrec6in2area(area1,area2);
			System.out.println("area : "+ area1 +" "+area2);
		}
		else {
			list = ss.picknewrecinarea(area);
			System.out.println("area : "+ area);
		}
		
		mo.addAttribute("list", list);
		
		//한마디 가져오기
		ArrayList<OneDTO> olist = ss.getonesentence(area);
		mo.addAttribute("olist", olist);
		
		//지역별 새글 수
		ArrayList<CountreviewDTO> clist = ss.getreviewcount();
		mo.addAttribute("clist", clist);
		System.out.println("지역별새글 리스트 뽑혀옴? : "+clist);
		
		return "bada_review";
			
	}
	
	
	@RequestMapping(value = "review_all_page")
	public String review4(HttpServletRequest request, PageDTO dto, Model mo) {
		
		
		String nowPage=request.getParameter("nowPage");
        System.out.println("nowpage 확인 : "+nowPage);

        String cntPerPage=request.getParameter("cntPerPage");
        System.out.println("cntperpage 확인 : "+cntPerPage);
		
		Service ss = sqlsession.getMapper(Service.class);
		int total=ss.total();
		
		System.out.println("board 전체 개수 : "+total);
		
        if(nowPage==null && cntPerPage == null) {
            
       	 nowPage="1";
           // 현재 페이지 번호
                                                             
         cntPerPage="20";
          // 한 페이지당 보여줄 게시물 수
        
        }
        else if(nowPage==null) {
           nowPage="1";
        }
        else if(cntPerPage==null) {
           cntPerPage="20";
        }
		
        dto=new PageDTO(total,Integer.parseInt(nowPage),Integer.parseInt(cntPerPage));
        mo.addAttribute("paging",dto);
        mo.addAttribute("list",ss.review_list(dto));

		return "review_page";
			
	}
	
	@RequestMapping(value = "review_detail")
	public String review4(HttpServletRequest request, Model mo) {
		
		int review_num = Integer.parseInt(request.getParameter("review_num"));
		Service ss = sqlsession.getMapper(Service.class);
		ss.hit_up(review_num);
		
		AllBoardDTO dto = ss.review_detail(review_num);
		mo.addAttribute("dto", dto);
		
		String beach = ss.beach_name(review_num);
		mo.addAttribute("beach", beach);
		
		List<String> gallery = new ArrayList<String>();
		
		if (!"no".equals(dto.getThumbnail()))
		{
				gallery.add(dto.getThumbnail());
		}
		for (int i = 1; i <= 5; i++) {
		  try {
			   String photoName = (String) AllBoardDTO .class.getMethod("getPhoto" + i).invoke(dto);
			   if (!"no".equals(photoName)) {
				   gallery.add(photoName);
		            }
		        } catch (Exception e) {
		            e.printStackTrace();
		        }
		    }
		    
		 mo.addAttribute("gallery", gallery);
		 
		 // 댓글에 id 불러오기 //
		 HttpSession hs = request.getSession();
		 String loginid = (String) hs.getAttribute("loginid");
		 mo.addAttribute("loginid", loginid);
		 
		 ArrayList<ReplyDTO> reply = ss.reply_show(review_num);
		 
		 mo.addAttribute("reply", reply);
		

		return "review_detail";
		
	}
	
	@RequestMapping(value = "review_delete")
	   public String review_delete(HttpServletRequest request) {

		     int review_num = Integer.parseInt(request.getParameter("review_num"));
		     Service ss = sqlsession.getMapper(Service.class);
		     
		     AllBoardDTO boardDTO = ss.all_photo(review_num);
		     
		     List<String> photoPaths = Arrays.asList(boardDTO.getPhoto1(), boardDTO.getPhoto2(), 
								                     boardDTO.getPhoto3(), boardDTO.getPhoto4(), 
								                     boardDTO.getPhoto5(), boardDTO.getThumbnail());
			for(String photo : photoPaths) {
				
				if(photo != null && !photo.equals("no")) 
				{
					File file = new File(image_path +File.separator+photo);
					
					if(file.exists()) 
					{
						file.delete();
					}
				}
			}
		     
		     ss.review_delete(review_num);
		     ss.review_comment_delete(review_num);

	      return "redirect:/bada_review";
	   }
	
	@RequestMapping(value = "review_change")
	   public String review_change(HttpServletRequest request, Model mo) {

		     int review_num = Integer.parseInt(request.getParameter("review_num"));
		     System.out.println("잘 들어옴? : "+review_num );
		     Service ss = sqlsession.getMapper(Service.class);
		     
		     AllBoardDTO dto = ss.change_view(review_num);
		     List<BeachDTO> beachList = ss.getBeachList();
		     List<String> photoList = Arrays.asList(dto.getPhoto1(), dto.getPhoto2(), dto.getPhoto3(), dto.getPhoto4(), dto.getPhoto5());
		     mo.addAttribute("beachList", beachList);
		     mo.addAttribute("dto", dto);
		     mo.addAttribute("photoList", photoList);

	      return "change_view";
	   }
	
	
	
	@RequestMapping(value = "review_change_save", method = RequestMethod.POST)
	   public String review_change_save(MultipartHttpServletRequest mul) throws IllegalStateException, IOException {


		int review_num = Integer.parseInt(mul.getParameter("review_num"));
		String visit_day = mul.getParameter("visit_day");
		String beach_code = mul.getParameter("beach");
		String review_title = mul.getParameter("review_title");
		String review_contents = mul.getParameter("review_contents");
		String review_score = mul.getParameter("review_score");
		String hashtags = mul.getParameter("hashtags");
		String re_visit = mul.getParameter("re_visit");
	    
	    Service ss = sqlsession.getMapper(Service.class);
	    
	    modi_thumbnail(mul, review_num, ss);    
	    
	    
	    boolean new_photos = false;
	    
	    for (int i = 1; i <= 5; i++) {
	        MultipartFile file = mul.getFile("pic" + i);
	        if (file != null && !file.isEmpty()) {
	        	new_photos = true;
	            break; // 새로운 파일이 하나라도 있으면 반복 종료
	        }
	    }
	    
	    
	    if (new_photos) {
	    	
	    	AllBoardDTO boardDTO = ss.all_photo(review_num);
		     
		     List<String> photoPaths = Arrays.asList(boardDTO.getPhoto1(), boardDTO.getPhoto2(), 
								                     boardDTO.getPhoto3(), boardDTO.getPhoto4(), 
								                     boardDTO.getPhoto5());
			for(String photo : photoPaths) {
				
				if(photo != null && !photo.equals("no")) 
				{
					File file = new File(image_path +File.separator+photo);
					
					if(file.exists()) 
					{
						file.delete();
					}
				}
			}
	    	
	        modi_photos(mul, review_num, ss);
	    }
	    
	    
	    
	    ss.review_modify(review_num,visit_day,review_title,review_contents,
	    		review_score,hashtags,beach_code,re_visit);
	    

	      return "redirect:/review_all_page";
	   }


	private void modi_photos(MultipartHttpServletRequest mul, int review_num, Service ss) throws IllegalStateException, IOException {
		
		String[] change_photo = new String[5];
	    
	    for (int i = 1; i <= 5; i++) {
	        MultipartFile file = mul.getFile("pic" + i);
	        if (file != null && !file.isEmpty()) {
	            UUID ud = UUID.randomUUID();
	            String fileName = ud.toString() + "_" + file.getOriginalFilename();
	            File newFile = new File(image_path + File.separator + fileName);
	            file.transferTo(newFile);
	            change_photo[i - 1] = fileName; 
	        } else {
	        	change_photo[i - 1] = "no";
	        }
	    }
	    

	    Map<String, Object> params = new HashMap<>();
	    params.put("review_num", review_num);
	    params.put("change_photo", change_photo);
	    ss.update_photo(params);
		
	}


	private void modi_thumbnail(MultipartHttpServletRequest mul, int review_num, Service ss) throws IllegalStateException, IOException {
	    MultipartFile tf = mul.getFile("thumb_nail");

	    if (tf != null && !tf.isEmpty()) {

	        String original = ss.original_thumbnail(review_num);

	        if (original != null && !original.equals("no")) {
	            File file = new File(image_path + File.separator + original);
	            if (file.exists()) {
	                file.delete(); 
	            }
	        }

	        UUID ud = UUID.randomUUID();
	        String t_name = ud.toString() + "_" + tf.getOriginalFilename();
	        File newFile = new File(image_path + File.separator + t_name);
	        tf.transferTo(newFile);

	       
	        ss.thumbnail_upload(review_num, t_name);
	    }
	    
	 
	}
	
	
	@RequestMapping(value = "review_recommend")
	   public String recommend(HttpServletRequest request, Model mo) {

		int review_num=Integer.parseInt(request.getParameter("review_num"));
		String loginid=request.getParameter("loginid");
		
		Service ss=sqlsession.getMapper(Service.class);
		// 추천 중복체크 확인
		int rec_id=ss.review_rec_id(review_num, loginid);
		
		if(rec_id==0) {
		ss.review_recommand(loginid, review_num);
		AllBoardDTO dto=ss.review_detail(review_num);
		mo.addAttribute("dto", dto);
		}
		
		else {
			AllBoardDTO dto=ss.review_detail(review_num);
			mo.addAttribute("dto", dto);
		}

	      return "redirect:/review_detail?review_num="+review_num;
	   }

	
	
	// 리뷰 댓글 처리 영역
	@ResponseBody
	@RequestMapping(value = "reply_save", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
	   public String review_comment(HttpServletRequest request) {
		
        int review_num = Integer.parseInt(request.getParameter("review_num"));
        String loginid = request.getParameter("loginid").trim();
        String reply = request.getParameter("reply");
        
        System.out.println("받아온 리뷰번호 : "+review_num+" / 로그인한 아이디 : "+loginid+" / 댓글 : "+reply);
        
        Service ss = sqlsession.getMapper(Service.class);
        
        String nickname =  ss.getnickname(loginid);
        System.out.println("닉네임 받아왔나? : "+nickname);
        
        ss.reply_save(review_num,loginid,reply,nickname);
        ss.reply_update(review_num);

        JSONObject obj = new JSONObject();
        obj.put("success", true);
        obj.put("loginid", loginid);
        obj.put("reply", reply);

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        String replyDate = sdf.format(new Date());
        obj.put("reply_day", replyDate);
        
        System.out.println("JSON 응답 : " + obj.toString());
        
        return obj.toString();
        
	   }
	
	
	// 신고기능
	@RequestMapping(value = "review_report_view")
	   public String report(HttpServletRequest request, Model mo) {

		int review_num=Integer.parseInt(request.getParameter("review_num"));
		String loginid=request.getParameter("loginid");
		
		Service ss=sqlsession.getMapper(Service.class);
		MemberDTO mdto = ss.input_info(loginid);
		mo.addAttribute("mdto", mdto);
		
		AllBoardDTO adto = ss.review_detail(review_num);
		mo.addAttribute("adto", adto);

	      return "review_report_view";
	   }
	
	  @ResponseBody
	  @RequestMapping(value = "review_ban_check", method = RequestMethod.POST)
	   public String inquire_ban_check(HttpServletRequest request) throws IOException {
	      
	        String id = request.getParameter("id");
	        int ban_review_num=Integer.parseInt(request.getParameter("ban_review_num"));
	        String category = request.getParameter("category");
	        String content = request.getParameter("content");
	        
	        System.out.println("체크 1: "+id);
	        System.out.println("체크 2: "+ban_review_num);
	        System.out.println("체크 3: "+category);
	        System.out.println("체크 4: "+content);
	        
	
	        Service ss=sqlsession.getMapper(Service.class);
	        String inquire_check="";
	        String result="";
	        inquire_check=ss.review_ban_check(id, ban_review_num, category, content); //동일한 사람이 동일한 글을 동일한 사유로 여러번 신고할 수 없도록 중복 방지
	        System.out.println("가져온 신고글 제목: "+inquire_check);
	        
	        if (inquire_check==null) {
	        	result="ok";
	        }
	        else {
	        	result="nope";
	        	}
	        System.out.println("결과 "+result);
	        
	      return result;
	   }
	
	  @RequestMapping(value = "review_ban_save", method = RequestMethod.POST)
	   public String inquire_ban_save(HttpServletRequest request, Model mo) throws IOException {
	      
	      	String title = request.getParameter("title");
	        String name = request.getParameter("name");
	        String id = request.getParameter("id");
	        int ban_review_num=Integer.parseInt(request.getParameter("ban_review_num"));
	        System.out.println("이동할 게시글 번호 : "+ban_review_num);
	        String ban_name = request.getParameter("ban_name");
	        String ban_id = request.getParameter("ban_id");
	        String category = request.getParameter("category");
	        String content = request.getParameter("content");
	
	        Service ss=sqlsession.getMapper(Service.class);
	        int user_num=ss.user_num(ban_id);
	        int user_num2=ss.user_num(id);
	        
	        ss.review_ban_save(title, name, id, ban_review_num, ban_name, ban_id, category, content,user_num,id,user_num2);
	        ss.report_up(ban_review_num);

	      return "redirect:/review_detail?review_num="+ban_review_num;
	   }
	  
	  // 댓글삭제
	  
	  @ResponseBody
	  @RequestMapping(value = "delete_reply")
	   public String reply_delete(HttpServletRequest request) throws IOException {
	      
		  	JSONObject obj = new JSONObject();
		  
		    try {
		        int reply_num = Integer.parseInt(request.getParameter("reply_num"));
		        int review_num = Integer.parseInt(request.getParameter("review_num"));

		        Service ss = sqlsession.getMapper(Service.class);
		        ss.reply_delete(reply_num); // 댓글테이블 댓글 삭제
		        ss.reply_minus(review_num); // user_review 테이블 reply count -
		        ss.report_reply_delete(reply_num); // 댓글신고내역 삭제

		        obj.put("success", true);
		        
		    } catch (Exception e) {
		    	obj.put("success", false);
		        e.printStackTrace();
		    }

	      return obj.toString();
	   }
	  
	  // 댓글 수정
	
	  @ResponseBody
	  @RequestMapping(value = "modify_reply")
	   public String reply_modify(HttpServletRequest request) throws IOException {
	      
		  	JSONObject obj = new JSONObject();
		  
		    try {
		        int reply_num = Integer.parseInt(request.getParameter("reply_num"));
		        String modi_reply = request.getParameter("reply");

		        Service ss = sqlsession.getMapper(Service.class);
		        ss.reply_modify(reply_num,modi_reply);
		        ReplyDTO dto = ss.reply_info(reply_num);
		        
		        obj.put("id",dto.getId());
		        obj.put("reply_day", dto.getReply_day().substring(0, 16));
		        obj.put("success", true);
		        
		    } catch (Exception e) {
		    	obj.put("success", false);
		        e.printStackTrace();
		    }

	      return obj.toString();
	   }
	  
	  // 댓글신고
	  
	  @ResponseBody
	  @RequestMapping(value = "report_reply" , method = RequestMethod.POST)
	   public String report_reply(HttpServletRequest request) throws IOException {
  
		  int reply_num = Integer.parseInt(request.getParameter("reply_num"));
		  int review_num = Integer.parseInt(request.getParameter("review_num"));
		  String id = request.getParameter("reporter_id");
		  String ban_id = request.getParameter("reply_id");
		  String reply_contents = request.getParameter("reply_content");
		  String reason = request.getParameter("reason");
		  String detail = request.getParameter("detail");
		  String result="";
				  
		  Service ss = sqlsession.getMapper(Service.class);
		  
		  String name = ss.user_name(id);
		  String ban_name = ss.user_name(ban_id);
		  int user_num=ss.user_num(ban_id);
		  int user_num2=ss.user_num(id);
		  
		  String ban_check = ss.report_check(reply_num,id,reason,reply_contents);
		  
		  if (ban_check==null) {
			  ss.reply_report_save(review_num, reply_num, id, ban_id, reply_contents, reason, detail,user_num,name,ban_name,user_num2);
			  result="ok";
	        } else {
	        	result="no";
	        }

		  
	      return result;
	   }
	  
	   @ResponseBody
	   @RequestMapping(value = "/review_search", produces = "text/html; charset=UTF-8")
	   public String search1(HttpServletRequest request) {
		    
	      String category = request.getParameter("search_category");
	      String search = request.getParameter("search");
      
	      if ("vdate".equals(category) || "wdate".equals(category)) {
	          String year = request.getParameter("year");
	          String month = request.getParameter("month");

	          if ("2020".equals(year)) {
	              search = "2020";
	          } else if (year != null && !year.isEmpty() && month != null && !month.isEmpty()) {
	              search = year + "-" + String.format("%02d", Integer.parseInt(month)); // "2024-05"
	          } else if (year != null && !year.isEmpty()) {
	              search = year; // "2024"
	          } else if (month != null && !month.isEmpty()) {
	              search = month;
	          }
	      }
	      
	      
	      Service ss = sqlsession.getMapper(Service.class);
	      
	      ArrayList<AllBoardDTO> list = ss.search_result(category,search);

	      StringBuilder sb = new StringBuilder();
	      sb.append("<table class='board-table'>");
	      sb.append("<thead>");
	      sb.append("<tr>");
	      sb.append("<th scope='col' class='th-num'>번호</th>");
	      sb.append("<th scope='col' class='th-title'>제목</th>");
	      sb.append("<th scope='col' class='th-writer'>작성자</th>");
	      sb.append("<th scope='col' class='th-date vdate'>방문일</th>");
	      sb.append("<th scope='col' class='th-date wdate'>작성일</th>");
	      sb.append("<th scope='col' class='th-num recommend'>추천수</th>");
	      sb.append("<th scope='col' class='th-num view'>조회수</th>");
	      sb.append("</tr>");
	      sb.append("</thead>");
	      sb.append("<tbody>");

	      sb.append("<tr class='notice_line'>");
	      sb.append("<td>3</td>");
	      sb.append("<td class='text_title'><a href='#'>[공지사항] 3번 </a></td>");
	      sb.append("<td>관리자</td>");
	      sb.append("<td></td>");
	      sb.append("<td>2024-04-08</td>");
	      sb.append("<td></td>");
	      sb.append("<td></td>");
	      sb.append("</tr>");

	      sb.append("<tr class='notice_line'>");
	      sb.append("<td>2</td>");
	      sb.append("<td class='text_title'><a href='#'>[공지사항] 2번 </a></td>");
	      sb.append("<td>관리자</td>");
	      sb.append("<td></td>");
	      sb.append("<td>2024-04-08</td>");
	      sb.append("<td></td>");
	      sb.append("<td></td>");
	      sb.append("</tr>");

	      sb.append("<tr class='notice_line'>");
	      sb.append("<td>1</td>");
	      sb.append("<td class='text_title'><a href='#'>[공지사항] 1번 </a></td>");
	      sb.append("<td>관리자</td>");
	      sb.append("<td></td>");
	      sb.append("<td>2024-04-08</td>");
	      sb.append("<td></td>");
	      sb.append("<td></td>");
	      sb.append("</tr>");

	      for (AllBoardDTO review : list) {
	          sb.append("<tr>");
	          sb.append("<td>").append(review.getReview_num()).append("</td>");
	          sb.append("<td class='text_title'><a href='review_detail?review_num=").append(review.getReview_num()).append("'>")
	              .append(review.getReview_title()).append(" <span class='reply_check'>[").append(review.getReply()).append("]</span></a></td>");
	          String show_id = review.getId().substring(0, 4) + "****";
	          sb.append("<td>").append(review.getName()).append("(").append(show_id).append(")님").append("</td>");
	          sb.append("<td>").append(review.getVisit_day()).append("</td>");
	          String write_day = review.getWrite_day().substring(0, 10);
	          sb.append("<td>").append(write_day).append("</td>");
	          sb.append("<td>").append(review.getRecommend()).append("</td>");
	          sb.append("<td>").append(review.getHits()).append("</td>");
	          sb.append("</tr>");
	      }

	      sb.append("</tbody></table>");
   
	      return sb.toString();
	   }
	   
   
	   @ResponseBody
	   @RequestMapping(value = "/review_area_search", produces = "text/html; charset=UTF-8")
	   public String search2(HttpServletRequest request) {
		    
	      String area = request.getParameter("area");
	      
	      Service ss = sqlsession.getMapper(Service.class);
	      
	      ArrayList<AllBoardDTO> list = ss.search_area_result(area);
     
	      StringBuilder sb = new StringBuilder();
	      sb.append("<table class='board-table'>");
	      sb.append("<thead>");
	      sb.append("<tr>");
	      sb.append("<th scope='col' class='th-num'>번호</th>");
	      sb.append("<th scope='col' class='th-title'>제목</th>");
	      sb.append("<th scope='col' class='th-writer'>작성자</th>");
	      sb.append("<th scope='col' class='th-date vdate'>방문일</th>");
	      sb.append("<th scope='col' class='th-date wdate'>작성일</th>");
	      sb.append("<th scope='col' class='th-num recommend'>추천수</th>");
	      sb.append("<th scope='col' class='th-num view'>조회수</th>");
	      sb.append("</tr>");
	      sb.append("</thead>");
	      sb.append("<tbody>");

	      sb.append("<tr class='notice_line'>");
	      sb.append("<td>3</td>");
	      sb.append("<td class='text_title'><a href='#'>[공지사항] 3번 </a></td>");
	      sb.append("<td>관리자</td>");
	      sb.append("<td></td>");
	      sb.append("<td>2024-04-08</td>");
	      sb.append("<td></td>");
	      sb.append("<td></td>");
	      sb.append("</tr>");

	      sb.append("<tr class='notice_line'>");
	      sb.append("<td>2</td>");
	      sb.append("<td class='text_title'><a href='#'>[공지사항] 2번 </a></td>");
	      sb.append("<td>관리자</td>");
	      sb.append("<td></td>");
	      sb.append("<td>2024-04-08</td>");
	      sb.append("<td></td>");
	      sb.append("<td></td>");
	      sb.append("</tr>");

	      sb.append("<tr class='notice_line'>");
	      sb.append("<td>1</td>");
	      sb.append("<td class='text_title'><a href='#'>[공지사항] 1번 </a></td>");
	      sb.append("<td>관리자</td>");
	      sb.append("<td></td>");
	      sb.append("<td>2024-04-08</td>");
	      sb.append("<td></td>");
	      sb.append("<td></td>");
	      sb.append("</tr>");

	      for (AllBoardDTO review : list) {
	          sb.append("<tr>");
	          sb.append("<td>").append(review.getReview_num()).append("</td>");
	          sb.append("<td class='text_title'><a href='review_detail?review_num=").append(review.getReview_num()).append("'>")
	              .append(review.getReview_title()).append(" <span class='reply_check'>[").append(review.getReply()).append("]</span></a></td>");
	          String show_id = review.getId().substring(0, 4) + "****";
	          sb.append("<td>").append(review.getName()).append("(").append(show_id).append(")님").append("</td>");
	          sb.append("<td>").append(review.getVisit_day()).append("</td>");
	          String write_day = review.getWrite_day().substring(0, 10);
	          sb.append("<td>").append(write_day).append("</td>");
	          sb.append("<td>").append(review.getRecommend()).append("</td>");
	          sb.append("<td>").append(review.getHits()).append("</td>");
	          sb.append("</tr>");
	      }

	      sb.append("</tbody></table>");
	   
	      return sb.toString();
	   }
	 
		@RequestMapping(value = "review_ban_listout")
		   public String ban_list(HttpServletRequest request, PageDTO dto, Model mo) {
			

			String nowPage=request.getParameter("nowPage");
	        String cntPerPage=request.getParameter("cntPerPage");

			Service ss = sqlsession.getMapper(Service.class);
			int total=ss.ban_review_total();

	        if(nowPage==null && cntPerPage == null) {
	       	 nowPage="1";
	           // 현재 페이지 번호                                    
	         cntPerPage="20";
	          // 한 페이지당 보여줄 게시물 수
	        }
	        else if(nowPage==null) {
	           nowPage="1";
	        }
	        else if(cntPerPage==null) {
	           cntPerPage="20";
	        }
			
	        dto=new PageDTO(total,Integer.parseInt(nowPage),Integer.parseInt(cntPerPage));
	        mo.addAttribute("paging",dto);
	        mo.addAttribute("list",ss.review_report(dto));

		      return "review_ban_listout";
		   }
		
		
		   // 신고된 글 자세히 보기
		@RequestMapping(value = "review_ban_detail")
			public String ban_review_detail(HttpServletRequest request, Model mo) {
		
			int ban_review_num = Integer.parseInt(request.getParameter("ban_review_num"));
			String ban_id=request.getParameter("ban_id");
			
			Service ss=sqlsession.getMapper(Service.class);

			Review_report_DTO dto=ss.review_ban_detail(ban_review_num);
			mo.addAttribute("dto", dto);

			int ban_count=ss.review_ban_count(ban_id);
			mo.addAttribute("ban_count", ban_count);
			
			ArrayList<Review_report_DTO> list=ss.review_ban_list(ban_id);
			mo.addAttribute("list", list);
		

			return "review_ban_detail";
		}
	   
		//관리자 권한에서 신고 내역 삭제
		@RequestMapping(value="review_ban_delete")
	    public String review_ban_delete(HttpServletRequest request) {
			
			int review_report_num=Integer.parseInt(request.getParameter("review_report_num"));
			
			Service ss=sqlsession.getMapper(Service.class);
			ss.review_ban_delete(review_report_num);
			
			return "redirect:/review_ban_listout";
	    }
		
		
		@RequestMapping(value = "reply_ban_listout")
		   public String reply_ban_list(HttpServletRequest request, PageDTO dto, Model mo) {
			

			String nowPage=request.getParameter("nowPage");
	        String cntPerPage=request.getParameter("cntPerPage");
			
			Service ss = sqlsession.getMapper(Service.class);
			int total=ss.ban_reply_total();
			
	        if(nowPage==null && cntPerPage == null) {
	            
	       	 nowPage="1";
	           // 현재 페이지 번호
	                                                             
	         cntPerPage="20";
	          // 한 페이지당 보여줄 게시물 수
	        
	        }
	        else if(nowPage==null) {
	           nowPage="1";
	        }
	        else if(cntPerPage==null) {
	           cntPerPage="20";
	        }
			
	        dto=new PageDTO(total,Integer.parseInt(nowPage),Integer.parseInt(cntPerPage));
	        mo.addAttribute("paging",dto);
	        mo.addAttribute("list",ss.reply_report(dto));
			

		      return "reply_ban_listout";
		   }
		
		
		@RequestMapping(value="/reply_ban_delete")
	    public String reply_ban_delete(HttpServletRequest request) {
			
			int review_reply_ban_num=Integer.parseInt(request.getParameter("review_reply_ban_num"));
			
			Service ss=sqlsession.getMapper(Service.class);
			ss.reply_ban_delete(review_reply_ban_num);
			
			return "redirect:/reply_ban_listout";
	    }
		
		@ResponseBody
		@RequestMapping(value="recommend_view", method = RequestMethod.GET, produces = "application/json; charset=utf-8")
		public String main_review(HttpServletRequest request, Model mo) {
		    Service ss = sqlsession.getMapper(Service.class);
		    ArrayList<AllBoardDTO> list = ss.pickbestrec();

		    System.out.println("리스트 가져왔니? : " + list);
		    System.out.println("리스트 안 썸네일 하나 : " + list.get(0).getThumbnail());

		 // 리스트를 두 번 반복하여 똑같은 데이터를 포함한 새로운 리스트 생성
		    ArrayList<AllBoardDTO> duplicatedList = new ArrayList<>();
		    duplicatedList.addAll(list);
		    duplicatedList.addAll(list);

		    // ObjectMapper를 사용하여 두 번 반복된 리스트를 JSON 문자열로 변환
		    ObjectMapper mapper = new ObjectMapper();
		    String jsonList = "";
		    try {
		        jsonList = mapper.writeValueAsString(duplicatedList);
		    } catch (Exception e) {
		        e.printStackTrace();
		    }

		    return jsonList;
		}
		
		
		
		
		
		//나도 한마디 출력 페이지
		@RequestMapping(value = "/say_one_sentence")
		public String say_one_sentence(HttpServletRequest request, Model mo, HttpServletResponse response) throws IOException {
			
			Service ss = sqlsession.getMapper(Service.class);
			HttpSession hs = request.getSession();
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			if (hs.getAttribute("loginstate") == null || !(boolean) hs.getAttribute("loginstate")) {
		        // 로그인하지 않은 상태에서는 로그인 관련 정보를 가져오지 않고, 채팅 내역만 가져옴
		        ArrayList<OneDTO> list = ss.say_one_sentence();
		        mo.addAttribute("list", list);
		    } else {
		        // 로그인한 경우에는 사용자 정보와 함께 채팅 내역을 가져옴
		        String loginid = (String) hs.getAttribute("loginid");
		        MemberDTO dto = ss.input_info(loginid);
		        mo.addAttribute("dto", dto);

		        // 채팅 내역 가져오기
		        ArrayList<OneDTO> list = ss.say_one_sentence();
		        mo.addAttribute("list", list);
		    }
			
			return "say_one_sentence";
		}
		
		
		
		//나도 한마디 입력 후 저장, 그리고 다시 출력
		@RequestMapping(value = "/say_one_save", method = RequestMethod.POST)
		public String say_one_save(HttpServletRequest request, Model mo, HttpServletResponse response) {
		
			String loc = request.getParameter("loc");
			String id = request.getParameter("id");
		    String name = request.getParameter("name");
		    String content = request.getParameter("content");
		    
		    System.out.println("확인용 가지가지 출력: 1. "+loc+"  2. "+id+"  3. "+name+"  4. "+content);
		    
		    Service ss = sqlsession.getMapper(Service.class);
			HttpSession hs = request.getSession();
			response.setContentType("text/html; charset=UTF-8");
		    
		    if(content.equals("")||content==null||content.isEmpty()) {content="바라는 바다 짱!><♡";}
		    
		    else {System.out.println("하하 집에 가고 싶어");}
		    
	    	//입력한 한마디를 테이블에 저장
			ss.say_one_save(id, name, content, loc);
			
			//사전에 나도 한마디를 입력하려는 사용자의 정보를 가져옴
			String loginid = (String) hs.getAttribute("loginid");
			MemberDTO dto = ss.input_info(loginid);
			mo.addAttribute("dto", dto);
				
			//다시 나도 한마디 창에 가져가는 정보(기존 채팅 + 방금 올린 채팅)
			ArrayList<OneDTO> list=ss.say_one_sentence();
			mo.addAttribute("list", list);
		    
			return "say_one_sentence";
		    
		}
		
		
		
		//관리자 또는 유저가 나도 한마디를 삭제하는 경우
		  @RequestMapping(value = "one_delete")
		   public String one_delete(HttpServletRequest request, Model mo, HttpServletResponse response) {

				int one_num = Integer.parseInt(request.getParameter("one_num"));
				 
				Service ss = sqlsession.getMapper(Service.class);
				HttpSession hs = request.getSession();
				response.setContentType("text/html; charset=UTF-8");
				 
				ss.one_delete(one_num);
				 
				//사전에 나도 한마디를 입력하려는 사용자의 정보를 가져옴
				String loginid = (String) hs.getAttribute("loginid");
				MemberDTO dto = ss.input_info(loginid);
				mo.addAttribute("dto", dto);
					
				//다시 나도 한마디 창에 가져가는 정보(기존 채팅 + 방금 올린 채팅)
				ArrayList<OneDTO> list=ss.say_one_sentence();
				mo.addAttribute("list", list);
			    
				return "say_one_sentence";
		   }
		  
		  
		  
		//나도 한마디 채팅이 신고된 경우
		  @ResponseBody
		  @RequestMapping(value = "one_ban")
		   public String one_ban(HttpServletRequest request, Model mo, HttpServletResponse response) {

				int ban_one_num = Integer.parseInt(request.getParameter("one_num")); //신고당한 채팅 번호
				String id=request.getParameter("id"); //신고한 사람의 아이디
				 
				Service ss = sqlsession.getMapper(Service.class);
				HttpSession hs = request.getSession();
				response.setContentType("text/html; charset=UTF-8");
				
				int count_same_ban=ss.count_same_ban(ban_one_num, id); //중복 신고 방지를 위해 정보 가져옴
				
				if(count_same_ban==0) { //중복신고가 아닌 경우
				
				String ban_id=ss.find_ban_user_id(ban_one_num); //신고당한 채팅에서 신고당한 유저의 아이디 가져옴
				int ban_user_num = ss.ban_user_num(ban_id); //신고당한 유저의 아이디로 신고당한 유저의 회원번호를 가져옴
				String ban_name=ss.find_ban_user_name(ban_id); //신고당한 유저의 아이디로 신고당한 유저의 닉네임을 가져옴
				String ban_content=ss.find_ban_content(ban_one_num); //신고당한 채팅 번호로 신고당한 채팅의 내용을 가져옴
				String name=ss.find_name(id); //신고한 사람의 아이디로 신고한 사람의 닉네임을 가져옴
				 
				ss.one_ban_save(id, name, ban_user_num, ban_id, ban_name, ban_content, ban_one_num); //신고 정보를 테이블에 저장함
				 
				//사전에 나도 한마디를 입력하려는 사용자의 정보를 가져옴
				String loginid = (String) hs.getAttribute("loginid");
				MemberDTO dto = ss.input_info(loginid);
				mo.addAttribute("dto", dto);
					
				//다시 나도 한마디 창에 가져가는 정보(기존 채팅 + 방금 올린 채팅)
				ArrayList<OneDTO> list=ss.say_one_sentence();
				mo.addAttribute("list", list);
			    
				return "say_one_sentence";}
				
				else { //중복신고인 경우
				    response.setStatus(HttpServletResponse.SC_CONFLICT); // HTTP 상태 코드 409를 설정하여 중복 신고임을 전달
				    return "duplicate_report"; // 중복 신고를 클라이언트로 전달하고 종료
				}
		   }
		  
		  
		  
		  //나도 한마디 채팅 신고 내역 확인창
		  @RequestMapping(value = "one_ban_listout")
		   public String one_ban_listout(HttpServletRequest request, PageDTO dto, Model mo) {

			String nowPage=request.getParameter("nowPage");
	        String cntPerPage=request.getParameter("cntPerPage");
			
			Service ss = sqlsession.getMapper(Service.class);
			int total=ss.one_ban_total();
			
	        if(nowPage==null && cntPerPage == null) {
	            
	       	 nowPage="1";
	           // 현재 페이지 번호
	                                                             
	         cntPerPage="20";
	          // 한 페이지당 보여줄 게시물 수
	        
	        }
	        else if(nowPage==null) {
	           nowPage="1";
	        }
	        else if(cntPerPage==null) {
	           cntPerPage="20";
	        }
			
	        dto=new PageDTO(total,Integer.parseInt(nowPage),Integer.parseInt(cntPerPage));
	        mo.addAttribute("paging",dto);
	        mo.addAttribute("list",ss.one_ban(dto));
		      return "one_ban_listout";
		   }
		  
		  
		  
		//관리자 권한에서 신고 내역 삭제
			@RequestMapping(value="one_ban_delete")
		    public String one_ban_delete(HttpServletRequest request) {
				
				int one_ban_num=Integer.parseInt(request.getParameter("one_ban_num"));
				
				Service ss=sqlsession.getMapper(Service.class);
				ss.one_ban_delete(one_ban_num);
				
				return "redirect:/one_ban_listout";
		    }
		
		
}
