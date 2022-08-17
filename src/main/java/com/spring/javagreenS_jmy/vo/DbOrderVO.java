package com.spring.javagreenS_jmy.vo;

import lombok.Data;

@Data
public class DbOrderVO {
  private int idx;
  private String orderIdx;
  private String mid;
  private int productIdx;
  private String orderDate;
  private String productName;
  private int mainPrice;
  private String thumbImg;
  private String optionName;
  private String optionPrice;
  private String optionNum;
  private int totalPrice;
  
  private int cartIdx;  
  private int maxIdx;   
  private int baesong;  
  
  private String orderStatus;
  
  private int diffTime;
}
