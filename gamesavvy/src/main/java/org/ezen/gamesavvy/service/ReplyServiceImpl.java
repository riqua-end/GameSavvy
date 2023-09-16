package org.ezen.gamesavvy.service;

import java.util.List;

import org.ezen.gamesavvy.domain.Criteria;
import org.ezen.gamesavvy.domain.ReplyPageDTO;
import org.ezen.gamesavvy.domain.ReplyVO;
import org.ezen.gamesavvy.mapper.GamesavvyMapper;
import org.ezen.gamesavvy.mapper.ReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReplyServiceImpl implements ReplyService {
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private GamesavvyMapper boardMapper;
	
	@Transactional
	@Override
	public int register(ReplyVO vo) {
		
		log.info("register" + vo);
		
		boardMapper.updateReplyCnt(vo.getBno(), 1); //댓글수 처리 메서드
		
		return mapper.insert(vo);
	}
	
	@Override
	public ReplyVO get(Long rno) {
		
		log.info("get" + rno);
		return mapper.read(rno);
	}
	
	@Override
	public int modify(ReplyVO vo) {
		
		log.info("modify" + vo);
		return mapper.update(vo);
	}
	
	@Transactional
	@Override
	public int remove(Long rno) {
		
		log.info("remove" + rno);
		
		ReplyVO vo = mapper.read(rno);
		
		boardMapper.updateReplyCnt(vo.getBno(), -1); //댓글 삭제시 -1
		
		return mapper.delete(rno);
	}
	
	//댓글의 페이징 처리
	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) {
		
		log.info("get List" + bno);
		return mapper.getListWithPaging(cri, bno);
	}
	
	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long bno) {
		
		return new ReplyPageDTO(mapper.getCountByBno(bno), mapper.getListWithPaging(cri, bno));
	}
	
}
