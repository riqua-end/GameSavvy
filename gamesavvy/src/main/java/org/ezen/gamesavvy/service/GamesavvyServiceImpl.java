package org.ezen.gamesavvy.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
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
	
}
