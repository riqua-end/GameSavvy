package org.ezen.gamesavvy.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {
	
	private Long rno;
	private Long bno;
	private Long parent_id; // 부모 댓글의 ID 필드
	private Long depth;
	
	private String reply;
	private String replyer;
	private Date replyDate;
	private Date updatedate;
	
}
