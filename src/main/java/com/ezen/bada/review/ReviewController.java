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
import com.fasterxml.jackson.databind.ObjectMapper;


@Controller
public class ReviewController {
	
	@Autowired
	SqlSession sqlsession;
	
	String image_path="C:\\이젠디지탈12\\spring\\bada\\src\\main\\webapp\\resources\\image_user";
	
	
	
	//리뷰 작성(데이터 삽입)
	@RequestMapping(value = "review_input")
	public String review1(HttpServletRequest request, Model mo, HttpServletResponse response) throws IOException {

		Service ss = sqlsession.getMapper(Service.class);
		HttpSession hs = request.getSession();
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		if (hs.getAttribute("loginstate") == null) {
		    out.print("<script type='text/javascript'> alert('로그인이 필요한 기능입니다.');");
		    out.print("window.location.href='login';");
		    out.print("</script>");
		    out.flush();
		    
		    return null;
		}
		
		else {
			boolean loginstate = (boolean) hs.getAttribute("loginstate");
			
			if(loginstate) {
				String loginid = (String) hs.getAttribute("loginid");
				if (loginid == null || loginid.isEmpty()) {
			        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
			        return null;
			    }
				MemberDTO dto = ss.input_info(loginid);
				List<BeachDTO> beachList = ss.getBeachList();
				mo.addAttribute("dto", dto);
				mo.addAttribute("beachList", beachList);
				
				return "review_input";
			}
			
			else {
				out.println("<script>alert('로그인이 필요한 기능입니다.'); location.href='login';</script>");
			    out.flush();
			    
			    return null;
			}
	    }
	}
	
	
	//리뷰 저장
	@RequestMapping(value = "review_save", method = RequestMethod.POST)
	public String review2(MultipartHttpServletRequest mul, HttpServletResponse response) throws IOException {

		String id = mul.getParameter("id");
		if (id == null || id.isEmpty()) {
	        showAlertAndRedirect(response, "오류로 인해 저장이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
	        return null;
	    }
		String name = mul.getParameter("name");
		if (name == null || name.isEmpty()) {
	        showAlertAndRedirect(response, "오류로 인해 저장이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
	        return null;
	    }
		String visit_day = mul.getParameter("visit_day");
		if (visit_day == null || visit_day.isEmpty()) {
	        showAlertAndRedirect(response, "오류로 인해 저장이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
	        return null;
	    }
		String beach_code = mul.getParameter("beach");
		if (beach_code == null || beach_code.isEmpty()) {
	        showAlertAndRedirect(response, "오류로 인해 저장이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
	        return null;
	    }
		String review_title = mul.getParameter("review_title");
		if (review_title == null || review_title.isEmpty()) {
	        showAlertAndRedirect(response, "오류로 인해 저장이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
	        return null;
	    }
		String review_contents = mul.getParameter("review_contents");
		if (review_contents == null || review_contents.isEmpty()) {
	        showAlertAndRedirect(response, "오류로 인해 저장이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
	        return null;
	    }
		String review_score = mul.getParameter("review_score");
		if (review_score == null || review_score.isEmpty()) {
	        showAlertAndRedirect(response, "오류로 인해 저장이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
	        return null;
	    }
		String hashtags = mul.getParameter("hashtags");
		if (hashtags == null || hashtags.isEmpty()) {
	        showAlertAndRedirect(response, "오류로 인해 저장이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
	        return null;
	    }
		String re_visit = mul.getParameter("re_visit");
		if (re_visit == null || re_visit.isEmpty()) {
	        showAlertAndRedirect(response, "오류로 인해 저장이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
	        return null;
	    }
		
		MultipartFile tf = mul.getFile("thumb_nail");
		String t_name;
		if (tf != null && !tf.isEmpty()) {
		    t_name = System.currentTimeMillis() + "_" + tf.getOriginalFilename();
		    tf.transferTo(new File(image_path + File.separator + t_name));
		} else {
		    t_name = "no"; // 썸네일 파일이 없는 경우 "no" 저장
		}
		
		 String[] fileNames = new String[5];
	        
	        for (int i = 1; i <= 5; i++) {
	            MultipartFile file = mul.getFile("pic" + i);
	            if (file != null && !file.isEmpty()) {
	                String filename = System.currentTimeMillis() + "_" + file.getOriginalFilename();
	                file.transferTo(new File(image_path + File.separator + filename));
	                fileNames[i - 1] = filename; // 파일 이름을 배열에 저장
	            }
	            else {
	                fileNames[i - 1] = "no"; // 파일이 없는 경우 -> null 저장시 오류 발생
	            }
	        }
	   
	    Service ss = sqlsession.getMapper(Service.class);
	    ss.review_save(id,name,visit_day,review_title,review_contents,fileNames,
	    		t_name,review_score,hashtags,beach_code,re_visit);
	        
	    return "main";
	}
	
	
	//리뷰 저장2
	@RequestMapping(value = "review_input2")
	public String review2(HttpServletRequest request, HttpServletResponse response, Model mo) throws IOException {
		
		return "review_input2";
			
	}
	

	//리뷰 페이지의 가장 첫 번째 페이지(미니 홈페이지 ver)
	@RequestMapping(value = "bada_review")
	public String review3(HttpServletRequest request, Model mo, HttpServletResponse response) throws IOException {
		
		String area = request.getParameter("area");
		if (area == null || area.isEmpty()) {
	        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
	        return null;
	    }
		mo.addAttribute("area",area);
		//아이디,닉네임 넣기
		HttpSession hs = request.getSession();
		String id = null;
		String name = null;
		Service ss = sqlsession.getMapper(Service.class);
		
		if(hs.getAttribute("loginid")!=null) {
			id = (String) hs.getAttribute("loginid");
			if (id == null || id.isEmpty()) {
		        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
		        return null;
		    }
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
			if (area1 == null || area1.isEmpty()) {
		        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
		        return null;
		    }
			String area2 = area.substring(2);
			if (area2 == null || area2.isEmpty()) {
		        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
		        return null;
		    }
			list = ss.picknewrec6in2area(area1,area2);
		}
		else {
			list = ss.picknewrecinarea(area);
		}
		
		mo.addAttribute("list", list);
		
		//리뷰많이쓴사람 가져오기 (1~5위)
		ArrayList<String> list2 = ss.getbestreviewer();
		mo.addAttribute("list2", list2);
		
		//한마디 가져오기
		ArrayList<OneDTO> olist = ss.getonesentence(area);
		mo.addAttribute("olist", olist);
		
		//지역별 새글 수
		ArrayList<CountreviewDTO> clist = ss.getreviewcount();
		mo.addAttribute("clist", clist);
		
		return "bada_review";
	}
	

	//리뷰 목록형(페이징 처리형) 페이지 가져오기
	//가장 초기에 불러와주는 페이지이며, 소트(정렬 기준)이 없을 시 최신순 정렬을 자동으로 실시
	@RequestMapping(value = "review_all_page")
	public String review4(HttpServletRequest request, PageDTO dto, Model mo) {
		
		String sort=request.getParameter("sort");
		if(sort==null || sort.isEmpty()) {sort="latest";} //정렬 기준이 없을 시 자동으로 최신순 정렬
		
		String nowPage=request.getParameter("nowPage");
        String cntPerPage=request.getParameter("cntPerPage");
        
		Service ss = sqlsession.getMapper(Service.class);
		int total=ss.total();
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
        if(sort.equals("latest")) {
	    	mo.addAttribute("list",ss.page_review_listout_latest(dto));
	    	mo.addAttribute("sort", sort);
	    }
	    else {
	    	mo.addAttribute("list",ss.page_review_listout_popular(dto));
	    	mo.addAttribute("sort", sort);
	    }

		return "review_page";
	}
	
	
	//리뷰 목록형(페이징 처리형) 페이지 가져오기.
	//가장 초기에 불러와주는 페이지이며, 소트(정렬 기준)이 없을 시 최신순 정렬을 자동으로 실시
	//review_all_page가 아닌 review_page로 이동할 시에도 오류가 나지 않도록 한 번 더 불러와줌
	@RequestMapping(value = "review_page")
	public String review_page(HttpServletRequest request, PageDTO dto, Model mo) {
		
		String sort=request.getParameter("sort");
		if(sort==null || sort.isEmpty()) {sort="latest";} //정렬 기준이 없을 시 최신순으로 기본 정렬
		
		String nowPage=request.getParameter("nowPage");
        String cntPerPage=request.getParameter("cntPerPage");
		
		Service ss = sqlsession.getMapper(Service.class);
		int total=ss.total();
		
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
        if(sort.equals("latest")) {
	    	mo.addAttribute("list",ss.page_review_listout_latest(dto));
	    	mo.addAttribute("sort", sort);
	    }
	    else {
	    	mo.addAttribute("list",ss.page_review_listout_popular(dto));
	    	mo.addAttribute("sort", sort);
	    }

		return "review_page";
	}
	

	//리뷰 디테일(리뷰 상세 보기)
	@RequestMapping(value = "review_detail")
	public String review4(HttpServletRequest request, Model mo, HttpServletResponse response) throws IOException {
		
		try {
			
			int review_num = Integer.parseInt(request.getParameter("review_num"));
			
			 if (review_num == 0) {
			        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
			        return null;
			 }
			 
			Service ss = sqlsession.getMapper(Service.class);
			ss.hit_up(review_num);
			
			AllBoardDTO dto = ss.review_detail(review_num);
			mo.addAttribute("dto", dto);
			
			String beach = ss.beach_name(review_num);
			mo.addAttribute("beach", beach);
			
			List<String> gallery = new ArrayList<String>();
			
			if (!"no".equals(dto.getThumbnail())){gallery.add(dto.getThumbnail());}
			
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
			 
			 if(hs.getAttribute("loginid")!=null) {
				 
				 String loginid = (String) hs.getAttribute("loginid");
				 mo.addAttribute("loginid", loginid);
				 
			 }
			 
			 ArrayList<ReplyDTO> reply = ss.reply_show(review_num);
			 
			 mo.addAttribute("reply", reply);
			 
			 return "review_detail";
			 
			
		    } catch (NumberFormatException e) {
		        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
		        
		        return null;
		    }
		  
	}
	
	
	//리뷰를 삭제할 시
	@RequestMapping(value = "review_delete")
	public String review_delete(HttpServletRequest request, HttpServletResponse response) throws IOException {

	     int review_num;
	     try {
	    	 review_num = Integer.parseInt(request.getParameter("review_num"));
		    } catch (NumberFormatException e) {
		        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
		        return null;
		    }
	     
		    if (review_num == 0) {
		        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
		        return null;
		    }
	     Service ss = sqlsession.getMapper(Service.class);
	     
	     AllBoardDTO boardDTO = ss.all_photo(review_num);
	     
	     List<String> photoPaths = Arrays.asList(boardDTO.getPhoto1(), boardDTO.getPhoto2(), 
							                     boardDTO.getPhoto3(), boardDTO.getPhoto4(), 
							                     boardDTO.getPhoto5(), boardDTO.getThumbnail());
		for(String photo : photoPaths) {
			
			if(photo != null && !photo.equals("no")) 
			{File file = new File(image_path +File.separator+photo);
				if(file.exists()){file.delete();}
			}
		}
	     
	     ss.review_delete(review_num);
	     ss.review_comment_delete(review_num);

      return "redirect:/review_all_page";
      }
	

	//리뷰를 수정할 시
	@RequestMapping(value = "review_change")
	public String review_change(HttpServletRequest request, Model mo, HttpServletResponse response) throws IOException {

	     int review_num;
	     try {
	    	 review_num = Integer.parseInt(request.getParameter("review_num"));
		    } catch (NumberFormatException e) {
		        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
		        return null;
		    }
		    if (review_num == 0) {
		        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
		        return null;
		    }
	     Service ss = sqlsession.getMapper(Service.class);
	     
	     AllBoardDTO dto = ss.change_view(review_num);
	     List<BeachDTO> beachList = ss.getBeachList();
	     List<String> photoList = Arrays.asList(dto.getPhoto1(), dto.getPhoto2(), dto.getPhoto3(), dto.getPhoto4(), dto.getPhoto5());
	     mo.addAttribute("beachList", beachList);
	     mo.addAttribute("dto", dto);
	     mo.addAttribute("photoList", photoList);

     return "change_view";
     }
	
	
	//리뷰를 수정해서 다시 저장
	@RequestMapping(value = "review_change_save", method = RequestMethod.POST)
	public String review_change_save(MultipartHttpServletRequest mul, HttpServletResponse response) throws IllegalStateException, IOException {

		int review_num;
		try {
			review_num = Integer.parseInt(mul.getParameter("review_num"));
		    } catch (NumberFormatException e) {
		        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
		        return null;
		    }
		    if (review_num == 0) {
		        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
		        return null;
		    }
		String visit_day = mul.getParameter("visit_day");
		if (visit_day == null || visit_day.isEmpty()) {
	        showAlertAndRedirect(response, "오류로 인해 저장이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
	        return null;
	    }
		String beach_code = mul.getParameter("beach");
		if (beach_code == null || beach_code.isEmpty()) {
	        showAlertAndRedirect(response, "오류로 인해 저장이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
	        return null;
	    }
		String review_title = mul.getParameter("review_title");
		if (review_title == null || review_title.isEmpty()) {
	        showAlertAndRedirect(response, "오류로 인해 저장이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
	        return null;
	    }
		String review_contents = mul.getParameter("review_contents");
		if (review_contents == null || review_contents.isEmpty()) {
	        showAlertAndRedirect(response, "오류로 인해 저장이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
	        return null;
	    }
		String review_score = mul.getParameter("review_score");
		if (review_score == null || review_score.isEmpty()) {
	        showAlertAndRedirect(response, "오류로 인해 저장이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
	        return null;
	    }
		String hashtags = mul.getParameter("hashtags");
		if (hashtags == null || hashtags.isEmpty()) {
	        showAlertAndRedirect(response, "오류로 인해 저장이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
	        return null;
	    }
		String re_visit = mul.getParameter("re_visit");
		if (re_visit == null || re_visit.isEmpty()) {
	        showAlertAndRedirect(response, "오류로 인해 저장이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
	        return null;
	    }
		
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
				{File file = new File(image_path +File.separator+photo);
					if(file.exists()) {file.delete();}
				}
			}
			
		    modi_photos(mul, review_num, ss);
		}
		    
		    ss.review_modify(review_num,visit_day,review_title,review_contents,
		    				review_score,hashtags,beach_code,re_visit);
		    
		      return "redirect:/review_detail?review_num="+ review_num;
		   }
	
	
	//리뷰를 수정할 때 만일 사진이 바뀔 경우 기존의 사진 파일을 삭제하는 메소드
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
	        }
	        else {change_photo[i - 1] = "no";}
	    }
	    
	    Map<String, Object> params = new HashMap<>();
	    params.put("review_num", review_num);
	    params.put("change_photo", change_photo);
	    ss.update_photo(params);
	}
	
	//리뷰를 삭제할 때 만일 썸네일이 바뀔 경우 썸네일을 수정하고 기존의 썸네일을 삭제하는 메소드
	private void modi_thumbnail(MultipartHttpServletRequest mul, int review_num, Service ss) throws IllegalStateException, IOException {
	    MultipartFile tf = mul.getFile("thumb_nail");
	    
	    if (tf != null && !tf.isEmpty()) {
	        String original = ss.original_thumbnail(review_num);

	        if (original != null && !original.equals("no")) {
	            File file = new File(image_path + File.separator + original);
	            if (file.exists()) {file.delete();}
	        }

	        UUID ud = UUID.randomUUID();
	        String t_name = ud.toString() + "_" + tf.getOriginalFilename();
	        File newFile = new File(image_path + File.separator + t_name);
	        tf.transferTo(newFile);
	       
	        ss.thumbnail_upload(review_num, t_name);
	    }
	}

	
	//리뷰 검색 기능
	@ResponseBody
	@RequestMapping(value = "/review_search", produces = "text/html; charset=UTF-8")
	public String search1(HttpServletRequest request) {
		
		String category = request.getParameter("search_category");
		String search = request.getParameter("search");
		String nowPage = request.getParameter("nowPage");
		String cntPerPage = request.getParameter("cntPerPage");
		Service ss = sqlsession.getMapper(Service.class);
		String beach_code = "";
		
		if (nowPage == null || cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "20";
		}
  
		if ("vdate".equals(category) || "wdate".equals(category)) {
			String year = request.getParameter("year");
			String month = request.getParameter("month");

			if ("2020".equals(year)) {
				search = "2020";
			} else if (year != null && !year.isEmpty() && month != null && !month.isEmpty()) {
				search = year + "-" + String.format("%02d", Integer.parseInt(month)); // "2024-05"
			} else if (year != null && !year.isEmpty()) {
				search = year; // "2024"
			} else if (month != null && !month.isEmpty()) {search = month;}
	    }
		
		if(category.equals("beach_name")) {
			category = "beach_code";	
			beach_code = ss.findbeachcode(search);
			search = beach_code;
			System.out.println("카테고리 : "+category+", 해변코드 : "+beach_code );
		}
	    
	    int total = ss.search_result_count(category, search);
	    System.out.println("리뷰갯수"+total);
	    PageDTO dto = new PageDTO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
	    ArrayList<AllBoardDTO> list2 = ss.search_result(category,search, dto.getStart(), dto.getEnd());
	    System.out.println("리뷰들어왔니? : "+list2);
	    StringBuilder sb = new StringBuilder();
	    sb.append("<table class='board-table'>");
	    sb.append("<thead><tr>");
	    sb.append("<th scope='col' class='th-num'>번호</th>");
	    sb.append("<th scope='col' class='th-title'>제목</th>");
	    sb.append("<th scope='col' class='th-writer'>작성자</th>");
	    sb.append("<th scope='col' class='th-date vdate'>방문일</th>");
	    sb.append("<th scope='col' class='th-date wdate'>작성일</th>");
	    sb.append("<th scope='col' class='th-num recommend'>추천수</th>");
	    sb.append("<th scope='col' class='th-num view'>조회수</th>");
	    sb.append("</tr></thead>");
	    sb.append("<tbody>");

	    for(AllBoardDTO item:list2) {
	    	sb.append("<tr>");
	        sb.append("<td>").append(item.getReview_num()).append("</td>");
	        sb.append("<td class='text_title'><a href='review_detail?review_num=").append(item.getReview_num()).append("'>")
	              	  .append(item.getReview_title()).append(" <span class='reply_check'>[").append(item.getReply()).append("]</span></a></td>");
	        sb.append("<td>").append(item.getName()).append("(")
	              	  .append(item.getId().substring(0, 4)).append("****)님</td>");
	        sb.append("<td>").append(item.getVisit_day()).append("</td>");
	        sb.append("<td>").append(item.getWrite_day().substring(0, 10)).append("</td>");
	        sb.append("<td>").append(item.getRecommend()).append("</td>");
	        sb.append("<td>").append(item.getHits()).append("</td>");
	        sb.append("</tr>");
	    }
	    sb.append("<tr style='border-left: none; border-right: none; border-bottom: none;'>");
	    sb.append("<th colspan='7' style='text-align: center;'>");

	    // 페이징 로직 시작
	    if (dto.getStartPage() > 1) {
	        sb.append("<a href='review_all_page?nowPage=").append(dto.getStartPage() - 1)
	            	  .append("&cntPerPage=").append(dto.getCntPerPage()).append("'>◀</a> ");
	    }

	    for (int i = dto.getStartPage(); i <= dto.getEndPage(); i++) {
	    	if (i == dto.getNowPage()) {
	            sb.append("<span style='color: red;'>").append(i).append("</span> ");
	        } else {
	            sb.append("<a href='review_all_page?nowPage=").append(i)
	              		  .append("&cntPerPage=").append(dto.getCntPerPage()).append("'>")
	              		  .append(i).append("</a> ");
	        }
	    }

	    if (dto.getEndPage() < dto.getLastPage()) {
	        sb.append("<a href='review_all_page?nowPage=").append(dto.getEndPage() + 1)
	            	  .append("&cntPerPage=").append(dto.getCntPerPage()).append("'>▶</a>");
	    }

	    sb.append("</th>");
	    sb.append("</tr>");
	    sb.append("</tbody></table>"); 
	    
	    System.out.println(sb.toString());
	    
	    return sb.toString();

	   }
		
		
		
	//리뷰 서치
	@ResponseBody
	@RequestMapping(value = "/review_area_search", produces = "text/html; charset=UTF-8")
	public String search2(HttpServletRequest request) {
		    
	   String area = request.getParameter("area");
	   String nowPage = request.getParameter("nowPage");
	   String cntPerPage = request.getParameter("cntPerPage");

	   if (nowPage == null || cntPerPage == null) {
	       nowPage = "1";
	       cntPerPage = "20";
	   }
	      
	   Service ss = sqlsession.getMapper(Service.class);
	   int total = ss.area_result_count(area);
	   PageDTO dto = new PageDTO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
	   ArrayList<AllBoardDTO> list = ss.search_area_result(area,dto.getStart(), dto.getEnd());
	   
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
	      
	   sb.append("<tr style='border-left: none; border-right: none; border-bottom: none;'>");
	   sb.append("<th colspan='7' style='text-align: center;'>");

	   // 페이징 로직 시작
	   if (dto.getStartPage() > 1) {
	       sb.append("<a href='review_all_page?nowPage=").append(dto.getStartPage() - 1)
	            	  .append("&cntPerPage=").append(dto.getCntPerPage()).append("'>◀</a> ");
	      }
	   
	      for (int i = dto.getStartPage(); i <= dto.getEndPage(); i++) {
	          if (i == dto.getNowPage()) {
	          sb.append("<span style='color: red;'>").append(i).append("</span> ");
	          } else {
	              sb.append("<a href='review_all_page?nowPage=").append(i)
	              .append("&cntPerPage=").append(dto.getCntPerPage()).append("'>")
	              .append(i).append("</a> ");
	          }
	      }

	      if (dto.getEndPage() < dto.getLastPage()) {
	          sb.append("<a href='review_all_page?nowPage=").append(dto.getEndPage() + 1)
	          .append("&cntPerPage=").append(dto.getCntPerPage()).append("'>▶</a>");
	      }

	   sb.append("</th>");
	   sb.append("</tr>");
	   sb.append("</tbody></table>"); 

	   return sb.toString();
	}
	
	
	
	
	
	//리뷰 추천하기를 누를 시
	@RequestMapping(value = "review_recommend")
	public String recommend(HttpServletRequest request, Model mo, HttpServletResponse response) throws IOException {

		int review_num;
		try {
			review_num = Integer.parseInt(request.getParameter("review_num"));
		    } catch (NumberFormatException e) {
		        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
		        return null;
		    }
		    if (review_num == 0) {
		        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
		        return null;
		    }
		String loginid=request.getParameter("loginid");
		if (loginid == null || loginid.isEmpty()) {
	        showAlertAndRedirect(response, "오류로 인해 저장이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
	        return null;
	    }
		
		Service ss=sqlsession.getMapper(Service.class);
		// 추천 중복체크 확인
		int rec_id=ss.review_rec_id(review_num, loginid);
		
		 if (rec_id == 0) {
		        ss.review_recommand(loginid, review_num);
		    } else {
		        ss.unrecommend(loginid, review_num);
		    }
		 
			AllBoardDTO dto=ss.review_detail(review_num);
			mo.addAttribute("dto", dto);
	
	      return "redirect:/review_detail?review_num="+review_num;
   }
	
	
	
		//추천 보기
		@ResponseBody
		@RequestMapping(value="recommend_view", method = RequestMethod.GET, produces = "application/json; charset=utf-8")
		public String main_review(HttpServletRequest request, Model mo) {
			
		    Service ss = sqlsession.getMapper(Service.class);
		    ArrayList<AllBoardDTO> list = ss.pickbestrec();

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

		//추천 취소
		@RequestMapping(value = "review_unrecommend")
		public String unrecommend(HttpServletRequest request, HttpServletResponse response) throws IOException {
		    int reviewNum;
		    String userId;
		    try {
		        reviewNum = Integer.parseInt(request.getParameter("review_num"));
		        userId = request.getParameter("user_id");
		    } catch (NumberFormatException e) {
		        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
		        return null;
		    }

		    if (reviewNum == 0 || userId == null || userId.isEmpty()) {
		        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
		        return null;
		    }
		    
		    try {
		        Service ss = sqlsession.getMapper(Service.class);
		        ss.unrecommend(userId, reviewNum);
		    } catch (Exception e) {
		        showAlertAndRedirect(response, "오류가 발생했습니다. 다시 시도해 주세요.");
		        return null;
		    }


		    return "redirect:/my_favorite";
		}
	
	
	
	
	//신고 기능
	@RequestMapping(value = "review_report_view")
	public String report(HttpServletRequest request, Model mo, HttpServletResponse response) throws IOException {

		int review_num;
		try {
			review_num = Integer.parseInt(request.getParameter("review_num"));
		    } catch (NumberFormatException e) {
		        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
		        return null;
		    }
		    if (review_num == 0) {
		        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
		        return null;
		    }
		String loginid=request.getParameter("loginid");
		if (loginid == null || loginid.isEmpty()) {
	        showAlertAndRedirect(response, "오류로 인해 저장이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
	        return null;
	    }
		
		Service ss=sqlsession.getMapper(Service.class);
		MemberDTO mdto = ss.input_info(loginid);
		mo.addAttribute("mdto", mdto);
		
		AllBoardDTO adto = ss.review_detail(review_num);
		mo.addAttribute("adto", adto);

	      return "review_report_view";
   }
	
	//리뷰 신고 할 시 중복 방지
	@ResponseBody
	@RequestMapping(value = "review_ban_check", method = RequestMethod.POST)
	public String inquire_ban_check(HttpServletRequest request, HttpServletResponse response) throws IOException {
  
		String id = request.getParameter("id");
		if (id == null || id.isEmpty()) {
	        showAlertAndRedirect(response, "오류로 인해 저장이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
	        return null;
	    }
		int ban_review_num=Integer.parseInt(request.getParameter("ban_review_num"));
		try {
			ban_review_num = Integer.parseInt(request.getParameter("ban_review_num"));
		    } catch (NumberFormatException e) {
		        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
		        return null;
		    }
		    if (ban_review_num == 0) {
		        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
		        return null;
		    }
		String category = request.getParameter("category");
		if (category == null || category.isEmpty()) {
	        showAlertAndRedirect(response, "오류로 인해 저장이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
	        return null;
	    }
		
		Service ss=sqlsession.getMapper(Service.class);
		String inquire_check="";
		String result="";
		inquire_check=ss.review_ban_check(id, ban_review_num, category); //동일한 사람이 동일한 글을 동일한 사유로 여러번 신고할 수 없도록 중복 방지
		
		if (inquire_check==null) {result="ok";}
		else {result="nope";}
		        
		return result;
	}
	
	//리뷰 신고 리스트 아웃
	@RequestMapping(value = "review_ban_listout")
	public String ban_list(HttpServletRequest request, PageDTO dto, Model mo) {
		
		String nowPage=request.getParameter("nowPage");
		String cntPerPage=request.getParameter("cntPerPage");
		Service ss = sqlsession.getMapper(Service.class);
		int total=ss.ban_review_total();
		
		if(nowPage==null && cntPerPage == null) {
		 nowPage="1";
		   // 현재 페이지 ㄴ번호                                    
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
	public String ban_review_detail(HttpServletRequest request, Model mo, HttpServletResponse response) throws IOException {
	
		int ban_review_num;
		try {
			ban_review_num = Integer.parseInt(request.getParameter("ban_review_num"));
		    } catch (NumberFormatException e) {
		        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
		        return null;
		    }
		    if (ban_review_num == 0) {
		        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
		        return null;
		    }
		String ban_id=request.getParameter("ban_id");
		if (ban_id == null || ban_id.isEmpty()) {
	        showAlertAndRedirect(response, "오류로 인해 저장이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
	        return null;
	    }
		
		Service ss=sqlsession.getMapper(Service.class);

		Review_report_DTO dto=ss.review_ban_detail(ban_review_num);
		mo.addAttribute("dto", dto);

		int ban_count=ss.review_ban_count(ban_id);
		mo.addAttribute("ban_count", ban_count);
		
		ArrayList<Review_report_DTO> list=ss.review_ban_list(ban_id);
		mo.addAttribute("list", list);

		return "review_ban_detail";
	}
			
	   
	//신고 내역 삭제
	@RequestMapping(value="review_ban_delete")
    public String review_ban_delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		int review_report_num;
		try {
			review_report_num = Integer.parseInt(request.getParameter("review_report_num"));
		    } catch (NumberFormatException e) {
		        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
		        return null;
		    }
		    if (review_report_num == 0) {
		        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
		        return null;
		    }
		
		Service ss=sqlsession.getMapper(Service.class);
		ss.review_ban_delete(review_report_num);
		
		return "redirect:/review_ban_listout";
    }

	
	//리뷰 댓글 처리 영역
	//리뷰 댓글 저장
	@ResponseBody
	@RequestMapping(value = "reply_save", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
    public String review_comment(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
        int review_num;
        try {
        	review_num = Integer.parseInt(request.getParameter("review_num"));
		    } catch (NumberFormatException e) {
		        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
		        return null;
		    }
		    if (review_num == 0) {
		        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
		        return null;
		    }
        String loginid = request.getParameter("loginid").trim();
        String reply = request.getParameter("reply");
        if (reply == null || reply.isEmpty()) {
	        showAlertAndRedirect(response, "오류로 인해 저장이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
	        return null;
	    }
        
        Service ss = sqlsession.getMapper(Service.class);
        
        String nickname =  ss.getnickname(loginid);
        
        ss.reply_save(review_num,loginid,reply,nickname);
        ss.reply_update(review_num);

        JSONObject obj = new JSONObject();
        obj.put("success", true);
        obj.put("loginid", loginid);
        obj.put("reply", reply);

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        String replyDate = sdf.format(new Date());
        obj.put("reply_day", replyDate);
        
        return obj.toString();    
	}
	

	//댓글 삭제하는 기능
	@ResponseBody
	@RequestMapping(value = "delete_reply")
	public String reply_delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
  
		JSONObject obj = new JSONObject();
  
	    try {
	    	
			int reply_num;
			try {
				reply_num = Integer.parseInt(request.getParameter("reply_num"));
			    } catch (NumberFormatException e) {
			        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
			        return null;
			    }
			    if (reply_num == 0) {
			        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
			        return null;
			    }
			int review_num;
			try {
				review_num = Integer.parseInt(request.getParameter("review_num"));
			    } catch (NumberFormatException e) {
			        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
			        return null;
			    }
			    if (review_num == 0) {
			        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
			        return null;
			    }
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
		
	//댓글 수정하는 기능
	@ResponseBody
	@RequestMapping(value = "modify_reply")
	public String reply_modify(HttpServletRequest request, HttpServletResponse response) throws IOException {
      
	  	JSONObject obj = new JSONObject();
	  
	    try {
	    	
	        int reply_num = Integer.parseInt(request.getParameter("reply_num"));
	        try {
	        	reply_num = Integer.parseInt(request.getParameter("reply_num"));
			    } catch (NumberFormatException e) {
			        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
			        return null;
			    }
			    if (reply_num == 0) {
			        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
			        return null;
			    }
	        String modi_reply = request.getParameter("reply");
	        if (modi_reply == null || modi_reply.isEmpty()) {
		        showAlertAndRedirect(response, "오류로 인해 저장이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
		        return null;
		    }

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
	

	//댓글 신고
	@ResponseBody
	@RequestMapping(value = "report_reply" , method = RequestMethod.POST)
	public String report_reply(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		int reply_num;
		try {
			reply_num = Integer.parseInt(request.getParameter("reply_num"));
		    } catch (NumberFormatException e) {
		        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
		        return null;
		    }
		    if (reply_num == 0) {
		        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
		        return null;
		    }
		int review_num;
		try {
			review_num = Integer.parseInt(request.getParameter("review_num"));
		    } catch (NumberFormatException e) {
		        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
		        return null;
		    }
		    if (review_num == 0) {
		        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
		        return null;
		    }
		String id = request.getParameter("reporter_id");
		if (id == null || id.isEmpty()) {
	        showAlertAndRedirect(response, "오류로 인해 저장이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
	        return null;
	    }
		String ban_id = request.getParameter("reply_id");
		if (ban_id == null || ban_id.isEmpty()) {
	        showAlertAndRedirect(response, "오류로 인해 저장이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
	        return null;
	    }
		String reply_contents = request.getParameter("reply_content");
		if (reply_contents == null || reply_contents.isEmpty()) {
	        showAlertAndRedirect(response, "오류로 인해 저장이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
	        return null;
	    }
		String reason = request.getParameter("reason");
		if (reason == null || reason.isEmpty()) {
	        showAlertAndRedirect(response, "오류로 인해 저장이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
	        return null;
	    }
		String detail = request.getParameter("detail");
		if (detail == null || detail.isEmpty()) {
	        showAlertAndRedirect(response, "오류로 인해 저장이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
	        return null;
	    }
		
		String result="";
			  
		Service ss = sqlsession.getMapper(Service.class);
	  
		String name = ss.user_name(id);
		String ban_name = ss.user_name(ban_id);
		int user_num = ss.user_num(ban_id);
		int user_num2 = ss.user_num(id);
	  
		String ban_check = ss.report_check(reply_num,id,reason,reply_contents);
	  
		if (ban_check==null) {
		  ss.reply_report_save(review_num, reply_num, id, ban_id, reply_contents, reason, detail, user_num, name, ban_name, user_num2);
		  result="ok";
        } else {result="no";}

		return result;
	}
	
	
	//신고 당한 댓글 조회
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
	
	//댓글 신고 내역 삭제
	@RequestMapping(value="/reply_ban_delete")
	public String reply_ban_delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		int review_reply_ban_num=Integer.parseInt(request.getParameter("review_reply_ban_num"));
		try {
			review_reply_ban_num = Integer.parseInt(request.getParameter("inquire_num"));
		    } catch (NumberFormatException e) {
		        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
		        return null;
		    }
		    if (review_reply_ban_num == 0) {
		        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
		        return null;
		    }
		
		Service ss=sqlsession.getMapper(Service.class);
		ss.reply_ban_delete(review_reply_ban_num);
		
		return "redirect:/reply_ban_listout";
	}
	  
	  //리뷰 신고 저장하기 기능
	@RequestMapping(value = "review_ban_save", method = RequestMethod.POST)
	public String inquire_ban_save(HttpServletRequest request, HttpServletResponse response, Model mo) throws IOException {
	      
		String title = request.getParameter("title");
		if (title == null || title.isEmpty()) {
	        showAlertAndRedirect(response, "오류로 인해 저장이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
	        return null;
	    }
		String name = request.getParameter("name");
		if (name == null || name.isEmpty()) {
	        showAlertAndRedirect(response, "오류로 인해 저장이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
	        return null;
	    }
		String id = request.getParameter("id");
		if (id == null || id.isEmpty()) {
	        showAlertAndRedirect(response, "오류로 인해 저장이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
	        return null;
	    }
		int ban_review_num;
		try {
			ban_review_num = Integer.parseInt(request.getParameter("ban_review_num"));
		    } catch (NumberFormatException e) {
		        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
		        return null;
		    }
		    if (ban_review_num == 0) {
		        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
		        return null;
		    }
		String ban_name = request.getParameter("ban_name");
		if (ban_name == null || ban_name.isEmpty()) {
	        showAlertAndRedirect(response, "오류로 인해 저장이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
	        return null;
	    }
		String ban_id = request.getParameter("ban_id");
		if (ban_id == null || ban_id.isEmpty()) {
	        showAlertAndRedirect(response, "오류로 인해 저장이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
	        return null;
	    }
		String category = request.getParameter("category");
		if (category == null || category.isEmpty()) {
	        showAlertAndRedirect(response, "오류로 인해 저장이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
	        return null;
	    }
		String content = request.getParameter("content");
		if (content == null || content.isEmpty()) {
	        showAlertAndRedirect(response, "오류로 인해 저장이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
	        return null;
	    }
		
		Service ss=sqlsession.getMapper(Service.class);
		int user_num=ss.user_num(ban_id);
		int user_num2=ss.user_num(id);
		
		ss.review_ban_save(title, name, id, ban_review_num, ban_name, ban_id, category, content,user_num,user_num2);
		ss.report_up(ban_review_num);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		out.print("<script type='text/javascript'>");
		out.print("self.close(); window.reload();");
		out.print("</script>");
		out.flush();
		
		return null;
	}	  

	//나도 한마디 출력 페이지
	@RequestMapping(value = "/say_one_sentence")
	public String say_one_sentence(HttpServletRequest request, Model mo, HttpServletResponse response) throws IOException {
		
		Service ss = sqlsession.getMapper(Service.class);
		HttpSession hs = request.getSession();
		response.setContentType("text/html; charset=UTF-8");
		
		if (hs.getAttribute("loginstate") == null || !(boolean) hs.getAttribute("loginstate")) {
	        // 로그인하지 않은 상태에서는 로그인 관련 정보를 가져오지 않고, 채팅 내역만 가져옴
	        ArrayList<OneDTO> list = ss.say_one_sentence();
	        mo.addAttribute("list", list);
	        
	    } else {
	        // 로그인한 경우에는 사용자 정보와 함께 채팅 내역을 가져옴
	        String loginid = (String) hs.getAttribute("loginid");
	        if (loginid == null || loginid.isEmpty()) {
		        showAlertAndRedirect(response, "오류로 인해 저장이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
		        return null;
		    }
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
	public String say_one_save(HttpServletRequest request, Model mo, HttpServletResponse response) throws IOException {
	
		String loc = request.getParameter("loc");
		if (loc == null || loc.isEmpty()) {
	        showAlertAndRedirect(response, "오류로 인해 저장이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
	        return null;
	    }
		String id = request.getParameter("id");
		if (id == null || id.isEmpty()) {
	        showAlertAndRedirect(response, "오류로 인해 저장이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
	        return null;
	    }
	    String name = request.getParameter("name");
	    if (name == null || name.isEmpty()) {
	        showAlertAndRedirect(response, "오류로 인해 저장이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
	        return null;
	    }
	    String content = request.getParameter("content");
	    
	    Service ss = sqlsession.getMapper(Service.class);
		HttpSession hs = request.getSession();
		response.setContentType("text/html; charset=UTF-8");
	    
	    if(content.equals("")||content==null||content.isEmpty()) {content="바라는 바다 짱!><♡";}
	    else {}
	    
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
	public String one_delete(HttpServletRequest request, Model mo, HttpServletResponse response) throws IOException {

		int one_num;
		try {
			one_num = Integer.parseInt(request.getParameter("one_num"));
		    } catch (NumberFormatException e) {
		        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
		        return null;
		    }
		    if (one_num == 0) {
		        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
		        return null;
		    }
		 
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
	public String one_ban(HttpServletRequest request, Model mo, HttpServletResponse response) throws IOException {

		int ban_one_num; //신고당한 채팅 번호
		try {
			ban_one_num = Integer.parseInt(request.getParameter("ban_one_num"));
			System.out.println("확인1 :"+ban_one_num);
		    } catch (NumberFormatException e) {
		        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
		        return null;
		    }
		    if (ban_one_num == 0) {
		        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
		        return null;
		    }
		String id=request.getParameter("id"); //신고한 사람의 아이디
		System.out.println("확인1 :"+id);
		if (id == null || id.isEmpty()) {
	        showAlertAndRedirect(response, "오류로 인해 저장이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
	        return null;
	    }
		 
		Service ss = sqlsession.getMapper(Service.class);
		HttpSession hs = request.getSession();
		response.setContentType("text/html; charset=UTF-8");
		
		int count_same_ban=ss.count_same_ban(ban_one_num, id); //중복 신고 방지를 위해 정보 가져옴
		System.out.println("확인1 :"+count_same_ban);
		
		if(count_same_ban==0) { //중복신고가 아닌 경우
		
		String ban_id=ss.find_ban_user_id(ban_one_num); //신고당한 채팅에서 신고당한 유저의 아이디 가져옴
		System.out.println("확인1 :"+ban_id);
		int ban_user_num = ss.ban_user_num(ban_id); //신고당한 유저의 아이디로 신고당한 유저의 회원번호를 가져옴
		System.out.println("확인2 :"+ban_user_num);
		String ban_name=ss.find_ban_user_name(ban_id); //신고당한 유저의 아이디로 신고당한 유저의 닉네임을 가져옴
		System.out.println("확인3 :"+ban_name);
		String ban_content=ss.find_ban_content(ban_one_num); //신고당한 채팅 번호로 신고당한 채팅의 내용을 가져옴
		System.out.println("확인4 :"+ban_content);
		String name=ss.find_name(id); //신고한 사람의 아이디로 신고한 사람의 닉네임을 가져옴
		System.out.println("확인5 :"+name);
		 
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
	public String one_ban_delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		int one_ban_num;
		try {
			one_ban_num = Integer.parseInt(request.getParameter("one_ban_num"));
		    } catch (NumberFormatException e) {
		        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
		        return null;
		    }
		    if (one_ban_num == 0) {
		        showAlertAndRedirect(response, "오류로 인해 진행이 어렵습니다. 새로고침 후 다시 시도해 주세요.");
		        return null;
		    }
		
		Service ss=sqlsession.getMapper(Service.class);
		ss.one_ban_delete(one_ban_num);
		
		return "redirect:/one_ban_listout";
    }
	
	
	
	//호출되는 예외처리 메소드
	private void showAlertAndRedirect(HttpServletResponse response, String message) throws IOException {
       response.setContentType("text/html;charset=UTF-8");
       PrintWriter out = response.getWriter();
       out.println("<script>alert('" + message + "'); history.back();</script>");
       out.flush();
   }
		
}
