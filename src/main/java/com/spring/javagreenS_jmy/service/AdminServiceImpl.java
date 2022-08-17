package com.spring.javagreenS_jmy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javagreenS_jmy.dao.AdminDAO;
import com.spring.javagreenS_jmy.vo.ChartVO;

@Service
public class AdminServiceImpl implements AdminService{

	@Autowired
	AdminDAO adminDAO;

	@Override
	public List<ChartVO> getRecentlyVisitCount() {
		return adminDAO.getRecentlyVisitCount();
	}
}
