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
import com.bit.yanado.model.dto.WatchingReco;

public interface AdminMapper {
	
	public AdminInfo login(@Param("id") String id,@Param("pw") String pw);
	public List<TagName> getAllTagName();
	public void setTagNameCount(Tag newTeg);
	public List<VideoTitle> getAllVideoTitle();
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
	public void videoDelete(@Param("uniqueNo") int uniqueNo);
	public void videoUpdate(VideoInfo video);
	public List<String> getTagByUniqueNo(@Param("uniqueNo") int uniqueNo);
	public void teaserDelete(@Param("teaserSeq") int teasers);
	public void teaserIsMainReset();
	public void teaserToMain(@Param("teaserSeq") int teasers);
	public void deleteTag(@Param("uniqueNo") int uniqueNo);
	public void deletePoster(@Param("titleSeq") int titleSeq, @Param("season") int season);
	public List<WatchingReco> getAllWatchingRecord();
	public int getCountLoginMemberByDate(@Param("dateInfo") String dateInfo);
	public int getCountOutMemberByDate(@Param("dateInfo") String dateInfo);
	public int getCountJoinMemberByDate(@Param("dateInfo") String dateInfo);
	public List<String> getMemberLoginYear();
	public List<String> getMemberJoinYear();
	public List<String> getMemberOutYear();
	public List<String> getWatchingRecoDate();
	public int getMemberWithoutOut();
	public List<TagName> getBestTag();
}
