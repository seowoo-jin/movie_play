package com.bit.yanado.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import com.bit.yanado.model.dto.BookMark;
import com.bit.yanado.model.dto.MemInfo;
import com.bit.yanado.model.dto.Qna;

public interface MemberMapper {
	
	public MemInfo login(@Param("id") String id,@Param("pw") String pw);
	public void join(MemInfo newMember);
	public String findId(String email);
	public void findPw(@Param("id") String id,@Param("pw") String pw);
	public String checkId(String id);
	public void updateMember(MemInfo Member);
	public void writeQuestion(Qna qna);
	public List<Qna> getAllQna();
	public Qna getQna(int qnaSeq);
	public void updateQna(Qna qna);
	public void deleteQna(int qnaSeq);
	public List<Qna> getQnaById(String id);
	public void deleteMember(@Param("id") String id);
	public List<BookMark> getAllBookmarks(@Param("id") String id);
	public void updateLoginDate(@Param("id") String id);
	public void deleteQnaById(@Param("id") String id);
	public void deleteBookmarkById(@Param("id") String id);
	public void deleteWatchingRecoById(@Param("id") String id);
	//kakaologin
	public MemInfo member_kakao(String id);
	//kakao 저장
	public void kakao_join(MemInfo member);
}
