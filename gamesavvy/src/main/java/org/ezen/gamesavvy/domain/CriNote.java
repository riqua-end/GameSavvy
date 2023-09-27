package org.ezen.gamesavvy.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
public class CriNote {
	
	private int pageNum;  //페이지 번호
	private int amount;  //한 페이지의 게시글 갯수
	
	private String userid;
	
	public CriNote() {
		this(1,10);
	}
	
	public CriNote(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	public String getListLink() {
		
		UriComponentsBuilder builder = UriComponentsBuilder
				.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.amount)
				.queryParam("userid", this.getUserid());
		
		return builder.toUriString();
		
	}
}
