package org.ezen.gamesavvy.domain;

import java.util.Date;
import java.util.List;

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
	
	//GamesavvyVO를 한번에 처리 하도록 List<GsAttachVO>를 추가
	private List<GsAttachVO> attachList;
	
	//다중게시판 gs_type
	private int gs_type;
	
	// 카테고리 분류
	private String categoryName;
	
	
	private List<MemberProfileDTO> profileImages;

}
