package com.bit.yanado.controller;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import javax.swing.JFileChooser;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.yanado.model.dto.Poster;
import com.bit.yanado.model.dto.Teaser;
import com.bit.yanado.model.dto.tagName;
import com.bit.yanado.model.dto.videoinfo;
import com.bit.yanado.model.dto.videotitle;
import com.bit.yanado.model.service.AdminService;
import com.bit.yanado.model.service.AwsS3;
import com.bit.yanado.model.dto.tag;

@Controller
@RequestMapping(value="admin/")
public class AdminController {
	
	@Autowired
	AwsS3 awsS3;
	
	@Autowired
	AdminService adminService;

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
	public String write(Model model) {
		// TAG NAME 가져와서 Model로 보내
		model.addAttribute("tagName",adminService.getTag());
		
		// 영화제목 가져와서 모델로 보내기
		model.addAttribute("movieTitle",adminService.getTitle());
		
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
	public String videoUpload(videoinfo videoinfo,videotitle videotitle, Poster poster, 
			@Param("tag") String tag, Teaser teaser) {
		
		if(!videoinfo.getPeople().isEmpty()) {
			/*
			  영상 고유(유니크) 번호를 만드는 구간.
			*/
			
			int titleSeq = videotitle.getTitleSeq();
			
			if(videotitle.getTitleSeq() == 0) {				// 타이틀이 없는 새로운 타이틀이면 번호를 만들어 줘야한다.
				titleSeq = adminService.newTitleSeq(videotitle.getTitle());
			}
			String uniqueNoStr = "" + titleSeq + String.format("%02d", videoinfo.getSeason())
			+ String.format("%02d",videoinfo.getEpisode());				// 시즌과 에피소드를 합쳐서 유니크 넘버를 만들어준다.
			int uniqueNo = Integer.parseInt(uniqueNoStr);				// 유니크 넘버를 숫자인 int 형으로 바꿔준다.
			
			
			
			/*
			 * 포스터 파일을 처리하는 구간.
			 */
			if(!poster.getPoster().isEmpty()) {
				File newPoster = new File(poster.getPoster());			// 불러온 포스터 링크를 참고해 파일을 만든다.
				String posterName = getFileName(poster.getPoster()).toString();	// 링크에서 포스터 파일 이름만따로 뺴낸다.
				awsS3.upload(newPoster, posterName);							// 포스터 파일을 포스터 이름으로 S3에 올린다.
		//		https://swjinbucket.s3.ap-northeast-2.amazonaws.com/
				posterName.replace(" ", "+");						// 파일이름에 빈칸이 들어가 있으면 +로 치환해준다. -> S3에서 이런식으로 파일이 저장된다.
				poster.setPoster("https://swjinbucket.s3.ap-northeast-2.amazonaws.com/"+posterName);	// 파일이름 앞에 버킷 주소를 적어준 다음에 넣어준다.
				poster.setTitleSeq(titleSeq);							// 영상 타이틀 시퀀스를 적어준다.
				adminService.setPost(poster);							// 만들어진 포스터를 포스터 테이블에 넣어준다.
			}
			/*
			 * 비디오 파일을 처리하는 구간.
			 */
			
			File video = new File(videoinfo.getLink());				// 불러온 비디오 링크를 참고해 파일을 만든다.
			String fileName = getFileName(videoinfo.getLink()).toString();	// 링크에서 비디오 파일 이름만 따로 뺴낸다.
			awsS3.upload(video, fileName);									// 비디오 파일을 비디오 이름으로 S3에 올린다.
			videoinfo.setUniqueNo(uniqueNo);
			fileName.replace(" ", "+");	
			videoinfo.setLink("https://swjinbucket.s3.ap-northeast-2.amazonaws.com/"+fileName);
			
			/*
			 * 자막 처리하는 구간.
			 */
			if(!videoinfo.getSubEng().isEmpty()) {
				File subTitle = new File(videoinfo.getSubEng());
				String tempName = getFileName(videoinfo.getSubEng()).toString();
				tempName.replace(" ", "+");	
				videoinfo.setSubEng("https://swjinbucket.s3.ap-northeast-2.amazonaws.com/"+tempName);
				awsS3.upload(subTitle, tempName);	
			}
			
			if(!videoinfo.getSubKor().isEmpty()) {
				File subTitle = new File(videoinfo.getSubEng());
				String tempName = getFileName(videoinfo.getSubKor()).toString();
				tempName.replace(" ", "+");	
				videoinfo.setSubEng("https://swjinbucket.s3.ap-northeast-2.amazonaws.com/"+tempName);
				awsS3.upload(subTitle, tempName);
			}
			
			if(!videoinfo.getSubMix().isEmpty()) {
				File subTitle = new File(videoinfo.getSubEng());
				String tempName = getFileName(videoinfo.getSubMix()).toString();
				tempName.replace(" ", "+");	
				videoinfo.setSubEng("https://swjinbucket.s3.ap-northeast-2.amazonaws.com/"+tempName);
				awsS3.upload(subTitle, tempName);
			}
			System.out.println(videoinfo);
			adminService.setVideo(videoinfo);
			
			/*
			 * 테그를 처리해 주는 구간.
			 */
			List<String> tempTag = new ArrayList<String>();
			String[] splTag = tag.split("&");					// 받아온 테그를 '&'를 기준으로 나눠준다.
			for(int i = 0; i< splTag.length; i++) {				// 테그를 List로 옮겨준다. 
				if(!splTag[i].isEmpty())						// 빈 테그가 있다면 스킵해준다.
					tempTag.add(splTag[i]);
			}
			
			for(int i=0; i<tempTag.size();i++) {				// 테그를 리스트로 옮긴뒤 빈 테그를 생성해서 영상 고유번호와 테그번호를 지정해서 테그 테이블에 삽입한다.
				tag newTag = new tag();
				newTag.setUniqueNo(uniqueNo);					// 테그에 영상 고유번호를 넣는다.
				newTag.setTagNameSeq(adminService.getTagSeq(tempTag.get(i)));	// 테그에 테그고유번호를 넣는다. 테그 고유번호가 없는 테그면 새로 생성해서 넣는다.
				adminService.setTag(newTag);					// 입력된 테그를 테그 테이블에 넣어준다.
			}
			
		}
		/*
		 * Teaser가 있으면 올려준다.
		 */
		
		System.out.println(teaser.getTeaserLink().isEmpty());
		if(!teaser.getTeaserLink().isEmpty()) {
			teaser.setTitleSeq(videotitle.getTitleSeq());
			File newTeaser = new File(teaser.getTeaserLink());
			String tempName = "teaser"+getFileName(teaser.getTeaserLink()).toString();
			System.out.println(tempName);
			awsS3.upload(newTeaser, tempName);
			teaser.setTeaserLink("https://swjinbucket.s3.ap-northeast-2.amazonaws.com/"+tempName);
			adminService.setTeaser(teaser);
		}
		
		
		
		
		
		
		
		return "redirect: adminpage";
	}
	
	public Path getFileName(String path) {
		return Paths.get(path).getFileName();
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
