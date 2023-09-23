package org.ezen.gamesavvy.mapper;

import java.util.List;

import org.ezen.gamesavvy.domain.Criteria;
import org.ezen.gamesavvy.domain.GamesavvyVO;
import org.ezen.gamesavvy.domain.MemberVO;

public interface AdminMapper {
	
/*================================= 관리자 회원 목록 =====================================*/
	//관리자 페이지 회원 목록
  	public List<MemberVO> getAllMembers();
  	
  	//관리자 페이지 회원 목록
  	public List<MemberVO> getAllMembersWithPaging(Criteria cri);
  	
  	//관리자 페이지 회원목록 총갯수.
  	public int getMembersTotalCount(Criteria cri);
  	
  	//관리자 페이지 회원 강제 탈퇴
  	public void deleteMember(String userid);
  	
  	//권한
  	public void deleteMemberAuth(String userid);
  	
  	//게시판
  	public void deleteBoardByWriter(String userid);
  	
  	//댓글
  	public void deleteReplyByReplyer(String userid);
  	
  	//추천
  	public void deleteLikes(String userid);
  	
  	//첨부파일 uuid값
  	public void deleteGsAttach(String userid);
  	
  	//첨부파일 uuid 목록 찾기.
  	public List<String> getUuidByUserId(String userid);
  	
/*====================================================================================*/
/*=============================== 관리자 게시판 목록 =====================================*/
  	//관리자 페이지 게시판 목록
  	public List<GamesavvyVO> getAllList();
  	
  	//관리자 페이지 게시판 목록
  	public List<GamesavvyVO> getAllListWithPaging(Criteria cri);
  	
  	//관리자 페이지 게시글 총갯수.
  	public int getListTotalCount(Criteria cri);
  	
  	//게시판 번호
  	public void deleteBoardByBno(Long bno);
  	
/*====================================================================================*/
  	
  	public void updateMember(MemberVO member);
  	
}
