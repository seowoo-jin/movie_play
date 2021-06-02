package com.bit.yanado.model.service;

import java.util.List;

import com.bit.yanado.model.dto.Poster;
import com.bit.yanado.model.dto.Teaser;
import com.bit.yanado.model.dto.admininfo;
import com.bit.yanado.model.dto.tag;
import com.bit.yanado.model.dto.tagName;
import com.bit.yanado.model.dto.videoinfo;
import com.bit.yanado.model.dto.videotitle;

public interface AdminService {
	public admininfo login(String id, String pw);
	public List<tagName> getTag();
	public List<videotitle> getTitle();
	public int newTitleSeq(String title);
	public int getTagSeq(String tag);
	public void setTag(tag newTeg);
	public void setPost(Poster poster);
	public void setVideo(videoinfo video);
	public void setTeaser(Teaser teaser);
}
