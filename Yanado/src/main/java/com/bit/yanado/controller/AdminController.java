package com.bit.yanado.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="admin/")
public class AdminController {

	
	@RequestMapping(value="video/stat")
	public String stat() {
		
		return "admin/video/stat";
	}
	
	@RequestMapping(value="video/write")
	public String write() {
		
		return "admin/video/write";
	}
	
	@RequestMapping(value="video/board")
	public String board() {
		
		return "admin/video/board";
	}
	
	@RequestMapping(value="video/read")
	public String read() {
		
		return "admin/video/read";
	}
	
	@RequestMapping(value="video/teaser")
	public String teaser() {
		
		return "admin/video/teaser";
	}
	
	@RequestMapping(value="member")
	public String member() {
		
		return "admin/member";
	}
	
	@RequestMapping(value="qna")
	public String qna() {
		
		return "admin/qna";
	}
}
