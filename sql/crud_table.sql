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



