package com.itwillbs.c5d2308t1.vo;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class OrdersVO {
	
	private int cart_id; //
	private String product_id; //
	private String member_id; //
	private int cart_total_price; // 상품가격
	private int product_count; // 상품갯수
	private int payment_status; // 구매 상태
	private Timestamp cart_add_time; //
}
