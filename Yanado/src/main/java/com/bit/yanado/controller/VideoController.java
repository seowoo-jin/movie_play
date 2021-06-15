package com.bit.yanado.controller;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bit.yanado.model.dto.AdminInfo;
import com.bit.yanado.model.dto.MemInfo;
import com.bit.yanado.model.dto.VideoInfo;
import com.bit.yanado.model.dto.WatchingReco;
import com.bit.yanado.model.service.VideoService;

@Controller
@RequestMapping(value="video/")
public class VideoController {
	
	@Autowired
	VideoService videoService;
	
	
	@RequestMapping(value="play")
	public String play(int trackId, Model model, HttpSession session) {
		MemInfo member = (MemInfo) session.getAttribute("member");
		AdminInfo admin = (AdminInfo) session.getAttribute("admin");
		
		if(member != null || admin!= null) {
			VideoInfo newVid = videoService.getVideo(trackId);
			model.addAttribute("newVid",newVid);
			if(member != null) {
				WatchingReco isRecord = videoService.getRecord(member.getId(), trackId);
				if (isRecord != null)
					model.addAttribute("record", isRecord);
			}
			return "video/play";
		}
		
		
		return "redirect:/";
	}
	
	
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
	
	
}
