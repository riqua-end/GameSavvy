package org.ezen.gamesavvy.mapper;

import java.util.List;

import org.ezen.gamesavvy.domain.MemberProfileDTO;

public interface ProfileImgMapper {
	
	void insert(MemberProfileDTO attachVO);
	int delete(String uuid);
	
	public List<MemberProfileDTO> findByUserid(String userid);
	
	void deleteAll(String userid);
	
}
