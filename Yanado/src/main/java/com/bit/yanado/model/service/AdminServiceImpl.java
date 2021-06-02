package com.bit.yanado.model.service;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.yanado.model.dao.AdminMapper;
import com.bit.yanado.model.dto.Poster;
import com.bit.yanado.model.dto.Teaser;
import com.bit.yanado.model.dto.admininfo;
import com.bit.yanado.model.dto.tag;
import com.bit.yanado.model.dto.tagName;
import com.bit.yanado.model.dto.videoinfo;
import com.bit.yanado.model.dto.videotitle;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	public AdminMapper adminMapper;
	
	@Override
	public admininfo login(String id, String pw) {
		// TODO Auto-generated method stub
		return adminMapper.login(id, pw);
	}

	@Override
	public List<tagName> getTag() {
		// TODO Auto-generated method stub
		return adminMapper.getTag();
	}

	@Override
	public List<videotitle> getTitle() {
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
	public void setTag(tag newTeg) {
		// TODO Auto-generated method stub
		adminMapper.setTag(newTeg);
	}

	@Override
	public void setPost(Poster poster) {
		// TODO Auto-generated method stub
		adminMapper.setPost(poster);
	}

	@Override
	public void setVideo(videoinfo video) {
		// TODO Auto-generated method stub
		adminMapper.setVideo(video);
	}

	@Override
	public void setTeaser(Teaser teaser) {
		// TODO Auto-generated method stub
		adminMapper.setTeaser(teaser);
	}

}
