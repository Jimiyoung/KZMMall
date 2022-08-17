package com.spring.javagreenS_jmy.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_jmy.vo.MemberVO;

public interface MemberDAO {

	public MemberVO getMemIdCheck(@Param("mid") String mid);

	public int setMemInputOk(@Param("vo") MemberVO vo);

	public void setMemberVisitProcess(@Param("vo") MemberVO vo);

	public void setMemPwdChange(@Param("changePwd")String changePwd, @Param("mid") String mid);

	public void setMemUpdateOk(@Param("vo") MemberVO vo);

	public void setMemDeleteOk(@Param("mid") String mid);

	public MemberVO getMemEmailFind(@Param("name") String name, @Param("email") String email);

	public MemberVO getMemTelFind(@Param("name") String name, @Param("tel") String tel);

	public MemberVO getMemPwdFind(@Param("mid") String mid, @Param("name") String name, @Param("toMail") String toMail);

	public void setPwdChange(@Param("mid") String mid, @Param("pwd") String pwd);

	public ArrayList<MemberVO> getAdminMemberLevelList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("level") int level);

	public ArrayList<MemberVO> getAdminMemberMidList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("mid") String mid);

	public int totRecCntAdminMemberList(@Param("level") int level);

	public int totRecCntAdminMemberMidList(@Param("mid") String mid);

	public MemberVO getMemInfor(@Param("idx") int idx);

	public void setAdminLevelUpdate(@Param("idx") int idx,	@Param("level") int level);

	public MemberVO getMemberInfor(@Param("mid") String mid);

	public void setMemberReset(@Param("idx") int idx);

	public String getTodayVisitDate();

	public void setTodayVisitCountInsert();

	public void setTodayVisitCountUpdate(@Param("strToday") String strToday);

	public void setQrCode(@Param("qrCode") String qrCode, @Param("idx") int idx);

	public MemberVO getMemEmailCheck(@Param("email") String email);

	public void setKakaoMemberInputOk(@Param("mid") String mid, @Param("pwd") String pwd, @Param("name") String name, @Param("tel") String tel, @Param("email") String email, @Param("address") String address);



}
