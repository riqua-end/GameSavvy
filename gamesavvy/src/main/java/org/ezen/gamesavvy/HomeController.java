package org.ezen.gamesavvy;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.stream.Collectors;

import org.ezen.gamesavvy.domain.GamesavvyVO;
import org.ezen.gamesavvy.service.GamesavvyService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.Setter;




/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Setter(onMethod_ = @Autowired)
	private GamesavvyService gameservice;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String Index(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		/*
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
		*/
		
		return "redirect:home/home";
	}
	

	
	@GetMapping("/home/home")
	public void get(Model model) {
		
		model.addAttribute("home", gameservice.getLi());
		
		List<GamesavvyVO> homeData = gameservice.getLi();

	    // 최신순으로 정렬하고 최대 5개의 항목 선택
	    List<GamesavvyVO> sortedData = homeData.stream()
	            .sorted((c1, c2) -> c2.getBno().compareTo(c1.getBno())) // 최신순 정렬
	            .limit(5) // 최대 5개 항목 선택
	            .collect(Collectors.toList());

	    model.addAttribute("home", sortedData);
		
	    // 각 게시물의 추천 수를 가져와서 모델에 추가
	    // 현재 페이지의 게시물 목록에서 각 게시물의 번호(bno)를 추출하여 리스트로 저장
 		List<Long> bnoList = gameservice.getLi()  // 서비스를 통해 현재 페이지의 게시물 목록을 가져옴
 		    .stream()                               // 목록을 스트림으로 변환하여 각 게시물에 접근
 		    .map(GamesavvyVO::getBno)               // 각 게시물에 대해 getBno() 메서드를 호출하여 게시물 번호를 추출
 		    .collect(Collectors.toList());          // 추출된 게시물 번호를 리스트로 수집
	    
	    // 각 게시물의 추천 수를 저장할 맵을 생성
	    Map<Long, Integer> recommendCounts = new HashMap<>();
	    
	    // 각 게시물의 번호를 기반으로 추천 수를 조회하고 맵에 저장
	    for (Long bno : bnoList) {
	        int recommendCount = gameservice.getRecommendCount(bno);
	        recommendCounts.put(bno, recommendCount);
	    }
	    // 모델에 추천 수를 추가
	    // list.jsp에서 ${recommendCounts[board.bno]} 를 사용해서 각 게시물의 추천수를 출력
	    model.addAttribute("recommendCounts", recommendCounts);
	    
	}
	
}
