package org.ezen.gamesavvy.service;

import java.util.List;

import org.ezen.gamesavvy.domain.CriNote;
import org.ezen.gamesavvy.domain.NoteVO;
import org.ezen.gamesavvy.mapper.NoteMapper;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class NoteServiceImpl implements NoteService {
	
	private NoteMapper nmapper;
	
	@Override
	public List<NoteVO> getListPaging(CriNote cn) {
		
		log.info("NoteList..." + cn);
		
		return nmapper.getListPaging(cn);
		
	}

}
