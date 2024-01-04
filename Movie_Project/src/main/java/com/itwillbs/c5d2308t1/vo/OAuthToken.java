package com.itwillbs.c5d2308t1.vo;

import lombok.Data;

@Data
public class OAuthToken {
	private String access_token;
	private String token_type;
	private String refresh_token;
	private int expires_in;
	private int scope;
	private int refresh_token_expires_in;
}
