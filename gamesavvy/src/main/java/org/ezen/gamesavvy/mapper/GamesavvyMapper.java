package org.ezen.gamesavvy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.ezen.gamesavvy.domain.Criteria;
import org.ezen.gamesavvy.domain.GamesavvyVO;

public interface GamesavvyMapper {
	
	//@Select("select * from gs_board where bno > 0")
	public List<GamesavvyVO> getList();
	
	// 페이지 관련 Criteria객체를 파라메터로 갖는 메서드
	public List<GamesavvyVO> getListWithPaging(Criteria cri);
	
	// pk값 bno에 들어가는 시퀀스 nextval값을 미리 알필요 없는 경우
	public void insert(GamesavvyVO game);
	
	// pk값 bno에 들어가는 시퀀스 nextval값을 미리 알필요 있는 경우
	public Integer insertSelectKey(GamesavvyVO game);
	
	// pk인 bno를 검색 조건으로 하여 일치하는 GamesavvyVO를 객체로 반환
	public GamesavvyVO read(Long bno);
	
	// 게시판에서 pk인 bno를 검색 조건으로 하여 일치하는 레코드를 삭제.
	public int delete(Long bno);
	
	// 게시판에서 수정한 내용 업데이트...
	public int update(GamesavvyVO game);
	
	// 게시물 총갯수 나중에 수정 필요할지도.. 
	public int getTotalCount(Criteria cri);
	
	// 게시판의 댓글 숫자 업데이트..
	//amount는 댓글등록시에는 1, 댓글 삭제시는 -1을 나타내는 파라메터
	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
	
}
