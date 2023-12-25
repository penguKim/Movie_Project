package com.itwillbs.c5d2308t1.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.c5d2308t1.mapper.LoginMapper;
import com.itwillbs.c5d2308t1.vo.*;
@Service
public class LoginService {
	
	@Autowired
	private LoginMapper mapper;

	public MemberVO getMember(MemberVO member) {
//		System.out.println("LoginService - getMember()" + member);
		return mapper.selectMember(member);
	}
	
	public int editMember(MemberVO member, String newEmail, String newPasswd) {
		return mapper.updateMember(member, newEmail, newPasswd);
	}

	public int getMovieListCount(String searchKeyword) {
		return mapper.selectMovieListCount(searchKeyword);
	}

	// 한 페이지에 표시할 영화 목록 조회 작업 요청
	public List<MoviesVO> getMovieList(String searchKeyword, PageDTO page) {
		return mapper.selectMovieList(searchKeyword, page);
	}

	// 예매 페이지에 있는 영화제목,예약시간,예약상태 조회 작업
	public Map<String, String> getReserveList() {
		
		return mapper.getReserveList();
	}

}
