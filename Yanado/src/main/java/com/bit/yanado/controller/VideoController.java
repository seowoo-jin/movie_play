package com.bit.yanado.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.yanado.model.dto.AdminInfo;
import com.bit.yanado.model.dto.BookMark;
import com.bit.yanado.model.dto.MemInfo;
import com.bit.yanado.model.dto.VideoInfo;
import com.bit.yanado.model.dto.WatchingReco;
import com.bit.yanado.model.service.VideoService;

@Controller
@RequestMapping(value="video/")
public class VideoController {
	
	@Autowired
	VideoService videoService;
	
	// 재생화면 메소드. 여러가지 맴버 정보를 보내준다.
	@RequestMapping(value="play")
	public String play(@Param("trackId") int trackId,
			@RequestParam(value="bookmarkTime", defaultValue="") String bookmarkTime , Model model, HttpSession session) {
		MemInfo member = (MemInfo) session.getAttribute("member");
		AdminInfo admin = (AdminInfo) session.getAttribute("admin");
		
		if(member != null || admin!= null) {
			VideoInfo newVid = videoService.getVideo(trackId);
			model.addAttribute("newVid",newVid);
			if(member != null) {
				WatchingReco isRecord = videoService.getRecord(member.getId(), trackId);
				String Record = (bookmarkTime.isEmpty())?((isRecord != null)?isRecord.getRecentPo():""):bookmarkTime;
				model.addAttribute("record", Record);
				System.out.println(Record);
				// get Bookmarks
				List<BookMark> bookmarks = videoService.getBookmarks(member.getId(), trackId);
				String defaultSubtitle = member.getDefaultCap();
				System.out.println(defaultSubtitle);
				model.addAttribute("defaultSubtitle", defaultSubtitle);
				model.addAttribute("bookmarks",bookmarks);
				
			}
			return "video/play";
		}
		return "redirect:/";
	}
	
	// 메인으로 돌아가는 메소드 - 시청기록을 저장해준다.
	@RequestMapping(value="backToMain")
	public String backToMain(@Param("trackId") int trackId, @Param("record") String record, HttpSession session) {
		AdminInfo admin = (AdminInfo) session.getAttribute("admin");
		MemInfo member = (MemInfo) session.getAttribute("member");
		if(member != null) {
			WatchingReco isRecord = videoService.getRecord(member.getId(), trackId);
			System.out.println(isRecord);
			if (isRecord != null) {
				int seq = isRecord.getHistorySeq();
				videoService.modRecord(String.valueOf(seq), record);
			}else {
				videoService.setRecord(member.getId(), trackId, record);
			}
		}
		return "redirect:/";
	}
	
	// 북마크 생성 메소드.
	@ResponseBody
	@RequestMapping(value="setBookmark")
	public String setBookmark(@Param("trackId") int trackId, @Param("startTime") String startTime,
			@Param("subtitle") String subtitle, HttpSession session) {
		MemInfo member = (MemInfo) session.getAttribute("member");
		BookMark newBookmark = new BookMark(0, member.getId(), trackId, startTime, subtitle);
		videoService.setBookmark(newBookmark);
		
		
		
		return "success";
	}
	
	// 북마크 삭제 메소드.
	@ResponseBody
	@RequestMapping(value="deleteBookmark")
	public String deleteBookmark(@Param("trackId") int trackId, @Param("startTime") String startTime, HttpSession session) {
		MemInfo member = (MemInfo) session.getAttribute("member");
		BookMark newBookmark = new BookMark(0, member.getId(), trackId, startTime, "");
		videoService.deleteBookmark(newBookmark);
		return "success";
	}
	
	
	// 기본 자막을 설정해주는 메소드.
		@ResponseBody
		@RequestMapping(value="setDefaultCaption")
		public String setDefaultCaption(@Param("caption") String caption, HttpSession session) {
			MemInfo member = (MemInfo) session.getAttribute("member");
			member.setDefaultCap(caption);
			System.out.println(caption);
			videoService.setDefaultCap(caption, member.getId());
			
			return "success";
		}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
