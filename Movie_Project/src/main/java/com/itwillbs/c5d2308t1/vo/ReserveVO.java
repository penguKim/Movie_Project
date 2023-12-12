package com.itwillbs.c5d2308t1.vo;

public class ReserveVO {
	private String movie_title;
	private String theater_name;
	private String play_date;
	private String play_start_time;
	
	public String getMovie_title() {
		return movie_title;
	}
	public void setMovie_title(String movie_title) {
		this.movie_title = movie_title;
	}
	public String getTheater_name() {
		return theater_name;
	}
	public void setTheater_name(String theater_name) {
		this.theater_name = theater_name;
	}
	public String getPlay_date() {
		return play_date;
	}
	public void setPlay_date(String play_date) {
		this.play_date = play_date;
	}
	public String getPlay_start_time() {
		return play_start_time;
	}
	public void setPlay_start_time(String play_start_time) {
		this.play_start_time = play_start_time;
	}
	@Override
	public String toString() {
		return "ReserveVO [movie_title=" + movie_title + ", theater_name=" + theater_name + ", play_date=" + play_date
				+ ", play_start_time=" + play_start_time + "]";
	}
	
	
}