package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.zerock.dto.ReplyDTO;

@Mapper
public interface ReplyMapper {
	
	// 게시글 댓글 목록 조회
	List<ReplyDTO> findByBno(int bno);
	
	// 댓글 작성 
	int insert(ReplyDTO replyDTO);
	
	// 댓글 수정
	int update(ReplyDTO replyDTO);
	
	// 댓글 삭제
	int delete(int rno);
	
	// 댓글 상세 조회
	ReplyDTO findByRno(int rno);
	
	// 게시글의 댓글 수 조회
	int countByBno(int bno);
	
	
}
