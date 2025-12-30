package org.zerock.mapper;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
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
	
	@Test
	void testFindAll() {
		
		List<MemberDTO> list = memberMapper.findAll();
		
		list.forEach(m -> log.info(m));
		
	}

}
