package org.zerock.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class BoardDTO {
    private Long seq;           // id → seq
    private String title;
    private String content;
    private String writer;
    private LocalDateTime regdate;
    private LocalDateTime updatedate;  // moddate → updatedate
    private int hit;            // viewCount → hit
    private boolean delflag;    // 삭제 여부 추가
    
    // 기존 코드 호환성을 위한 getter/setter
    public Long getId() { return seq; }
    public void setId(Long id) { this.seq = id; }
    
    public LocalDateTime getModdate() { return updatedate; }
    public void setModdate(LocalDateTime moddate) { this.updatedate = moddate; }
    
    public int getViewCount() { return hit; }
    public void setViewCount(int viewCount) { this.hit = viewCount; }
}