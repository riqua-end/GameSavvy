package org.ezen.gamesavvy.service;

import java.util.List;

import org.ezen.gamesavvy.domain.Criteria;
import org.ezen.gamesavvy.domain.GamesavvyVO;
import org.ezen.gamesavvy.domain.MemberVO;
import org.ezen.gamesavvy.mapper.AdminMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	AdminMapper amapper;
	
	//관리자 페이지 회원 목록
	@Override
	public List<MemberVO> getAllMember(Criteria cri){
		
		log.info("getAll Members With Paging..." + cri);
		
		return amapper.getAllMembersWithPaging(cri);
	}
	
	//관리자 페이지 게시판 목록
	//페이지 처리
	@Override
	public List<GamesavvyVO> getAllList(Criteria cri){
		
		log.info("getAll List With Paging..." + cri);
		
		return amapper.getAllListWithPaging(cri);
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
	// 게시글 총 갯수
	@Override
	public int getListTotal(Criteria cri) {
		
		log.info("getListTotal...." + cri);
		
		return amapper.getListTotalCount(cri);
		
	}
	// 회원 총 갯수
	@Override
	public int getMembersTotal(Criteria cri) {
		
		log.info("getListTotal...." + cri);
		
		return amapper.getMembersTotalCount(cri);
		
	}

}
