package com.bit.yanado.controller;

import java.io.IOException;



import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bit.yanado.model.dao.MemberMapper;
import com.bit.yanado.model.dto.EmailDTO;
import com.bit.yanado.model.dto.Poster;
import com.bit.yanado.model.dto.Teaser;
import com.bit.yanado.model.dto.AdminInfo;
import com.bit.yanado.model.dto.MemInfo;
import com.bit.yanado.model.service.AdminService;
import com.bit.yanado.model.service.EmailService;
import com.bit.yanado.model.service.MemberService;
import com.bit.yanado.model.service.VideoService;
import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;

@Controller
@RequestMapping(value="/")
public class MainController {

	@Autowired
	public MemberService memberService;
	
	@Autowired
    private EmailService mailSender;
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private VideoService videoService;
	
	@RequestMapping(value="/")
	public String main(HttpSession session,Model model) {
		MemInfo member = (MemInfo) session.getAttribute("member");
		AdminInfo admin = (AdminInfo) session.getAttribute("admin");
		
		if(member != null || admin!= null ) {
			
			List<Poster> posters = videoService.getPost();
			List<String> videoSeason = new ArrayList<String>();
			String tempSeason;
			for(int i=0;i<posters.size();i++) {
				tempSeason = posters.get(i).getTitleSeq()+String.format("%02d", posters.get(i).getSeason());
				videoSeason.add(tempSeason); 
			}
			model.addAttribute("vidSeason",videoSeason);
			model.addAttribute("posters", posters);
			List<Teaser> teaserVids = videoService.getTeaserVid();
			Teaser teaserVid = teaserVids.get(0);
			model.addAttribute("teaserVid", teaserVid);
			if(member != null) {
				model.addAttribute("isLogin","Y");
				return (member.getIsPay().equals("Y"))?(member.getIsOut()==1?"redirect:login":"main"):"redirect:pay";
			}
			if(admin != null) {
				model.addAttribute("isLogin","A");
			}
		}else {
			model.addAttribute("isLogin","N");
		}
		return "main";
	}
	
	@ResponseBody
	@RequestMapping(value="getEpisode", method=RequestMethod.POST)
	public List<String> getEpisode(Model model, String titleSeason) {
		System.out.println(videoService.getEpisode(titleSeason));
		return videoService.getEpisode(titleSeason);
	}
	
	
	// 로그인  --------------------------------------------------------------------
	@RequestMapping(value="login")
	public String login() {
		return "login";
	}
	
	@SuppressWarnings("unused")
	@RequestMapping(value="CheckLogin", method=RequestMethod.POST)
	public String CheckLogin(MemInfo newMember, Model model, HttpSession session) {
		MemInfo member = (MemInfo) memberService.login(newMember.getId(), newMember.getPw());
		AdminInfo admin = adminService.login(newMember.getId(),newMember.getPw());
		if(admin != null) {
			session.setAttribute("admin", admin);
			model.addAttribute("admin",admin);
			return "redirect:/";
		}else {
			if(member != null ) {
				session.setAttribute("member", member);
				return member.getIsPay().equals("Y")?"redirect:/":"redirect:pay";
			}else {
				model.addAttribute("message","Check your ID or Password.");
				return "login";
			}
		}
	}
	
	@RequestMapping(value="logout", method=RequestMethod.POST)
	public String logout(HttpSession session) {
		System.out.println("logout");
		System.out.println(session.getAttribute("member"));
		session.removeAttribute("member");
		session.removeAttribute("admin");
		return "redirect:/";
	}
	
	
	// 회원가입 --------------------------------------------------------------------
	@RequestMapping(value="joinForm")
	public String joinForm() {
		return "join";
	}
	
	@ResponseBody
	@RequestMapping(value="checkId")
	public String checkId(String id) {
		return memberService.checkId(id);
	}
	
	@RequestMapping(value="join", method=RequestMethod.POST)
	public String join( Model model, MemInfo newMember) {
		memberService.join(newMember);
		return "redirect:pay";
	}
	
	@ResponseBody
	@RequestMapping(value="checkPhone")
	public String checkPhone(String phoneNum) {
		// id : swjin0203@gmail.com pw:qlalfqjsghspwkfl(비밀번호네자리) 
		// sid : ACd61c341ed4e22090247d3577a1ca91e3
		// tocken : 03848ab1a1bb7d1dc7cc60d7b79f098f
		//휴대폰 인증번호 생성 
		
		int authNum = (int) ((Math.random() * (999999 - 100000 + 1)) + 100000);
		    //전송 메시지 
		String authMsg = "The authentication number is [" + authNum + "]" ;
		Twilio.init("ACd61c341ed4e22090247d3577a1ca91e3", "03848ab1a1bb7d1dc7cc60d7b79f098f");
		
		phoneNum = "+82" + phoneNum.substring(1, phoneNum.length());
		System.out.println(phoneNum);
//		Message message = Message
//		        .creator(new PhoneNumber(phoneNum), // to
//		                new PhoneNumber("+12542790923"), // from (가입하고발급받은 번호) 
//		                authMsg) //보낼 내용 
//		        .create();
		
//		System.out.println(message.getSid());
		return Integer.toString(authNum);
	}
	// 결제 ------------------------------------------------------------------------------------
	@RequestMapping(value="pay")
	public String pay(HttpSession session) {
		return "pay";
	}
	
	@RequestMapping(value="successPay")
	public String successPay(HttpSession session) {
		MemInfo member = (MemInfo) session.getAttribute("member");
		System.out.println(member);
		if(member!=null) {
			member.setIsPay("Y");
			memberService.updateMember(member);
		}
		return "redirect:/";
	}
	
	
	// 아이디 비밀번호 찾기  -----------------------------------------------------------------------
	@RequestMapping(value="find")
	public String find() {
		return "find";
	}
	
	@ResponseBody
	@RequestMapping(value="findId")
	public String findId(@RequestParam Map<String, Object> param, EmailDTO dto) {
		String email = (String) param.get("email");
		String id = memberService.findId(email);
		// mail 보내기
		if(id != null) {
			try {
	        	// dto로 저장
		        dto.setReceiveMail(email);
		        dto.setSubject("[Yanado] 귀하의 아이디를 보내드립니다.");
		        dto.setMessage("Your ID is "+ id + ". Don't forget it.");
		        dto.setSenderName("Yanado Admin");
		        dto.setSenderMail("ibjin1010@gmail.com");
	            mailSender.sendMail(dto);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
			return "Your ID has been sended to your E-mail!";
		}else {
			return "Wrong E-mail Adress, Check it again!";
		}
	}
	
	@ResponseBody
	@RequestMapping(value="findPw")
	public String findPw(String email, String id, EmailDTO dto) {
		//이메일로 아이디 확인
		String checkId = memberService.findId(email);
		// 이메일로 확인한 아이디와 입력된 아이디가 같으면 실행
		if(id.equals(checkId)) {
			String pw = "";
			for(int i = 0; i < 6; i++) {
			    double dValue = Math.random();
			    char cValue = (char)((dValue * 26) + 65);   // 대문자
			    pw = pw + cValue;
			}
			memberService.findPw(id, pw);
			// mail 보내기
			try {
	        	// dto로 저장
		        dto.setReceiveMail(email);
		        dto.setSubject("[Yanado] 귀하의 변경된 비밀번를 보내드립니다.");
		        dto.setMessage("Your Temporary Password is "+pw + ". Don't forget it.");
		        dto.setSenderName("Yanado Admin");
		        dto.setSenderMail("ibjin1010@gmail.com");
	            mailSender.sendMail(dto);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
			return "Your Temporary Password has been sended to your E-mail!";
		}else {
			return "Wrong E-mail Adress or ID, Check it again!";
		}
	}
	
	

	
	
	
}
