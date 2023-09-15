package org.ezen.gamesavvy.service;

import java.util.List;

import org.ezen.gamesavvy.domain.GamesavvyVO;
import org.ezen.gamesavvy.domain.MemberVO;

public interface AdminService {
	
	public List<MemberVO> getAllMember();
	
	public List<GamesavvyVO> getAllList();
	
	public void removeMember(String userid);
	
	public void removeList(Long bno);
	
}
