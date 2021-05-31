package com.bit.yanado.model.dao;

import org.apache.ibatis.annotations.Param;

import com.bit.yanado.model.dto.admininfo;

public interface AdminMapper {
	
	public admininfo login(@Param("id") String id,@Param("pw") String pw);
	
}
