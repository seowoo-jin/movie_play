package com.bit.yanado.controller;

import java.io.File;


import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.swing.JFileChooser;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.yanado.model.dto.AdminInfo;
import com.bit.yanado.model.dto.MemInfo;
import com.bit.yanado.model.dto.Poster;
import com.bit.yanado.model.dto.Qna;
import com.bit.yanado.model.dto.Teaser;
import com.bit.yanado.model.dto.TagName;
import com.bit.yanado.model.dto.VideoInfo;
import com.bit.yanado.model.dto.VideoTitle;
import com.bit.yanado.model.service.AdminService;
import com.bit.yanado.model.service.AwsS3;
import com.bit.yanado.model.service.MemberService;
import com.bit.yanado.model.service.VideoService;
import com.bit.yanado.model.dto.Tag;

@Controller
@RequestMapping(value="admin/")
public class AdminController {
	
	@Autowired
	AwsS3 awsS3;
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	VideoService videoService;

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
	public String videoUpload(VideoInfo videoinfo,VideoTitle videotitle, Poster poster, 
			@Param("tag") String tag, Teaser teaser) {
		
		
		if(!videoinfo.getPeople().isEmpty()) {    // 올릴 영상이 존재한다는 것을 사람을 입력했는지를 통해 알수 있다.
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
			 * 포스터 파일 업로드.
			 */
			if(!poster.getPoster().isEmpty()) {
				File newPoster = new File(poster.getPoster());			// 불러온 포스터 링크를 참고해 파일을 만든다.
				String posterName = getFileName(poster.getPoster()).toString();	// 링크에서 포스터 파일 이름만따로 뺴낸다.
				awsS3.upload(newPoster, posterName);							// 포스터 파일을 포스터 이름으로 S3에 올린다.
		//		https://swjinbucket.s3.ap-northeast-2.amazonaws.com/
				posterName.replace(" ", "+");						// 파일이름에 빈칸이 들어가 있으면 +로 치환해준다. -> S3에서 이런식으로 파일이 저장된다.
				poster.setPoster("https://swjin0203.s3.ap-northeast-2.amazonaws.com/"+posterName);	// 파일이름 앞에 버킷 주소를 적어준 다음에 넣어준다.
				poster.setTitleSeq(titleSeq);							// 영상 타이틀 시퀀스를 적어준다.
				adminService.setPost(poster);							// 만들어진 포스터를 포스터 테이블에 넣어준다.
			}
			/*
			 * 비디오 파일 업로드.
			 */
			File video = new File(videoinfo.getLink());				// 불러온 비디오 링크를 참고해 파일을 만든다.
			String fileName = getFileName(videoinfo.getLink()).toString();	// 링크에서 비디오 파일 이름만 따로 뺴낸다.
			awsS3.upload(video, fileName);									// 비디오 파일을 비디오 이름으로 S3에 올린다.
			videoinfo.setUniqueNo(uniqueNo);
			fileName.replace(" ", "+");	
			videoinfo.setLink("https://swjin0203.s3.ap-northeast-2.amazonaws.com/"+fileName);
			
			/*
			 * 자막 업로드.
			 */
			if(!videoinfo.getSubEng().isEmpty()) {
				File subTitle = new File(videoinfo.getSubEng());
				String tempName = getFileName(videoinfo.getSubEng()).toString();
				tempName.replace(" ", "+");	
				videoinfo.setSubEng("https://swjin0203.s3.ap-northeast-2.amazonaws.com/"+tempName);
				awsS3.upload(subTitle, tempName);	
			}
			
			if(!videoinfo.getSubKor().isEmpty()) {
				File subTitle = new File(videoinfo.getSubKor());
				String tempName = getFileName(videoinfo.getSubKor()).toString();
				tempName.replace(" ", "+");	
				videoinfo.setSubEng("https://swjin0203.s3.ap-northeast-2.amazonaws.com/"+tempName);
				awsS3.upload(subTitle, tempName);
			}
			
			if(!videoinfo.getSubMix().isEmpty()) {
				File subTitle = new File(videoinfo.getSubMix());
				String tempName = getFileName(videoinfo.getSubMix()).toString();
				tempName.replace(" ", "+");	
				videoinfo.setSubEng("https://swjin0203.s3.ap-northeast-2.amazonaws.com/"+tempName);
				awsS3.upload(subTitle, tempName);
			}
			System.out.println(videoinfo);
			adminService.setVideo(videoinfo);
			
			/*
			 * 테그를 처리해 주는 구간.
			 */
			List<String> tempTag = adminService.splitTag(tag);
			for(int i=0; i<tempTag.size();i++) {				// 테그를 리스트로 옮긴뒤 빈 테그를 생성해서 영상 고유번호와 테그번호를 지정해서 테그 테이블에 삽입한다.
				Tag newTag = new Tag();
				newTag.setUniqueNo(uniqueNo);					// 테그에 영상 고유번호를 넣는다.
				newTag.setTagNameSeq(adminService.getTagSeq(tempTag.get(i)));	// 테그에 테그고유번호를 넣는다. 테그 고유번호가 없는 테그면 새로 생성해서 넣는다.
				adminService.setTag(newTag);					// 입력된 테그를 테그 테이블에 넣어준다.
			}
		}
		/*
		 * Teaser가 있으면 올려준다.
		 */
		
		System.out.println(teaser.getTeaserLink().isEmpty());
		if(!teaser.getTeaserLink().isEmpty()) {							// 올릴 티저 영상이 있는지 확인한 후 영상이 있으면 실행.
			teaser.setTitleSeq(videotitle.getTitleSeq());
			File newTeaser = new File(teaser.getTeaserLink());
			String tempName = "teaser"+getFileName(teaser.getTeaserLink()).toString();
			System.out.println(tempName);
			awsS3.upload(newTeaser, tempName);
			teaser.setTeaserLink("https://swjin0203.s3.ap-northeast-2.amazonaws.com/"+tempName);
			adminService.setTeaser(teaser);
		}
		return "redirect: adminpage";
	}
	
	public Path getFileName(String path) {
		return Paths.get(path).getFileName();
	}
	
	
	// 관리자 영상 관리 게시판으로 이동 --------------------------------------------------------------
	@RequestMapping(value="video/board")
	public String board() {
		return "admin/video/board";
	}
	
	// 관리자 영상 정보 보기 게시판으로 이동 --------------------------------------------------------------
		@RequestMapping(value="video/videoRead")
		public String videoRead(@Param("uniqueNo") int uniqueNo,Model model) {
			System.out.println(uniqueNo);
			VideoInfo selectedVideo=videoService.getVideo(uniqueNo);
			selectedVideo.setSeason((selectedVideo.getUniqueNo()%10000)/100);	// 영상에 고유번호에서 시즌 정보 불러오
			selectedVideo.setEpisode(selectedVideo.getUniqueNo()%100);
			model.addAttribute("videoInfo",selectedVideo);
			/*
			 * uniqueNo로 해당 테그 가져오기.
			 */
			String tag = adminService.combineTag(adminService.getTagByUniqueNo(uniqueNo));
			model.addAttribute("tag",tag);
			return "admin/video/read";
		}
	
	
	// 관리자 영상 관리 게시판에서 영상 정보 불러오기 -----------------------------------------------------------------
	@ResponseBody
	@RequestMapping(value="video/videoList")
	public List<VideoInfo> videoList() {
		List<VideoInfo> list = adminService.getAllVideo();					//영상 정보 다 불러오
		for(int i=0; i<list.size();i++) {
			list.get(i).setSeason((list.get(i).getUniqueNo()%10000)/100);	// 영상에 고유번호에서 시즌 정보 불러오
			list.get(i).setEpisode(list.get(i).getUniqueNo()%100);			// 영상 고유번호에서 에피소드 가져오
		}
		return list;
	}
	
	// 관리자 영상 리스트로 삭제 ---------------------------------------------------------------------
	@RequestMapping(value="videoDelete")
	public String videoDelete(@RequestParam(value="videos[]") List<Integer> uniqueNo) {
		System.out.println(uniqueNo);
		for(int i=0;i<uniqueNo.size();i++) {
			adminService.videoDelete(uniqueNo.get(i));
		}
		return "admin/adminpage";
	}
	
	// 관리자 영상 하나 삭제 ---------------------------------------------------------------------
		@RequestMapping(value="singleVideoDelete")
		public String singleVideoDelete(@Param("uniqueNo") int uniqueNo) {
			System.out.println(uniqueNo);
			adminService.videoDelete(uniqueNo);
			return "admin/adminpage";
		}
	
	// 관리자 영상 수정 게시판 이동 ---------------------------------------------------------------------
		@RequestMapping(value="videoModifyForm")
		public String videoModifyForm(@Param("uniqueNo") int uniqueNo,Model model) {
			System.out.println(uniqueNo);
			// TAG NAME 가져와서 Model로 보내
			model.addAttribute("tagName",adminService.getTag());
			// 영화제목 가져와서 모델로 보내기
			model.addAttribute("movieTitle",adminService.getTitle());
			VideoInfo selectedVideo=videoService.getVideo(uniqueNo);
			selectedVideo.setSeason((selectedVideo.getUniqueNo()%10000)/100);	// 영상에 고유번호에서 시즌 정보 불러오
			selectedVideo.setEpisode(selectedVideo.getUniqueNo()%100);
			model.addAttribute("videoInfo",selectedVideo);
			String tag = adminService.combineTag(adminService.getTagByUniqueNo(uniqueNo));
			model.addAttribute("savedTagName",tag);
			
			return "admin/video/write";
		}
		
	// 관리자 영상 수정 --------------------------------------------------------------------
		@RequestMapping(value="videoModify")
		public String videoModify(VideoInfo videoInfo, @Param("tag") String tag) {
			// 수정할 때 테그도 중복된걸 제외하고 수정해줘야함.
			adminService.videoUpdate(videoInfo);
			return "admin/adminpage";
		}
		
		
	
	// 관리자 예고편 관리 게시판으로 이동 --------------------------------------------------------------
	@RequestMapping(value="video/teaser")
	public String teaser() {
		return "admin/video/teaser";
	}
	
	// 관리자 예고편 정보 보내기 --------------------------------------------------------------
	@ResponseBody
	@RequestMapping(value="video/teaserList")
	public List<Map<String,String>> teaserList() {
		List<Map<String,String>> list = new ArrayList<Map<String,String>>();
		List<Teaser> teaserVids = videoService.getTeaserVid();
		
		for(int i=0; i<teaserVids.size();i++) {
			Map<String,String> map = new HashMap<String,String>();
			map.put("title",videoService.getTitleByTitleSeq(teaserVids.get(i).getTitleSeq()));
			map.put("uploadDate", teaserVids.get(i).getUploadDate().toString());
			map.put("isMain", teaserVids.get(i).getIsMain());
			map.put("teaserSeq",String.valueOf(teaserVids.get(i).getTeaserSeq()));
			list.add(map); 
		}
		return list;
	}
	
	// 메인 화면에 재생시킬 예고편 선택     --------------------------------------------------------------
	@RequestMapping(value="teaserToMain")
	public String teaserToMain(@RequestParam(value="teasers[]") List<Integer> teaserSeq) {
		adminService.teaserToMain(teaserSeq);
		return "admin/adminpage";
	}
	
	
	
	
	// 관리자 영상 리스트로 삭제 ---------------------------------------------------------------------
		@RequestMapping(value="teaserDelete")
		public String teaserDelete(@RequestParam(value="teasers[]") List<Integer> teaserSeq) {
			adminService.teaserDelete(teaserSeq);
			return "admin/adminpage";
		}
	
	// 멤버 게시판으로 이동 ----------------------------------------------------------------------
	@RequestMapping(value="member")
	public String member() {
		return "admin/member";
	}
	
	// 멤버 정보 보내기 --------------------------------------------------------------
	@ResponseBody
	@RequestMapping(value="memberList")
	public List<MemInfo> memberList() {
		List<MemInfo> members = adminService.getAllMember();
		return members;
	}
	
	
	// 멤버 삭제 메소드  --------------------------------------------------------------
	@RequestMapping(value="memberDelete")
	public String memberDelete(
			@RequestParam(value="members[]") List<String> id) {
		System.out.println(id.get(0));
		for(int i=0;i<id.size();i++)
			adminService.memberDelete(id.get(i));
		return "admin/member";
	}
	
	
	// Q&A 글 보기   -------------------------------------------------------------------------
	@RequestMapping(value="qna")
	public String qna(Model model, HttpSession session) {
		List<Qna> allQna = memberService.getAllQna();
		model.addAttribute("allQna",allQna);
		return "admin/qna";
	}
	
	// Q&A 글 삭제  -------------------------------------------------------------------------
	@RequestMapping(value="qna/deleteQna")
	public String deleteQna(int qnaSeq){
		memberService.deleteQna(qnaSeq);
		return "admin/qna";
	}
		
	// Q&A 답변 쓰기  -------------------------------------------------------------------------
	@RequestMapping(value="reply")
	public String reply(@Param("qnaSeq") int qnaSeq,@Param("reply")  String reply, HttpSession session) {
		AdminInfo admin = (AdminInfo) session.getAttribute("admin");
		admin.getAdminName();
		System.out.println(qnaSeq);
		System.out.println(reply);
		adminService.setReply(qnaSeq, reply, admin.getAdminName());;
		return "admin/qna";
	}
	
	
	
	
	
	
	
	
	
	
}
