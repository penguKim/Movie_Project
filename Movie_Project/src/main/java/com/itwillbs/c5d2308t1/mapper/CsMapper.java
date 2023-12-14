package com.itwillbs.c5d2308t1.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.c5d2308t1.vo.CsVO;

@Mapper
public interface CsMapper {
	

	// 고객센터 문의글 등록 - 추상메서드 정의
	int insertBoard(CsVO cs);

	// 고객센터 자주묻는질문 조회 - 추상메서드 정의
	List<CsVO> selectFaqList();
	List<CsVO> selectFaqList(int startRow, int listLimit);
	
	// 고객센터 자주묻는질문 목록별 조회 - 추상메서드 정의
	List<CsVO> selectFaqDetail(String cs_type_detail);
	
	// 고객센터 자주묻는질문 갯수 조회 - 추상메서드 정의
	Integer selectFaqListCount();
	
	// 고객센터 공지사항 조회 - 추상메서드 정의
	List<CsVO> selectNoticeList();
	List<CsVO> selectNoticeList(int startRow, int listLimit);

	// 고객센터 공지사항 갯수 조회 - 추상메서드 정의
	Integer selectNoticeListCount();


}
