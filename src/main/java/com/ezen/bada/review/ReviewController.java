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

import com.ezen.bada.member.MemberDTO;




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
	   
	        
	        System.out.println("배열확인 : "+fileNames[0]);
	        System.out.println("배열확인 : "+fileNames[1]);
	        System.out.println("배열확인 : "+fileNames[2]);
	    
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
	public String review3() {
			
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
		System.out.println("수정수정수정수정 : "+review_num);
		String visit_day = mul.getParameter("visit_day");
		System.out.println("수정111 : "+visit_day);
		String beach_code = mul.getParameter("beach");
		System.out.println("확인4 : "+beach_code);
		String review_title = mul.getParameter("review_title");
		System.out.println("확인5 : "+review_title);
		String review_contents = mul.getParameter("review_contents");
		System.out.println("확인6 : "+review_contents);
		String review_score = mul.getParameter("review_score");
		System.out.println("확인7 : "+review_score);
		String hashtags = mul.getParameter("hashtags");
		System.out.println("확인8 : "+hashtags);
		String re_visit = mul.getParameter("re_visit");
		System.out.println("확인9 : "+re_visit);
		
	    
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
        String loginid = request.getParameter("loginid");
        String reply = request.getParameter("reply");
        
        Service ss = sqlsession.getMapper(Service.class);
        ss.reply_save(review_num,loginid,reply);
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
	        int user_num=ss.ban_user_num(ban_id);
	        
	        
	        ss.review_ban_save(title, name, id, ban_review_num, ban_name, ban_id, category, content,user_num);
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
		  
		  int user_num=ss.ban_user_num(ban_id);
		  System.out.println("너 왜그래?"+user_num);
		  
		  String ban_check = ss.report_check(reply_num,id,reason,reply_contents);
		  
		  if (ban_check==null) {
			  ss.reply_report_save(review_num, reply_num, id, ban_id, reply_contents, reason, detail,user_num);
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
	      
	      Service ss = sqlsession.getMapper(Service.class);
	      
	      ArrayList<AllBoardDTO> list = ss.search_result(category,search);
	      
	      System.out.println("검색 출력 확인 : "+list.toString());
	      
	      StringBuilder sb = new StringBuilder();
	        sb.append("<table class='board-table'>");
	        sb.append("<thead><tr><th>번호</th><th>제목</th><th>작성자</th><th>방문일</th><th>작성일</th><th>추천수</th><th>조회수</th></tr></thead>");
	        sb.append("<tbody>");
	        for (AllBoardDTO review : list) {
	            sb.append("<tr>");
	            sb.append("<td>").append(review.getReview_num()).append("</td>");
	            sb.append("<td><a href='review_detail?review_num=").append(review.getReview_num()).append("'>")
	            .append(review.getReview_title()).append(" <span class='reply_check'>[").append(review.getReply()).append("]</span></a></td>");
	            String show_id = review.getId().substring(0,4)+"****";
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
	   
	  

	
}
