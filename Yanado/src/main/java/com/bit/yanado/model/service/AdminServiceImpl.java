package com.bit.yanado.model.service;

import java.util.ArrayList;
import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.yanado.model.dao.AdminMapper;
import com.bit.yanado.model.dao.VideoMapper;
import com.bit.yanado.model.dto.Poster;
import com.bit.yanado.model.dto.Teaser;
import com.bit.yanado.model.dto.AdminInfo;
import com.bit.yanado.model.dto.MemInfo;
import com.bit.yanado.model.dto.Tag;
import com.bit.yanado.model.dto.TagName;
import com.bit.yanado.model.dto.VideoInfo;
import com.bit.yanado.model.dto.VideoTitle;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	public AdminMapper adminMapper;
	
	@Autowired
	public VideoMapper videoMapper;
	
	@Override
	public AdminInfo login(String id, String pw) {
		// TODO Auto-generated method stub
		return adminMapper.login(id, pw);
	}

	@Override
	public List<TagName> getTag() {
		// TODO Auto-generated method stub
		return adminMapper.getTag();
	}

	@Override
	public List<VideoTitle> getTitle() {
		// TODO Auto-generated method stub
		return adminMapper.getTitle();
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
	public void setTag(Tag newTeg) {
		// TODO Auto-generated method stub
		adminMapper.setTag(newTeg);
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
	public void memberDelete(String id) {
		// TODO Auto-generated method stub
		adminMapper.memberDelete(id);
	}

	@Override
	public void videoDelete(int uniqueNo) {
		// TODO Auto-generated method stub
		adminMapper.videoDelete(uniqueNo);
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

}
