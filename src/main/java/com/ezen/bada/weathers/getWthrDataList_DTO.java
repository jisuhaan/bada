package com.ezen.bada.weathers;

import java.util.Set;

public class getWthrDataList_DTO {
	String tm; // 측정일
	String avgTa; // 평균 온도
	String minTa; // 최저 온도
	String maxTa; // 최고 온도
	String sumRn; // 일강수량
	String avgWs; // 풍속
	String avgRhm; // 습도
	String avgTca; // 전운량
	String iscs; // 박무
	Set<String> ptySet; // 기상 형태를 모두 저장한 배열
	
	public getWthrDataList_DTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public getWthrDataList_DTO(String tm, String avgTa, String minTa, String maxTa, String sumRn, String avgWs,
			String avgRhm, String avgTca, String iscs, Set<String> ptySet) {
		super();
		this.tm = tm;
		this.avgTa = avgTa;
		this.minTa = minTa;
		this.maxTa = maxTa;
		this.sumRn = sumRn;
		this.avgWs = avgWs;
		this.avgRhm = avgRhm;
		this.avgTca = avgTca;
		this.iscs = iscs;
		this.ptySet = ptySet;
	}

	public String getTm() {
		return tm;
	}

	public void setTm(String tm) {
		this.tm = tm;
	}

	public String getAvgTa() {
		return avgTa;
	}

	public void setAvgTa(String avgTa) {
		this.avgTa = avgTa;
	}

	public String getMinTa() {
		return minTa;
	}

	public void setMinTa(String minTa) {
		this.minTa = minTa;
	}

	public String getMaxTa() {
		return maxTa;
	}

	public void setMaxTa(String maxTa) {
		this.maxTa = maxTa;
	}

	public String getSumRn() {
		return sumRn;
	}

	public void setSumRn(String sumRn) {
		this.sumRn = sumRn;
	}

	public String getAvgWs() {
		return avgWs;
	}

	public void setAvgWs(String avgWs) {
		this.avgWs = avgWs;
	}

	public String getAvgRhm() {
		return avgRhm;
	}

	public void setAvgRhm(String avgRhm) {
		this.avgRhm = avgRhm;
	}

	public String getAvgTca() {
		return avgTca;
	}

	public void setAvgTca(String avgTca) {
		this.avgTca = avgTca;
	}

	public String getIscs() {
		return iscs;
	}

	public void setIscs(String iscs) {
		this.iscs = iscs;
	}

	public Set<String> getPtySet() {
		return ptySet;
	}

	public void setPtySet(Set<String> ptySet) {
		this.ptySet = ptySet;
	}

	@Override
	public String toString() {
		return "getWthrDataList_DTO [tm=" + tm + ", avgTa=" + avgTa + ", minTa=" + minTa + ", maxTa=" + maxTa
				+ ", sumRn=" + sumRn + ", avgWs=" + avgWs + ", avgRhm=" + avgRhm + ", avgTca=" + avgTca + ", iscs="
				+ iscs + ", ptySet=" + ptySet + "]";
	}
	
	
	
}
