package org.zerock.security;

import java.io.IOException;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.log4j.Log4j2;

@Log4j2
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
	
		log.info("-------------------CustomLoginSuccessHandler----------------------------------------");
		
		boolean isAdmin = authentication.getAuthorities().stream()
		        .anyMatch(auth -> auth.getAuthority().equals("ROLE_ADMIN"));
		    
		    SavedRequest savedRequest = new HttpSessionRequestCache().getRequest(request, response);
		    
		    if(savedRequest != null) {
		    	
		        response.sendRedirect(savedRequest.getRedirectUrl());
		        
		    } else {
		    	
		        if(isAdmin) {
		            response.sendRedirect("/admin");
		        } else {
		            response.sendRedirect("/board/list");
		        }
		
		}
		
		
	}
}
