package com.spring.javagreenS_jmy.vo;

import lombok.Data;

@Data
public class PayMentVO {
	private String name;						
	private int amount;							
	private String buyer_email;			
	private String buyer_name;		
	private String buyer_tel;				
	private String buyer_addr;			
	private String buyer_postcode;	
	
	private String imp_uid;				
	private String merchant_uid;	
	private String paid_amount;		
	private String apply_num;			
}
