package com.itwillbs.c5d2308t1.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.c5d2308t1.mapper.MoviesMapper;
import com.itwillbs.c5d2308t1.vo.LikesVO;
import com.itwillbs.c5d2308t1.vo.MoviesVO;
import com.itwillbs.c5d2308t1.vo.ReviewBoardVO;
import com.itwillbs.c5d2308t1.vo.ReviewsVO;

@Service
public class MoviesService {
	@Autowired
	MoviesMapper mapper;
	
	// DB에 저장된 영화 목록 리스트 조회 작업 요청
	public List<Map<String, String>> getMovieList(int sortType) {
		return mapper.selectMoviesList(sortType);
	}

	// 요청한 movie_id에 해당하는 영화정보 조회 작업 요청
	public HashMap<String, String> getMovieDetail(int movie_id) {
		return mapper.selectMovieDetail(movie_id);
	}

	
	// 찜하기 정보 가져오기
	public String getLike(LikesVO like) {
		// 찜한 영화인지 판별을 위해 DB에 조회 요청
		LikesVO dbLike = mapper.selectLike(like);
		
		if(dbLike != null) { // 해당 영화를 찜한 경우
			mapper.deleteLike(like); // 찜하기 삭제 수행
			return "true";
		} else { // 찜을 안한 경우
			mapper.insertLike(like); // 찜하기 등록 수행
			return "false";
		}
	}

	// 찜하기 등록
	public int registLike(LikesVO like) {
		return mapper.insertLike(like);
	}
	
	// 찜하기 삭제
	public int removeLike(LikesVO like) {
		return mapper.deleteLike(like);
	}

	// 해당 회원의 좋아요 정보 불러오기
	public List<LikesVO> getLikeList(String sId) {
		return mapper.selectLikeList(sId);
	}
	
	// 자바 코드로 API 정보 가져오는 테스트 ============================

	// List 객체 전달과 ON DUPLICATE KEY UPDATE 테스트
	public int registMovieCd(List<MoviesVO> movies) {
		return mapper.upsertMovieCd(movies);
	}
	// 모든 영화 가져오기
	public List<MoviesVO> getAllMovie() {
		return mapper.selectAllMovie();
	}
	
	public int insertMovie(MoviesVO movie) {
		System.out.println("insertMovie");
		return mapper.insertMovie(movie);
	}
	//리뷰 조회
	public List<ReviewsVO> getreview(Map<String, String> map) {
		return mapper.selectReview(map);
	}
	
	//리뷰작성
	public int registReview(String sId, String review_content, String movie_id) {
		return mapper.insertReviewBoard(sId, review_content, movie_id);
	}

}
