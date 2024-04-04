package com.ezen.bada.review;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ezen.bada.member.MemberDTO;



@Controller
public class ReviewController {
	
	@Autowired
	SqlSession sqlsession;
	
	String image_path="C:\\이젠디지털12\\spring\\bada\\src\\main\\webapp\\resources\\image_user";
	
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
		System.out.println("확인1 : "+id);
		String name = mul.getParameter("name");
		System.out.println("확인2 : "+name);
		String visit_day = mul.getParameter("visit_day");
		System.out.println("확인3 : "+visit_day);
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
		System.out.println("맞는데 ? : "+review_num);
		
		ArrayList<AllBoardDTO> list = ss.review_detail(review_num);
		mo.addAttribute("list", list);

		return "review_detail";
			
	}
		

}
