package org.ezen.gamesavvy.mapper;


import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.ezen.gamesavvy.domain.AuthVO;
import org.ezen.gamesavvy.domain.Criteria;
import org.ezen.gamesavvy.domain.GamesavvyVO;
import org.ezen.gamesavvy.domain.MemberVO;

public interface MemberMapper {
	
	//회원 가입
	public void join(MemberVO member);
	
	//1:N 의 권한 정보를 갖는 MemberVO객체를 반환하는 메서드
	public MemberVO read(String userid);
	
	//권한 등록
	public int memberAuth(AuthVO aVO);
	
	// 사용자 이름으로 회원 정보 조회
    MemberVO getMemberByUsername(@Param("userid") String userid);
  	
  	// 회원 정보 수정.
  	public void updateMember(MemberVO member);
  	
  	// 로그인한 사용자 게시글 불러오기 페이징 처리.
  	public List<GamesavvyVO> readUser(@Param("cri") Criteria cri, @Param("userid") String userid);
  	
  	// 사용자 작성한 게시글 수.
  	public int getUserTotalCount(@Param("cri") Criteria cri, @Param("userid") String userid);
}
