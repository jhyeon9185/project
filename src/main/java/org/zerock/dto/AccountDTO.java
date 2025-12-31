package org.zerock.dto;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class AccountDTO implements UserDetails{
	
	private String uid;
	private String upw;
	private String uname;
	private String email;
	
	private List<AccountRole> roleNames;           // USER, MANAGER, ADMIN
	
	public void addRole(AccountRole role) {
		if(roleNames == null) {
			roleNames = new ArrayList<AccountRole>();
		}
		roleNames.add(role);
	}
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
	    
	    // [1] 방어 코드: 권한이 아예 없거나 리스트가 생성되지 않은 경우
	    if(roleNames == null || roleNames.size() == 0) {
	        return List.of(); // 빈 리스트를 반환하여 에러 방지
	    }

	    // [2] 변환 로직 (Stream API 사용)
	    return roleNames.stream() // 리스트에서 데이터를 하나씩 꺼내서 흐름(Stream)을 만듦
	        .map(role ->          // 각 권한(Enum)을 새로운 객체로 변형(map)함
	            new SimpleGrantedAuthority("ROLE_" + role.name())) // "USER" -> "ROLE_USER" 객체로 생성
	        .collect(Collectors.toList()); // 변형된 객체들을 다시 리스트로 모아서 반환
	}
	
	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return upw;
	}


	@Override
	public String getUsername() {
	    return uid;
	}


}
