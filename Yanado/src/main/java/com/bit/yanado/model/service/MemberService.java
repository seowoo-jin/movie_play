package com.bit.yanado.model.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;

import com.bit.yanado.model.dto.BookMark;
import com.bit.yanado.model.dto.MemInfo;
import com.bit.yanado.model.dto.Qna;


public interface MemberService {

	public MemInfo login(String id, String pw);
	public void join(MemInfo newMember);
	public String findId(String email);
	public void findPw(String id, String pw);
	public String checkId(String id);
	public void updateMember(MemInfo Member);
	public void writeQuestion(Qna qna);
	public List<Qna> getAllQna();
	public Qna getQna(int qnaSeq);
	public void updateQna(Qna qna);
	public void deleteQna(int qnaSeq);
	public List<Qna> getQnaById(String id);
	public void deleteMember(String id);
	public List<BookMark> getAllBookmarks(String id);
	public void updateLoginDate(String id);

	//kakao login 관련 service
			//kakao login access token 가지고 오기
			public String getAccessToken (String authorize_code);
			//kakao login userinfo 가지고 오기
			public HashMap<String, Object> getUserInfo (String access_Token);
			//kakao login member information 조회
			public MemInfo member_kakao(String id);
			// kakao 저장
			public void kakao_join(MemInfo member);
			//kakao logout 
			public void kakaoLogout(String access_Token);
			
	
}
