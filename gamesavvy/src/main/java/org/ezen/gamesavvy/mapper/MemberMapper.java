package org.ezen.gamesavvy.mapper;

import org.ezen.gamesavvy.domain.MemberVO;

public interface MemberMapper {
	
	public MemberVO read(String userid);
	
}
