package org.ezen.gamesavvy.service;

import java.util.List;

import org.ezen.gamesavvy.domain.Criteria;
import org.ezen.gamesavvy.domain.GamesavvyVO;
import org.ezen.gamesavvy.domain.MemberVO;

public interface AdminService {
	
	//페이지 처리
	public List<MemberVO> getAllMember(Criteria cri);
	
	//회원 총 갯수
	public int getMembersTotal(Criteria cri);
	
	//페이지 처리
	public List<GamesavvyVO> getAllList(Criteria cri);
	
	//게시글 총 갯수
	public int getListTotal(Criteria cri);
	
	public void removeMember(String userid);
	
	public void removeList(Long bno);
	
}
