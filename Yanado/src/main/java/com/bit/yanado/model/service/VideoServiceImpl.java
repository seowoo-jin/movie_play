package com.bit.yanado.model.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.yanado.model.dao.VideoMapper;
import com.bit.yanado.model.dto.BookMark;
import com.bit.yanado.model.dto.Poster;
import com.bit.yanado.model.dto.Teaser;
import com.bit.yanado.model.dto.VideoInfo;
import com.bit.yanado.model.dto.WatchingReco;

@Service
public class VideoServiceImpl implements VideoService {
	
	@Autowired
	VideoMapper videoMapper;
	
	@Override
	public List<Poster> getAllPost() {
		// TODO Auto-generated method stub
		return videoMapper.getAllPost();
	}

	@Override
	public List<Teaser> getTeaserVid(){
		// TODO Auto-generated method stub
		return videoMapper.getTeaserVid();
	}

	@Override
	public List<String> getEpisode(String titleSession) {
		// TODO Auto-generated method stub
		return videoMapper.getEpisode(titleSession);
	}

	@Override
	public VideoInfo getVideo(int uniqueNo) {
		// TODO Auto-generated method stub
		VideoInfo videoInfo = videoMapper.getVideo(uniqueNo);
		return videoInfo;
	}

	@Override
	public void setRecord(String id, int uniqueNo, String record) {
		// TODO Auto-generated method stub
		videoMapper.setRecord(id, uniqueNo, record);
	}

	@Override
	public WatchingReco getRecord(String id, int uniqueNo) {
		// TODO Auto-generated method stub
		return videoMapper.getRecord(id, uniqueNo);
	}

	@Override
	public void modRecord(String recoSeq, String record) {
		// TODO Auto-generated method stub
		videoMapper.modRecord(recoSeq, record);
	}

	@Override
	public List<WatchingReco> getAllRecord(String id) {
		// TODO Auto-generated method stub
		return videoMapper.getAllRecord(id);
	}

	@Override
	public Poster getPostByTitleSeason(int titleSeq, int season) {
		// TODO Auto-generated method stub
		return videoMapper.getPostByTitleSeason(titleSeq, season);
	}

	@Override
	public String getTitleByTitleSeq(int titleSeq) {
		// TODO Auto-generated method stub
		return videoMapper.getTitleByTitleSeq(titleSeq);
	}

	@Override
	public List<BookMark> getBookmarks(String id, int uniqueNo) {
		// TODO Auto-generated method stub
		return videoMapper.getBookmarks(id, uniqueNo);
	}

	@Override
	public void setBookmark(BookMark newBookmark) {
		// TODO Auto-generated method stub
		videoMapper.setBookmark(newBookmark);
	}

	@Override
	public void deleteBookmark(BookMark newBookmark) {
		// TODO Auto-generated method stub
		videoMapper.deleteBookmark(newBookmark);
	}

	@Override
	public void setDefaultCap(String caption, String id) {
		// TODO Auto-generated method stub
		videoMapper.setDefaultCap(caption,id);
	}

	@Override
	public List<Poster> getSearchMdeia(String item) {
		// TODO Auto-generated method stub
		List<Poster> newPoster = new ArrayList<Poster>();
		newPoster.addAll(videoMapper.getSearchMediaByTag(item));
		newPoster.addAll(videoMapper.getSearchMediaByTitle(item));
		return newPoster;
	}

	@Override
	public VideoInfo getVideoByTitleSeason(String TitleSeason) {
		// TODO Auto-generated method stub
		return videoMapper.getVideoByTitleSeason(TitleSeason).get(0);
	}

}
