package com.itwillbs.c5d2308t1.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.c5d2308t1.mapper.AdminMapper;
import com.itwillbs.c5d2308t1.vo.CsVO;

@Service
public class AdminService {

	@Autowired
	AdminMapper mapper;
	
	// 분실물 문의 관리 게시판 조회 작업 요청
	public List<CsVO> getLostnfoundList() {
		return mapper.selectLostnfoundList();
	}

	// 분실문 문의 관리 게시판 상세 조회 작업 요청
	public CsVO getlostnfound(CsVO cs) {
		return mapper.selectLostnfound(cs);
	}
	
	// 분실물 문의 답변 등록 작업 요청
	public int LostnfoundReply(CsVO cs) {
		return mapper.updateLnfReply(cs);
	}
	
	// 분실물 문의 답변 삭제 작업 요청
	public int lostnfoundDlt(CsVO cs) {
		return mapper.updateLnfDlt(cs);
	}
	
	// 분실물 페이징 처리를 위한 게시물 개수 조회 작업 요청
	public int getlostnfoundListCount() {
		return mapper.selectLostnfoundListCount();
	}

}
