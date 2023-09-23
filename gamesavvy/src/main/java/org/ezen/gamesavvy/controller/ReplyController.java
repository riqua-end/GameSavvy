package org.ezen.gamesavvy.controller;

import org.ezen.gamesavvy.domain.Criteria;
import org.ezen.gamesavvy.domain.ReplyPageDTO;
import org.ezen.gamesavvy.domain.ReplyVO;
import org.ezen.gamesavvy.service.ReplyService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/replies")
@RestController
@Log4j
@AllArgsConstructor
public class ReplyController {
	
	private ReplyService service;
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/new", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE + ";charset=UTF-8" })
	public ResponseEntity<String> create(@RequestBody ReplyVO vo, @RequestParam(value = "parentRno", required = false) Long parentRno) {
	    if (parentRno != null) {
	        // 부모 댓글의 ID를 ReplyVO에 설정
	        vo.setParent_id(parentRno);

	        // 부모 댓글을 조회하여 부모 댓글의 depth + 1 값을 자식 댓글의 depth로 설정
	        ReplyVO parentReply = service.get(parentRno);
	        if (parentReply != null) {
	            vo.setDepth(parentReply.getDepth() + 1);
	            log.info("Setting depth to: " + vo.getDepth());
	        }
	    } else {
	        // 부모 댓글인 경우 depth를 0으로 설정
	        vo.setDepth(0L);
	        log.info("Setting depth to 0");
	    }

	    log.info("ReplyVO: " + vo);

	    int insertCount = service.register(vo); // 댓글 등록 서비스 호출

	    log.info("Reply Insert Count: " + insertCount);

	    if (insertCount == 1) {
	        return new ResponseEntity<>("success", HttpStatus.OK);
	    } else {
	        return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}


	
	//List 처리

	@GetMapping(value = "/pages/{bno}/{page}",produces = {MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<ReplyPageDTO> getList(@PathVariable("page") int page,@PathVariable("bno") Long bno) {
		
		Criteria cri = new Criteria(page,10);
		
		log.info("get Reply List bno" + bno);
		log.info("cri" + cri);
		
		return new ResponseEntity<>(service.getListPage(cri, bno),HttpStatus.OK);
		
	}
	
	//조회
	
	@GetMapping(value = "/{rno}" , produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<ReplyVO> get(@PathVariable("rno") Long rno) {
		
		log.info("get" + rno);
		
		return new ResponseEntity<>(service.get(rno),HttpStatus.OK);
	}
	
	//댓글 삭제
	@PreAuthorize("principal.username == #vo.replyer")
	@DeleteMapping(value = "/{rno}", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@RequestBody ReplyVO vo, @PathVariable("rno") Long rno) {
		
		log.info("remove" + rno);
		
		return service.remove(rno) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//댓글 수정
	@PreAuthorize("principal.username == #vo.replyer")
	@RequestMapping(method = { RequestMethod.PUT,RequestMethod.PATCH }, value = "/{rno}",
			consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	
	public ResponseEntity<String> modify(@RequestBody ReplyVO vo, @PathVariable("rno") Long rno) {
		
		vo.setRno(rno);
		
		log.info("rno" + rno);
		log.info("modify" + vo);
		
		
		return service.modify(vo) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
}
