package com.spring.javagreenS_jmy.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.javagreenS_jmy.vo.NoticeVO;

public interface NoticeService {

	public void imgCheck(String content);

	public void setNoticeInput(NoticeVO vo);

	public List<NoticeVO> getNoticeList(int startIndexNo, int pageSize);

	public void setReadNum(int idx);

	public NoticeVO getNoticeContent(int idx);

	public ArrayList<NoticeVO> getPreNext(int idx);

	public int getMinIdx();

	public void imgDelete(String content);

	public void setNoticeDelete(int idx);

	public void imgCheckUpdate(String content);

	public void setNoticeUpdate(NoticeVO vo);

	public List<NoticeVO> getNoticeSearch(int startIndexNo, int pageSize, String search, String searchString);

}
