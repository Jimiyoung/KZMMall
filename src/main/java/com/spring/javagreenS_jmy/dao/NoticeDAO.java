package com.spring.javagreenS_jmy.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_jmy.vo.NoticeVO;

public interface NoticeDAO {

	public void setNoticeInput(@Param("vo") NoticeVO vo);

	public int totRecCnt();

	public List<NoticeVO> getNoticeList(@Param("startIndexNo") int startIndexNo, @Param("pageSize")int pageSize);

	public void setReadNum(@Param("idx") int idx);

	public NoticeVO getNoticeContent(@Param("idx") int idx);

	public ArrayList<NoticeVO> getPreNext(@Param("idx") int idx);

	public int getMinIdx();

	public void setNoticeDelete(@Param("idx") int idx);

	public void setNoticeUpdate(@Param("vo") NoticeVO vo);

	public int totSearchRecCnt(@Param("search") String search, @Param("searchString") String searchString);

	public List<NoticeVO> getNoticeSearch(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("search") String search, @Param("searchString") String searchString);
	
}
