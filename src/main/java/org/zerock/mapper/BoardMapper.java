package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.zerock.dto.BoardDTO;
import org.zerock.dto.PageDTO;

@Mapper
public interface BoardMapper {
	
	List<BoardDTO> findAll();
	
	// 페이징 처리된 게시글 목록 조회
	List<BoardDTO> findAllWithPaging(PageDTO pageDTO);
	
	// 전체 게시글 수 조회 (삭제되지 않은 글만)
	int getTotalCount();
	
	BoardDTO findById(Long seq);
	
	int insert(BoardDTO boardDTO);
	
	int update(BoardDTO boardDTO);
	
	int delete(Long seq);
	
	int increaseViewCount(Long seq);
}