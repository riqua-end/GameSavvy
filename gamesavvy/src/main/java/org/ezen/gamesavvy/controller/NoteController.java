package org.ezen.gamesavvy.controller;

import java.util.List;

import org.ezen.gamesavvy.domain.CriNote;
import org.ezen.gamesavvy.domain.NoteVO;
import org.ezen.gamesavvy.service.NoteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("note")
@Log4j
public class NoteController {
	
	@Autowired
	private NoteService nservice;
	
	@GetMapping("/note")
	public void list(CriNote cn, Model model) {
		
		log.info("list...");
		
	}
}
