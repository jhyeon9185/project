package org.zerock.dto;

import java.time.LocalDateTime;

import lombok.Data;

/* -- 댓글 테이블
	CREATE TABLE reply (
	    rno INT AUTO_INCREMENT PRIMARY KEY,   -- 댓글 번호 (자동 증가)
	    bno INT NOT NULL,                      -- 게시글 번호 (외래키)
	    replyText VARCHAR(500) NOT NULL,      -- 댓글 내용
	    replyer VARCHAR(50) NOT NULL,         -- 댓글 작성자 아이디
	    replydate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- 댓글 작성일시
	    updatedate TIMESTAMP DEFAULT CURRENT_TIMESTAMP  -- 댓글 수정일시
	        ON UPDATE CURRENT_TIMESTAMP,
	    deflag BOOLEAN DEFAULT FALSE,         -- 삭제 여부 (논리적 삭제)
	    FOREIGN KEY (bno) REFERENCES board(seq) ON DELETE CASCADE
	);
*/

@Data
public class ReplyDTO {
	private int rno;
	private int bno;
	private String replyText;
	private String replyer;
	private LocalDateTime replydate;
	private LocalDateTime updatedate;
	private boolean deflag;
}
