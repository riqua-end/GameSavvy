package org.ezen.gamesavvy.service;


import java.util.List;

import org.ezen.gamesavvy.domain.AuthVO;
import org.ezen.gamesavvy.domain.Criteria;
import org.ezen.gamesavvy.domain.GamesavvyVO;
import org.ezen.gamesavvy.domain.MemberVO;
import org.ezen.gamesavvy.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
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
	
	// 회원 정보 수정.
	@Override
    public void modifyMember(MemberVO member, String newPassword) {
        String bcryptNewPassword = passwordEncoder.encode(newPassword);
        member.setUserpw(bcryptNewPassword);
        membermapper.updateMember(member);
    }
	
	// 로그인한 사용자 게시판 불러오기 페이징 처리.
	@Override
	public List<GamesavvyVO> getUser(Criteria cri, String userid) {
		
		log.info("get..." + userid);
		
		return membermapper.readUser(cri, userid);
		
	}
	
	// 로그인한 사용자 게시판 수.
	@Override
	public int getUserTotal(Criteria cri, String userid) {
		
		log.info("getTotal..." + cri);
		
		return membermapper.getUserTotalCount(cri, userid);
		
	}

}
