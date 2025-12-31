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

	    // [핵심 추가] DB에서 가져온 단일 role 정보를 리스트에 추가합니다.
	    // MemberDTO에 작성하신 addRole 메서드를 활용하거나 직접 세팅합니다.
	    if (member.getRole() != null) {
	        member.addRole(member.getRole());
	    } else {
	        // 혹시라도 role이 null인 경우 기본 권한이라도 부여하려면 아래처럼 처리 가능
	        // member.addRole(AccountRole.MEMBER); 
	        log.warn("User {} has no role assigned!", username);
	    }

	    log.info("Loaded Member: " + member);
	    return member; 
	}
}
