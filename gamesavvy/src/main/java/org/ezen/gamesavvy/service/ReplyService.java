package org.ezen.gamesavvy.service;

import java.util.List;

import org.ezen.gamesavvy.domain.Criteria;
import org.ezen.gamesavvy.domain.ReplyPageDTO;
import org.ezen.gamesavvy.domain.ReplyVO;

public interface ReplyService {
	
	public int register(ReplyVO vo);
	
	public ReplyVO get(Long rno);
	
	public int modify(ReplyVO vo);
	
	public int remove(Long rno);
	
	public List<ReplyVO> getList(Criteria cri, Long bno);
	
	//댓글의 수와 댓글의 목록을 같이 처리하는 DTO반환 메서드
	public ReplyPageDTO getListPage(Criteria cri, Long bno);
	
}
