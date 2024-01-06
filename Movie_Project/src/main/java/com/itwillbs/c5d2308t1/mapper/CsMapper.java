package com.itwillbs.c5d2308t1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.c5d2308t1.vo.CsVO;

@Mapper
public interface CsMapper {
	
	// 고객센터 메인에 자주묻는질문과 공지사항 출력
	List<CsVO> selectFaqMainList();
	List<CsVO> selectNoticeMainList();
	
	// 고객센터 자주묻는질문 조회 - 추상메서드 정의
	List<HashMap<String, Object>> selectFaqList(@Param("cs") CsVO cs, @Param("startRow") int startRow, @Param("listLimit") int listLimit, @Param("searchValue") String searchValue, @Param("buttonName") String buttonName);
	
	// 고객센터 공지사항 조회 - 추상메서드 정의
	List<HashMap<String, Object>> selectNoticeList(@Param("cs") CsVO cs, @Param("startRow") int startRow, @Param("listLimit") int listLimit, @Param("theater") int theater, @Param("searchValue") String searchValue);
	
	// 공지사항 항목별 목록 갯수 조회 - 추상메서드 정의
	int selectNoticeCount(@Param("cs") CsVO cs, @Param("theater") int theater, @Param("searchValue") String searchValue);
	
	// 자주묻는질문 항목별 목록 갯수 조회 - 추상메서드 정의
	int selectFaqCount(@Param("cs") CsVO cs, @Param("searchValue") String searchValue, @Param("buttonName") String buttonName);
	
	// 자주묻는질문 세부항목별 조회 - 추상메서드 정의
	List<CsVO> selectFaqDetail(@Param("cs") CsVO cs, @Param("buttonName") String buttonName);

	// 공지사항 상세페이지 보기
	HashMap<String, Object> selectNoticeDetail(CsVO cs);
	
	// 공지사항 상세페이지 이전글 다음글 제목 가져오기
	List<HashMap<String, Object>> selectNoticeSubject(CsVO cs);

	// 극장명 조회하여 지점명으로 출력
	List<HashMap<String, Object>> selectTheaterList();

	// 고객센터 문의글 등록 - 추상메서드 정의
	int insertBoard(CsVO cs);


}
