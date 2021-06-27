package com.bit.yanado.model.service;

import java.util.List;

import com.bit.yanado.model.dto.BookMark;
import com.bit.yanado.model.dto.Poster;
import com.bit.yanado.model.dto.TagName;
import com.bit.yanado.model.dto.Teaser;
import com.bit.yanado.model.dto.VideoInfo;
import com.bit.yanado.model.dto.WatchingReco;

public interface VideoService {
	public List<Poster> getAllPost();
	public List<Teaser> getTeaserVid();
	public String getTitleByTitleSeq(int titleSeq);
	public List<String> getEpisode(String titleSession);
	public VideoInfo getVideo(int uniqueNo);
	public void setRecord(String id, int uniqueNo, String record);
	public WatchingReco getRecord(String id, int uniqueNo);
	public void modRecord(String recoSeq, String record);
	public List<WatchingReco> getAllRecord(String id);
	public Poster getPostByTitleSeason(int titleSeq, int season);
	public List<BookMark> getBookmarks(String id, int uniqueNo);
	public void setBookmark(BookMark newBookmark);
	public void deleteBookmark(BookMark newBookmark);
	public void setDefaultCap(String caption, String id);
	public List<Poster> getSearchMdeia(String item);
	public VideoInfo getVideoByTitleSeason(String TitleSeason );
	
}
