package org.ezen.gamesavvy.controller;

import java.util.List;

import org.ezen.gamesavvy.domain.Criteria;
import org.ezen.gamesavvy.domain.GamesavvyVO;
import org.ezen.gamesavvy.domain.MemberVO;
import org.ezen.gamesavvy.domain.PageDTO;
import org.ezen.gamesavvy.mapper.ReplyMapper;
import org.ezen.gamesavvy.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private AdminService aservice;
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	// 게시판의 분류 정보를 반환하는 메서드
	private String getCategoryName(int gs_type) {
	    switch (gs_type) {
	        case 1:
	            return "자유";
	        case 2:
	            return "공략";
	        case 3:
	            return "정보";
	        case 4:
	            return "리뷰";
	        case 5:
	            return "공지";
	        default:
	            return "기타";
	    }
	}
	
	@Secured({ "ROLE_ADMIN" })
	@GetMapping("/adminMember")
	public void adminMember(Criteria cri, Model model) {
		
		log.info("회원관리 페이지...");
		
		List<MemberVO> admin = aservice.getAllMember(cri);
		
		model.addAttribute("admin", admin);
		
		int total = aservice.getMembersTotal(cri);
		log.info("total.." + total);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
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
	public void adminList(Criteria cri, Model model) {
		
		log.info("게시판관리 페이지...");
		
		List<GamesavvyVO> adminList = aservice.getAllList(cri);
		
		model.addAttribute("adminList", adminList);
		
		int total = aservice.getListTotal(cri);
		log.info("total.." + total);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
		// 각 게시물의 gs_type에 해당하는 categoryName 설정
	    for (GamesavvyVO board : adminList) {
	        String categoryName = getCategoryName(board.getGs_type());
	        board.setCategoryName(categoryName);
	    }
		
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
