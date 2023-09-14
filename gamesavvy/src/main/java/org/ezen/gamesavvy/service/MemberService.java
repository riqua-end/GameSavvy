package org.ezen.gamesavvy.service;


import org.ezen.gamesavvy.domain.MemberVO;

public interface MemberService {
	
	//회원가입
	public void join(MemberVO member);
	
	public int joinRegister(MemberVO member);
	
	public String joinIdCheck(String userid);
	
	// 현재 로그인한 사용자의 정보를 가져옴
	public MemberVO getMemberByUsername(String userid);

	public void removeMember(String userid);

	void modifyMember(MemberVO member, String newPassword);

	
}
