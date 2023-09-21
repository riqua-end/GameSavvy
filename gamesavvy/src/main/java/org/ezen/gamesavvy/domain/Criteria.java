package org.ezen.gamesavvy.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
public class Criteria {
	
	private int pageNum;  //페이지 번호
	private int amount;  //한 페이지의 게시글 갯수
	
	//검색 기능 추가
	private String type;
	private String keyword;
	
	// 추가된 검색 조건
	private int gs_type;
	
	public Criteria() { // controller list에 cri값이 전달 안될시 초기값
		this(1,10);
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	//문자열 type을 배열로 변환
	public String[] getTypeArr() {
		
		return type == null ? new String[] {} : type.split("");
		//type은 문자열로 공백없이("TWC") 오는데 split하면 배열 {T,W,C}
	}
	
	// Criteria멤버변수 4개를 하늬 쿼리문자열 형태로 만들어 줌 (?파라메터이름=값&파라메터이름=값
	public String getListLink() {
		
		UriComponentsBuilder builder = UriComponentsBuilder
				.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount())
				.queryParam("type", this.getType())
				.queryParam("keyword", this.getKeyword())
				.queryParam("gs_type", this.getGs_type());
		
		return builder.toUriString();
		
	}
	
}
