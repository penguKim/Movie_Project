package com.itwillbs.c5d2308t1.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.c5d2308t1.vo.CsVO;

@Mapper
public interface AdminMapper {

	// ================ 분실물 게시판 ================
	// 분실물 문의 관리 게시판 조회 작업
	List<CsVO> selectLostnfoundList();

	// 분실문 문의 관리 게시판 상세 조회 작업
	CsVO selectLostnfound(CsVO cs);

	// 분실물 문의 답변 등록 작업
	int updateLnfReply(CsVO cs);

	// 분실물 문의 답변 삭제 작업
	int updateLnfDlt(CsVO cs);

	// 분실물 페이징 처리를 위한 게시물 개수 조회 작업
	int selectLostnfoundListCount();

}
