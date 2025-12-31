package org.zerock.dto;

import lombok.Data;

@Data
public class PageDTO {
    private int page = 1;           // 현재 페이지 번호 (기본값: 1)
    private int size = 10;          // 페이지당 게시글 수 (기본값: 10)
    private int total;              // 전체 게시글 수
    
    // 계산된 값들
    private int startPage;          // 페이지 네비게이션 시작 번호
    private int endPage;            // 페이지 네비게이션 끝 번호
    private int totalPages;         // 전체 페이지 수
    private boolean prev;           // 이전 페이지 그룹 존재 여부
    private boolean next;           // 다음 페이지 그룹 존재 여부
    
    private static final int PAGE_GROUP_SIZE = 10; // 페이지 네비게이션에 표시할 페이지 수
    
    public PageDTO() {
        this(1, 10);
    }
    
    public PageDTO(int page, int size) {
        this.page = page;
        this.size = size;
    }
    
    // 전체 게시글 수를 설정하면 페이징 정보를 자동 계산
    public void setTotal(int total) {
        this.total = total;
        calcPageInfo();
    }
    
    // 페이징 정보 계산
    private void calcPageInfo() {
        // 전체 페이지 수 계산
        this.totalPages = (int) Math.ceil((double) total / size);
        
        // 현재 페이지가 전체 페이지 수를 초과하지 않도록 조정
        if (this.page > totalPages && totalPages > 0) {
            this.page = totalPages;
        }
        
        // 페이지 네비게이션 시작/끝 번호 계산
        int tempEndPage = (int) Math.ceil((double) page / PAGE_GROUP_SIZE) * PAGE_GROUP_SIZE;
        this.startPage = tempEndPage - PAGE_GROUP_SIZE + 1;
        this.endPage = Math.min(tempEndPage, totalPages);
        
        // 이전/다음 페이지 그룹 존재 여부
        this.prev = startPage > 1;
        this.next = endPage < totalPages;
    }
    
    // MyBatis에서 사용할 OFFSET 값 (0부터 시작)
    public int getOffset() {
        return (page - 1) * size;
    }
    
    // MyBatis에서 사용할 LIMIT 값
    public int getLimit() {
        return size;
    }
}