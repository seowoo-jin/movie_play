package com.bit.yanado.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="member/")
public class MemberController {

	
	@RequestMapping(value="mypage")
	public String mypage() {
		
		return "member/mypage";
	}
	
	@RequestMapping(value="bookmark")
	public String bookmark() {
		
		return "member/bookmark";
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
