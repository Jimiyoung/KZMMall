package com.spring.javagreenS_jmy.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_jmy.vo.AsReplyVO;
import com.spring.javagreenS_jmy.vo.AsVO;

public interface AsDAO {

	public void setAsInputOk(@Param("vo") AsVO vo);

	public int totRecCnt();

	public int totSearchRecCnt(@Param("search") String search, @Param("searchString") String searchString);

	public List<AsVO> getAsList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public AsVO getAsContent(@Param("idx") int idx);

	public void setAsUpdate(@Param("vo") AsVO vo);

	public void setAsDelete(@Param("idx") int idx);

	public String maxLevelOrder(@Param("asIdx") int asIdx);

	public void setAsReplyInput(@Param("replyVo") AsReplyVO replyVo);

	public ArrayList<AsReplyVO> getAsReply(@Param("idx") int idx);

	public void setAsReplyDelete(@Param("idx") int idx);

	public void setAsReplyUpdate(@Param("replyVo") AsReplyVO replyVo);

	public void levelOrderPlusUpdate(@Param("replyVo") AsReplyVO replyVo);

	public void setAsReplyInput2(@Param("replyVo") AsReplyVO replyVo);

	public void swCheck(@Param("idx") int idx);

	public ArrayList<AsVO> getAsBoardList(@Param("mid") String mid, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public int totMemASRecCnt(@Param("searchString") String searchString);

	public void setAsDeleteReply(@Param("idx") int idx);


}
