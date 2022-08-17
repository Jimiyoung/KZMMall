package com.spring.javagreenS_jmy.vo;

import lombok.Data;

@Data
public class DbProductQnAVO {
	private int idx;
	private int productIdx;
	private String mid;
	private String wDate;
	private String content;
	
	private int level;
	private int levelOrder;
	
	private int diffTime;
}
