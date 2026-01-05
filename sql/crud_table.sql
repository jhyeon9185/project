use testdb;

-- 회원 테이블 member
CREATE TABLE members (
    id VARCHAR(50) PRIMARY KEY,           -- 회원 아이디 (고유 키)
    password VARCHAR(200) NOT NULL,       -- 암호화된 비밀번호
    name VARCHAR(100) NOT NULL,           -- 회원 이름
    email VARCHAR(200) NOT NULL,          -- 이메일
    role VARCHAR(20) DEFAULT 'MEMBER',    -- 권한 (MEMBER 또는 ADMIN)
    phone VARCHAR(20),                    -- 전화번호 (선택)
    regdate TIMESTAMP DEFAULT NOW(),      -- 가입일시 (자동 입력)
    enabled BOOLEAN DEFAULT TRUE          -- 계정 활성화 여부
);

-- 회원 권한 테이블
CREATE TABLE member_roles (
    id VARCHAR(50) NOT NULL,              -- 회원 아이디
    role VARCHAR(50) NOT NULL,            -- 권한 이름
    PRIMARY KEY (id, role),               -- 복합 키 (둘 다 합쳐서 고유)
    FOREIGN KEY (id) REFERENCES members(id) ON DELETE CASCADE
);

-- 로그인 유지 테이블 
CREATE TABLE persistent_logins (
    username VARCHAR(64) NOT NULL,        -- 사용자 아이디
    series VARCHAR(64) PRIMARY KEY,       -- 시리즈 토큰 (고유 키)
    token VARCHAR(64) NOT NULL,           -- 인증 토큰
    last_used TIMESTAMP NOT NULL          -- 마지막 사용 시간
);

-- 게시판 테이블
CREATE TABLE board (
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


-- 댓글 테이블
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

select * from reply;

select * from board;

INSERT INTO members (id, password, name, email, role) VALUES 
('devmaster', '1111', '관리자', 'admin@test.com', 'ADMIN'),
('user1', '1111', '유저1', 'user1@test.com', 'MEMBER'),
('user2', '1111', '유저2', 'user2@test.com', 'MEMBER'),
('user3', '1111', '유저3', 'user3@test.com', 'MEMBER');

INSERT INTO board (title, content, writer, regdate, hit, delflag) VALUES
('첫 번째 게시글입니다', '첫 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'admin', NOW(), 15, FALSE),
('두 번째 게시글입니다', '두 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user1', NOW(), 8, FALSE),
('세 번째 게시글입니다', '세 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user2', NOW(), 12, FALSE),
('네 번째 게시글입니다', '네 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'admin', NOW(), 20, FALSE),
('다섯 번째 게시글입니다', '다섯 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user3', NOW(), 5, FALSE),
('여섯 번째 게시글입니다', '여섯 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user1', NOW(), 18, FALSE),
('일곱 번째 게시글입니다', '일곱 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user2', NOW(), 7, FALSE),
('여덟 번째 게시글입니다', '여덟 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'admin', NOW(), 25, FALSE),
('아홉 번째 게시글입니다', '아홉 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user3', NOW(), 11, FALSE),
('열 번째 게시글입니다', '열 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user1', NOW(), 14, FALSE),
('열한 번째 게시글입니다', '열한 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user2', NOW(), 9, FALSE),
('열두 번째 게시글입니다', '열두 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'admin', NOW(), 22, FALSE),
('열세 번째 게시글입니다', '열세 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user3', NOW(), 6, FALSE),
('열네 번째 게시글입니다', '열네 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user1', NOW(), 17, FALSE),
('열다섯 번째 게시글입니다', '열다섯 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user2', NOW(), 13, FALSE),
('열여섯 번째 게시글입니다', '열여섯 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'admin', NOW(), 19, FALSE),
('열일곱 번째 게시글입니다', '열일곱 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user3', NOW(), 10, FALSE),
('열여덟 번째 게시글입니다', '열여덟 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user1', NOW(), 16, FALSE),
('열아홉 번째 게시글입니다', '열아홉 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user2', NOW(), 21, FALSE),
('스무 번째 게시글입니다', '스무 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'admin', NOW(), 4, FALSE),
('스물한 번째 게시글입니다', '스물한 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user3', NOW(), 23, FALSE),
('스물두 번째 게시글입니다', '스물두 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user1', NOW(), 8, FALSE),
('스물세 번째 게시글입니다', '스물세 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user2', NOW(), 15, FALSE),
('스물네 번째 게시글입니다', '스물네 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'admin', NOW(), 12, FALSE),
('스물다섯 번째 게시글입니다', '스물다섯 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user3', NOW(), 18, FALSE);

-- 데이터 확인
SELECT COUNT(*) as total_posts FROM board WHERE delflag = FALSE;
SELECT * FROM board WHERE delflag = FALSE ORDER BY regdate DESC LIMIT 10;

INSERT INTO board (title, content, writer, regdate, hit, delflag) VALUES
('첫 번째 게시글입니다', '첫 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'admin', NOW(), 15, FALSE),
('두 번째 게시글입니다', '두 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user1', NOW(), 8, FALSE),
('세 번째 게시글입니다', '세 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user2', NOW(), 12, FALSE),
('네 번째 게시글입니다', '네 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'admin', NOW(), 20, FALSE),
('다섯 번째 게시글입니다', '다섯 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user3', NOW(), 5, FALSE),
('여섯 번째 게시글입니다', '여섯 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user1', NOW(), 18, FALSE),
('일곱 번째 게시글입니다', '일곱 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user2', NOW(), 7, FALSE),
('여덟 번째 게시글입니다', '여덟 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'admin', NOW(), 25, FALSE),
('아홉 번째 게시글입니다', '아홉 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user3', NOW(), 11, FALSE),
('열 번째 게시글입니다', '열 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user1', NOW(), 14, FALSE),
('열한 번째 게시글입니다', '열한 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user2', NOW(), 9, FALSE),
('열두 번째 게시글입니다', '열두 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'admin', NOW(), 22, FALSE),
('열세 번째 게시글입니다', '열세 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user3', NOW(), 6, FALSE),
('열네 번째 게시글입니다', '열네 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user1', NOW(), 17, FALSE),
('열다섯 번째 게시글입니다', '열다섯 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user2', NOW(), 13, FALSE),
('열여섯 번째 게시글입니다', '열여섯 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'admin', NOW(), 19, FALSE),
('열일곱 번째 게시글입니다', '열일곱 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user3', NOW(), 10, FALSE),
('열여덟 번째 게시글입니다', '열여덟 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user1', NOW(), 16, FALSE),
('열아홉 번째 게시글입니다', '열아홉 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user2', NOW(), 21, FALSE),
('스무 번째 게시글입니다', '스무 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'admin', NOW(), 4, FALSE),
('스물한 번째 게시글입니다', '스물한 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user3', NOW(), 23, FALSE),
('스물두 번째 게시글입니다', '스물두 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user1', NOW(), 8, FALSE),
('스물세 번째 게시글입니다', '스물세 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user2', NOW(), 15, FALSE),
('스물네 번째 게시글입니다', '스물네 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'admin', NOW(), 12, FALSE),
('스물다섯 번째 게시글입니다', '스물다섯 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user3', NOW(), 18, FALSE),
('스물여섯 번째 게시글입니다', '스물여섯 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'admin', NOW(), 11, FALSE),
('스물일곱 번째 게시글입니다', '스물일곱 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user1', NOW(), 24, FALSE),
('스물여덟 번째 게시글입니다', '스물여덟 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user2', NOW(), 7, FALSE),
('스물아홉 번째 게시글입니다', '스물아홉 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user3', NOW(), 16, FALSE),
('서른 번째 게시글입니다', '서른 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'admin', NOW(), 13, FALSE),
('서른한 번째 게시글입니다', '서른한 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user1', NOW(), 20, FALSE),
('서른두 번째 게시글입니다', '서른두 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user2', NOW(), 9, FALSE),
('서른세 번째 게시글입니다', '서른세 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user3', NOW(), 17, FALSE),
('서른네 번째 게시글입니다', '서른네 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'admin', NOW(), 14, FALSE),
('서른다섯 번째 게시글입니다', '서른다섯 번째 게시글의 내용입니다. 페이징 테스트를 위한 샘플 데이터입니다.', 'user1', NOW(), 19, FALSE);

-- 데이터 확인
SELECT COUNT(*) as total_posts FROM board WHERE delflag = FALSE;
SELECT * FROM board WHERE delflag = FALSE ORDER BY regdate DESC LIMIT 10;


select * from members;

delete from members
where id = "오창준주니어";