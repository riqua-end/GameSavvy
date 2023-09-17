package org.ezen.gamesavvy.service;

import java.util.List;

import org.ezen.gamesavvy.domain.Criteria;
import org.ezen.gamesavvy.domain.GamesavvyVO;
import org.ezen.gamesavvy.mapper.GamesavvyMapper;
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
	
	@Override
	public void register(GamesavvyVO game) {
		
		log.info("register...." + game);
		
		gmapper.insertSelectKey(game);
		
	}

	@Override
	public GamesavvyVO get(Long bno) {
		
		log.info("get..." + bno);
		
		return gmapper.read(bno);
		
	}

	@Override
	public boolean modify(GamesavvyVO game) {
		
		log.info("modify...." + game);
		
		return gmapper.update(game) == 1;
		
	}

	@Override
	public boolean remove(Long bno) {
		
		log.info("remove..." + bno);
		
		return gmapper.delete(bno) == 1;
		
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
