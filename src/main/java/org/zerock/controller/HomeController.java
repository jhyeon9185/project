package org.zerock.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
//@RequestMapping("/home")
public class HomeController {
    
	@GetMapping("/")  // 루트 경로 - localhost:8080
    public String root() {
        return "redirect:/home";
    }
	
    @GetMapping("/home")  // /home 경로 (빈 문자열)
    public String getHome() {
        log.info("--------------접속완-----------------");
        return "home";
    }
    
    
}
