package org.ezen.gamesavvy.service;


import java.util.List;

import org.ezen.gamesavvy.domain.Criteria;
import org.ezen.gamesavvy.domain.GamesavvyVO;
import org.ezen.gamesavvy.domain.MemberVO;

public interface MemberService {
	
	//회원가입
	public void join(MemberVO member);
	
	public int joinRegister(MemberVO member);
	
	public String joinIdCheck(String userid);
	
	// 현재 로그인한 사용자의 정보를 가져옴
	public MemberVO getMemberByUsername(String userid);
	
	// 회원 정보 수정.
	void modifyMember(MemberVO member, String newPassword);

	// 로그인한 사용자 게시글 불러오기 페이징 처리.
	public List<GamesavvyVO> getUser(Criteria cri, String userid);
	
	// 사용자가 작성한 게시글 수.
	public int getUserTotal(Criteria cri, String userid);
	
	// 사용자가 작성한 댓글 수.
	public int getReplyTotal(String userid);
}
