SELECT id, password, name, email, role, phone, regdate, enabled 
FROM members 
ORDER BY regdate DESC;


-- 관리자 계정 (비밀번호: admin123)
INSERT INTO members (id, password, name, email, role, phone, enabled) 
VALUES ('admin', '$2a$10$N.zmdr9rW6K7e1SyRzd/I.eFD0PnYMwZz.6YwQxZ.9Nv6ynO4qP2e', 
        '관리자', 'admin@daechul.com', 'ADMIN', '010-1234-5678', true);
INSERT INTO member_roles (id, role) VALUES ('admin', 'ROLE_ADMIN');

-- 일반 회원 계정 (비밀번호: user123)
INSERT INTO members (id, password, name, email, role, phone, enabled) 
VALUES ('user01', '$2a$10$dXJ3SW6G7P50lGmMkkmwe.20cQQubK3.HZWzG3YB1tlRy.fqvM/BG', 
        '홍길동', 'user01@daechul.com', 'MEMBER', '010-9876-5432', true);
INSERT INTO member_roles (id, role) VALUES ('user01', 'ROLE_MEMBER');

-- 테스트 게시글
INSERT INTO board (writer, title, content) VALUES 
('admin', '공지사항입니다', '대출 프로젝트 게시판에 오신 것을 환영합니다.'),
('user01', '첫 번째 게시글', '게시판 테스트 글입니다.');

-- 테스트 댓글
INSERT INTO reply (bno, replyText, replyer) VALUES 
(1, '좋은 정보 감사합니다!', 'user01'),
(1, '공지사항 확인했습니다.', 'user01');

select * from members;

select * from board;

UPDATE members SET role = 'MEMBER' WHERE role IS NULL;