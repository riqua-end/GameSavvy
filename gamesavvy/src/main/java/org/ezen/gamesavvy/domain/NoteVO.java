package org.ezen.gamesavvy.domain;

import java.util.Date;

import lombok.Data;

@Data
public class NoteVO {
	
	private Long rno;
	private String title;
	private String content;
	private String userid;
	private Date regdate;
	
}
