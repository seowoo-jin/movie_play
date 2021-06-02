package com.bit.yanado.model.service;

import java.util.List;

import com.bit.yanado.model.dto.Poster;
import com.bit.yanado.model.dto.Teaser;

public interface VideoService {
	public List<Poster> getPost();
	public Teaser getTeaserVid();
}
