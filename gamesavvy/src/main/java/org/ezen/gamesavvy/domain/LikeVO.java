package org.ezen.gamesavvy.domain;

import java.util.Date;

import lombok.Data;

@Data
public class LikeVO {
	
	//좋아요 기능 VO
	private Long likeId;	//좋아요 정보의 고유한 식별자로서 기본키인 like_id와 매핑
	private String userId;	//좋아요를 누른 사용자의 고유한 식별자로서 외래키 fk user_id와 매핑
	private Long boardId;	//좋아요를 누른 게시글의 고유한 식별자로서 외래키 fk board_id와 매핑
	private Date likeDate;	//좋아요를 누른 날짜 like_date와 매핑
	private int likeStatus;
}
