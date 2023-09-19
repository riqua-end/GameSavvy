package org.ezen.gamesavvy.domain;

import lombok.Data;

@Data
//gs_attach 테이블과 매핑되는 VO클래스
public class GsAttachVO {
	
	private String uuid; // PK키
	private String uploadPath;
	private String fileName;
	private boolean fileType;
	
	private Long bno; // gs_board FK키 , 해당 게시물의 bno를 저장
}
