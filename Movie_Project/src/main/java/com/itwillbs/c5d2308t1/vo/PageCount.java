package com.itwillbs.c5d2308t1.vo;

import lombok.Data;

/*
먼저 생성한 PageDTO 객체를 준비합니다.
listCount는 각 게시판별 COUNT(*)를 준비합니다.
pageListLimit는 한 페이지에서 보일 갯수를 지정합니다.

@GetMapping("")
public String method(@RequestParam(defaultValue = "1") int pageNum, HttpSession session, Model model) {
	// 페이지 번호와 글의 개수를 파라미터로 전달
	PageDTO page = new PageDTO(pageNum, 5);
	// 전체 게시글 갯수 조회
	int listCount = service.getBoardListCount();
	// PageDTO 객체와 게시글 갯수, 페이지 번호 갯수를 파라미터로 전달
	PageCount pageInfo = new PageCount(page, listCount, 3);
	// page 객체를 파라미터로 글 목록 조회
	List<CsVO> BoardList = service.getBoardList(page);
	// 모델 객체에 담아서 전송
	model.addAttribute("BoardList", BoardList);
	model.addAttribute("pageInfo", pageInfo);
	return "admin/admin_board_lostnfound";
}
*/

@Data
public class PageCount {
	private PageDTO page; // 페이지 번호, 글의 개수, SQL 시작 행 지정
	private int listCount; // 총 게시물 수
	private int pageListLimit; // 페이지 당 표시할 페이지 번호 갯수
	private int maxPage; // 전체 페이지 수(최대 페이지 번호)
	private int startPage; // 시작 페이지 번호
	private int endPage; // 끝 페이지 번호
	
	
	// 파라미터 생성자 정의
	public PageCount(PageDTO page, int listCount, int pageListLimit) {
		this.listCount = listCount;
		this.pageListLimit = pageListLimit;
		maxPage = listCount / page.getListLimit() + (listCount % page.getListLimit() > 0 ? 1 : 0);
		startPage = (page.getPageNum() - 1) / pageListLimit * pageListLimit + 1;
		endPage = startPage + pageListLimit - 1;
		endPage = endPage > maxPage? maxPage : startPage + pageListLimit - 1;
	}
}
