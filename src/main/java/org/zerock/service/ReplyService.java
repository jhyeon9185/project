
package org.zerock.service;

import java.util.List;
import org.zerock.dto.ReplyDTO;

public interface ReplyService {
    // 특정 게시글의 댓글 목록 조회
    List<ReplyDTO> getRepliesByBno(int bno);
    
    // 댓글 작성
    Integer writeReply(ReplyDTO replyDTO);
    
    // 댓글 수정
    void modifyReply(ReplyDTO replyDTO);
    
    // 댓글 삭제
    void deleteReply(int rno);
    
    // 댓글 상세 조회
    ReplyDTO getReplyByRno(int rno);
    
    // 특정 게시글의 댓글 수 조회
    int getReplyCount(int bno);
}
