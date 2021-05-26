package com.bit.yanado.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import com.bit.yanado.model.dto.meminfo;

public interface MemberMapper {
	
	public meminfo login(@Param("id") String id,@Param("pw") String pw);
	public void join(meminfo newMember);
	public String findId(String email);
	public void findPw(@Param("id") String id,@Param("pw") String pw);
	public String checkId(String id);
}
