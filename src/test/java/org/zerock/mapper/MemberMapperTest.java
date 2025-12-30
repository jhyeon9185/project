package org.zerock.mapper;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.zerock.dto.MemberDTO;

import lombok.extern.log4j.Log4j2;

@ExtendWith(SpringExtension.class)
@Log4j2
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
class MemberMapperTest {
	
	@Autowired
	private MemberMapper memberMapper;
	
	@Autowired
	private PasswordEncoder encoder;
	
	@Test
	void testFindAll() {
		
		List<MemberDTO> list = memberMapper.findAll();
		
		list.forEach(m -> log.info(m));
		
	}
	
	@Test
	void testFindById() {
		
		MemberDTO result = memberMapper.findById("admin");
		
		log.info(result);
		
	}
	
	@Test
	void insertTest() {
		// given
		MemberDTO memberDTO = new MemberDTO();
		
		memberDTO.setId("test");
		memberDTO.setPassword(encoder.encode("1234"));
		memberDTO.setName("오창준");
		memberDTO.setEmail("test@test.test");
		memberDTO.setPhone("010-1234-5678");

        // when
        int result = memberMapper.insert(memberDTO);

        // then
        log.info(result);
        
	}
	
	@Test
	void updateTest() {
		// given
		MemberDTO memberDTO = MemberDTO.builder()
				.password(encoder.encode("1111"))
				.email("dev@dev.dev")
				.build();
		memberMapper.insert(memberDTO);
		
		// when
		int result = memberMapper.update(memberDTO);
		
		log.info(result);
	}
}
