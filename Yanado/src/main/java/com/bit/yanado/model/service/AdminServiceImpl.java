package com.bit.yanado.model.service;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.yanado.model.dao.AdminMapper;
import com.bit.yanado.model.dao.VideoMapper;
import com.bit.yanado.model.dto.Poster;
import com.bit.yanado.model.dto.Teaser;
import com.bit.yanado.model.dto.AdminInfo;
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

}
