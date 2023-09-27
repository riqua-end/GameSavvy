package org.ezen.gamesavvy.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.ezen.gamesavvy.domain.Criteria;
import org.ezen.gamesavvy.domain.GamesavvyVO;
import org.ezen.gamesavvy.domain.GsAttachVO;
import org.ezen.gamesavvy.domain.MemberProfileDTO;
import org.ezen.gamesavvy.domain.PageDTO;
import org.ezen.gamesavvy.service.GamesavvyService;
import org.ezen.gamesavvy.service.ProfileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board")
@AllArgsConstructor
public class GamesavvyController {
	
	private GamesavvyService service;
	
	@Autowired
	private ProfileService profileService;
	
	@GetMapping("/list")
	public void list(@ModelAttribute("cri") Criteria cri, Model model) {
		
		log.info("cri: " + cri);
		List<GamesavvyVO> list = service.getList(cri);

	    // 각 사용자에게 프로필 이미지를 가져와 연결합니다
	    for (GamesavvyVO board : list) {
	        String userid = board.getUserid();
	        List<MemberProfileDTO> profileImages = profileService.getAttachList(userid);
	        board.setProfileImages(profileImages);
	    }

	    model.addAttribute("list", list);
		
		// 공지사항에 대한 추천 수를 추가합니다
	    List<Long> noticeBnoList = service.notice()  // 서비스에서 공지사항을 가져옵니다
	        .stream()                                 // 공지사항을 스트림으로 변환합니다
	        .map(GamesavvyVO::getBno)                 // 각 공지사항의 bno를 추출합니다
	        .collect(Collectors.toList());            // bno를 리스트로 수집합니다

	    Map<Long, Integer> recommendCountsForNotices = new HashMap<>();
	    
	    for (Long bno : noticeBnoList) {
	        int recommendCount = service.getRecommendCount(bno);
	        recommendCountsForNotices.put(bno, recommendCount);
	    }
	    
	    model.addAttribute("notice", service.notice());
	    model.addAttribute("recommendCountsForNotices", recommendCountsForNotices);
		
		int total = service.getTotal(cri);
		log.info("total: " + total);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
		// 각 게시물의 추천 수를 가져와서 모델에 추가
		// 현재 페이지의 게시물 목록에서 각 게시물의 번호(bno)를 추출하여 리스트로 저장
		List<Long> bnoList = service.getList(cri)  // 서비스를 통해 현재 페이지의 게시물 목록을 가져옴
		    .stream()                               // 목록을 스트림으로 변환하여 각 게시물에 접근
		    .map(GamesavvyVO::getBno)               // 각 게시물에 대해 getBno() 메서드를 호출하여 게시물 번호를 추출
		    .collect(Collectors.toList());          // 추출된 게시물 번호를 리스트로 수집
		
		// 각 게시물의 추천 수를 저장할 맵을 생성
	    Map<Long, Integer> recommendCounts = new HashMap<>();
	    
	    // 각 게시물의 번호를 기반으로 추천 수를 조회하고 맵에 저장
	    for (Long bno : bnoList) {
	        int recommendCount = service.getRecommendCount(bno);
	        recommendCounts.put(bno, recommendCount);
	    }
	    // 모델에 추천 수를 추가
	    // list.jsp에서 ${recommendCounts[board.bno]} 를 사용해서 각 게시물의 추천수를 출력
	    model.addAttribute("recommendCounts", recommendCounts);
	    
	}
	
	@GetMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public void register() {
		log.info("---registerForm");
	}
	
	//게시판 + 첨부물 등록 처리
	@PostMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public String register(@RequestParam("gs_type") int gs_type, GamesavvyVO game, RedirectAttributes rttr) {
		
		log.info("==========================");
		// RedirectAttributes는 redirect:일시 파라메터를 실어보내는 객체(form의 getParameter역활)
		
		log.info("register: " + game);
		
		game.setGs_type(gs_type);
		
		if (game.getAttachList() != null) {
			game.getAttachList().forEach(attach -> log.info(attach));
		}
		
		log.info("==========================");
		
		service.register(game);

		rttr.addFlashAttribute("result", game.getBno());
		// board.getBno()는 bno값을 반환
		// 1회용 데이터 처리
		
		// gs_type에 따라 다른 리스트 페이지로 이동
	    if (gs_type == 1) {
	        return "redirect:list?gs_type=1";
	    } else if (gs_type == 2) {
	        return "redirect:list?gs_type=2";
	    } else if (gs_type == 3) {
	        return "redirect:list?gs_type=3";
	    } else if (gs_type == 4) {
	        return "redirect:list?gs_type=4";
	    } else if (gs_type == 5) {
		    return "redirect:list?gs_type=5";
	    } else if (gs_type == 6) {
	    	return "redirect:list?gs_type=6";
	    } else {
	        // 다른 경우에는 기본 리스트 페이지로 이동
	        return "redirect:/list";
	    }

	}
	
	// 게시글 조회 및 수정 페이지
	// 이 메서드는 URL 경로가 "/get" 또는 "/modify"인 경우에 실행
	@GetMapping({ "/get", "/modify" })
	public void get(@RequestParam("bno") Long bno, // URL에서 전달되는 게시물 번호를 파라미터로 받음
	                @ModelAttribute("cri") Criteria cri, // @ModelAttribute로 설정된 "cri" 속성을 모델에 추가
	                Model model, // 뷰에 전달할 데이터를 담는 모델 객체
	                Authentication authentication) { // 현재 사용자의 인증 정보를 확인하기 위한 객체

	    log.info("/get or modify");

	    // 게시글의 조회수를 증가. 조회 페이지에 접근한 경우 조회수를 증가
	    service.updateCnt(bno);

	    // 추천 기능을 구현하기 위한 변수들을 초기화
	    String username = null; // 현재 로그인한 사용자의 이름을 저장할 변수
	    boolean isLiked = false; // 현재 사용자가 해당 게시물을 추천했는지 여부를 저장할 변수
	    int recommendCount = 0; // 해당 게시물의 총 추천 수를 저장할 변수

	    // 현재 사용자가 로그인되어 있고, 인증된 경우에만 추천 기능을 확인
	    if (authentication != null && authentication.isAuthenticated()) {
	        username = authentication.getName(); // 현재 로그인한 사용자의 이름을 가져옴
	        isLiked = service.isLikedByUser(bno, username); // 현재 사용자가 해당 게시물을 추천했는지 확인
	        recommendCount = service.getRecommendCount(bno); // 해당 게시물의 총 추천 수를 가져옴
	    }

	    // 뷰로 전달할 데이터를 모델에 추가
	    model.addAttribute("board", service.get(bno)); // 해당 게시물의 상세 정보를 모델에 추가
	    model.addAttribute("isLiked", isLiked); // 현재 사용자가 해당 게시물을 추천했는지 여부를 모델에 추가
	    model.addAttribute("recommendCount", recommendCount); // 해당 게시물의 총 추천 수를 모델에 추가
	}

	
	//페이지 정보처리 고려한 modify 시큐리티 적용
	@PostMapping("/modify")
	@PreAuthorize("principal.username == #game.userid") //로그인한 아이디와 게시글 작성한 동일 체크
	public String modify(GamesavvyVO game, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		
		log.info("modify:" + game);
		
		if(service.modify(game)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:list" + cri.getListLink();
		
	}
	
	//수정화면에서 게시글 삭제 처리(게시글,첨부물,댓글 모두 삭제 처리) 시큐리티 처리
	@PostMapping("/remove")
	@PreAuthorize("principal.username == #userid")
	public String remove(@RequestParam("bno") Long bno, Criteria cri, RedirectAttributes rttr, String userid) {

		log.info("remove..." + bno);
		
		List<GsAttachVO> attachList = service.getAttachList(bno);

		if (service.remove(bno)) {
			
			// delete attach files (c:upload폴더에 저장된 파일 삭제)
			deleteFiles(attachList);
			
			rttr.addFlashAttribute("result", "success");
		}

		return "redirect:list" + cri.getListLink();
	}
	
	//조회화면에서 첨부 파일 처리
	@GetMapping(value = "/getProfileImages", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<MemberProfileDTO>> getProfileImages(String userid) {
	    log.info("프로필 이미지 userid : " + userid);
	    
	    List<MemberProfileDTO> profileImages = profileService.getAttachList(userid);
	    
	    return new ResponseEntity<>(profileImages, HttpStatus.OK);
	}

	
	//조회 화면에서 첨부 파일 처리
	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<GsAttachVO>> getAttachList(Long bno) {
		
		log.info("getAttachList : " + bno);
		
		return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);
	}
	
	private void deleteFiles(List<GsAttachVO> attachList) {
		
		if (attachList == null || attachList.size() == 0) {
			return;
		}
		
		log.info("delete attach files...................");
		log.info(attachList);
		
		attachList.forEach(attach -> {
			try {
				Path file = Paths.get(
						"C:/upload/" + attach.getUploadPath() + "/" + attach.getUuid() + "_" + attach.getFileName()); //원본파일과 일반 파일

				Files.deleteIfExists(file); //파일존재시 삭제

				if (Files.probeContentType(file).startsWith("image")) {

					Path thumbNail = Paths.get("C:/upload/" + attach.getUploadPath() + "/s_" + attach.getUuid() + "_"
							+ attach.getFileName());

					Files.delete(thumbNail);
				}

			} catch (Exception e) {
				log.error("delete file error" + e.getMessage());
			} // end catch
		});
	}
	
	
// =============================================================== //	
	//추천
	@PostMapping("/like")
	@ResponseBody
	public ResponseEntity<String> like(@RequestParam("bno") Long bno, Authentication authentication) {
	    String username = authentication.getName(); // 현재 로그인한 사용자의 이름

	    if (service.isLikedByUser(bno, username)) {
	        // 이미 좋아요한 경우, 추천을 취소하도록 처리
	        service.decreaseRecommendCount(bno);
	        service.removeLike(bno, username);
	        return ResponseEntity.ok("unliked");
	    } else {
	        // 좋아요하지 않은 경우, 추천수 증가 및 좋아요 상태 추가
	        service.increaseRecommendCount(bno);
	        service.addLike(bno, username);
	        return ResponseEntity.ok("liked");
	    }
	}
	
	//추천 취소
	@PostMapping("/dislike")
	@ResponseBody
	public ResponseEntity<String> dislike(@RequestParam("bno") Long bno, Authentication authentication) {
	    String username = authentication.getName(); // 현재 로그인한 사용자의 이름

	    if (service.isLikedByUser(bno, username)) {
	        // 이미 좋아요한 경우, 추천을 취소하도록 처리
	        service.decreaseRecommendCount(bno);
	        service.removeLike(bno, username);
	        return ResponseEntity.ok("unliked");
	    } else {
	        // 이미 좋아요하지 않은 경우, 아무 작업 없이 "unliked" 응답
	        return ResponseEntity.ok("unliked");
	    }
	}
	
	//추천수 조회
	@GetMapping("/getRecommendCount")
    @ResponseBody
    public ResponseEntity<Integer> getRecommendCount(@RequestParam("bno") Long bno) {
        int recommendCount = service.getRecommendCount(bno);
        return ResponseEntity.ok(recommendCount);
    }
	
	//로그인한 사용자의 추천 여부 확인
	@GetMapping("/checkLiked")
	@ResponseBody
	public ResponseEntity<String> checkLiked(@RequestParam("bno") Long bno, Authentication authentication) {
	    if (authentication != null && authentication.isAuthenticated()) {
	        String username = authentication.getName(); // 현재 로그인한 사용자의 이름

	        if (service.isLikedByUser(bno, username)) {
	            return ResponseEntity.ok("liked");
	        } else {
	            return ResponseEntity.ok("unliked");
	        }
	    } else {
	        // 인증되지 않은 사용자라면 "unliked" 응답
	        return ResponseEntity.ok("unliked");
	    }
	}
	
}
