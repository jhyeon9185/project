package org.zerock.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.dto.AccountRole;
import org.zerock.dto.MemberDTO;
import org.zerock.service.MemberService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
@RequestMapping("/member")
@RequiredArgsConstructor 
public class MemberController {
	
	private final MemberService memberService;
	
	@GetMapping("/login")
	public String loginForm() {
		
		log.info("----- 로그인 페이지 진입 --------");
		return "member/login";
	}
	
	@GetMapping("/join")
	public String joinForm() {
		
		log.info("------회원가입 페이지 진입 -------");
		return "member/join";
	}
	
	@GetMapping("/access-denied")
	public String accessDenied() {
	    return "member/access-denied";
	}
	
	@PostMapping("/check-id")
	@ResponseBody
	public Map<String, Object> checkId(@RequestParam("id") String id) {
	    Map<String, Object> result = new HashMap<>();
	    
	    try {
	        boolean isDuplicated = memberService.isUsernameDuplicated(id);
	        
	        result.put("success", true);
	        result.put("isDuplicated", isDuplicated);
	        
	        if (isDuplicated) {
	            result.put("message", "이미 사용 중인 아이디입니다.");
	        } else {
	            result.put("message", "사용 가능한 아이디입니다.");
	        }
	        
	    } catch (Exception e) {
	        result.put("success", false);
	        result.put("message", "중복 체크 중 오류가 발생했습니다.");
	        log.error("ID 중복 체크 오류: ", e);
	    }
	    
	    return result;
	}
	

	@PostMapping("/join")
	public String join(@RequestParam("adminCode") String adminCode, MemberDTO memberDTO) {
	    
		// 관리자 코드 확인
	    if ("1234".equals(adminCode)) {
	        memberDTO.addRole(AccountRole.ADMIN);
	        memberDTO.setRole(AccountRole.ADMIN);  
	    } else {
	        memberDTO.addRole(AccountRole.MEMBER);
	        memberDTO.setRole(AccountRole.MEMBER); 
	    }
	    
	    memberService.join(memberDTO);
	    return "redirect:/member/login";
	}

	@GetMapping("/modify")
	public String modifyForm(Model model, Principal principal) {
	    // 현재 로그인한 사용자 정보 조회
	    MemberDTO member = memberService.findById(principal.getName());
	    model.addAttribute("member", member);
	    return "member/modify";
	}

	@PostMapping("/modify")
	public String modify(MemberDTO memberDTO) {
	    memberService.update(memberDTO);
	    return "redirect:/board/list";
	}

	@GetMapping("/withdraw")
	@PreAuthorize("isAuthenticated()")
	public String withdrawForm() {
		return "member/withdraw";
	}
	
	@PostMapping("/withdraw")
	@PreAuthorize("isAuthenticated()")
	public String withdraw(@RequestParam("password") String password,
			Principal principal,
			RedirectAttributes redirectAttributes,
			HttpServletRequest request) {
		
		String currentUserId = principal.getName();
		
		// 비번확인
		if (!memberService.deletePwd(currentUserId, password)) {
			redirectAttributes.addFlashAttribute("error", "비밀번호가 올바르지 않습니다");
			return "redirect:/member/withdraw";
		}
		
		memberService.delete(currentUserId);
		
		request.getSession().invalidate();
		
		redirectAttributes.addFlashAttribute("message", "회원탈퇴가 완료되었습니다");
		
		return "redirect:/home";
	}
			
	
}
