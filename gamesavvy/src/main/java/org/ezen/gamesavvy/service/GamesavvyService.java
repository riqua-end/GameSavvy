package org.ezen.gamesavvy.service;

import java.util.List;

import org.ezen.gamesavvy.domain.Criteria;
import org.ezen.gamesavvy.domain.GamesavvyVO;
import org.ezen.gamesavvy.domain.GsAttachVO;

public interface GamesavvyService {
	
	//게시글 등록
	public void register(GamesavvyVO game);
	
	//특정번호 게시판 보기.
	public GamesavvyVO get(Long bno);
	
	//수정
	public boolean modify(GamesavvyVO game);
	
	//삭제
	public boolean remove(Long bno);
	
	// 각 게시판 타입별로 최대 5개의 게시글 가져오기
    List<GamesavvyVO> getTop5ByType(int gs_type);
	
	//페이지 미처리 리스트
	public List<GamesavvyVO> getLi();
	
	//페이지 처리한 리스트
	public List<GamesavvyVO> getList(Criteria cri);
	
	//공지사항
	public List<GamesavvyVO> notice();
	
	//게시글 총 갯수
	public int getTotal(Criteria cri);
	
	//게시글 조회수
	public int updateCnt(Long bno);
	
	//게시글 조회 화면 (get)에서 사용하는 첨부물 처리 추상메서드
	public List<GsAttachVO> getAttachList(Long bno);
	
	// =======================================================
	
	//추천수 증가
	public void increaseRecommendCount(Long bno);
	
	//추천수 감소
	public void decreaseRecommendCount(Long bno);
	
	//추천수 조회
	public int getRecommendCount(Long bno);
	
	//좋아요 추가
	public void addLike(Long bno, String username);
	
	//좋아요 제거
	public void removeLike(Long bno, String username);
	
	//해당 사용자가 해당 게시물을 추천했는지 확인
	public boolean isLikedByUser(Long bno, String username);
}
