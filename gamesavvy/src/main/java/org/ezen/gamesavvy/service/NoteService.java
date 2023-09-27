package org.ezen.gamesavvy.service;

import java.util.List;

import org.ezen.gamesavvy.domain.CriNote;
import org.ezen.gamesavvy.domain.NoteVO;

public interface NoteService {
	
	public List<NoteVO> getListPaging(CriNote cn);
	
}
