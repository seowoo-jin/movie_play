package com.bit.yanado.model.service;

import com.bit.yanado.model.dto.admininfo;

public interface AdminService {
	public admininfo login(String id, String pw);
}
