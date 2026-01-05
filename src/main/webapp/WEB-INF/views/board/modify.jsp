<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Edit Post</title>
    <style>
        /* 폰트 임포트 */
        @import url("https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.css");

        :root {
            --primary-color: #0071e3;
            --bg-color: #f5f5f7;
            --card-bg: #ffffff;
            --text-main: #1d1d1f;
            --text-sub: #86868b;
            --border-soft: #d2d2d7;
            --error-color: #ff3b30;
        }

        body {
            font-family: 'Pretendard', -apple-system, sans-serif;
            margin: 0;
            padding: 0;
            background-color: var(--bg-color);
            color: var(--text-main);
            -webkit-font-smoothing: antialiased;
        }

        /* 상단 내비게이션 바 (목록과 통일) */
        .top-nav {
            position: sticky;
            top: 0;
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(20px);
            z-index: 100;
            border-bottom: 1px solid #f2f2f2;
            padding: 0 40px;
            height: 52px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .nav-logo { font-weight: 700; font-size: 18px; text-decoration: none; color: var(--text-main); }
        .nav-link { font-size: 13px; text-decoration: none; color: var(--text-sub); font-weight: 500; }

        /* 헤더 섹션 */
        .modify-header {
            padding: 80px 20px 40px;
            text-align: center;
        }
        .modify-header h1 {
            font-size: 34px;
            font-weight: 700;
            letter-spacing: -1px;
            margin-bottom: 8px;
        }
        .modify-header p {
            color: var(--text-sub);
            font-size: 17px;
        }

        /* 메인 컨테이너 */
        .modify-container {
            max-width: 800px;
            margin: 0 auto 100px;
            background-color: var(--card-bg);
            padding: 50px;
            border-radius: 28px;
            box-shadow: 0 12px 40px rgba(0,0,0,0.03);
        }

        /* 경고 텍스트 박스 */
        .warning-text {
            color: var(--text-sub);
            background-color: #fbfbfd;
            border: 1px solid #efeff4;
            padding: 14px;
            border-radius: 12px;
            margin-bottom: 30px;
            font-size: 13px;
            text-align: center;
        }

        /* 포스트 요약 정보 (미니멀하게) */
        .post-info {
            display: flex;
            gap: 20px;
            margin-bottom: 40px;
            padding-bottom: 20px;
            border-bottom: 1px solid #f2f2f2;
        }
        .post-info-item {
            font-size: 13px;
            color: var(--text-sub);
        }
        .post-info-item strong {
            color: var(--text-main);
            margin-right: 4px;
        }

        /* 폼 스타일 */
        .form-group {
            margin-bottom: 32px;
        }
        .form-group label {
            display: block;
            margin-bottom: 10px;
            color: var(--text-main);
            font-weight: 600;
            font-size: 15px;
        }
        
        /* 입력창 디자인 */
        .form-group input[type="text"], 
        .form-group textarea {
            width: 100%;
            padding: 15px;
            border: 1px solid var(--border-soft);
            border-radius: 12px;
            font-size: 16px;
            font-family: inherit;
            box-sizing: border-box;
            background-color: #ffffff;
            transition: all 0.2s;
        }
        .form-group input[type="text"]:focus, 
        .form-group textarea:focus {
            border-color: var(--primary-color);
            outline: none;
            box-shadow: 0 0 0 4px rgba(0, 113, 227, 0.1);
        }

        .form-group textarea {
            min-height: 400px;
            line-height: 1.6;
            resize: none;
        }

        /* 작성자 정보 (읽기 전용) */
        .writer-info {
            color: var(--text-sub);
            font-size: 15px;
            padding: 5px 0;
        }

        /* 하단 카운트 및 부가정보 */
        .char-count {
            text-align: right;
            font-size: 12px;
            color: var(--text-sub);
            margin-top: 8px;
        }

        /* 버튼 컨테이너 */
        .btn-container {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 12px;
            margin-top: 50px;
            padding-top: 30px;
            border-top: 1px solid #f2f2f2;
        }

        .btn {
            padding: 12px 30px;
            border-radius: 40px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            text-decoration: none;
            border: none;
        }

        .btn-submit { background-color: #000; color: #fff; }
        .btn-submit:hover { background-color: #333; transform: translateY(-1px); }

        .btn-cancel { background-color: #f5f5f7; color: var(--text-main); }
        .btn-cancel:hover { background-color: #e8e8ed; }

        .btn-delete { background-color: transparent; color: var(--error-color); font-weight: 500; }
        .btn-delete:hover { text-decoration: underline; }

    </style>
</head>
<body>

    <nav class="top-nav">
        <div class="nav-menu">
            <a href="/board/list" class="nav-link">목록으로 돌아가기</a>
        </div>
    </nav>

    <div class="modify-header">
        <h1>게시글 수정</h1>
    </div>
    
    <div class="modify-container">
        <div class="warning-text">
            수정 완료 시 업데이트 일시가 최신화됩니다.
        </div>
        
        <div class="post-info">
            <div class="post-info-item"><strong>번호</strong> ${board.seq}</div>
            <div class="post-info-item">
                <strong>날짜</strong> 
                <c:choose>
                    <c:when test="${board.regdate != null}">${board.regdate.toString().substring(0, 10)}</c:when>
                    <c:otherwise>-</c:otherwise>
                </c:choose>
            </div>
            <div class="post-info-item"><strong>조회수</strong> ${board.hit}</div>
        </div>
        
        <form action="/board/modify/${board.seq}" method="post" onsubmit="return validateForm()">
            <div class="form-group">
                <label>작성자</label>
                <div class="writer-info">${board.writer}</div>
            </div>
            
            <div class="form-group">
                <label for="title">제목</label>
                <input type="text" id="title" name="title" required value="${board.title}" maxlength="200">
                <div class="char-count"><span id="titleCount">0</span> / 200</div>
            </div>
            
            <div class="form-group">
                <label for="content">내용</label>
                <textarea id="content" name="content" required>${board.content}</textarea>
                <div class="char-count"><span id="contentCount">0</span> characters</div>
            </div>
            
            <div class="btn-container">
                <button type="submit" class="btn btn-submit">수정하기</button>
                <a href="/board/${board.seq}" class="btn btn-cancel">취소</a>
                
                <sec:authorize access="isAuthenticated()">
                    <sec:authentication property="name" var="currentUser" />
                    <c:if test="${currentUser == board.writer || pageContext.request.isUserInRole('ROLE_ADMIN')}">
                        <button type="button" class="btn btn-delete" onclick="deletePost(${board.seq})">삭제</button>
                    </c:if>
                </sec:authorize>
            </div>
        </form>
    </div>

    <script>
        window.onload = () => { updateTitleCount(); updateContentCount(); };
        
        document.getElementById('title').addEventListener('input', updateTitleCount);
        document.getElementById('content').addEventListener('input', updateContentCount);
        
        function updateTitleCount() {
            const len = document.getElementById('title').value.length;
            const el = document.getElementById('titleCount');
            el.textContent = len;
            el.style.color = len > 180 ? 'var(--error-color)' : 'var(--text-sub)';
        }
        
        function updateContentCount() {
            document.getElementById('contentCount').textContent = document.getElementById('content').value.length;
        }
        
        function validateForm() {
            const title = document.getElementById('title').value.trim();
            const content = document.getElementById('content').value.trim();
            if (title.length < 2 || content.length < 10) {
                alert('제목은 2자, 내용은 10자 이상 입력해주세요.');
                return false;
            }
            return confirm('수정사항을 저장할까요?');
        }
        
        function deletePost(id) {
            if (confirm('삭제된 게시글은 복구할 수 없습니다. 정말 삭제할까요?')) {
                const form = document.createElement('form');
                form.method = 'POST'; form.action = '/board/delete/' + id;
                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</body>
</html>