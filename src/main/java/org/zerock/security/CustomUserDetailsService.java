package org.zerock.security;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.zerock.dto.AccountDTO;
import org.zerock.dto.MemberDTO;
import org.zerock.mapper.AccountMapper;
import org.zerock.mapper.MemberMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
@RequiredArgsConstructor
public class CustomUserDetailsService implements UserDetailsService {
	
	private final PasswordEncoder encoder; 
	private final MemberMapper memberMapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

	    log.info("--------- loadUserByUsername --------- : " + username);

	    MemberDTO member = memberMapper.findById(username);

	    if (member == null) {
	        throw new UsernameNotFoundException("User not found with username: " + username);
	    }
	    if (member.getRole() != null) {
	        member.addRole(member.getRole());
	    } else {
	        log.warn("User {} has no role assigned!", username);
	    }

	    log.info("Loaded Member: " + member);
	    return member; 
	}
}
