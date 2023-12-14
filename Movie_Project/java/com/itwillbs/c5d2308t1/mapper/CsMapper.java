package com.itwillbs.c5d2308t1.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.c5d2308t1.vo.CsVO;

@Mapper
public interface CsMapper {
	
	// 고객센터 문의글 등록 - 추상메서드 정의
	int insertBoard(CsVO cs);

	// 고객센터 자주묻는질문 조회 - 추상메서드 정의
	List<CsVO> selectFqaList();
	
	// 고객센터 공지사항 조회 - 추상메서드 정의
	List<CsVO> selectNoticeList();

}
