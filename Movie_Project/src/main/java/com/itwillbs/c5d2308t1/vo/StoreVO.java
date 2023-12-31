package com.itwillbs.c5d2308t1.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class StoreVO {
	
	private String product_id; // 상품구분아이디?
	private String product_name; // 상품명
	private int product_price; // 상품가격
	private String product_img; // 상품이미지
	private String product_txt; // 상품설명?
	private int product_count; // 상품갯수 
	
	// ===================================
	// 업로드되는 실제 파일을 다룰 MultipartFile 타입 멤버변수 추가
	// => 멤버변수명은 form 태그 내의 파일의 name 속성갑과 동일해야함 
	// 실제로 파일을 처리하는 타입
	private MultipartFile imgFile; // 실제 상품이미지
	
}
