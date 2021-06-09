package com.bit.yanado.model.service;

import java.util.List;

import com.bit.yanado.model.dto.Poster;
import com.bit.yanado.model.dto.Teaser;
import com.bit.yanado.model.dto.AdminInfo;
import com.bit.yanado.model.dto.Tag;
import com.bit.yanado.model.dto.TagName;
import com.bit.yanado.model.dto.VideoInfo;
import com.bit.yanado.model.dto.VideoTitle;

public interface AdminService {
	public AdminInfo login(String id, String pw);
	public List<TagName> getTag();
	public List<VideoTitle> getTitle();
	public int newTitleSeq(String title);
	public int getTagSeq(String tag);
	public void setTag(Tag newTeg);
	public void setPost(Poster poster);
	public void setVideo(VideoInfo video);
	public void setTeaser(Teaser teaser);
	public void setReply(int qnaSeq, String reply, String adminWriter);
	public List<VideoInfo> getAllVideo();
}
