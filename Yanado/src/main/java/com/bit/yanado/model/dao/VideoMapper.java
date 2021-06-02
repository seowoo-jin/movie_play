package com.bit.yanado.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.bit.yanado.model.dto.Poster;
import com.bit.yanado.model.dto.Teaser;

public interface VideoMapper {
	
	public List<Poster> getPost();
	public Teaser getTeaserVid();
}
