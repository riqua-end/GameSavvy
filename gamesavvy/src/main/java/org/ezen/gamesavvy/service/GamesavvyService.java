package org.ezen.gamesavvy.service;

import java.util.List;

import org.ezen.gamesavvy.domain.Criteria;
import org.ezen.gamesavvy.domain.GamesavvyVO;

public interface GamesavvyService {
	
	//게시글 등록
	public void register(GamesavvyVO game);
	
	//특정번호 게시판 보기.
	public GamesavvyVO get(Long bno);
	
	//수정
	public boolean modify(GamesavvyVO game);
	
	//삭제
	public boolean remove(Long bno);
	
	//페이지 미처리 리스트
	public List<GamesavvyVO> getLi();
	
	//페이지 처리한 리스트
	public List<GamesavvyVO> getList(Criteria cri);
	
	//게시글 총 갯수
	public int getTotal(Criteria cri);
	
	//게시글 조회수
	public int updateCnt(Long bno);
	
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
