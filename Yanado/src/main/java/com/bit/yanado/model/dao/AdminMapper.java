package com.bit.yanado.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bit.yanado.model.dto.Poster;
import com.bit.yanado.model.dto.Teaser;
import com.bit.yanado.model.dto.AdminInfo;
import com.bit.yanado.model.dto.MemInfo;
import com.bit.yanado.model.dto.Tag;
import com.bit.yanado.model.dto.TagName;
import com.bit.yanado.model.dto.VideoInfo;
import com.bit.yanado.model.dto.VideoTitle;

public interface AdminMapper {
	
	public AdminInfo login(@Param("id") String id,@Param("pw") String pw);
	public List<TagName> getTag();
	public List<VideoTitle> getTitle();
	public void insertNewTitle(String title);
	public int newTitleSeq(String title);
	public String getTagSeq(String tag);
	public void setTagSeq(String tag);
	public void setTag(Tag newTeg);
	public void setPost(Poster poster);
	public void setVideo(VideoInfo video);
	public void setTeaser(Teaser teaser);
	public void setReply(@Param("qnaSeq") int qnaSeq,@Param("reply")  String reply,@Param("adminWriter")  String adminWriter);
	public List<MemInfo> getAllMember();
	public void memberDelete(@Param("id") String id);
}
