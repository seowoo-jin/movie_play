package com.bit.yanado.model.service;

import org.springframework.stereotype.Service;

import com.bit.yanado.model.dto.meminfo;


public interface MemberService {

	public meminfo login(String id, String pw);
	public void join(meminfo newMember);
	public String findId(String email);
	public int findPw(String id, String pw);
	public String checkId(String id);
	
	
}
