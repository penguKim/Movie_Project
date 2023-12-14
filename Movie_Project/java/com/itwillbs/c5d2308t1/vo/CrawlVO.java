package com.itwillbs.c5d2308t1.vo;

public class CrawlVO {
	private String title;
	private String poster;
	private String percent;
	private String release;
	private String detailNum;
	private String plot;
	
	public CrawlVO() {}

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

	public String getDetailNum() {
		return detailNum;
	}

	public void setDetailNum(String detailNum) {
		this.detailNum = detailNum;
	}

	public String getPlot() {
		return plot;
	}

	public void setPlot(String plot) {
		this.plot = plot;
	}

	@Override
	public String toString() {
		return "CrawlVO [title=" + title + ", poster=" + poster + ", percent=" + percent + ", release=" + release
				+ ", detailNum=" + detailNum + ", plot=" + plot + ", getTitle()=" + getTitle() + ", getPoster()="
				+ getPoster() + ", getPercent()=" + getPercent() + ", getRelease()=" + getRelease()
				+ ", getDetailNum()=" + getDetailNum() + ", getPlot()=" + getPlot() + ", getClass()=" + getClass()
				+ ", hashCode()=" + hashCode() + ", toString()=" + super.toString() + "]";
	}


}
