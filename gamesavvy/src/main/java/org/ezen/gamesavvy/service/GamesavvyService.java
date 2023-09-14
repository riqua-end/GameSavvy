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
	
	//페이지 처리한 리스트
	public List<GamesavvyVO> getList(Criteria cri);
	
	//게시글 총 갯수
	public int getTotal(Criteria cri);
	
}
