package com.itwillbs.c5d2308t1.vo;

//페이징 처리에 사용되는 정보를 저장할 PageInfo 클래스 정의(DTO 역할)
public class PageInfo {
	private int listCount; // 총 게시물 수
	private int pageListLimit; // 페이지 당 표시할 페이지 번호 갯수
	private int maxPage; // 전체 페이지 수(최대 페이지 번호)
	private int startPage; // 시작 페이지 번호
	private int endPage; // 끝 페이지 번호
	
	// 기본 생성자 정의
	public PageInfo() {}

	// 파라미터 생성자 정의
	public PageInfo(int listCount, int pageListLimit, int maxPage, int startPage, int endPage) {
		this.listCount = listCount;
		this.pageListLimit = pageListLimit;
		this.maxPage = maxPage;
		this.startPage = startPage;
		this.endPage = endPage;
	}

	
	public int getListCount() {
		return listCount;
	}

	public void setListCount(int listCount) {
		this.listCount = listCount;
	}

	public int getPageListLimit() {
		return pageListLimit;
	}

	public void setPageListLimit(int pageListLimit) {
		this.pageListLimit = pageListLimit;
	}

	public int getMaxPage() {
		return maxPage;
	}

	public void setMaxPage(int maxPage) {
		this.maxPage = maxPage;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	
	@Override
	public String toString() {
		return "PageInfo [listCount=" + listCount + ", pageListLimit=" + pageListLimit + ", maxPage=" + maxPage
				+ ", startPage=" + startPage + ", endPage=" + endPage + "]";
	}
	
	
}
