package com.itwillbs.c5d2308t1.vo;

import lombok.Data;

/*
 파라미터가 있는 생성자로 객체를 생성합니다.
 매핑 메서드에는 @RequestParam(defaultValue = "1") int pageNum 가 있어야 합니다.
 첫번째 파라미터는 매핑 메서드의 파라미터인 pageNum 과 한 페이지에 표시할 글의 갯수를 지정합니다.
 SQL 구문에 넣어줄 파라미터로도 PageDTO 객체를 넣으시면 됩니다.
 */

@Data
public class PageDTO {

	// 파라미터로 넘어온 페이지 번호
	private int pageNum;
	// 한 페이지에서 표시할 글의 개수
	private int listLimit;
	// SQL 구문으로 사용할 조회 시작 행 지정
	private int startRow;
	
	public PageDTO(int pageNum, int listLimit) {
		this.pageNum = pageNum;
		this.listLimit = listLimit;
		this.startRow = (pageNum - 1) * listLimit;
	}
	
	
}
