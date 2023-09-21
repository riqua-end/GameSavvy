package org.ezen.gamesavvy.service;

import java.util.List;

import org.ezen.gamesavvy.domain.Criteria;
import org.ezen.gamesavvy.domain.GamesavvyVO;
import org.ezen.gamesavvy.domain.MemberVO;
import org.ezen.gamesavvy.domain.ReplyVO;
import org.ezen.gamesavvy.mapper.AdminMapper;
import org.ezen.gamesavvy.mapper.GamesavvyMapper;
import org.ezen.gamesavvy.mapper.GsAttachMapper;
import org.ezen.gamesavvy.mapper.ReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	AdminMapper amapper;
	
	@Autowired
	ReplyMapper rmapper;
	
	@Autowired
	GamesavvyMapper boardmapper;
	
	@Autowired
	GsAttachMapper atmapper;
	
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
		
		// 댓글 수 업데이트 삭제
	    List<ReplyVO> replies = rmapper.getRepliesByReplyer(userid); // 해당 회원이 작성한 댓글 목록 가져오기
	    for (ReplyVO reply : replies) {
	        boardmapper.updateReplyCnt(reply.getBno(), -1); // 댓글 삭제 시 -1
	    }
		
	    // GS_ATTACH 테이블에서 해당 회원의 첨부 파일을 모두 삭제
	    List<String> uuidsToDelete = amapper.getUuidByUserId(userid); // 해당 회원의 첨부 파일 uuid 목록 가져오기
	    for (String uuid : uuidsToDelete) {
	        amapper.deleteGsAttach(uuid); // 각각의 첨부 파일 삭제
	    }
		// 연관 데이터 삭제 순서: GS_ATTACH, LIKE_TEST, TEST_REPLY, TEST_BOARD, TEST_MEMBER_AUTH
		amapper.deleteLikes(userid);
		amapper.deleteBoardByWriter(userid);
	    amapper.deleteMemberAuth(userid);
	    amapper.deleteMember(userid);
	    amapper.deleteReplyByReplyer(userid);
	    
	}
	
	//관리자 게시판 관리 페이지 삭제
	@Transactional
	@Override
	public void removeList(Long bno) {
		// 연관 데이터 삭제 순서: 
		
		atmapper.deleteAll(bno);
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
