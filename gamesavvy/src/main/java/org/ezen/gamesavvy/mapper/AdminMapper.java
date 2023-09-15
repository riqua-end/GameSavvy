package org.ezen.gamesavvy.mapper;

import java.util.List;

import org.ezen.gamesavvy.domain.GamesavvyVO;
import org.ezen.gamesavvy.domain.MemberVO;

public interface AdminMapper {
	
	//관리자 페이지 회원 목록
  	public List<MemberVO> getAllMembers();
  	
  	//관리자 페이지 게시판 목록
  	public List<GamesavvyVO> getAllList();
  	
  	//관리자 페이지 회원 강제 탈퇴
  	public void deleteMember(String userid);
  	
  	//public void deleteLikes(String userid);

  	public void deleteMemberAuth(String userid);

  	public void deleteBoardByWriter(String userid);

  	//public void deleteReplyByWriter(String writer);
  	
  	public void deleteBoardByBno(Long bno);
  	
  	public void updateMember(MemberVO member);
	
}
