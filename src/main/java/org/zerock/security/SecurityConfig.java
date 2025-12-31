package org.zerock.security;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import lombok.extern.log4j.Log4j2;

@Configuration
@Log4j2
@EnableWebSecurity
public class SecurityConfig {
	
	@Autowired
	private DataSource dataSource;
	
	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {

	    log.info("---------------filterChain----------------------");

	    http.authorizeHttpRequests(auth -> auth
	        .requestMatchers(new AntPathRequestMatcher("/admin/**")).hasRole("ADMIN")
	        .requestMatchers(new AntPathRequestMatcher("/board/**")).hasAnyRole("USER", "ADMIN", "MEMBER")
	        .requestMatchers(
	            new AntPathRequestMatcher("/"),
	            new AntPathRequestMatcher("/home"),
	            new AntPathRequestMatcher("/member/login"),
	            new AntPathRequestMatcher("/member/join"),
	            new AntPathRequestMatcher("/member/check-id")
	        ).permitAll()
	        .anyRequest().authenticated()
	    );

	    http.formLogin(config -> {
	        config.loginPage("/member/login"); // ⚠️ 여기도 통일
	        config.successHandler(new CustomLoginSuccessHandler());
	    });

	    http.rememberMe(config -> {
	        config.key("my-key");
	        config.tokenRepository(persistentTokenRepository());
	        config.tokenValiditySeconds(60 * 60 * 24 * 30);
	    });

	    http.logout(config -> {
	        config.logoutUrl("/logout");
	        config.deleteCookies("JSESSIONID", "remember-me");
	    });

	    http.csrf(config -> config.disable());

	    http.exceptionHandling(config -> {
	        config.accessDeniedHandler(new Custom403Handler());
	    });
	    
	    http.headers(headers -> headers.frameOptions().sameOrigin());

	    return http.build();
	}

	
	@Bean
	public PersistentTokenRepository persistentTokenRepository() {
		JdbcTokenRepositoryImpl tokenRepository = new JdbcTokenRepositoryImpl();
		tokenRepository.setDataSource(dataSource);
		
		return tokenRepository;
	}
	
	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
}
