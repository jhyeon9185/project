package org.zerock.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.dto.BoardDTO;
import org.zerock.dto.PageDTO;
import org.zerock.service.BoardService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/board")
@RequiredArgsConstructor
@Log4j2
public class BoardController {
	
	private final BoardService boardService;
	
	@GetMapping("/list")
    public String list(Model model, 
    				  @RequestParam(value = "page", defaultValue = "1") int page,
    				  @RequestParam(value = "size", defaultValue = "10") int size) {
		
		PageDTO pageDTO = new PageDTO(page, size);
		List<BoardDTO> boardList = boardService.findAllWithPaging(pageDTO);
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("pageDTO", pageDTO);
		
        return "board/list";
    }
    
    @GetMapping("/{id}")
    public String view(@PathVariable("id") Long id, Model model) {
    	BoardDTO board = boardService.findById(id);
    	// 조회수 증가
    	boardService.increaseViewCount(id);
    	model.addAttribute("board", board);
        return "board/view";
    }
    
    @GetMapping("/write")
    @PreAuthorize("isAuthenticated()")
    public String writeForm() {
    	return "board/write";
    }
    
    @PostMapping("/write")
    @PreAuthorize("isAuthenticated()")
    public String write(BoardDTO boardDTO, Principal principal, RedirectAttributes redirectAttributes) {
    	// 현재 로그인한 사용자를 작성자로 설정
    	boardDTO.setWriter(principal.getName());
    	
    	Long boardId = boardService.write(boardDTO);
    	redirectAttributes.addFlashAttribute("message", "게시글이 작성되었습니다.");
    	
    	return "redirect:/board/" + boardId;
    }
    
    @GetMapping("/modify/{id}")
    @PreAuthorize("isAuthenticated()")
    public String modifyForm(@PathVariable("id") Long id, Model model, Principal principal, HttpServletRequest request) {
    	BoardDTO board = boardService.findById(id);
    	
    	// 작성자 본인 또는 관리자만 수정 가능
    	if (!board.getWriter().equals(principal.getName()) && 
    		!request.isUserInRole("ADMIN")) {
    		return "redirect:/board/" + id;
    	}
    	
    	model.addAttribute("board", board);
    	return "board/modify";
    }
    
    @PostMapping("/modify/{id}")
    @PreAuthorize("isAuthenticated()")
    public String modify(@PathVariable("id") Long id, BoardDTO boardDTO, 
    					Principal principal, RedirectAttributes redirectAttributes, HttpServletRequest request) {
    	
    	BoardDTO existingBoard = boardService.findById(id);
    	
    	// 작성자 본인 또는 관리자만 수정 가능
    	if (!existingBoard.getWriter().equals(principal.getName()) && 
    		!request.isUserInRole("ADMIN")) {
    		return "redirect:/board/" + id;
    	}
    	
    	boardDTO.setId(id);
    	boardDTO.setWriter(existingBoard.getWriter()); // 작성자는 변경하지 않음
    	
    	boardService.modify(boardDTO);
    	redirectAttributes.addFlashAttribute("message", "게시글이 수정되었습니다.");
    	
    	return "redirect:/board/" + id;
    }
    
    @PostMapping("/delete/{id}")
    @PreAuthorize("isAuthenticated()")
    public String delete(@PathVariable("id") Long id, Principal principal, 
    					RedirectAttributes redirectAttributes, HttpServletRequest request) {
    	
    	BoardDTO board = boardService.findById(id);
    	
    	// 작성자 본인 또는 관리자만 삭제 가능
    	if (!board.getWriter().equals(principal.getName()) && 
    		!request.isUserInRole("ADMIN")) {
    		return "redirect:/board/" + id;
    	}
    	
    	boardService.delete(id);
    	redirectAttributes.addFlashAttribute("message", "게시글이 삭제되었습니다.");
    	
    	return "redirect:/board/list";
    }
}
