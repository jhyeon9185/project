package org.zerock.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.zerock.dto.MemberDTO;
import org.zerock.service.MemberService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
public class AdminController {
	
	private final MemberService memberService;
	
	@GetMapping("")
    public String adminMain() {
        return "admin/main";  // admin/main.jsp
    }
	
	@GetMapping("/member/list")
	public String memberList(Model model) {
		List<MemberDTO> memberList = memberService.findAll();
		
		// 통계 계산 (더 안전한 null 체크)
		long totalMembers = memberList.size();
		long adminCount = memberList.stream()
			.filter(m -> {
				try {
					return m.getRole() != null && "ADMIN".equals(m.getRole().name());
				} catch (Exception e) {
					return false;
				}
			})
			.count();
		long memberCount = totalMembers - adminCount;
		
		model.addAttribute("memberList", memberList);
		model.addAttribute("totalMembers", totalMembers);
		model.addAttribute("adminCount", adminCount);
		model.addAttribute("memberCount", memberCount);
		
		return "admin/member/list";
	}
	
	@GetMapping("/member/detail/{id}")
	public String memberDetail(@PathVariable("id") String id, Model model) {
		MemberDTO member = memberService.findById(id);
		model.addAttribute("member", member);
		return "admin/member/detail";
	}
}

