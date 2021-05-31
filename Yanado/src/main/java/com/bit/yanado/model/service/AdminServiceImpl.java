package com.bit.yanado.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.yanado.model.dao.AdminMapper;
import com.bit.yanado.model.dto.admininfo;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	public AdminMapper adminMapper;
	
	@Override
	public admininfo login(String id, String pw) {
		// TODO Auto-generated method stub
		return adminMapper.login(id, pw);
	}

}
