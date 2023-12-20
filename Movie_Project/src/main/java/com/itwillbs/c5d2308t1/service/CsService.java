package com.itwillbs.c5d2308t1.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.c5d2308t1.mapper.CsMapper;
import com.itwillbs.c5d2308t1.vo.CsVO;

@Service
public class CsService {
	// 마이바티스를 통해 SQL 구문 처리를 담당할 XXXMapper.xml 파일과 연동되는
	// XXXMapper 객체(인터페이스)를 자동 주입받기 위해 @Autowired 어노테이션으로 멤버변수 선언
	@Autowired
	private CsMapper mapper;

	// cs 메인 페이지 자주묻는질문 목록 조회 요청
	public List<CsVO> getFaqMainList() {
		return mapper.selectFaqMainList();
	}
	
	// cs 메인 페이지 공지사항 목록 조회 요청
	public List<CsVO> getNoticeMainList() {
		return mapper.selectNoticeMainList();
	}
	
	// 자주묻는질문 공지사항 목록 조회 요청 및 페이징
	public List<CsVO> getCsList(CsVO cs, int startRow, int listLimit) {
		return mapper.selectCsList(cs, startRow, listLimit);
	}
	
	// 고객센터 항목별 목록 갯수 조회 요청
	public int getCsTypeListCount(CsVO cs) {
		return mapper.selectCsTypeCount(cs);
	}
	
	// 자주묻는질문 항목별로 모아보기 기능
	public List<CsVO> getFaqDetail(CsVO cs, String buttonName, int startRow, int listLimit) {
		return mapper.selectFaqDetail(cs, buttonName, startRow, listLimit);
	}
	
	// 자주묻는질문 항목별로 목록 개수 조회 요청
	public int getFaqDetailCount(CsVO cs, String buttonName) {
		return mapper.selectFaqDetailCount(cs, buttonName);
	}
	
	// 자주묻는질문 검색 기능
	public List<CsVO> getFaqSearch(String searchValue) {
		return mapper.selectFaqSearch(searchValue);
	}
	
	// 공지사항 검색기능
	public List<CsVO> getNoticeSearch(String theater_id, String searchValue) {
		return mapper.selectNoticeSearch(theater_id, searchValue);
	}

	// 공지사항 상세페이지 보기
	public CsVO csNoticeDetail(CsVO cs) {
		return mapper.selectNoticeDetail(cs);
	}

	// 극장 정보를 조회하여 문의글의 지점명 출력
	public List<HashMap<String, Object>> getTheaterList() {
		return mapper.selectTheaterList();
	}

	// 고객센터 문의글 등록
	public int registBoard(CsVO cs) {
		return mapper.insertBoard(cs);
	}




	
	
}
