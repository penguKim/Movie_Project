package com.itwillbs.c5d2308t1.vo;

import lombok.Data;

@Data
public class LikesVO {
	private int like_id; // 좋아요 인조키
	private String member_id;
	private int movie_id;
}
