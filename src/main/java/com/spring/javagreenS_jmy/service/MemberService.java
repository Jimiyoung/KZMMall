package com.spring.javagreenS_jmy.service;

import java.util.ArrayList;

import com.spring.javagreenS_jmy.vo.MemberVO;

public interface MemberService {

	public MemberVO getMemIdCheck(String mid);

	public int setMemInputOk(MemberVO vo);

	public void setMemberVisitProcess(MemberVO vo);

	public void setMemPwdChange(String changePwd, String mid);

	public void setMemUpdateOk(MemberVO vo);

	public void setMemDeleteOk(String mid);

	public MemberVO getMemEmailFind(String name, String email);

	public MemberVO getMemTelFind(String name, String tel);

	public MemberVO getMemPwdFind(String mid, String name, String toMail);

	public void setPwdChange(String mid, String pwd);

	public ArrayList<MemberVO> getAdminMemberLevelList(int startIndexNo, int pageSize, int level);

	public ArrayList<MemberVO> getAdminMemberMidList(int startIndexNo, int pageSize, String mid);

	public MemberVO getMemInfor(int idx);

	public void setAdminLevelUpdate(int idx, int level);

	public MemberVO getMemberInfor(String mid);

	public void setMemberReset(int idx);

	public String getTodayVisitDate();

	public void setTodayVisitCountInsert();

	public void setTodayVisitCountUpdate(String strToday);

	public String setQrCode(String uploadPath, String moveUrl, int idx);

	public MemberVO getMemEmailCheck(String email);

	public void setKakaoMemberInputOk(String mid, String pwd, String name, String tel, String email, String address);







}
