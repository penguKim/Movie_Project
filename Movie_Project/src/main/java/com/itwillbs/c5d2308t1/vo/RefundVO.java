package com.itwillbs.c5d2308t1.vo;

import java.sql.Time;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Date;

import lombok.Data;

@Data
public class RefundVO {
	
	private String payment_id; // // 결제번호
	private String product_id; // 상품번호(P005)
	private String product_name; // 상품이름
	private String member_id; // 회원아이디
	private String member_name; // 회원이름
	private int cart_total_price; // 상품가격
	private int product_count; // 상품갯수
	private int quantity; // 상품갯수
	private int payment_status; // 결제상태
	private String movie_title; // 영화제목
	private LocalDateTime payment_datetime; // 예약시간? / 취소시간 
	
}
