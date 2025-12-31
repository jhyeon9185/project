package org.zerock.service;

import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.zerock.dto.MemberDTO;
import org.zerock.mapper.MemberMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {
	
	private final MemberMapper memberMapper;
	private final PasswordEncoder passwordEncoder;

	// 아이디 중복 체크 로직
	public boolean isUsernameDuplicated(String id) {
		
		return memberMapper.countById(id);
	}

	@Override
	public void join(MemberDTO memberDTO) {
		
	    // 비밀번호 암호화
	    String encodedPassword = passwordEncoder.encode(memberDTO.getPassword());
	    memberDTO.setPassword(encodedPassword);
	    
	    // DB에 저장
	    memberMapper.insert(memberDTO);
	}

	@Override
	public MemberDTO findById(String id) {
	    return memberMapper.findById(id);
	}

	@Override
	public void update(MemberDTO memberDTO) {
	    // 비밀번호 암호화
	    String encodedPassword = passwordEncoder.encode(memberDTO.getPassword());
	    memberDTO.setPassword(encodedPassword);
	    
	    // DB 업데이트
	    memberMapper.update(memberDTO);
	}

	@Override
	public List<MemberDTO> findAll() {
		return memberMapper.findAll();
	}
	
	
}
