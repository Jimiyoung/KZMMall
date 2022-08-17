package com.spring.javagreenS_jmy.vo;

import lombok.Data;

@Data
public class NoticeVO {
	private int idx;
	private String name;
	private String title;
	private String content;
	private String wDate;
	private int readNum;
	private String mid;
	private int pin;
	
	private int diffTime;
}
