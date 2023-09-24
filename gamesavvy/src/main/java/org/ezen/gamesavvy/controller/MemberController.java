package org.ezen.gamesavvy.controller;

import java.security.Principal;
import java.util.List;

import org.ezen.gamesavvy.domain.Criteria;
import org.ezen.gamesavvy.domain.GamesavvyVO;
import org.ezen.gamesavvy.domain.MemberProfileDTO;
import org.ezen.gamesavvy.domain.MemberVO;
import org.ezen.gamesavvy.domain.PageDTO;
import org.ezen.gamesavvy.service.MemberService;
import org.ezen.gamesavvy.service.ProfileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	private MemberService memberservice;
	
	@Autowired
	private ProfileService profileService;
	
	@Setter(onMethod_ = @Autowired)
	private BCryptPasswordEncoder passwordEncoder;
	
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
	
	@GetMapping(value= "/idChk", produces = MediaType.TEXT_PLAIN_VALUE + ";charset=UTF-8")
	@ResponseBody
	public String memberJoinIdChk(String userid) {
		log.info("Join ID 중복체크");
		System.out.println("userid : " + userid);
		String result = memberservice.joinIdCheck(userid);
		return result;
	}
	
	@PostMapping("/join")
	public String join(MemberVO member) {
		System.out.println("member : " + member.getUsername());
		
		int result = memberservice.joinRegister(member);
		
		if(result > 0) {
			return "member/login";
		}
		else {
			return "redirect:join";
		}
	}
	
	// 회원 정보 페이징 처리
    @GetMapping("/custom")
    public void custom(Criteria cri, Model model, Principal principal) {
        
        log.info("custom");
        
        String userid = principal.getName(); // 현재 로그인한 사용자의 아이디
        List<GamesavvyVO> custom = memberservice.getUser(cri, userid);
        
        for(GamesavvyVO game : custom) {
        	String categoryName = getCategoryName(game.getGs_type());
        	game.setCategoryName(categoryName);
        }
        
        if (principal != null) {

            model.addAttribute("custom", custom);
        }
        // 현재 로그인한 사용자의 게시판 갯수
        int total = memberservice.getUserTotal(cri, userid);
        model.addAttribute("total", total);
        log.info("total: " + total);
        
        // 현재 로그인한 사용자의 댓글 갯수
        int replyTotal = memberservice.getReplyTotal(userid);
        model.addAttribute("replyTotal", replyTotal);
        log.info("replyTotal" + replyTotal);
        
        model.addAttribute("pageMaker", new PageDTO(cri, total));
        
    }
	
	//회원 정보 수정 --- 시큐리티 암호화 패스워드 변경
	@PostMapping("/modify")
	// 'principal'객체를 통해 현재 로그인된 사용자의 아이디를 가져옴
    public ResponseEntity<String> modifyMember(@ModelAttribute("member") MemberVO member,
                               @RequestParam("userpw") String newPassword,
                               @RequestParam("curPw") String currentPassword,
                               Principal principal
                               ) {
		//현재 로그인된 사용자의 아이디를 가져옴
		String username = principal.getName();
		//현재 로그인된 사용자의 정보를 데이터베이스에서 조회 -- getMemberByUsername mapper에서 userid를 가져옴
	    MemberVO currentMember = memberservice.getMemberByUsername(username);

	    // 현재 비밀번호가 맞는지 확인
	    // passwordEncoder.matches메서드를 사용해서 현재 비밀번호와 데이터베이스에 저장된 암호화된 비밀번호가 일치하는지 확인
	    if (!passwordEncoder.matches(currentPassword, currentMember.getUserpw())) {
	        //현재 비밀번호가 일치하지 않으면 "fail"를 반환
	    	return ResponseEntity.ok("fail");
	    }
		
        // 암호화된 새 비밀번호 저장
        String bcryptNewPassword = passwordEncoder.encode(newPassword);
        member.setUserpw(bcryptNewPassword);
       
        
        // 회원 정보 수정
        memberservice.modifyMember(member, newPassword);
        
        String newUserName = member.getUsername(); // 새로 업데이트된 사용자명 반환
        return ResponseEntity.ok(newUserName);
    }
	
	//회원정보 수정 페이지 진입 -- 진입시 프로필 이미지 보여야함
	@GetMapping("/modify")
	public String modifyMemberPage(Model model,Principal principal) {
	    log.info("회원정보수정 페이지");
	    
	    // 현재 로그인된 사용자의 아이디를 가져옴
        String username = principal.getName();

        // 현재 로그인된 사용자의 정보를 데이터베이스에서 조회
        MemberVO currentMember = memberservice.getMemberByUsername(username);
        
        // 회원의 프로필 이미지 리스트 가져오기
        List<MemberProfileDTO> attachList = profileService.getAttachList(username);

        model.addAttribute("currentMember", currentMember);
        model.addAttribute("attachList", attachList);
        
        return "member/modify";
	}
	
	//조회화면에서 첨부 파일 처리
	@GetMapping(value = "/getProfileList", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<MemberProfileDTO>> getAttachList(String userid) {
		
		log.info("프로필 이미지 userid : " + userid);
		
		return new ResponseEntity<>(profileService.getAttachList(userid), HttpStatus.OK);
	}
}
