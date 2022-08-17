package com.spring.javagreenS_jmy.vo;

import lombok.Data;

@Data
public class DbProductVO {
	private int idx;
	private String productCode;
	private String productName;
	private String detail;
	private String mainPrice;
	private String fName;
	private String fSName;
	private String content;
	
	private String categoryMainCode;
	private String categoryMainName;
	private String categorySubCode;
	private String categorySubName;
	
	private int reviewCount;
	private int qnaCount;
	
	private String searchString;
	
	private String mainName;
}
