package org.zerock.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.dto.BoardDTO;
import org.zerock.dto.PageDTO;
import org.zerock.mapper.BoardMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService {
	
	private final BoardMapper boardMapper;

	@Override
	public List<BoardDTO> findAll() {
		return boardMapper.findAll();
	}

	@Override
	public List<BoardDTO> findAllWithPaging(PageDTO pageDTO) {
		// 전체 게시글 수 조회 후 PageDTO에 설정
		int totalCount = boardMapper.getTotalCount();
		pageDTO.setTotal(totalCount);
		
		// 페이징 처리된 게시글 목록 조회
		return boardMapper.findAllWithPaging(pageDTO);
	}

	@Override
	public int getTotalCount() {
		return boardMapper.getTotalCount();
	}

	@Override
	public BoardDTO findById(Long id) {
		return boardMapper.findById(id);
	}

	@Override
	public Long write(BoardDTO boardDTO) {
		boardDTO.setRegdate(LocalDateTime.now());
		boardDTO.setHit(0);  // viewCount → hit
		boardDTO.setDelflag(false);
		boardMapper.insert(boardDTO);
		return boardDTO.getSeq();  // getId() → getSeq()
	}

	@Override
	public void modify(BoardDTO boardDTO) {
		boardDTO.setUpdatedate(LocalDateTime.now());  // moddate → updatedate
		boardMapper.update(boardDTO);
	}

	@Override
	public void delete(Long id) {
		boardMapper.delete(id);
	}

	@Override
	public void increaseViewCount(Long id) {
		boardMapper.increaseViewCount(id);
	}
}