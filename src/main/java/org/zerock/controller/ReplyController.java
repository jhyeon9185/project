package org.zerock.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.dto.ReplyDTO;
import org.zerock.service.ReplyService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/replies")
@RequiredArgsConstructor
public class ReplyController {
	
	private final ReplyService replyService;
	
	// 목록 조회
	@GetMapping("/board/{bno}")
	public ResponseEntity<List<ReplyDTO>> getReplies(@PathVariable("bno") int bno){
		
		List<ReplyDTO> replies = replyService.getRepliesByBno(bno);		
		return ResponseEntity.ok(replies);
	}
	
	// 댓글 작성
	@PostMapping
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<Integer> writeReply(@RequestBody ReplyDTO replyDTO, Principal principal){
		
		replyDTO.setReplyer(principal.getName());
		
		int rno = replyService.writeReply(replyDTO);
		
		return ResponseEntity.ok(rno);
	}
	
	// 댓글 수정
	@PutMapping("/{rno}")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> modifyReply(
			@PathVariable("rno") int rno,
			@RequestBody ReplyDTO replyDTO,
			Principal principal
			){
		ReplyDTO existingReply = replyService.getReplyByRno(rno);
		
		// 본인만 수정할수있게
		if(!existingReply.getReplyer().equals(principal.getName())) {
			return ResponseEntity.status(403).body("권한이 없습니다");	
		}
		
		replyDTO.setRno(rno);
		replyService.modifyReply(replyDTO);
		return ResponseEntity.ok("댓글이 수정되었습니다.");
	}
	
	// 댓글 삭제
	@DeleteMapping("/{rno}")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> deleteReply(
			@PathVariable("rno") int rno,
			Principal principal
			){
		ReplyDTO exisitngReply = replyService.getReplyByRno(rno);
		
		// 본인만 삭제
		if (!exisitngReply.getReplyer().equals(principal.getName())) {
			return ResponseEntity.status(403).body("권한 이즈 낫띵");
		}
		
		replyService.deleteReply(rno);
		
		return ResponseEntity.ok("댓글이 삭제되었습니다");
	}
	
}
