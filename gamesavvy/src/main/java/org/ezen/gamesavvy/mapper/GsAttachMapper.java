package org.ezen.gamesavvy.mapper;

import java.util.List;

import org.ezen.gamesavvy.domain.GsAttachVO;

//게시판에서 사용하는 첨부파일 처리 인터페이스 Mapper
public interface GsAttachMapper {
	
	//GsAttachVO객체를 테이블에 생성 (insert)
	public void insert(GsAttachVO vo);
	
	//pk인 uuid로 지정된 첨부 파일 레코드 삭제
	public void delete(String uuid);
	
	//게시글 번호 bno에 속하는 첨부물 리스트 반환 , 첨부파일의 수정이 없기 때문에 게시물 번호로 첨부파일을 찾음
	public List<GsAttachVO> findByBno(Long bno);
	
	//특정 게시글에 속하는 첨부 파일 모두 제거
	public void deleteAll(Long bno);
	
	//어제 날짜의 첨부 파일 반환 (Task)
	//public List<GsAttachVO> getOldFiles();
}
