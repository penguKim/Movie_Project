package com.itwillbs.c5d2308t1.vo;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class PaymentVO {
	
	private int payment_id;
	private String payment_name;
	private Timestamp payment_datetime;
	private String payment_card_name;
	private String payment_card_num;
	private int payment_total_price;
	private int payment_staus;
}	
