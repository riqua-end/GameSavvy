package org.ezen.gamesavvy.controller;

import java.util.List;

import org.ezen.gamesavvy.domain.GamesavvyVO;
import org.ezen.gamesavvy.domain.MemberVO;
import org.ezen.gamesavvy.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private AdminService aservice;
	
	@Secured({ "ROLE_ADMIN" })
	@GetMapping("/adminMember")
	public String adminMember(Model model) {
		
		log.info("회원관리 페이지...");
		
		List<MemberVO> admin = aservice.getAllMember();
		
		model.addAttribute("admin", admin);
		
		return "admin/adminMember";
		
	}
	
	//관리자 회원관리 페이지, 회원 강제 탈퇴
	@Secured({"ROLE_ADMIN"})
	@GetMapping("/delete/{userid}")
	public String deleteMember(@PathVariable String userid) {
		
		log.info("회원 강제 탈퇴 : " + userid);
		aservice.removeMember(userid);
		return "redirect:/admin/adminMember"; //강제 탈퇴 후 관리제 페이지로 이동
	}
	
	@Secured({ "ROLE_ADMIN" })
	@GetMapping("/adminList")
	public String adminList(Model model) {
		
		log.info("게시판관리 페이지...");
		
		List<GamesavvyVO> adminList = aservice.getAllList();
		
		model.addAttribute("adminList", adminList);
		
		return "admin/adminList";
	}
	//관리자 게시판 관리 페이지, 삭제
	@Secured({"ROLE_ADMIN"})
	@GetMapping("/deleteList/{bno}")
	public String deleteList(@PathVariable Long bno) {
		
		log.info("회원 강제 탈퇴 : " + bno);
		aservice.removeList(bno);
		return "redirect:/admin/adminList"; //강제 탈퇴 후 관리제 페이지로 이동
	}
	
}
