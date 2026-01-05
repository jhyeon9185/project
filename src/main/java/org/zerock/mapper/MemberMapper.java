package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.zerock.dto.MemberDTO;

@Mapper
public interface MemberMapper {
	
	List<MemberDTO> findAll();
	
	MemberDTO findById(String id);
	
	int insert(MemberDTO memberDTO);
	
	int update(MemberDTO memberDTO);
	
	int delete(String id);
	
	int disableMember(String id); 
	
	boolean countById(String id);
	

}
