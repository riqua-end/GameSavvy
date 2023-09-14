package org.ezen.gamesavvy.controller;

import org.ezen.gamesavvy.domain.Criteria;
import org.ezen.gamesavvy.domain.PageDTO;
import org.ezen.gamesavvy.service.GamesavvyService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
}
