package com.ezen.bada.member;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
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
import com.ezen.bada.inquire.InquireDTO2;
import com.ezen.bada.review.AllBoardDTO;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;



@Controller
public class MemberController {
	
	
   
   @Autowired
   SqlSession sqlsession;
   
   
   
   //회원가입 창으로 이동
   @RequestMapping(value = "/member_join")
   public String member1() {return "member_join";}
   
   
   //회원가입 시 아이디 중복 검사
   @ResponseBody
   @RequestMapping(value = "/idcheck")
   public String idcheck(HttpServletRequest request) {
      
      String id = request.getParameter("id");
      Service ss=sqlsession.getMapper(Service.class);

      String result=""; //originid로 얻어온 결과로 if문 실행
      String originid="";

      originid=ss.idcheck(id); //originid: table에서 id로 select where 해서 나온 값
      if(originid==null) {result="ok";} // 결과가 null이면 ok반환
      else {result="nope";} //select 결과가 있으면 nope 반환
      
      return result;
   }
   
   
   //회원가입 시 이메일 중복 검사
   @ResponseBody
   @RequestMapping(value = "/emailcheck")
   public String emailcheck(HttpServletRequest request) {
      
      String email = request.getParameter("email");
      Service ss=sqlsession.getMapper(Service.class);

      String result=""; //originemail로 얻어온 결과로 if문 실행
      String originemail="";

      originemail=ss.emailcheck(email); //originemail: table에서 email로 select where 해서 나온 값
      if(originemail==null) {result="ok";} // 결과가 null이면 ok반환
      else {result="nope";} //select 결과가 있으면 nope 반환
      
      return result;

   }

   
   
   //회원가입 후 저장
   @RequestMapping(value = "/member_save", method = RequestMethod.POST)
   public String membersave(HttpServletRequest request,HttpServletResponse response) throws IOException {
      
	   	String id = request.getParameter("id");
        String pw = request.getParameter("pw");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String gender = request.getParameter("gender");
        int age=Integer.parseInt(request.getParameter("age"));
        String bbti= request.getParameter("bbti");
        
        Service ss=sqlsession.getMapper(Service.class);
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
        
        if(bbti==null||bbti.trim().equals("")) {
	        ss.membersave(id, pw, name, email, gender, age);
	        
			out.print("<script type='text/javascript'>");
			out.print("var result = confirm('회원가입이 완료되었습니다! BBTI(바다성향테스트) 페이지로 이동할까요?');");
			out.print("if(result){ window.open('member_try_bbti?id="+id+"','BBTI 테스트','width=605,height=805,resizable=no,scrollbars=no,menubar=no,location=no') }");	
			out.print("else{ window.location.replace('main') }");
			out.print("</script>");
        }
        
        //만약 bbti 테스트 후에 회원가입을 진행했다면 bbti값도 함께 저장해줌
        else {
	        ss.membersavebbti(id, pw, name, email, gender, age, bbti);
        	
			out.print("<script type='text/javascript'>");
			out.print("alert('회원가입이 완료되었습니다. 물론, BBTI 정보도 잘 저장되었어요!');");
			out.print("window.location.href='./';");
			out.print("</script>");
        }
    
		return null;
   }
   
   
   
   //회원 출력 메소드
   @RequestMapping(value = "/member_out")
   public String memberout(HttpServletRequest request, Model mo, PageDTO dto) {
	   
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
	   mo.addAttribute("list",ss.member_list(dto));
      
	   return "member_out";
   }
   
   
   
   //회원 정보 디테일 출력창
   @RequestMapping(value = "/member_detail")
   public String member_detail(HttpServletRequest request, Model mo) {
	   
      int user_number = Integer.parseInt(request.getParameter("user_number"));
      
      Service ss=sqlsession.getMapper(Service.class);
      MemberDTO list = ss.member_detail_out(user_number);
      mo.addAttribute("list", list);
      
      return "member_detail";
   }
   
   
   
   
   
   //관리자 권한의 회원 정보 삭제(회원 강제 탈퇴)
   @RequestMapping(value = "/member_delete", method = RequestMethod.POST)
   public void memberdelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
      
        String id = request.getParameter("id");
        String admin_pw=request.getParameter("admin_pw");
        
        Service ss=sqlsession.getMapper(Service.class);
        String bringadmin=ss.admincheck(admin_pw);
        
        JSONObject jsonResponse = new JSONObject();

        if (bringadmin != null) {
            ss.quit_member(id);
            jsonResponse.put("result", "ok"); // 삭제 성공 시
        } else {
            jsonResponse.put("result", "nope");
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse.toString());
   }
   
   
   
   
   
   //관리자 권한에서의 회원 정보 수정창
   @RequestMapping(value = "/member_modify_view")
   public String member_modify_view(HttpServletRequest request, Model mo) {
      int user_number = Integer.parseInt(request.getParameter("user_number"));
      
      Service ss=sqlsession.getMapper(Service.class);
      MemberDTO list = ss.member_detail_out(user_number);
      mo.addAttribute("list", list);
      
      return "member_modify_view";
   }
   
   
   
   //관리자 권한의 회원 정보 수정 후 저장
   @RequestMapping(value = "/member_admin_check", method = RequestMethod.POST)
   public void memberadmincheck(HttpServletRequest request, HttpServletResponse response) throws IOException {
      
     	String id = request.getParameter("id");
        String pw = request.getParameter("pw");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String gender = request.getParameter("gender");
        int age=Integer.parseInt(request.getParameter("age"));
        String admin_pw=request.getParameter("admin_pw");
        
        Service ss=sqlsession.getMapper(Service.class);
        String bringadmin=ss.admincheck(admin_pw);
        
        JSONObject jsonResponse = new JSONObject();

        if (bringadmin != null) {
            ss.member_modify(pw, name, email, gender, age, id);
            jsonResponse.put("result", "ok"); // 수정 성공 시
        } else {
            jsonResponse.put("result", "nope");
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse.toString());
   }
   
   
   
   
   //회원 검색 기능
   @RequestMapping(value = "/member_search")
   public String membersearch(HttpServletRequest request, Model mo) {
      
      String keyword=request.getParameter("search_keyword");
      String value=request.getParameter("search_value");
      String gender=request.getParameter("gender");
      int age=Integer.parseInt(request.getParameter("age"));
      
      Service ss=sqlsession.getMapper(Service.class);
      ArrayList<MemberDTO> list;
      
      if(keyword.equals("user_number")) { //검색 키워드가 회원 번호인 경우
         if(gender.equals("") && age==0) { //성별과 나이를 모두 입력하지 않은 경우
            list=ss.member_search_num_n_n(value);
         }//내부 if문 끝
         else if(gender.equals("") && age!=0) { //성별은 입력하지 않고 나이는 입력한 경우
            list=ss.member_search_num_n_a(value, age);
         }//내부 else if문 끝
         else if(gender!=null && age==0) { //성별은 입력하고 나이는 입력하지 않은 경우
            list=ss.member_search_num_g_n(value, gender);
         }//내부 else if문2 끝
         else { //성별과 나이 모두 입력한 경우
            list=ss.member_search_num_g_a(value, gender, age);
         }//내부 else문 끝
      }
      
      else if(keyword.equals("id")) { //검색 키워드가 아이디인 경우
         if(gender.equals("") && age==0) {
            list=ss.member_search_id_n_n(value);
         }//내부 if문 끝
         else if(gender.equals("") && age!=0) {
            list=ss.member_search_id_n_a(value, age);
         }//내부 else if문 끝
         else if(gender!=null && age==0) {
            list=ss.member_search_id_g_n(value, gender);
         }//내부 else if문2 끝
         else {
            list=ss.member_search_id_g_a(value, gender, age);
         }//내부 else문 끝
      }
      
      else { //검색 키워드가 이름인 경우
         if(gender.equals("") && age==0) {
            list=ss.member_search_name_n_n(value);
         }//내부 if문 끝
         else if(gender.equals("") && age!=0) {
            list=ss.member_search_name_n_a(value, age);
         }//내부 else if문 끝
         else if(gender!=null && age==0) {
            list=ss.member_search_name_g_n(value, gender);
         }//내부 else if문2 끝
         else {
            list=ss.member_search_name_g_a(value, gender, age);
         }//내부 else문 끝
      }
      
      mo.addAttribute("list", list);
      
      return "member_out";
   }
   

   //로그인 + 마이페이지 파트
   //로그인창으로 이동
   @RequestMapping(value = "/login")
   public String login1(HttpServletRequest request) {return "login";}
   
   
   
   
   
   //로그인 창에서 회원정보 찾기(아이디 또는 비밀번호 찾기) 창으로 이동하는 경우
   @RequestMapping(value = "/info_search")
   public String search_login() {return "info_search";}

   
   
   //아이디 찾기를 선택한 경우
   @RequestMapping(value = "/find_id")
   public String find1() {return "find_id";}
   
   
   
   //아이디 찾기를 시도하는 경우
   @ResponseBody
   @RequestMapping(value = "/look_id",method = RequestMethod.POST , produces = "application/json;charset=UTF-8")
   public String look1(HttpServletRequest request, HttpServletResponse response) {
	   String name = request.getParameter("name");
	   String email = request.getParameter("email");
     
	   Service ss = sqlsession.getMapper(Service.class);
	   MemberDTO result = ss.lookid(name,email);
     
	   JSONObject returnObj = new JSONObject();
      
	   try {
		   returnObj.put("name", result.getName());
		   returnObj.put("id", result.getId());
	   } catch (NullPointerException e) {
		   returnObj.put("error", "해당 회원정보로 가입된 회원이 없습니다.");
	   }

      return returnObj.toString();
  }
   
   
   
   //비밀번호 찾기를 선택한 경우
   @RequestMapping(value = "/find_pw")
   public String find2() {return "find_pw";}
   
   
   
   //비밀번호 찾기를 시도하는 경우
	@ResponseBody
	@RequestMapping(value = "/look_pw", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public String look2(HttpServletRequest request, HttpServletResponse response) {

		String id = request.getParameter("id");
		String email = request.getParameter("email");

		Service ss = sqlsession.getMapper(Service.class);
		MemberDTO result = ss.lookpw(id, email);

		JSONObject returnObj = new JSONObject();

		try {
			returnObj.put("name", result.getName());
			returnObj.put("pw", result.getPw());
		} catch (NullPointerException e) {

			returnObj.put("error", "해당 회원정보로 가입된 회원이 없습니다.");
		}

		return returnObj.toString();
	}
   
  
   
   //로그인한 상태를 저장
   @ResponseBody
   @RequestMapping(value = "/login_save", method = RequestMethod.POST)
   public String login2(HttpServletRequest request, HttpServletResponse response) {
      
      String id = request.getParameter("id");
      String pw = request.getParameter("pw");
      String bbti = request.getParameter("bbti").trim();
      
      Service ss = sqlsession.getMapper(Service.class);
      String logincount = ss.login_check(id,pw);
      String result = "";
      
      if(logincount==null) {result = "no";}
      else {
         HttpSession hs = request.getSession();
         hs.setAttribute("loginstate", true);
         hs.setAttribute("loginid", id);
         hs.setAttribute("pw", pw);
         hs.setAttribute("position", logincount);
         String name = ss.getname(id);
         hs.setAttribute("name",name);
         hs.setMaxInactiveInterval(3600);
         
         if(!bbti.equals("")) {
        	 ss.insertbbti(bbti, id);
        	 result = "yes";
         }
         else {result = "yes";}
      }
      
      return result;
   }
   

   //로그아웃 메소드
   @RequestMapping(value = "/logout")
   public String logout(HttpServletRequest request,HttpServletResponse response) throws IOException {
      HttpSession hs=request.getSession();
      
      hs.removeAttribute("loginstate");
      hs.setAttribute("loginstate", false);
      hs.removeAttribute("loginid");
      hs.removeAttribute("pw");
      hs.removeAttribute("position");
      
      response.setCharacterEncoding("UTF-8");
      response.setContentType("text/html; charset=UTF-8");
      PrintWriter out = response.getWriter();
      out.print("<script type='text/javascript'> alert('로그아웃 되었습니다.'); window.location.replace('main')");
      out.print("</script>");
      
      return null;
   }
   
   
   //마이페이지 창
   @RequestMapping(value = "/mypage")
   public String mypage_post(HttpServletRequest request, HttpServletResponse response, PageDTO dto, Model mo) throws IOException {
	   
		HttpSession hs = request.getSession();

		if (hs.getAttribute("loginstate") == null || hs.getAttribute("loginid") == null) {

			sessionExpired(response, "로그인이 필요한 기능입니다");

			return null;

		} else {

			String loginid = (String) request.getSession().getAttribute("loginid");

			Service ss = sqlsession.getMapper(Service.class);
			// 리뷰페이징처리
			String nowPage = request.getParameter("nowPage");
			String cntPerPage = request.getParameter("cntPerPage");

			int total1 = ss.my_review_total(loginid);

			if (nowPage == null && cntPerPage == null) {

				nowPage = "1";
				cntPerPage = "5";

			} else if (nowPage == null) {
				nowPage = "1";
			} else if (cntPerPage == null) {
				cntPerPage = "5";
			}

			dto = new PageDTO(total1, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			mo.addAttribute("paging", dto);
			mo.addAttribute("list1", ss.my_review(dto.getStart(), dto.getEnd(), loginid));

			// 문의 페이징 처리

			String nowPage2 = request.getParameter("nowPage2");
			String cntPerPage2 = request.getParameter("cntPerPage2");

			int total2 = ss.inquire_total(loginid);

			if (nowPage2 == null && cntPerPage2 == null) {

				nowPage2 = "1";
				cntPerPage2 = "5";

			} else if (nowPage2 == null) {
				nowPage2 = "1";
			} else if (cntPerPage2 == null) {
				cntPerPage2 = "5";
			}

			PageDTO i_dto = new PageDTO(total2, Integer.parseInt(nowPage2), Integer.parseInt(cntPerPage2));
			mo.addAttribute("paging_i", i_dto);
			mo.addAttribute("list2", ss.my_inquire(i_dto.getStart(), i_dto.getEnd(), loginid));

			MemberDTO result = ss.myinfo_main(loginid);

			int total3 = ss.bookmark_total(loginid);

			mo.addAttribute("info", result);
			mo.addAttribute("review", total1);
			mo.addAttribute("inquire", total2);
			mo.addAttribute("bookmark", total3);

			return "mypage";

		}
           
   }

   
   //마이페이지에서 회원 정보 수정 입력창
   @RequestMapping(value = "/info_modify")
   public String mypage_modi1(HttpServletRequest request, HttpServletResponse response, Model mo) throws IOException {
      
		HttpSession hs = request.getSession();

		if (hs.getAttribute("loginstate") == null || hs.getAttribute("loginid") == null) {

			sessionExpired(response, "로그인이 필요한 기능입니다");

			return null;

		} else {

			String loginid = (String) request.getSession().getAttribute("loginid");
			Service ss = sqlsession.getMapper(Service.class);
			MemberDTO myinfo = ss.myinfo_modify(loginid);
			mo.addAttribute("info", myinfo);

			return "info_modify";

		}
   }
   
   
   
   //마이페이지에서 회원정보 수정 저장
   @RequestMapping(value = "/infomodi_save" , method = RequestMethod.POST)
   public String mypage_modi2(HttpServletRequest request, HttpServletResponse response) throws IOException {
      
       String id = request.getParameter("id");
       String email = request.getParameter("email");
       String gender = request.getParameter("gender");
       String name = request.getParameter("name");
       String pw = request.getParameter("pw");
       String original_pw = request.getParameter("original_pw");
       
       if (id == null || email == null || gender == null || name == null || (pw != null && pw.isEmpty())) {
           SaveError(response);
           return null;
       }

       if (pw != null && !pw.equals(original_pw)) {
           // 비밀번호 변경시
           Service service = sqlsession.getMapper(Service.class);
           service.update_info(id, pw, email, gender, Integer.parseInt(request.getParameter("age")), name);
       } else {
           // 비밀번호 미변경시
           Service service = sqlsession.getMapper(Service.class);
           service.update_no_pw(email, gender, Integer.parseInt(request.getParameter("age")), name, id);
       }
     
       	return "main";
      
   }
   
   //비밀번호 변경 시 검증 메소드
   @ResponseBody
   @RequestMapping(value = "/checkPassword", method = RequestMethod.POST)
   public String checkPassword(HttpServletRequest request) {
	   
       String password = request.getParameter("password");
       String loginid = (String) request.getSession().getAttribute("loginid");
       Service service = sqlsession.getMapper(Service.class);
       String real_pw = service.verify_Password(loginid);
       String result=""; 
       
       if(real_pw.equals(password)) { 
           result = "yes";
          return result; 
       } else {
          result = "no";
           return result; 
       } 
   }
    
   
   
	// 탈퇴하기
   @RequestMapping(value = "/quit")
   public String my3(HttpServletRequest request, HttpServletResponse response) throws IOException {
         
	   	 HttpSession hs=request.getSession();
         String loginid = (String) request.getSession().getAttribute("loginid");
         Service service = sqlsession.getMapper(Service.class);
         service.quit_member(loginid);
         
         hs.removeAttribute("loginstate");
         hs.setAttribute("loginstate", false);
         hs.removeAttribute("loginid");
         hs.removeAttribute("pw");
         hs.removeAttribute("position");

      return "main";
		  
   }

   
   
   //마이페이지에서 내가 쓴 문의글을 확인
   @RequestMapping(value = "my_require")
   public String my_require(HttpServletRequest request, HttpServletResponse response, Model mo, PageDTO dto) throws IOException {
	   
	   HttpSession hs = request.getSession();
	   
		  if(hs.getAttribute("loginstate")==null||hs.getAttribute("loginid")==null) {
			  
			  sessionExpired(response,"로그인이 필요한 기능입니다");
			  
			  return null;
			  
		  } else {
	   
	   String loginid = (String) request.getSession().getAttribute("loginid");
	   
	   String nowPage=request.getParameter("nowPage");

	   String cntPerPage=request.getParameter("cntPerPage");

	   Service ss = sqlsession.getMapper(Service.class);
	   int my_require_total=ss.inquire_total(loginid);
			
	   if(nowPage==null && cntPerPage == null) {
	       
	  	 nowPage="1";
	                                                    
	  	 cntPerPage="5";
	   
	   }
	   else if(nowPage==null) {
	      nowPage="1";
	   }
	   else if(cntPerPage==null) {
	      cntPerPage="5";
	   }
		
	   dto=new PageDTO(my_require_total,Integer.parseInt(nowPage),Integer.parseInt(cntPerPage));
	   mo.addAttribute("paging",dto);
	   mo.addAttribute("list",ss.my_inquire(dto.getStart(), dto.getEnd(),loginid));
	   
	   ArrayList<InquireDTO2> list2=ss.inquire_best3();
	   mo.addAttribute("list2", list2);
      
	   return "my_require";
		  
		 }
		  
   }
   
   
   
   //마이페이지에서 내가 쓴 리뷰를 확인
   @RequestMapping(value = "my_review")
	public String my_review(HttpServletRequest request, HttpServletResponse response, PageDTO dto, Model mo) throws IOException {
		
	   
	   HttpSession hs = request.getSession();
	   
		  if(hs.getAttribute("loginstate")==null||hs.getAttribute("loginid")==null) {
			  
			  sessionExpired(response,"로그인이 필요한 기능입니다");
			 
			  return null;
			  
		  } else {
	   
	   String loginid = (String) request.getSession().getAttribute("loginid");
	   String nowPage=request.getParameter("nowPage");

       String cntPerPage=request.getParameter("cntPerPage");

		Service ss = sqlsession.getMapper(Service.class);
		int total=ss.my_review_total(loginid);
		
		
       if(nowPage==null && cntPerPage == null) {
           
      	 nowPage="1";
                                                            
        cntPerPage="5";
       
       }
       else if(nowPage==null) {
          nowPage="1";
       }
       else if(cntPerPage==null) {
          cntPerPage="5";
       }
		
       dto=new PageDTO(total,Integer.parseInt(nowPage),Integer.parseInt(cntPerPage));
       mo.addAttribute("paging",dto);
       mo.addAttribute("list",ss.my_review(dto.getStart(), dto.getEnd(),loginid));

		return "my_review";
		  }
	}
   
   
   
   //마이페이지에서 내 북마크를 확인
   @RequestMapping(value = "my_favorite")
   public String my_favorite(HttpServletRequest request, HttpServletResponse response, Model mo) throws IOException {
	   
	   	HttpSession hs = request.getSession();
	   
		  if(hs.getAttribute("loginstate")==null||hs.getAttribute("loginid")==null) {
			  
			  sessionExpired(response,"로그인이 필요한 기능입니다");
			 
			  return null;
			  
		  } else {
	   
			String loginid = (String) request.getSession().getAttribute("loginid");
			Service ss = sqlsession.getMapper(Service.class);
			ArrayList<AllBoardDTO> list = ss.my_favorite(loginid);
			mo.addAttribute("list", list);
			   
			return "my_favorite";
		  }
   }
   
   
   
   //bbti 파트
   //회원 가입 후 bbti 테스트로 이동하는 경우
   @RequestMapping(value = "/member_try_bbti")
   public String membertrybbti(HttpServletRequest request, Model mo) {
	   
	  String id = request.getParameter("id");
	  mo.addAttribute("id", id);
      
      return "member_try_bbti";
   }
   

   
   //bbti값 저장하기
   @ResponseBody
   @RequestMapping(value="/bbti_save", method = RequestMethod.POST)
   public String bbti1(HttpServletRequest request, HttpServletResponse response) throws IOException {
	   
	   String id = request.getParameter("id").trim();
	   String bbti = request.getParameter("bbti");
	   String result = null;
	   Service ss = sqlsession.getMapper(Service.class);
	   
	   int bc = ss.bbticheck(id);
		  
		  if(bc==0) {
			   ss.insertbbti(bbti,id);
			   result = "ok";
		  }
		  else{result = "already";}
	   
	   return result;
   }
   
   
   
   //bbti값 저장하기2
   @RequestMapping(value="/bbti_save2", method = RequestMethod.GET)
   public String bbti2(HttpServletRequest request, HttpServletResponse response) throws IOException {
	   
	   String id = request.getParameter("id").trim();
	   String bbti = request.getParameter("bbti");
	   
	   if (id == null || bbti == null) {
	        SaveError(response);
	        return null;
	    }
	   
	   Service ss = sqlsession.getMapper(Service.class);
	   
	   response.setCharacterEncoding("UTF-8");
	   response.setContentType("text/html; charset=UTF-8");
	   PrintWriter out = response.getWriter();
	   
		ss.insertbbti(bbti,id);
		out.print("<script type='text/javascript'>");	
		out.print("alert('bbti가 성공적으로 저장되었습니다!');");
		out.print("window.opener.location.href='./';");
		out.print("self.close();");
		out.print("</script>");
		out.flush();
	   
	   return "main";
   }
   
   
   
   //bbti 저장
   @RequestMapping(value = "/bbti_list_save")
   public String bbti5(HttpServletRequest request, HttpServletResponse response) throws IOException {
	   
	   String id = request.getParameter("id");
	   String bbti = request.getParameter("bbti");
	   
	   if (id == null || bbti == null) {
	        SaveError(response);
	        return null;
	    }
	   Service ss = sqlsession.getMapper(Service.class);
	   
	   try {
	   response.setCharacterEncoding("UTF-8");
	   response.setContentType("text/html; charset=UTF-8");
	   PrintWriter out = response.getWriter();
	   
		ss.insertbbti(bbti,id);
		out.print("<script type='text/javascript'>");	
		out.print("alert('bbti가 성공적으로 저장되었습니다!');");
		out.print("window.location.href='./';");
		out.print("</script>");
		out.flush();
	   } catch (Exception e) {
	     SaveError(response);
	   }
	   
		return null;
	
   }
  
   
   
	// 회원의 bbti 리스트
	@RequestMapping(value = "/bbti_list")
	public String bbti4(HttpServletRequest request, Model mo) {

		String id = request.getParameter("id");
		mo.addAttribute("id", id);

		return "bbti_list";
	}
   
   
   //bbti 정보를 갖고 회원가입을 할 경우
   @RequestMapping(value = "/join_with")
   public String bbti3(HttpServletRequest request, Model mo) {
	   
	   String bbti = request.getParameter("bbti");
	   mo.addAttribute("bbti",bbti);
	   
	   return "member_join";
   }
   
   
   
   //bbti 정보를 갖고 로그인 할 경우
   @RequestMapping(value = "/login_with")
   public String bbti2(HttpServletRequest request, Model mo) {
	   
	   String bbti = request.getParameter("bbti");
	   mo.addAttribute("bbti",bbti);
	   
	   return "login";
   }
   
    
   
   //마이페이지에서 bbti를 확인할 시 내 bbti 정보가 있는지 확인
   @ResponseBody
   @RequestMapping(value = "/have_bbti")
   public String my_bbti1(String id) {
	   
	   String result = null;
	   Service ss = sqlsession.getMapper(Service.class);
	   
	   String bbti = ss.havebbti(id);
	   
	   if(bbti==null||bbti.trim().equals("")||bbti.equals("null")) {result = "nope";}
	   else {result = bbti;}
	   
	   return result;
   }
   
   
   
   //내 bbti 검사 결과를 확인
   @RequestMapping(value = "/my_bbti")
   public String my_bbti2(HttpServletRequest request, Model mo) {
	   
	   String id = request.getParameter("id");
	   String bbti = request.getParameter("bbti");
	   
	   mo.addAttribute("id",id);
	   mo.addAttribute("bbti",bbti);
	   
	   return "my_bbti";
   }
   
   //메인화면 거리순 추천
   	@ResponseBody
	@RequestMapping(value = "/distance_view", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	public String distance_view(HttpServletRequest request) {
   		double myLatitude = Double.parseDouble(request.getParameter("myLatitude"));
   		double myLongitude = Double.parseDouble(request.getParameter("myLongitude"));
   		System.out.println("위도"+myLatitude+", 경도"+myLongitude);
		Service ss = sqlsession.getMapper(Service.class);
		BadaSuggestDTO bdto = ss.getDistance(myLatitude,myLongitude);
        // ObjectMapper를 사용하여 DTO 객체를 JSON으로 변환하여 반환
		System.out.println("도출된 해수욕장의 dto위도"+bdto.getLatitude()+", dto경도"+bdto.getLongitude());
	    ObjectMapper mapper = new ObjectMapper();
	    String jsonList = "";
	    try {
	        jsonList = mapper.writeValueAsString(bdto);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return jsonList;
	}
   

   // null값의 입력에 대비한 예외처리 메소드
	private void showAlertAndRedirect(HttpServletResponse response, String message) throws IOException {
	    response.setContentType("text/html;charset=UTF-8");
	    PrintWriter out = response.getWriter();
	    out.println("<script>alert('" + message + "'); history.back();</script>");
	    out.flush();
	}
   
	private void sessionExpired(HttpServletResponse response, String message) throws IOException {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print("<script type='text/javascript'> alert('"+message+"'); window.location.replace('login');");
		out.print("</script>");
	}
	
	private void SaveError(HttpServletResponse response) throws IOException {
	    response.setCharacterEncoding("UTF-8");
	    response.setContentType("text/html; charset=UTF-8");
	    PrintWriter out = response.getWriter();
	    out.print("<script type='text/javascript'>");  
	    out.print("alert('오류로 인해 저장이 어렵습니다. 다시 시도해주세요.');");
	    out.print("history.back();");
	    out.print("</script>");
	    out.flush();
	}

}