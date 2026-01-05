package org.zerock.service;

import java.util.List;

import org.zerock.dto.MemberDTO;

public interface MemberService {
	
	boolean isUsernameDuplicated(String id);

	void join(MemberDTO memberDTO);

	MemberDTO findById(String name);

	void update(MemberDTO memberDTO);
	
	void delete(String id);
	
	boolean deletePwd(String id, String password);
	
	List<MemberDTO> findAll();

}
