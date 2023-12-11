package com.itwillbs.c5d2308t1.vo;

public class MovieVO {
	private String title;
	private String poster;
	private String percent;
	private String release;
	
	public MovieVO() {}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getPoster() {
		return poster;
	}

	public void setPoster(String poster) {
		this.poster = poster;
	}

	public String getPercent() {
		return percent;
	}

	public void setPercent(String percent) {
		this.percent = percent;
	}

	public String getRelease() {
		return release;
	}

	public void setRelease(String release) {
		this.release = release;
	}

	@Override
	public String toString() {
		return "MovieVO [title=" + title + ", poster=" + poster + ", percent=" + percent + ", release=" + release + "]";
	}
	
	
	
}
