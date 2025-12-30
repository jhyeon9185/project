package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.zerock.dto.MemberDTO;

@Mapper
public interface MemberMapper {
	
	List<MemberDTO> findAll();
}
