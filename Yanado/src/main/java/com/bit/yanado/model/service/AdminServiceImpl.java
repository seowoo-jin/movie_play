package com.bit.yanado.model.service;

import java.util.ArrayList;
import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.yanado.model.dao.AdminMapper;
import com.bit.yanado.model.dao.MemberMapper;
import com.bit.yanado.model.dao.VideoMapper;
import com.bit.yanado.model.dto.Poster;
import com.bit.yanado.model.dto.Teaser;
import com.bit.yanado.model.dto.AdminInfo;
import com.bit.yanado.model.dto.MemInfo;
import com.bit.yanado.model.dto.Tag;
import com.bit.yanado.model.dto.TagName;
import com.bit.yanado.model.dto.VideoInfo;
import com.bit.yanado.model.dto.VideoTitle;
import com.bit.yanado.model.dto.WatchingReco;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	public AdminMapper adminMapper;
	
	@Autowired
	public VideoMapper videoMapper;
	
	@Autowired
	public MemberMapper memberMapper;
	
	@Override
	public AdminInfo login(String id, String pw) {
		// TODO Auto-generated method stub
		return adminMapper.login(id, pw);
	}

	@Override
	public List<TagName> getAllTagName() {
		// TODO Auto-generated method stub
		return adminMapper.getAllTagName();
	}

	@Override
	public List<VideoTitle> getAllVideoTitle() {
		// TODO Auto-generated method stub
		return adminMapper.getAllVideoTitle();
	}

	@Override
	public int newTitleSeq(String title) {
		// TODO Auto-generated method stub
		adminMapper.insertNewTitle(title);
		return adminMapper.newTitleSeq(title);
	}

	@Override
	public int getTagSeq(String tag) {
		// TODO Auto-generated method stub
		
		String tagSeq = adminMapper.getTagSeq(tag);
		if(tagSeq == null) {
			adminMapper.setTagSeq(tag);
		}
		tagSeq = adminMapper.getTagSeq(tag);
		return Integer.parseInt(tagSeq);
	}

	@Override
	public void setTag(int uniqueNo, List<String> newTag) {
		// TODO Auto-generated method stub
		
		for(int i=0; i<newTag.size();i++) {				// 테그를 리스트로 옮긴뒤 빈 테그를 생성해서 영상 고유번호와 테그번호를 지정해서 테그 테이블에 삽입한다.
			Tag tempNewTag = new Tag();
			tempNewTag.setUniqueNo(uniqueNo);					// 테그에 영상 고유번호를 넣는다.
			tempNewTag.setTagNameSeq(getTagSeq(newTag.get(i)));	// 테그에 테그고유번호를 넣는다. 테그 고유번호가 없는 테그면 새로 생성해서 넣는다.
			adminMapper.setTag(tempNewTag);					// 입력된 테그를 테그 테이블에 넣어준다.
			adminMapper.setTagNameCount(tempNewTag);
		}
	}

	@Override
	public void setPost(Poster poster) {
		// TODO Auto-generated method stub
		adminMapper.setPost(poster);
	}

	@Override
	public void setVideo(VideoInfo video) {
		// TODO Auto-generated method stub
		adminMapper.setVideo(video);
	}

	@Override
	public void setTeaser(Teaser teaser) {
		// TODO Auto-generated method stub
		adminMapper.setTeaser(teaser);
	}

	@Override
	public void setReply(int qnaSeq, String reply, String adminWriter) {
		// TODO Auto-generated method stub
		adminMapper.setReply(qnaSeq, reply, adminWriter);
	}

	@Override
	public List<VideoInfo> getAllVideo() {
		// TODO Auto-generated method stub
		return videoMapper.getAllVideo();
	}

	@Override
	public List<MemInfo> getAllMember() {
		// TODO Auto-generated method stub
		return adminMapper.getAllMember();
	}


	@Override
	public void videoDelete(int uniqueNo) {
		// TODO Auto-generated method stub
		
		// videoMapper.getPostByTitleSeason(uniqueNo, uniqueNo);
		adminMapper.videoDelete(uniqueNo);
		List<String> episode = videoMapper.getEpisode(String.valueOf(uniqueNo/100));
		if(episode.size()==0) {
			adminMapper.deletePoster((uniqueNo/10000), ((uniqueNo%10000)/100));
		}
		// 삭제한 뒤 시즌으로 찾아서 에피소드가 하나도 없으면 포스터도 삭제해 준다.
	}

	@Override
	public void videoUpdate(VideoInfo video) {
		// TODO Auto-generated method stub
		adminMapper.videoUpdate(video);
	}

	@Override
	public List<String> splitTag(String tag) {
		// TODO Auto-generated method stub
		List<String> tempTag = new ArrayList<String>();
		String[] splTag = tag.split("&");					// 받아온 테그를 '&'를 기준으로 나눠준다.
		for(int i = 0; i< splTag.length; i++) {				// 테그를 List로 옮겨준다. 
			if(!splTag[i].isEmpty())						// 빈 테그가 있다면 스킵해준다.
				tempTag.add(splTag[i]);
		}
		return tempTag;
	}

	@Override
	public List<String> getTagByUniqueNo(int uniqueNo) {
		// TODO Auto-generated method stub
		return adminMapper.getTagByUniqueNo(uniqueNo);
	}

	@Override
	public String combineTag(List<String> tag) {
		// TODO Auto-generated method stub
		String result = "";
		for(int i=0; i<tag.size();i++) {
			result = result + "&"+ tag.get(i);
		}
		return result;
	}

	@Override
	public void teaserDelete(List<Integer> teasers) {
		// TODO Auto-generated method stub
		for(int i=0; i<teasers.size();i++) {
			adminMapper.teaserDelete(teasers.get(i));
		}
		
	}

	@Override
	public void teaserToMain(List<Integer> teasers) {
		// TODO Auto-generated method stub
		adminMapper.teaserIsMainReset();
		for(int i=0; i<teasers.size();i++) {
			adminMapper.teaserToMain(teasers.get(i));
		}
	}

	@Override
	public void deleteTag(int uniqueNo) {
		// TODO Auto-generated method stub
		adminMapper.deleteTag(uniqueNo);
	}

	@Override
	public List<WatchingReco> getAllWatchingRecord() {
		// TODO Auto-generated method stub
		return adminMapper.getAllWatchingRecord();
	}

	@Override
	public int getCountLoginMemberByDate(String dateInfo) {
		// TODO Auto-generated method stub
		return adminMapper.getCountLoginMemberByDate(dateInfo);
	}

	@Override
	public List<String> getMemberLoginYear() {
		// TODO Auto-generated method stub
		return adminMapper.getMemberLoginYear();
	}

	@Override
	public List<String> getMemberJoinYear() {
		// TODO Auto-generated method stub
		return adminMapper.getMemberJoinYear();
	}

	@Override
	public List<String> getMemberOutYear() {
		// TODO Auto-generated method stub
		return adminMapper.getMemberOutYear();
	}

	@Override
	public List<String> getWatchingRecoDate() {
		// TODO Auto-generated method stub
		return adminMapper.getWatchingRecoDate();
	}

	@Override
	public int getCountOutMemberByDate(String dateInfo) {
		// TODO Auto-generated method stub
		return adminMapper.getCountOutMemberByDate(dateInfo);
	}

	@Override
	public int getCountJoinMemberByDate(String dateInfo) {
		// TODO Auto-generated method stub
		return adminMapper.getCountJoinMemberByDate(dateInfo);
	}

	@Override
	public int getMemberWithoutOut() {
		// TODO Auto-generated method stub
		return adminMapper.getMemberWithoutOut();
	}

	@Override
	public List<TagName> getBestTag() {
		// TODO Auto-generated method stub
		return adminMapper.getBestTag();
	}

}
