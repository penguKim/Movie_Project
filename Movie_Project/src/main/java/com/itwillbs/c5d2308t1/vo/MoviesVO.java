package com.itwillbs.c5d2308t1.vo;


public class MoviesVO {
	
	// 영화 코드
	private int movie_id;
	// 영화 제목
	private String movie_title;
	// 제작 국가
	private String movie_nation;
	// 감독명
	private String movie_director;
	// 배우명
	private String movie_actor;
	// 장르
	private String movie_genre;
	// 관람등급
	private String movie_rating;
	// 줄거리
	private String movie_plot;
	// 상영 시작일
	private String movie_release_date;
	// 상영 종료일
	private String movie_close_date;
	// 상영시간
	private int movie_runtime;
	// 포스터 주소
	private String movie_poster;
	// 트레일러 주소
	private String movie_trailer;
	// 총 관람객 수
	private int movie_audience;
	// 개봉 상태
	private int movie_status;
	
	public int getMovie_id() {
		return movie_id;
	}
	public void setMovie_id(int movie_id) {
		this.movie_id = movie_id;
	}
	public String getMovie_title() {
		return movie_title;
	}
	public void setMovie_title(String movie_title) {
		this.movie_title = movie_title;
	}
	public String getMovie_nation() {
		return movie_nation;
	}
	public void setMovie_nation(String movie_nation) {
		this.movie_nation = movie_nation;
	}
	public String getMovie_director() {
		return movie_director;
	}
	public void setMovie_director(String movie_director) {
		this.movie_director = movie_director;
	}
	public String getMovie_actor() {
		return movie_actor;
	}
	public void setMovie_actor(String movie_actor) {
		this.movie_actor = movie_actor;
	}
	public String getMovie_genre() {
		return movie_genre;
	}
	public void setMovie_genre(String movie_genre) {
		this.movie_genre = movie_genre;
	}
	public String getMovie_rating() {
		return movie_rating;
	}
	public void setMovie_rating(String movie_rating) {
		this.movie_rating = movie_rating;
	}
	public String getMovie_plot() {
		return movie_plot;
	}
	public void setMovie_plot(String movie_plot) {
		this.movie_plot = movie_plot;
	}
	public String getMovie_release_date() {
		return movie_release_date;
	}
	public void setMovie_release_date(String movie_release_date) {
		this.movie_release_date = movie_release_date;
	}
	public String getMovie_close_date() {
		return movie_close_date;
	}
	public void setMovie_close_date(String movie_close_date) {
		this.movie_close_date = movie_close_date;
	}
	public int getMovie_runtime() {
		return movie_runtime;
	}
	public void setMovie_runtime(int movie_runtime) {
		this.movie_runtime = movie_runtime;
	}
	public String getMovie_poster() {
		return movie_poster;
	}
	public void setMovie_poster(String movie_poster) {
		this.movie_poster = movie_poster;
	}
	public String getMovie_trailer() {
		return movie_trailer;
	}
	public void setMovie_trailer(String movie_trailer) {
		this.movie_trailer = movie_trailer;
	}
	public int getMovie_audience() {
		return movie_audience;
	}
	public void setMovie_audience(int movie_audience) {
		this.movie_audience = movie_audience;
	}
	public int getMovie_status() {
		return movie_status;
	}
	public void setMovie_status(int movie_status) {
		this.movie_status = movie_status;
	}
	
	@Override
	public String toString() {
		return "MoviesVO [movie_id=" + movie_id + ", movie_title=" + movie_title + ", movie_nation=" + movie_nation
				+ ", movie_director=" + movie_director + ", movie_actor=" + movie_actor + ", movie_genre=" + movie_genre
				+ ", movie_rating=" + movie_rating + ", movie_plot=" + movie_plot + ", movie_release_date="
				+ movie_release_date + ", movie_close_date=" + movie_close_date + ", movie_runtime=" + movie_runtime
				+ ", movie_poster=" + movie_poster + ", movie_trailer=" + movie_trailer + ", movie_audience="
				+ movie_audience + ", movie_status=" + movie_status + ", getMovie_id()=" + getMovie_id()
				+ ", getMovie_title()=" + getMovie_title() + ", getMovie_nation()=" + getMovie_nation()
				+ ", getMovie_director()=" + getMovie_director() + ", getMovie_actor()=" + getMovie_actor()
				+ ", getMovie_genre()=" + getMovie_genre() + ", getMovie_rating()=" + getMovie_rating()
				+ ", getMovie_plot()=" + getMovie_plot() + ", getMovie_release_date()=" + getMovie_release_date()
				+ ", getMovie_close_date()=" + getMovie_close_date() + ", getMovie_runtime()=" + getMovie_runtime()
				+ ", getMovie_poster()=" + getMovie_poster() + ", getMovie_trailer()=" + getMovie_trailer()
				+ ", getMovie_audience()=" + getMovie_audience() + ", getMovie_status()=" + getMovie_status()
				+ ", getClass()=" + getClass() + ", hashCode()=" + hashCode() + ", toString()=" + super.toString()
				+ "]";
	}
	
	
}
