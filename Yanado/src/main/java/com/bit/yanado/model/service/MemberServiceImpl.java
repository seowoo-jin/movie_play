package com.bit.yanado.model.service;


import java.util.List;

import javax.inject.Inject;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.yanado.model.dao.AdminMapper;
import com.bit.yanado.model.dao.MemberMapper;
import com.bit.yanado.model.dao.VideoMapper;
import com.bit.yanado.model.dto.BookMark;
import com.bit.yanado.model.dto.MemInfo;
import com.bit.yanado.model.dto.Qna;


@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	public MemberMapper memberMapper;
	
	@Autowired
	public VideoMapper videoMapper;
	
	
	@Override
	public MemInfo login(String id, String pw) {
		// TODO Auto-generated method stub
		return memberMapper.login(id, pw);
	}

	@Override
	public void join(MemInfo newMember) {
		// TODO Auto-generated method stub
		memberMapper.join(newMember);
	}

	@Override
	public String findId(String email) {
		// TODO Auto-generated method stub
		return memberMapper.findId(email);
	}

	@Override
	public void findPw(String id, String pw) {
		// TODO Auto-generated method stub
		memberMapper.findPw(id, pw);
	}

	@Override
	public String checkId(String id) {
		// TODO Auto-generated method stub
		return memberMapper.checkId(id);
	}

	@Override
	public void updateMember(MemInfo Member) {
		// TODO Auto-generated method stub
		memberMapper.updateMember(Member);
	}

	@Override
	public void writeQuestion(Qna qna) {
		// TODO Auto-generated method stub
		memberMapper.writeQuestion(qna);
	}

	@Override
	public List<Qna> getAllQna() {
		// TODO Auto-generated method stub
		return memberMapper.getAllQna();
	}

	@Override
	public Qna getQna(int qnaSeq) {
		// TODO Auto-generated method stub
		return memberMapper.getQna(qnaSeq);
	}

	@Override
	public void updateQna(Qna qna) {
		// TODO Auto-generated method stub
		memberMapper.updateQna(qna);
	}

	@Override
	public void deleteQna(int qnaSeq) {
		// TODO Auto-generated method stub
		memberMapper.deleteQna(qnaSeq);
	}

	@Override
	public List<Qna> getQnaById(String id) {
		// TODO Auto-generated method stub
		return memberMapper.getQnaById(id);
	}

	@Override
	public void deleteMember(String id) {
		// TODO Auto-generated method stub
		memberMapper.deleteBookmarkById(id);
		memberMapper.deleteQnaById(id);
		memberMapper.deleteWatchingRecoById(id);
		memberMapper.deleteMember(id);
	}

	@Override
	public List<BookMark> getAllBookmarks(String id) {
		// TODO Auto-generated method stub
		List<BookMark> allBookMarks = memberMapper.getAllBookmarks(id);
		allBookMarks.get(0).getUniqueNo();
		int uniqueNo;
		for(int i=0; i<allBookMarks.size();i++) {
			uniqueNo = allBookMarks.get(i).getUniqueNo();	// 시청기록의 고유번호를 가져온다.
			allBookMarks.get(i).setTitle(videoMapper.getTitleByTitleSeq(uniqueNo/10000));				// 고유번호 중앞 5자리(영상제목)을 가져온다.
			allBookMarks.get(i).setSeason(((uniqueNo%10000)/100));
			allBookMarks.get(i).setEpisode(uniqueNo%100);
		}
		return allBookMarks;
	}

	@Override
	public void updateLoginDate(String id) {
		// TODO Auto-generated method stub
		memberMapper.updateLoginDate(id);
	}
	

}
