package com.bit.yanado.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.yanado.model.dto.AdminInfo;
import com.bit.yanado.model.dto.BookMark;
import com.bit.yanado.model.dto.MemInfo;
import com.bit.yanado.model.dto.Poster;
import com.bit.yanado.model.dto.Qna;
import com.bit.yanado.model.dto.VideoInfo;
import com.bit.yanado.model.dto.WatchingReco;
import com.bit.yanado.model.service.MemberService;
import com.bit.yanado.model.service.VideoService;

@Controller
@RequestMapping(value="member/")
public class MemberController {

	@Autowired
	VideoService videoService;
	
	@Autowired
	MemberService memberService;
	
	
	// 마이 페이지 불러오기 ------------------------------------------------------------
	@RequestMapping(value="mypage")
	public String mypage(Model model, HttpSession session) {
		MemInfo member = (MemInfo) session.getAttribute("member");
		AdminInfo admin = (AdminInfo) session.getAttribute("admin");
		if(member != null) {
			model.addAttribute("isLogin","Y");
			return "member/mypage";
		}else if(admin != null){
			model.addAttribute("isLogin","A");
			return "member/mypage";
		}else {
			model.addAttribute("isLogin","N");
			return "redirect:/";
		}
	}
	// 북마크  ------------------------------------------------------------
	@RequestMapping(value="bookmark")
	public String bookmark(Model model, HttpSession session) {
		MemInfo member = (MemInfo) session.getAttribute("member");
		
		List<BookMark> allBookmarks = memberService.getAllBookmarks(member.getId());
		model.addAttribute("allBookmarks",allBookmarks);
		
		return "member/bookmark";
	}
	
	// 시청 기록  ------------------------------------------------------------
	@RequestMapping(value="reco")
	public String reco(Model model, HttpSession session) {
		MemInfo member = (MemInfo) session.getAttribute("member");   // session에서 로그인된 맴버를 가져온다.
		
		List<WatchingReco> recoding = videoService.getAllRecord(member.getId());	//맴버 아이디로 시청기록을 가져온다.
		List<Poster> poster = new ArrayList<Poster>();		// 시청기록에 맞는 포스터를 가져올 리스트를 만든다.
		List<VideoInfo> videoInfo= new ArrayList<VideoInfo>();
		for (int i=0;i<recoding.size();i++){				// 시청기록 만큼 포스터 가져오는걸 반복한다.
			int uniqueNo = recoding.get(i).getUniqueNo();	// 시청기록의 고유번호를 가져온다.
			int titleSeq = uniqueNo/10000;					// 고유번호 중앞 5자리(영상제목)을 가져온다.
			poster.add(videoService.getPostByTitleSeason(titleSeq, (uniqueNo%10000)/100));	// 가져온 포스터를 리스트에 넣는다.
			videoInfo.add(videoService.getVideo(uniqueNo));
		}
		model.addAttribute("videoInfo", videoInfo);
		model.addAttribute("posters",poster);				// 모델로 포스터를 보내준다.
		model.addAttribute("allRecord",recoding);			// 모델로 시청기록을 보내준다.
		System.out.println(poster);
		return "member/reco";
	}
	
	// Q&A 게시판 글보기  ------------------------------------------------------------
	@RequestMapping(value="qna/board")
	public String qanBoard(Model model, HttpSession session) {
		List<Qna> allQna = memberService.getAllQna();
		MemInfo member = (MemInfo) session.getAttribute("member");
		model.addAttribute("member",member);
		model.addAttribute("allQna",allQna);
		System.out.println(allQna);
		return "member/qna/board";
	}
	
	// Q&A 글쓰기  -------------------------------------------------------------------------
	@RequestMapping(value="qna/write")
	public String qnaWrite() {
		return "member/qna/write";
	}
	
	@RequestMapping(value="qna/writequestion", produces="text/plain;charset=UTF-8")
	public String writequestion(Qna qna, HttpSession session) {
		MemInfo member = (MemInfo) session.getAttribute("member");
		qna.setId(member.getId());
		memberService.writeQuestion(qna);
		return "redirect:/member/mypage";
	}
	// Q&A 내글 보기   -------------------------------------------------------------------------
	@RequestMapping(value="qna/myqna")
	public String qnaMyqna(HttpSession session, Model model) {
		MemInfo member = (MemInfo) session.getAttribute("member");
		List<Qna> qnaById = memberService.getQnaById(member.getId());
		model.addAttribute("qnaById",qnaById);
		return "member/qna/myqna";
	}
	
	// Q&A 글 수정하기   -------------------------------------------------------------------------
	@RequestMapping(value="qna/selectQna")
	public String selectQna(int qnaSeq,Model model) {
		Qna qna = memberService.getQna(qnaSeq);
		model.addAttribute("qna",qna);
		return "member/qna/write";
	}
	@RequestMapping(value="qna/modifyQna")
	public String modifyQna(Qna qna){
		memberService.updateQna(qna);
		
		return "redirect:/member/mypage";
	}
	// Q&A 글 삭제  -------------------------------------------------------------------------
	@RequestMapping(value="qna/deleteQna")
	public String deleteQna(int qnaSeq){
		memberService.deleteQna(qnaSeq);
		return "redirect:/member/qna/board";
	}
	
	
	// 개인정보 수정  ---------------------------------------------------------------------
	@RequestMapping(value="modify")
	public String modify(HttpSession session, Model model) {
		MemInfo member = (MemInfo) session.getAttribute("member");
		model.addAttribute("member",member);
		return "member/modify";
	}
	
	@RequestMapping(value="edit")
	public String edit(MemInfo member) {
		memberService.updateMember(member);
		return "redirect:/";
	}
	
	@RequestMapping(value="delete")
	public String delete(MemInfo member, HttpSession session) {
		memberService.deleteMember(member.getId());
		session.removeAttribute("member");
		return "redirect:/";
	}
	
	
	
	
	
	
	
	
}
