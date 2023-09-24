package org.ezen.gamesavvy.service;

import java.util.List;

import org.ezen.gamesavvy.domain.MemberProfileDTO;

public interface ProfileService {
	
	void uploadProfileImage(MemberProfileDTO  attachDTO) throws Exception;
	void deleteProfileImage(String uuid) throws Exception;
    
    public List<MemberProfileDTO> getAttachList(String userid);
	
}
