package org.ezen.gamesavvy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.ezen.gamesavvy.domain.Criteria;
import org.ezen.gamesavvy.domain.ReplyVO;

public interface ReplyMapper {
	
	//댓글 등록
	public int insert(ReplyVO vo);
	
	//댓글 조회
	public ReplyVO read(Long bno);
	
	//댓글 삭제
	public int delete(Long bno);
	
	//댓글 수정
	public int update(ReplyVO reply);
	
	//댓글의 페이징처리
	public List<ReplyVO> getListWithPaging(
			@Param("cri") Criteria cri,
			@Param("bno") Long bno
	);
	
	//댓글 페이지 처리를 위한 댓글 개수
	public int getCountByBno(Long bno);
	
	//게시글 삭제시 댓글 모두 삭제
	public int deleteAll(Long bno);
	
}
