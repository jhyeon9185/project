package org.zerock.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.dto.ReplyDTO;
import org.zerock.mapper.ReplyMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReplyServiceImpl implements ReplyService{
	
	private final ReplyMapper replyMapper;
	
	@Override
	public List<ReplyDTO> getRepliesByBno(int bno){
		
		return replyMapper.findByBno(bno);
	}

	@Override
	public Integer writeReply(ReplyDTO replyDTO) {
		replyMapper.insert(replyDTO);
		return replyDTO.getRno();
	}

	@Override
	public void modifyReply(ReplyDTO replyDTO) {
		replyMapper.update(replyDTO);
		
	}

	@Override
	public void deleteReply(int rno) {
		replyMapper.delete(rno);
		
	}

	@Override
	public ReplyDTO getReplyByRno(int rno) {
		return replyMapper.findByRno(rno);
	}

	@Override
	public int getReplyCount(int bno) {
		return replyMapper.countByBno(bno);
	}
	
	
}
