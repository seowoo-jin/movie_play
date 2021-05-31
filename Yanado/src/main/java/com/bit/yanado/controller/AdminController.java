package com.bit.yanado.controller;

import java.io.File;

import javax.swing.JFileChooser;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.yanado.model.dto.videoinfo;
import com.bit.yanado.model.service.AwsS3;

@Controller
@RequestMapping(value="admin/")
public class AdminController {
	
	@Autowired
	AwsS3 awsS3;
	

	@RequestMapping(value="stat")
	public String stat() {
		
		return "admin/stat";
	}
	
	@RequestMapping(value="adminpage")
	public String adminpage() {
		
		return "admin/adminpage";
	}
	
	
	// video Upload------------------------------------------------------------------
	@RequestMapping(value="video/write")
	public String write() {
		
		return "admin/video/write";
	}
	
	@ResponseBody
	@RequestMapping(value="filePath")
	public String filePath() {
		
		
		 JFileChooser jfc = new JFileChooser();
		 jfc.showDialog(jfc, null);
		 jfc.showOpenDialog(null);
	            File file = jfc.getSelectedFile();
	            System.out.println(file.getAbsolutePath());
	            
		return file.getAbsolutePath();
	}
	
	@RequestMapping(value="videoUpload", method=RequestMethod.GET)
	public String videoUpload(videoinfo videoinfo,@Param("posterLink") String posterLink) {
		
		System.out.println(posterLink);
		File poster = new File(posterLink);
		awsS3.upload(poster, "poster/"+posterLink);
		
		System.out.println(videoinfo.getLink());
		File video = new File(videoinfo.getLink());
		awsS3.upload(video, videoinfo.getTitle()+".mp4");
		
		
		
		return "redirect: adminpage";
	}
	
	
	
	@RequestMapping(value="video/board")
	public String board() {
		
		return "admin/video/board";
	}
	
	@RequestMapping(value="video/read")
	public String read() {
		
		return "admin/video/read";
	}
	
	@RequestMapping(value="video/teaser")
	public String teaser() {
		
		return "admin/video/teaser";
	}
	
	@RequestMapping(value="member")
	public String member() {
		
		return "admin/member";
	}
	
	@RequestMapping(value="qna")
	public String qna() {
		
		return "admin/qna";
	}
}
