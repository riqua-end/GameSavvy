package org.ezen.gamesavvy.controller;

import java.util.List;

import org.ezen.gamesavvy.domain.CriNote;
import org.ezen.gamesavvy.domain.GamesavvyVO;
import org.ezen.gamesavvy.domain.MemberProfileDTO;
import org.ezen.gamesavvy.domain.NoteVO;
import org.ezen.gamesavvy.service.NoteService;
import org.ezen.gamesavvy.service.ProfileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("note")
@Log4j
public class NoteController {
	
	@Autowired
	private NoteService nservice;
	
	@Autowired
	private ProfileService profileService;
	
	@GetMapping("/note")
	public void list(CriNote cn, Model model) {
		
		List<NoteVO> NoteList = nservice.getListPaging(cn);
		
		// 각 사용자에게 프로필 이미지를 가져와 연결합니다
	    for (NoteVO board : NoteList) {
	        String userid = board.getUserid();
	        List<MemberProfileDTO> profileImages = profileService.getAttachList(userid);
	        board.setProfileImages(profileImages);
	    }
		
		model.addAttribute("NoteList..", NoteList);
		
		log.info("list...");
		
	}
	
	//조회화면에서 첨부 파일 처리
	@GetMapping(value = "/getProfileImages", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<MemberProfileDTO>> getProfileImages(String userid) {
	    log.info("프로필 이미지 userid : " + userid);
	    
	    List<MemberProfileDTO> profileImages = profileService.getAttachList(userid);
	    
	    return new ResponseEntity<>(profileImages, HttpStatus.OK);
	}
}
