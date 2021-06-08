package com.bit.yanado.model.service;

import java.util.List;

import org.springframework.stereotype.Service;


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
	
	
}
