package org.ezen.gamesavvy.domain;

import lombok.Data;

@Data
public class MemberProfileDTO {

	private String fileName; //원본파일 이름
	private String uploadPath; //업로드 경로(YYYY/MM/DD만)
	private String uuid; //UUID값
	private boolean fileType;
	private String userid;
}
