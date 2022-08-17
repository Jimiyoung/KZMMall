package com.spring.javagreenS_jmy.dao;

import java.util.List;

import com.spring.javagreenS_jmy.vo.ChartVO;

public interface AdminDAO {

	public List<ChartVO> getRecentlyVisitCount();
}
