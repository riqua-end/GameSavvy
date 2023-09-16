package org.ezen.gamesavvy.mapper;


import org.apache.ibatis.annotations.Param;
import org.ezen.gamesavvy.domain.AuthVO;
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
    

  	
  	//관리자 페이지 회원 강제 탈퇴
  	public void deleteMember(String userid);

  	public void deleteLikes(String userid);

  	public void deleteMemberAuth(String userid);

  	public void deleteBoardByWriter(String writer);

  	public void deleteReplyByWriter(String writer);

  	public void updateMember(MemberVO member);
}
