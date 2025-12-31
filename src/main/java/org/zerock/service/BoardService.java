package org.zerock.service;

import java.util.List;

import org.zerock.dto.BoardDTO;
import org.zerock.dto.PageDTO;

public interface BoardService {
	
	List<BoardDTO> findAll();
	
	// 페이징 처리된 게시글 목록 조회
	List<BoardDTO> findAllWithPaging(PageDTO pageDTO);
	
	// 전체 게시글 수 조회
	int getTotalCount();
	
	BoardDTO findById(Long id);
	
	Long write(BoardDTO boardDTO);
	
	void modify(BoardDTO boardDTO);
	
	void delete(Long id);
	
	void increaseViewCount(Long id);
}
