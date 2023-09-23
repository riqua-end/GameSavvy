package org.ezen.gamesavvy.service;

import java.util.List;

import org.ezen.gamesavvy.domain.Criteria;
import org.ezen.gamesavvy.domain.GamesavvyVO;
import org.ezen.gamesavvy.domain.GsAttachVO;
import org.ezen.gamesavvy.mapper.GamesavvyMapper;
import org.ezen.gamesavvy.mapper.GsAttachMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import lombok.extern.log4j.Log4j;


@Service
@Log4j
public class GamesavvyServiceImpl implements GamesavvyService {
	
	@Setter(onMethod_ = @Autowired)
	private GamesavvyMapper gmapper;
	
	@Autowired
	private GsAttachMapper attachMapper;
	
	//게시판 + 첨부 파일 처리
	//게시물의 등록과 첨부 파일의 등록은 양쪽 모두 insert가 진행되기 때문에 트랜잭션처리
	@Transactional
	@Override
	public void register(GamesavvyVO game) {
		
		log.info("register...." + game);
		
		// insertSelectKey 메서드를 호출하여 bno를 얻어옴
		gmapper.insertSelectKey(game);
		
		//첨부물이 없으면 return
		if (game.getAttachList() == null || game.getAttachList().size() <= 0) {
			return;
		}
		
		game.getAttachList().forEach(attach -> {
			
			attach.setBno(game.getBno());
			attachMapper.insert(attach);
		});
	}

	@Override
	public GamesavvyVO get(Long bno) {
		
		log.info("get..." + bno);
		
		return gmapper.read(bno);
		
	}
	
	//게시판 + 첨부파일 처리
	//첨부 파일은 수정이라는 개념이 없으므로 삭제 후 등록처리
	@Override
	public boolean modify(GamesavvyVO game) {
		
		log.info("modify...." + game);
		
		//게시글 bno에 해당되는 것을 모두 삭제
		attachMapper.deleteAll(game.getBno());
		
		boolean modifyResult = gmapper.update(game) == 1;
		
		if (modifyResult && game.getAttachList() != null && game.getAttachList().size() > 0) {
			
			game.getAttachList().forEach(attach -> {
				attach.setBno(game.getBno());
				attachMapper.insert(attach);
			});
		}
		
		return modifyResult;
		
	}
	
	//게시글 + 첨부파일 일괄 삭제
	@Override
	public boolean remove(Long bno) {
		
		log.info("remove..." + bno);
		
		//삭제시 bno를 외래키로 사용하는 자식 테이블부터 삭제
		attachMapper.deleteAll(bno);
		
		return gmapper.delete(bno) == 1;
		
	}
	
	// 각 게시판 타입별로 최대 5개의 게시글 가져오기
	@Override
    public List<GamesavvyVO> getTop5ByType(int gs_type) {
        // 해당 게시판 타입별로 최대 5개의 게시글을 가져오는 로직을 여기에 구현
        // 예를 들어, 데이터베이스에서 해당 타입의 최신 5개 게시글을 가져오도록 구현할 수 있습니다.
        return gmapper.getTop5ByTypeFromDatabase(gs_type); // 데이터베이스 쿼리를 실행하여 최신 5개 게시글 가져오기
    }
	
	//페이지 미처리
	@Override
	public List<GamesavvyVO> getLi() {
		
		log.info("get Li....");
		
		return gmapper.getLi();
		
	}
	
	//페이지 처리
	@Override
	public List<GamesavvyVO> getList(Criteria cri) {
		
		log.info("get List With Criteria...." + cri);
		
		return gmapper.getListWithPaging(cri);
		
	}
	
	//공지사항
	public List<GamesavvyVO> notice(){
		
		log.info("공지사항...");
		
		return gmapper.notice();
		
	}
	
	// 게시물 총갯수 나중에 수정 필요할지도.. 
	@Override
	public int getTotal(Criteria cri) {
		
		log.info("getTotal..." + cri);
		
		return gmapper.getTotalCount(cri);
		
	}
	
	//게시글 조회수 처리
	@Override
	public int updateCnt(Long bno) {
		return gmapper.updateCnt(bno);
	}
	
	//게시판 조회에서 사용하는 첨부물 처리 메서드
	@Override
	public List<GsAttachVO> getAttachList(Long bno) {
		
		log.info("get Attach list by bno : " + bno);
		
		return attachMapper.findByBno(bno);
	}
	
	
	/* ================== 게시글 추천 기능 구현 ==================== */
	
	//게시글 추천 증가
	@Override
	@Transactional
	public void increaseRecommendCount(Long bno) {
		
		log.info("게시글 추천");
		gmapper.updateRecommendCount(bno, 1);
	}
	
	//게시글 추천 감소
	@Override
	@Transactional
	public void decreaseRecommendCount(Long bno) {
		
		log.info("게시글 추천 취소");
		gmapper.updateRecommendCount(bno, -1);
	}
	
	//추천수 조회
	@Override
	public int getRecommendCount(Long bno) {
		return gmapper.getRecommendCount(bno);
	}
	
	//좋아요 추가
	@Override
    public void addLike(Long bno, String username) {
        gmapper.addLike(bno, username);
    }
    
	//좋아요 제거
    @Override
    public void removeLike(Long bno, String username) {
        gmapper.removeLike(bno, username);
    }
    
    //로그인한 사용자의 추천여부 파악
  	@Override
  	public boolean isLikedByUser(Long bno,String username) {
  		int count = gmapper.isLikedByUser(bno, username);
  	    return count > 0;
  	}
}
