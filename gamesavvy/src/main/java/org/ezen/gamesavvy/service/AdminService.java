package org.ezen.gamesavvy.service;

import java.util.List;

import org.ezen.gamesavvy.domain.MemberVO;

public interface AdminService {
	
	public List<MemberVO> getAllMember();
	
	public void removeMember(String userid);
	
}
