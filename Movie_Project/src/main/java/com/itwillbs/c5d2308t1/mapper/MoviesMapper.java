package com.itwillbs.c5d2308t1.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.ui.Model;

import com.itwillbs.c5d2308t1.vo.LikesVO;
import com.itwillbs.c5d2308t1.vo.MoviesVO;
import com.itwillbs.c5d2308t1.vo.ReviewBoardVO;
import com.itwillbs.c5d2308t1.vo.ReviewsVO;

@Mapper
public interface MoviesMapper {
	
	
	// DB에 저장된 영화 목록 리스트 조회 작업
	List<Map<String, Object>> selectMoviesList(int sortType);

	// 요청한 movie_id에 해당하는 영화정보 조회 작업 요청
	HashMap<String, String> selectMovieDetail(int movie_id);
	
	// 찜하기 정보 조회
	LikesVO selectLike(LikesVO like);
	
	// 찜하기 등록
	int insertLike(LikesVO like);
	
	// 찜하기 삭제
	int deleteLike(LikesVO like);
	
	// 해당 회원의 좋아요 정보 불러오기
	List<LikesVO> selectLikeList(String sId);
	// 자바 코드로 API 정보 가져오는 테스트 ============================
	// List 객체 전달과 ON DUPLICATE KEY UPDATE 테스트
	int upsertMovieCd(List<MoviesVO> movies);

	// 모든 영화 가져오기
	List<MoviesVO> selectAllMovie();
	
//	//영화 리뷰
//	int insertReviewBoard(ReviewBoardVO review1);

	int insertMovie(MoviesVO movie);

	// 스케쥴러에서 사용하는 일일 관객수 업데이트 메서드
	int updateMovieAudiAcc(MoviesVO movie);
	
//	//리뷰 작성
	int insertReviewBoard(@Param("sId")String sId, @Param("review_content")String review_content, @Param("movie_id")String movie_id);

	//리뷰 조회
	List<ReviewsVO> selectReview(ReviewsVO review);

	// 메인 페이지에 보여줄 트레일러 정보 가져오기
	List<MoviesVO> selectMovieTrailerList();

	List<Map<String, Object>> selectTheaterName();

	// 상세 페이지에 출력할 연령대 차트 데이터
	List<Map<String, Object>> selectAgeGroupList(int movie_id);

	// 영화 상세페이지에 사용할 성별 통계
	List<Map<String, Object>> selectGenderGroupList(int movie_id);
	
	// 종영작으로 수정하는 작업
	void updateMovieEndingStatus(Map<String, Object> movie);

	// 리뷰 조건 판별
	List<Map<String, Object>> selectReviewCheckList(Map<String, String> map);



}
