<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시글 상세보기</title>
    <style>
        @import url("https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.css");

        :root {
            --primary-color: #0071e3;
            --bg-color: #ffffff;
            --text-main: #1d1d1f;
            --text-sub: #86868b;
            --line-color: #f2f2f2;
            --error-red: #ff3b30;
        }

        body {
            font-family: 'Pretendard', -apple-system, sans-serif;
            margin: 0;
            padding: 0;
            background-color: var(--bg-color);
            color: var(--text-main);
            line-height: 1.6;
            -webkit-font-smoothing: antialiased;
        }

        /* 최상단 진행 바 (디테일 요소) */
        .top-bar {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: var(--line-color);
            z-index: 1000;
        }

        .container {
            max-width: 720px; /* 본문 집중을 위해 폭을 좁힘 */
            margin: 0 auto;
            padding: 100px 24px;
        }

        /* 헤더 섹션: 더 과감하고 깔끔하게 */
        .post-header {
            margin-bottom: 60px;
        }

        .category-tag {
            font-size: 14px;
            font-weight: 600;
            color: var(--primary-color);
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 16px;
            display: block;
        }

        .post-title {
            font-size: 42px;
            font-weight: 700;
            letter-spacing: -1.8px;
            line-height: 1.2;
            margin: 0 0 32px 0;
            word-break: keep-all;
        }

        .post-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 30px;
            border-bottom: 1px solid var(--line-color);
        }

        .writer-box {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .writer-avatar {
            width: 40px;
            height: 40px;
            background-color: #f5f5f7;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            color: var(--text-sub);
            font-size: 14px;
        }

        .writer-info-text {
            display: flex;
            flex-direction: column;
        }

        .writer-name {
            font-weight: 600;
            font-size: 15px;
        }

        .post-date {
            font-size: 13px;
            color: var(--text-sub);
        }

        .post-stats {
            font-size: 13px;
            color: var(--text-sub);
        }

        /* 본문 영역: 박스 테두리 제거, 폰트 최적화 */
        .post-body {
            padding: 40px 0;
            font-size: 18px; /* 가독성을 위해 살짝 키움 */
            line-height: 1.85;
            color: #333333;
            min-height: 400px;
        }

        .post-body p {
            margin-bottom: 24px;
        }

        /* 하단 액션 바 */
        .post-footer {
            margin-top: 80px;
            padding-top: 40px;
            border-top: 1px solid var(--line-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .btn-group {
            display: flex;
            gap: 8px;
            align-items: center;
        }

        .btn {
            padding: 10px 20px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            border: none;
        }

        /* 기본 버튼 - 투명 배경 */
        .btn-ghost {
            background-color: transparent;
            color: var(--text-sub);
        }
        .btn-ghost:hover {
            background-color: #f5f5f7;
            color: var(--text-main);
        }

        /* 강조 버튼 - 블랙 */
        .btn-dark {
            background-color: #1d1d1f;
            color: #ffffff;
        }
        .btn-dark:hover {
            background-color: #000000;
            transform: translateY(-1px);
        }

        /* 삭제 버튼 - 레드 */
        .btn-danger {
            color: var(--error-red);
        }
        .btn-danger:hover {
            background-color: #fff2f1;
        }

        .admin-label {
            font-size: 11px;
            background: #f5f5f7;
            padding: 2px 6px;
            border-radius: 4px;
            margin-left: 6px;
            color: var(--text-sub);
        }

        /* 댓글 섹션 스타일 */
        .comments-section {
            margin-top: 60px;
            padding-top: 40px;
            border-top: 1px solid var(--line-color);
        }

        .comments-header h3 {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 30px;
            color: var(--text-main);
        }

        .comment-count {
            color: var(--primary-color);
            font-size: 18px;
        }

        .comment-form {
            margin-bottom: 40px;
        }

        .comment-input-box {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .comment-input-box textarea {
            width: 100%;
            padding: 16px;
            border: 1px solid var(--line-color);
            border-radius: 8px;
            font-size: 14px;
            font-family: inherit;
            resize: vertical;
            min-height: 80px;
            box-sizing: border-box;
        }

        .comment-input-box textarea:focus {
            outline: none;
            border-color: var(--primary-color);
        }

        .comment-input-box .btn {
            align-self: flex-end;
            margin-top: 8px;
        }

        .comment-login-notice {
            text-align: center;
            padding: 30px;
            background-color: #f8f9fa;
            border-radius: 8px;
            margin-bottom: 30px;
        }

        .comment-login-notice a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 600;
        }

        .comments-list {
            margin-top: 30px;
        }

        .comment-item {
            padding: 20px 0;
            border-bottom: 1px solid var(--line-color);
        }

        .comment-item:last-child {
            border-bottom: none;
        }

        .comment-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
        }

        .comment-writer {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .comment-writer .writer-avatar {
            width: 32px;
            height: 32px;
            font-size: 12px;
        }

        .comment-writer .writer-name {
            font-weight: 600;
            font-size: 14px;
        }

        .comment-date {
            font-size: 12px;
            color: var(--text-sub);
        }

        .comment-actions {
            display: flex;
            gap: 8px;
        }

        .btn-small {
            padding: 4px 8px;
            font-size: 12px;
            border: none;
            background: transparent;
            color: var(--text-sub);
            cursor: pointer;
            border-radius: 4px;
        }

        .btn-small:hover {
            background-color: #f5f5f7;
            color: var(--text-main);
        }

        .btn-small.btn-danger {
            color: var(--error-red);
        }

        .btn-small.btn-danger:hover {
            background-color: #fff2f1;
        }

        .btn-small.btn-dark {
            background-color: #1d1d1f;
            color: white;
        }

        .btn-small.btn-dark:hover {
            background-color: #000000;
        }

        .comment-content {
            margin-left: 42px;
        }

        .reply-text {
            margin: 0;
            line-height: 1.6;
            color: var(--text-main);
        }

        .reply-edit-text {
            width: 100%;
            padding: 12px;
            border: 1px solid var(--line-color);
            border-radius: 6px;
            font-size: 14px;
            font-family: inherit;
            resize: vertical;
            box-sizing: border-box;
        }

        .edit-actions {
            margin-top: 8px;
            display: flex;
            gap: 8px;
        }

        .no-comments {
            text-align: center;
            padding: 40px;
            color: var(--text-sub);
        }
    </style>
</head>
<body>

    <div class="top-bar"></div>
    <div class="container">
        <header class="post-header">
            <h1 class="post-title">${board.title}</h1>
            
            <div class="post-meta">
                <div class="writer-box">
                    <div class="writer-avatar">${board.writer.substring(0,1).toUpperCase()}</div>
                    <div class="writer-info-text">
                        <span class="writer-name">${board.writer}</span>
                        <span class="post-date">
                            <c:choose>
                                <c:when test="${board.regdate != null}">
                                    ${board.regdate.toString().substring(0, 10)}
                                </c:when>
                                <c:otherwise>날짜 미상</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                </div>
                <div class="post-stats">
                    조회수 ${board.viewCount}
                </div>
            </div>
        </header>
        
        <main class="post-body">
            <c:choose>
                <c:when test="${not empty board.content}">
                    ${board.content}
                </c:when>
                <c:otherwise>
                    <p style="color: var(--text-sub); text-align: center;">작성된 내용이 없습니다.</p>
                </c:otherwise>
            </c:choose>
        </main>
        
        <!-- 댓글 섹션 -->
        <section class="comments-section">
            <div class="comments-header">
                <h3>댓글 <span class="comment-count">${replyCount}</span></h3>
            </div>
            
            <!-- 댓글 작성 폼 (로그인한 사용자만) -->
            <sec:authorize access="isAuthenticated()">
                <div class="comment-form">
                    <div class="comment-input-box">
                        <textarea id="replyText" placeholder="댓글을 입력하세요..." rows="3"></textarea>
                        <button type="button" class="btn btn-dark" onclick="writeReply()">댓글 작성</button>
                    </div>
                </div>
            </sec:authorize>
            
            <!-- 로그인하지 않은 사용자 -->
            <sec:authorize access="!isAuthenticated()">
                <div class="comment-login-notice">
                    <p>댓글을 작성하려면 <a href="/member/login">로그인</a>이 필요합니다.</p>
                </div>
            </sec:authorize>
            
            <!-- 댓글 목록 -->
            <div class="comments-list" id="commentsList">
                <c:forEach var="reply" items="${replies}">
                    <div class="comment-item" data-rno="${reply.rno}">
                        <div class="comment-header">
                            <div class="comment-writer">
                                <div class="writer-avatar">${reply.replyer.substring(0,1).toUpperCase()}</div>
                                <span class="writer-name">${reply.replyer}</span>
                                <span class="comment-date">
                                    <c:choose>
                                        <c:when test="${reply.replydate != null}">
                                            ${reply.replydate.toString().substring(0, 16)}
                                        </c:when>
                                        <c:otherwise>날짜 미상</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                            
                            <!-- 댓글 수정/삭제 버튼 (작성자 본인만) -->
                            <sec:authorize access="isAuthenticated()">
                                <sec:authentication property="name" var="currentUser" />
                                <c:if test="${currentUser == reply.replyer}">
                                    <div class="comment-actions">
                                        <button type="button" class="btn-small" onclick="editReply(${reply.rno})">수정</button>
                                        <button type="button" class="btn-small btn-danger" onclick="deleteReply(${reply.rno})">삭제</button>
                                    </div>
                                </c:if>
                            </sec:authorize>
                        </div>
                        <div class="comment-content">
                            <p class="reply-text">${reply.replyText}</p>
                            <textarea class="reply-edit-text" style="display: none;" rows="2">${reply.replyText}</textarea>
                            <div class="edit-actions" style="display: none;">
                                <button type="button" class="btn-small btn-dark" onclick="updateReply(${reply.rno})">저장</button>
                                <button type="button" class="btn-small" onclick="cancelEdit(${reply.rno})">취소</button>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                
                <c:if test="${empty replies}">
                    <div class="no-comments">
                        <p>아직 댓글이 없습니다. 첫 번째 댓글을 작성해보세요!</p>
                    </div>
                </c:if>
            </div>
        </section>
        
        <footer class="post-footer">
            <a href="/board/list" class="btn btn-ghost">목록으로 돌아가기</a>
            
            <div class="btn-group">
                <sec:authorize access="isAuthenticated()">
                    <sec:authentication property="name" var="currentUser" />
                    
                    <%-- 작성자 본인 권한 --%>
                    <c:if test="${currentUser == board.writer}">
                        <a href="/board/modify/${board.id}" class="btn btn-ghost">수정</a>
                        <button type="button" class="btn btn-ghost btn-danger" onclick="deletePost(${board.id})">삭제</button>
                    </c:if>

                    <%-- 관리자 권한 --%>
                    <sec:authorize access="hasRole('ADMIN')">
                        <c:if test="${currentUser != board.writer}">
                            <a href="/board/modify/${board.id}" class="btn btn-ghost">수정 <span class="admin-label">관리자</span></a>
                            <button type="button" class="btn btn-ghost btn-danger" onclick="deletePost(${board.id})">삭제 <span class="admin-label">관리자</span></button>
                        </c:if>
                    </sec:authorize>
                    
                    <a href="/board/write" class="btn btn-dark">글쓰기</a>
                    
                </sec:authorize>
            </div>
        </footer>
    </div>

    <script>
        function deletePost(boardId) {
            if (confirm('이 게시글을 삭제하시겠습니까?')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '/board/delete/' + boardId;
                const methodInput = document.createElement('input');
                methodInput.type = 'hidden';
                methodInput.name = '_method';
                methodInput.value = 'DELETE';
                form.appendChild(methodInput);
                document.body.appendChild(form);
                form.submit();
            }
        }

        // 댓글 작성
        function writeReply() {
            const replyText = document.getElementById('replyText').value.trim();
            if (!replyText) {
                alert('댓글 내용을 입력해주세요.');
                return;
            }

            const replyData = {
                bno: ${board.seq},
                replyText: replyText
            };

            fetch('/api/replies', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(replyData)
            })
            .then(response => {
                if (response.ok) {
                    alert('댓글이 작성되었습니다.');
                    location.reload(); // 페이지 새로고침
                } else {
                    alert('댓글 작성에 실패했습니다.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('댓글 작성 중 오류가 발생했습니다.');
            });
        }

        // 댓글 수정 모드 전환
        function editReply(rno) {
            const commentItem = document.querySelector(`[data-rno="\${rno}"]`);
            const replyText = commentItem.querySelector('.reply-text');
            const editText = commentItem.querySelector('.reply-edit-text');
            const editActions = commentItem.querySelector('.edit-actions');

            replyText.style.display = 'none';
            editText.style.display = 'block';
            editActions.style.display = 'flex';
        }

        // 댓글 수정 취소
        function cancelEdit(rno) {
            const commentItem = document.querySelector(`[data-rno="\${rno}"]`);
            const replyText = commentItem.querySelector('.reply-text');
            const editText = commentItem.querySelector('.reply-edit-text');
            const editActions = commentItem.querySelector('.edit-actions');

            replyText.style.display = 'block';
            editText.style.display = 'none';
            editActions.style.display = 'none';
        }

        // 댓글 수정 저장
        function updateReply(rno) {
            const commentItem = document.querySelector(`[data-rno="\${rno}"]`);
            const editText = commentItem.querySelector('.reply-edit-text');
            const newText = editText.value.trim();

            if (!newText) {
                alert('댓글 내용을 입력해주세요.');
                return;
            }

            const replyData = {
                replyText: newText
            };

            fetch(`/api/replies/\${rno}`, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(replyData)
            })
            .then(response => {
                if (response.ok) {
                    alert('댓글이 수정되었습니다.');
                    location.reload();
                } else {
                    alert('댓글 수정에 실패했습니다.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('댓글 수정 중 오류가 발생했습니다.');
            });
        }

        // 댓글 삭제
        function deleteReply(rno) {
            if (!confirm('이 댓글을 삭제하시겠습니까?')) {
                return;
            }

            fetch(`/api/replies/\${rno}`, {
                method: 'DELETE'
            })
            .then(response => {
                if (response.ok) {
                    alert('댓글이 삭제되었습니다.');
                    location.reload();
                } else {
                    alert('댓글 삭제에 실패했습니다.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('댓글 삭제 중 오류가 발생했습니다.');
            });
        }
    </script>
</body>
</html>