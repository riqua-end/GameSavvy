package org.ezen.gamesavvy.mapper;

import java.util.List;

import org.ezen.gamesavvy.domain.CriNote;
import org.ezen.gamesavvy.domain.NoteVO;

public interface NoteMapper {
	
	public List<NoteVO> getListPaging(CriNote cn);
	
}
