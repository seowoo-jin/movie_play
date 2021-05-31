package com.bit.yanado.model.service;


import javax.inject.Inject;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.yanado.model.dao.AdminMapper;
import com.bit.yanado.model.dao.MemberMapper;
import com.bit.yanado.model.dto.meminfo;


@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	public MemberMapper memberMapper;
	
	@Override
	public meminfo login(String id, String pw) {
		// TODO Auto-generated method stub
		return memberMapper.login(id, pw);
	}

	@Override
	public void join(meminfo newMember) {
		// TODO Auto-generated method stub
		memberMapper.join(newMember);
	}

	@Override
	public String findId(String email) {
		// TODO Auto-generated method stub
		return memberMapper.findId(email);
	}

	@Override
	public int findPw(String id, String pw) {
		// TODO Auto-generated method stub
		memberMapper.findPw(id, pw);
		return 1;
	}

	@Override
	public String checkId(String id) {
		// TODO Auto-generated method stub
		return memberMapper.checkId(id);
	}

	@Override
	public void updateMember(meminfo Member) {
		// TODO Auto-generated method stub
		memberMapper.updateMember(Member);
	}
	

}
