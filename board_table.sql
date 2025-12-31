-- 게시판 테이블 생성
CREATE TABLE board (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,           -- 게시글 번호 (자동 증가)
    title VARCHAR(200) NOT NULL,                    -- 제목
    content TEXT,                                   -- 내용
    writer VARCHAR(50) NOT NULL,                    -- 작성자 ID
    regdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,   -- 작성일시
    moddate TIMESTAMP NULL,                         -- 수정일시
    view_count INT DEFAULT 0,                       -- 조회수
    
    -- 외래키 제약조건 (members 테이블과 연결)
    FOREIGN KEY (writer) REFERENCES members(id) ON DELETE CASCADE
);

-- 인덱스 생성 (성능 향상)
CREATE INDEX idx_board_writer ON board(writer);
CREATE INDEX idx_board_regdate ON board(regdate DESC);

-- 테스트 데이터 삽입
INSERT INTO board (title, content, writer, regdate, view_count) VALUES
('첫 번째 게시글', '안녕하세요! 첫 번째 게시글입니다.', 'admin', NOW(), 0),
('두 번째 게시글', '두 번째 게시글 내용입니다.', 'admin', NOW(), 5),
('세 번째 게시글', '세 번째 게시글 내용입니다.', 'user1', NOW(), 3);