package org.ezen.gamesavvy.service;

import java.util.List;

import org.ezen.gamesavvy.domain.GamesavvyVO;
import org.ezen.gamesavvy.domain.MemberVO;
import org.ezen.gamesavvy.mapper.AdminMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	AdminMapper amapper;
	
	//관리자 페이지 회원 목록
	@Override
	public List<MemberVO> getAllMember(){
		return amapper.getAllMembers();
	}
	
	//관리자 페이지 게시판 목록
	@Override
	public List<GamesavvyVO> getAllList(){
		return amapper.getAllList();
	}

	//관리자 회원관리 페이지 회원 강제 탈퇴
	@Transactional
	@Override
	public void removeMember(String userid) {
		// 연관 데이터 삭제 순서: LIKE_TEST, TEST_REPLY, TEST_BOARD, TEST_MEMBER_AUTH
		//amapper.deleteLikes(userid);
		//amapper.deleteReplyByWriter(userid);
		amapper.deleteBoardByWriter(userid);
	    amapper.deleteMemberAuth(userid);
	    amapper.deleteMember(userid);
	}
	
	//관리자 게시판 관리 페이지 삭제
	@Transactional
	@Override
	public void removeList(Long bno) {
		// 연관 데이터 삭제 순서: 

		amapper.deleteBoardByBno(bno);
		
	}
	
}
