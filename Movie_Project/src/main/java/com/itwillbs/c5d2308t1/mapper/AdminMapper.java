package com.itwillbs.c5d2308t1.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.c5d2308t1.vo.CsVO;
import com.itwillbs.c5d2308t1.vo.PageDTO;

@Mapper
public interface AdminMapper {

	// ================ 분실물 게시판 ================
	// 분실물 문의 관리 게시판 조회 작업
//	List<CsVO> selectLostnfoundList(@Param(value = "startRow") int startRow, @Param(value = "listLimit")int listLimit);
	List<HashMap<String, Object>> selectLostnfoundList(PageDTO page);

	// 분실문 문의 관리 게시판 상세 조회 작업
	HashMap<String, Object> selectLostnfound(CsVO cs);

	// 분실물 문의 답변 등록 작업
	int updateLnfReply(CsVO cs);

	// 분실물 문의 답변 삭제 작업
	int updateLnfDlt(CsVO cs);

	// 분실물 페이징 처리를 위한 게시물 개수 조회 작업
	int selectLostnfoundListCount();

}
