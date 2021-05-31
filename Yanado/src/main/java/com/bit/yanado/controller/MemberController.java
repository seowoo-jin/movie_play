package com.bit.yanado.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.yanado.model.dto.meminfo;

@Controller
@RequestMapping(value="member/")
public class MemberController {

	
	@RequestMapping(value="mypage")
	public String mypage(Model model, HttpSession session) {
		meminfo member = (meminfo) session.getAttribute("member");
		if(member != null) {
			System.out.println(member.getIsPay());
			model.addAttribute("isLogin","Y");
		}else {
			model.addAttribute("isLogin","N");
		}
		return "member/mypage";
	}
	
	@RequestMapping(value="bookmark")
	public String bookmark() {
		return "member/bookmark";
	}
	
	@RequestMapping(value="reco")
	public String reco() {
		return "member/reco";
	}
	
	@RequestMapping(value="qna/board")
	public String qanBoard() {
		
		return "member/qna/board";
	}
	
	@RequestMapping(value="qna/write")
	public String qnaWrite() {
		
		return "member/qna/write";
	}
	
	@RequestMapping(value="qna/myqna")
	public String qnaMyqna() {
		
		return "member/qna/myqna";
	}
	
	@RequestMapping(value="modify")
	public String modify() {
		
		return "member/modify";
	}
}
