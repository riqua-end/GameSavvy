package org.ezen.gamesavvy.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class NotePageDTO {
	
	private int startPage;
	private int endPage;
	private boolean prev, next;
	
	private int total;
	private CriNote cn;
	
	public NotePageDTO(CriNote cn, int total) {
		
		this.cn = cn;
		this.total = total;
		
		this.endPage = (int)(Math.ceil(cn.getPageNum() / 10.0)) * 10;
		this.startPage = this.endPage - 9;
		
		int realEnd = (int)(Math.ceil((total * 1.0) / cn.getAmount()));
		
		if(realEnd <= this.endPage) {
			this.endPage = realEnd;
		}
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
		
	}
}
