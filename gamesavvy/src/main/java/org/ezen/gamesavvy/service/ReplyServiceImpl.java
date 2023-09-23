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

	    // 부모 댓글의 ID가 있을 경우에만 depth를 설정
	    if (vo.getParent_id() != null) {
	        // 부모 댓글을 조회하여 부모 댓글의 depth + 1 값을 자식 댓글의 depth로 설정
	        ReplyVO parentReply = mapper.read(vo.getParent_id());
	        if (parentReply != null) {
	            vo.setDepth(parentReply.getDepth() + 1);
	            log.info("Setting depth to: " + vo.getDepth());
	        }
	    } else {
	        // 부모 댓글이 아닌 경우 depth를 0으로 설정
	        vo.setDepth(0L);
	        log.info("Setting depth to 0");
	    }

	    // 댓글 수 처리 메서드
	    boardMapper.updateReplyCnt(vo.getBno(), 1);

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
