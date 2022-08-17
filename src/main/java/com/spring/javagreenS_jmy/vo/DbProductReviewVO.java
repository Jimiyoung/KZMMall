package com.spring.javagreenS_jmy.vo;

import lombok.Data;

@Data
public class DbProductReviewVO {
	private int idx;
	private int productIdx;
	private String mid;
	private String wDate;
	private String content;
	
	private String diffTime;
}

