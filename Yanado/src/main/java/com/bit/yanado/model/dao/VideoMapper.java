package com.bit.yanado.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.bit.yanado.model.dto.BookMark;
import com.bit.yanado.model.dto.Poster;
import com.bit.yanado.model.dto.Teaser;
import com.bit.yanado.model.dto.VideoInfo;
import com.bit.yanado.model.dto.WatchingReco;

public interface VideoMapper {
	
	public List<Poster> getAllPost();
	public List<Teaser> getTeaserVid();
	public String getTitleByTitleSeq(@Param("titleSeq") int titleSeq);
	public List<String> getEpisode(@Param("titleSession") String titleSession);
	public VideoInfo getVideo(@Param("uniqueNo") int uniqueNo);
	public void setRecord(@Param("id") String id, @Param("uniqueNo") int uniqueNo,@Param("record") String record);
	public WatchingReco getRecord(@Param("id") String id, @Param("uniqueNo") int uniqueNo);
	public void modRecord(@Param("recoSeq") String recoSeq,@Param("record") String record);
	public List<WatchingReco> getAllRecord(@Param("id") String id);
	public Poster getPostByTitleSeason(@Param("titleSeq") int titleSeq, @Param("season") int season);
	public List<VideoInfo> getAllVideo();
	public List<BookMark> getBookmarks(@Param("id") String id,@Param("uniqueNo")  int uniqueNo);
	public void setBookmark(BookMark newBookmark);
	public void deleteBookmark(BookMark newBookmark);
	public void setDefaultCap(@Param("caption") String caption, @Param("id") String id);
	public List<Poster> getSearchMediaByTag(@Param("item") String item);
	public List<Poster> getSearchMediaByTitle(@Param("item") String item);
	public List<VideoInfo> getVideoByTitleSeason(@Param("TitleSeason") String TitleSeason );
}
