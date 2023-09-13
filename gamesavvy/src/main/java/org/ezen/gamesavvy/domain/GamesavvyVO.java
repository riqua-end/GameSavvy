package org.ezen.gamesavvy.domain;

import java.util.Date;

import lombok.Data;

@Data
public class GamesavvyVO {
	
	private Long bno; // 테이블 번호
	private String title; // 테이블 제목
	private String content; // 테이블 내용
	private String username; // 테이블 작성자 이름
	private Date regdate; // 테이블 작성날짜
	
	//댓글 수
	private int replycnt;
	
}
