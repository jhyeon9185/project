package org.zerock.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
	
/*
 * CREATE TABLE board (
	    seq INT AUTO_INCREMENT PRIMARY KEY,   -- 글 번호 (자동 증가)
	    writer VARCHAR(50) NOT NULL,          -- 작성자 아이디
	    title VARCHAR(500) NOT NULL,          -- 글 제목
	    content TEXT NOT NULL,                -- 글 내용
	    hit INT DEFAULT 0,                    -- 조회수
	    regdate TIMESTAMP DEFAULT NOW(),      -- 작성일시
	    updatedate TIMESTAMP DEFAULT NOW()    -- 수정일시
	        ON UPDATE CURRENT_TIMESTAMP,
	    delflag BOOLEAN DEFAULT FALSE,        -- 삭제 여부 (논리적 삭제)
	    FOREIGN KEY (writer) REFERENCES members(id) ON DELETE CASCADE
	);
 * 
 * */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class BoardDTO {
	
	private int seq;
	private String writer;
	private String title;
	private String content;
	private int hit;
	private LocalDateTime regdate;
	private LocalDateTime updateDate;
	private boolean delflag;
	
}
