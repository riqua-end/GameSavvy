package org.ezen.gamesavvy.service;


import java.util.List;

import org.ezen.gamesavvy.domain.MemberProfileDTO;
import org.ezen.gamesavvy.mapper.ProfileImgMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.log4j.Log4j;


@Service
@Log4j
public class ProfileServiceImpl implements ProfileService {
	
	@Autowired
	private ProfileImgMapper imgMapper;
	
	@Override
    @Transactional
    public void uploadProfileImage(MemberProfileDTO  attachVO) throws Exception {
        // 데이터베이스에 이미지 정보 추가
		imgMapper.insert(attachVO);

    }

	@Override
    @Transactional
    public void deleteProfileImage(String uuid) throws Exception {
		
		int result = imgMapper.delete(uuid);
		
		if(result > 0) {
			log.info("delete 성공 : " + uuid);
		}else {
			log.warn("delete 실패 : " + uuid);
		}
		
    }
	
	@Override
    public List<MemberProfileDTO> getAttachList(String userid) {
        return imgMapper.findByUserid(userid);
    }

}
