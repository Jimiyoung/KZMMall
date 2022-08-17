package com.spring.javagreenS_jmy.vo;

import lombok.Data;

@Data
public class MemberVO {
	private int idx;
	private String mid;
	private String pwd;
	private String name;
	private String tel;
	private String email;
	private String address;
	private String startDate;
	private String lastDate;
	private String userDel;
	private int level;
	private int point;

	private String strLevel; 
	
	private int applyDiff;
}
