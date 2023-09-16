package org.ezen.gamesavvy.domain;

import java.util.Date;

import lombok.Data;

@Data
public class GamesavvyVO {
	
	private Long bno; // 테이블 번호
	private String title; // 테이블 제목
	private String content; // 테이블 내용
	private String userid; // 테이블 작성자 이름
	private Date regdate; // 테이블 작성날짜
	private Date updatedate; // 테이블 수정날짜
	
	//댓글 수
	private int replycnt;
	
	//조회수
	private int cnt;
	
	//추천수
	private int recommendCount;
}
