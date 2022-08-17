package com.spring.javagreenS_jmy.vo;

import lombok.Data;

@Data
public class DbCartListVO {
	private int idx;
	private String cartDate;
	private String mid;
	private int productIdx;
	private String productName;
	private int mainPrice;
	private String thumbImg;
	private String optionIdx;
	private String optionName;
	private String optionPrice;
	private String optionNum;
	private int totalPrice;
}
