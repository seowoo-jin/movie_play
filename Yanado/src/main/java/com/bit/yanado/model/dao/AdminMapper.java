package com.bit.yanado.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bit.yanado.model.dto.Poster;
import com.bit.yanado.model.dto.Teaser;
import com.bit.yanado.model.dto.admininfo;
import com.bit.yanado.model.dto.tag;
import com.bit.yanado.model.dto.tagName;
import com.bit.yanado.model.dto.videoinfo;
import com.bit.yanado.model.dto.videotitle;

public interface AdminMapper {
	
	public admininfo login(@Param("id") String id,@Param("pw") String pw);
	public List<tagName> getTag();
	public List<videotitle> getTitle();
	public void insertNewTitle(String title);
	public int newTitleSeq(String title);
	public String getTagSeq(String tag);
	public void setTagSeq(String tag);
	public void setTag(tag newTeg);
	public void setPost(Poster poster);
	public void setVideo(videoinfo video);
	public void setTeaser(Teaser teaser);
	
}
