package com.bit.yanado.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.yanado.model.dao.VideoMapper;
import com.bit.yanado.model.dto.Poster;
import com.bit.yanado.model.dto.Teaser;

@Service
public class VideoServiceImpl implements VideoService {
	
	@Autowired
	VideoMapper videoMapper;
	
	@Override
	public List<Poster> getPost() {
		// TODO Auto-generated method stub
		return videoMapper.getPost();
	}

	@Override
	public Teaser getTeaserVid() {
		// TODO Auto-generated method stub
		return videoMapper.getTeaserVid();
	}

}
