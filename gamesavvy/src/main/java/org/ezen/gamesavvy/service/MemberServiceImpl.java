package org.ezen.gamesavvy.service;

import java.util.List;

import org.ezen.gamesavvy.domain.AuthVO;
import org.ezen.gamesavvy.domain.MemberVO;
import org.ezen.gamesavvy.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	MemberMapper membermapper;
	
	@Setter(onMethod_ = @Autowired)
	private BCryptPasswordEncoder passwordEncoder;
	
	@Override
	public void join(MemberVO member) {
		
		membermapper.join(member);
	}

	@Transactional
	@Override
	public int joinRegister(MemberVO member) {
		
		String userid = member.getUserid();
		
		String userpw = member.getUserpw();
		
		String bcryptPw = passwordEncoder.encode(userpw); //암호화된 패스워드
		
		member.setUserpw(bcryptPw);
		
		AuthVO auth = new AuthVO();
		
		auth.setAuth("ROLE_MEMBER"); // 권한은 일반 회원으로 초기화
		
		auth.setUserid(userid);
		
		membermapper.join(member);
		
		int result = membermapper.memberAuth(auth);
		
		return result;
	}

	@Override
	public String joinIdCheck(String userid) {
		
		MemberVO vo = membermapper.read(userid);
		
		String result = null;
		
		if(vo == null) {
			result = "success";
		}
		else {
			result = "failed";
		}
		
		return result;
		
	}

	// 사용자 이름으로 회원 정보 조회
	@Override
    public MemberVO getMemberByUsername(String userid) {
        return membermapper.getMemberByUsername(userid);
    }

	//관리자 페이지 회원 목록
	@Override
	public List<MemberVO> getAllMember(){
		return membermapper.getAllMembers();
	}

	//관리자 페이지 회원 강제 탈퇴
	@Transactional
	@Override
	public void removeMember(String userid) {
		// 연관 데이터 삭제 순서: LIKE_TEST, TEST_REPLY, TEST_BOARD, TEST_MEMBER_AUTH
		membermapper.deleteLikes(userid);
		membermapper.deleteReplyByWriter(userid);
		membermapper.deleteBoardByWriter(userid);
	    membermapper.deleteMemberAuth(userid);
	    membermapper.deleteMember(userid);
	}

	@Override
    public void modifyMember(MemberVO member, String newPassword) {
        String bcryptNewPassword = passwordEncoder.encode(newPassword);
        member.setUserpw(bcryptNewPassword);
        membermapper.updateMember(member);
    }

}
