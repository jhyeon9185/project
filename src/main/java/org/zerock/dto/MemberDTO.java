package org.zerock.dto;

import java.time.LocalDateTime;
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

/*
 * CREATE TABLE members (
	    id VARCHAR(50) PRIMARY KEY,           -- 회원 아이디 (고유 키)
	    password VARCHAR(200) NOT NULL,       -- 암호화된 비밀번호
	    name VARCHAR(100) NOT NULL,           -- 회원 이름
	    email VARCHAR(200) NOT NULL,          -- 이메일
	    role VARCHAR(20) DEFAULT 'MEMBER',    -- 권한 (MEMBER 또는 ADMIN)
	    phone VARCHAR(20),                    -- 전화번호 (선택)
	    regdate TIMESTAMP DEFAULT NOW(),      -- 가입일시 (자동 입력)
	    enabled BOOLEAN DEFAULT TRUE          -- 계정 활성화 여부
	);
 * 
 */
@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberDTO implements UserDetails{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String id;
	private String password;
	private String name;
	private String email;
	private String phone;
	private LocalDateTime regdate;
	private boolean enabled;
	private AccountRole role;
	
	private List<AccountRole> roleNames;
	
	public void addRole(AccountRole role) {
		if(roleNames == null) {
			roleNames = new ArrayList<AccountRole>();
		}
		roleNames.add(role);
	}
	
	@Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        // null 체크를 추가하여 안전하게 스트림 처리
        if (this.roleNames == null || this.roleNames.isEmpty()) {
            // 만약 roleNames는 비어있는데 role 필드에 값이 있다면 처리
            if (this.role != null) {
                return List.of(new SimpleGrantedAuthority("ROLE_" + this.role.name()));
            }
            return new ArrayList<>();
        }

        return roleNames.stream()
            .map(role -> new SimpleGrantedAuthority("ROLE_" + role.name()))
            .collect(Collectors.toList());
    }

	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return password;
	}
	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return id;
	}
	
	// 로그인이 튕기지 않게 하기 위해
	@Override
	public boolean isAccountNonExpired() { return true; }

	@Override
	public boolean isAccountNonLocked() { return true; }

	@Override
	public boolean isCredentialsNonExpired() { return true; }

	@Override
	public boolean isEnabled() {
		return enabled; // DB의 enabled 값과 연동
	}
	
}
