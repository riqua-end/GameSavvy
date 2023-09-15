package org.ezen.gamesavvy.controller;

import java.util.List;

import org.ezen.gamesavvy.domain.Criteria;
import org.ezen.gamesavvy.domain.GamesavvyVO;
import org.ezen.gamesavvy.domain.PageDTO;
import org.ezen.gamesavvy.service.GamesavvyService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board")
@AllArgsConstructor
public class GamesavvyController {
	
	private GamesavvyService service;
	
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		
		log.info("cri: " + cri);
		model.addAttribute("list", service.getList(cri));
		
		int total = service.getTotal(cri);
		log.info("total: " + total);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
	}
	
	@GetMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public void register() {
		log.info("---registerForm");
	}
	
	@PostMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public String register(GamesavvyVO game, RedirectAttributes rttr) {
		
		log.info("==========================");
		// RedirectAttributes는 redirect:일시 파라메터를 실어보내는 객체(form의 getParameter역활)
		
		log.info("register: " + game);
		
		service.register(game);

		rttr.addFlashAttribute("result", game.getBno());
		// board.getBno()는 bno값을 반환
		// 1회용 데이터 처리

		return "redirect:list";
	}
	
	//페이지 처리를 한 get,modify
	@GetMapping({ "/get", "/modify" })
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		// bean규칙의 DTO객체는 자동 model에 포함
		// @ModelAttribute("cri")는 model에 cri속성으로 cri객체를 강제로 저장
		// 기본형을 Model에 포함시킬때
		log.info("/get or modify");
		model.addAttribute("board", service.get(bno));
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

		if (service.remove(bno)) {

			rttr.addFlashAttribute("result", "success");
		}

		return "redirect:list" + cri.getListLink();
	}
	
}
