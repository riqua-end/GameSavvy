package org.ezen.gamesavvy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member")
public class MemberController {
	
	//로그인 페이지
	@GetMapping("/login")
	public void loginInput(String error, String logout, Model model) {
		
		log.info("error : " + error);
		
		log.info("logout : " + logout);
		
		if(error != null) {
			model.addAttribute("error","아이디와 비밀 번호가 일치하지 않습니다.");
		}
		if(logout != null) {
			model.addAttribute("logout", "logout!");
		}
		
	}
	
	//로그아웃
	@GetMapping("/logout")
	public void logoutGet() {
		
		log.info("custom logout");
	}
	
	//회원가입 페이지 진입
	@GetMapping("join")
	public void joinGet() {
		
		log.info("회원 가입 페이지 진입");
		
	}
	
}
