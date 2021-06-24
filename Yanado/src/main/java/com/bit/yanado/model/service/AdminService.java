package com.bit.yanado.model.service;

import java.util.List;

import com.bit.yanado.model.dto.Poster;
import com.bit.yanado.model.dto.Teaser;
import com.bit.yanado.model.dto.AdminInfo;
import com.bit.yanado.model.dto.MemInfo;
import com.bit.yanado.model.dto.Tag;
import com.bit.yanado.model.dto.TagName;
import com.bit.yanado.model.dto.VideoInfo;
import com.bit.yanado.model.dto.VideoTitle;
import com.bit.yanado.model.dto.WatchingReco;

public interface AdminService {
	public AdminInfo login(String id, String pw);
	public List<TagName> getAllTagName();
	public List<VideoTitle> getAllVideoTitle();
	public int newTitleSeq(String title);
	public int getTagSeq(String tag);
	public void setTag(int uniqueNo, List<String> newTag);
	public void setPost(Poster poster);
	public void setVideo(VideoInfo video);
	public void setTeaser(Teaser teaser);
	public void setReply(int qnaSeq, String reply, String adminWriter);
	public List<VideoInfo> getAllVideo();
	public List<MemInfo> getAllMember();
	public void videoDelete(int uniqueNo);
	public void videoUpdate(VideoInfo video);
	public List<String> splitTag(String tag);
	public String combineTag(List<String> tag);
	public List<String> getTagByUniqueNo(int uniqueNo);
	public void teaserDelete(List<Integer> teasers);
	public void teaserToMain(List<Integer> teasers);
	public void deleteTag(int uniqueNo);
	public List<WatchingReco> getAllWatchingRecord();
	public int getCountLoginMemberByDate(String dateInfo);
	public int getCountOutMemberByDate(String dateInfo);
	public int getCountJoinMemberByDate(String dateInfo);
	public List<String> getMemberLoginYear();
	public List<String> getMemberJoinYear();
	public List<String> getMemberOutYear();
	public List<String> getWatchingRecoDate();
	public int getMemberWithoutOut();
	public List<TagName> getBestTag();
	
	
}
