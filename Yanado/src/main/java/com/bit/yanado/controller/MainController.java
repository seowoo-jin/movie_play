package com.bit.yanado.controller;

import java.io.IOException;

import java.io.PrintWriter;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.yanado.model.dao.MemberMapper;
import com.bit.yanado.model.dto.EmailDTO;
import com.bit.yanado.model.dto.meminfo;
import com.bit.yanado.model.service.EmailService;
import com.bit.yanado.model.service.MemberService;

@Controller
@RequestMapping(value="/")
public class MainController {

	
	
	
	@Autowired
	public MemberService memberService;
	
	@Autowired
    private EmailService mailSender;
	
	@RequestMapping(value="/")
	public String main() {
		return "main";
	}
	
	@RequestMapping(value="login")
	public String login() {
		return "login";
	}
	
	@RequestMapping(value="CheckLogin", method=RequestMethod.POST)
	public String CheckLogin(meminfo newMember, Model model) {
		
		meminfo member = (meminfo) memberService.login(newMember.getId(), newMember.getPw());
		System.out.println(member);
		return "redirect:login";
	}
	
	
	@RequestMapping(value="joinFrom")
	public String joinFrom() {
		
		
		return "join";
	}
	
	@RequestMapping(value="join", method=RequestMethod.POST)
	public String join( Model model, meminfo newMember) {
		
		memberService.join(newMember);
		
		return "main";
	}
	
	
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
		System.out.println(email);
		System.out.println(id);
		//이메일로 아이디 확인
		String checkId = memberService.findId(email);
		System.out.println(checkId);
		// 이메일로 확인한 아이디와 입력된 아이디가 같으면 실행
		if(id.equals(checkId)) {
			String pw = "";
			
			for(int i = 0; i < 6; i++) {
			    double dValue = Math.random();
			    char cValue = (char)((dValue * 26) + 65);   // 대문자
			    pw = pw + cValue;
			}
			
		System.out.println("a");
			int isChanging = memberService.findPw(id, pw);
			System.out.println(isChanging);
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
	
	
	
	@RequestMapping(value="video/play")
	public String videoPlay() {
		
		return "video/play";
	}
	
	@RequestMapping(value="video/search")
	public String videoSearch() {
		
		return "video/search";
	}
	
	
	
}
