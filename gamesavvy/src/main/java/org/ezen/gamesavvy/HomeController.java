package org.ezen.gamesavvy;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.stream.Collectors;

import org.ezen.gamesavvy.domain.GamesavvyVO;
import org.ezen.gamesavvy.domain.MemberProfileDTO;
import org.ezen.gamesavvy.service.GamesavvyService;
import org.ezen.gamesavvy.service.ProfileService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.Setter;
import lombok.extern.log4j.Log4j;




/**
 * Handles requests for the application home page.
 */
@Controller
@Log4j
public class HomeController {
	
	@Setter(onMethod_ = @Autowired)
	private GamesavvyService gameservice;
	
	@Autowired
	private ProfileService profileService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String Index(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		return "redirect:home/home";
	}
	

	
	@GetMapping("/home/home")
	public void get(Model model) {
		
		// 각 게시판 타입별로 최대 5개의 게시글 가져오기
		List<GamesavvyVO> board1 = gameservice.getTop5ByType(1); // 자유게시판
		List<GamesavvyVO> board2 = gameservice.getTop5ByType(2); // 공략게시판
		List<GamesavvyVO> board3 = gameservice.getTop5ByType(3); // 정보게시판
		List<GamesavvyVO> board4 = gameservice.getTop5ByType(4); // 리뷰게시판
		
		// 각 사용자에게 프로필 이미지를 가져와 연결합니다
	    for (GamesavvyVO board : board1) {
	        String userid = board.getUserid();
	        List<MemberProfileDTO> profileImages = profileService.getAttachList(userid);
	        board.setProfileImages(profileImages);
	    }
		
		model.addAttribute("board1", board1);
		model.addAttribute("board2", board2);
		model.addAttribute("board3", board3);
		model.addAttribute("board4", board4);
		
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
	
	//조회화면에서 첨부 파일 처리
	@GetMapping(value = "/home/getProfileImages", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<MemberProfileDTO>> getProfileImages(String userid) {
	    log.info("프로필 이미지 userid : " + userid);
	    
	    List<MemberProfileDTO> profileImages = profileService.getAttachList(userid);
	    
	    return new ResponseEntity<>(profileImages, HttpStatus.OK);
	}
	
}
