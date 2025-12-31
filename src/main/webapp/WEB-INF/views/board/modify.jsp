<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 수정</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f8f9fa;
        }
        .modify-header {
            background-color: #ffc107;
            color: #212529;
            padding: 20px;
            text-align: center;
            border-radius: 10px;
            margin-bottom: 20px;
        }
        .modify-container {
            max-width: 800px;
            margin: 0 auto;
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: bold;
            font-size: 14px;
        }
        .form-group input[type="text"] {
            width: 100%;
            padding: 12px;
            border: 2px solid #dee2e6;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
        }
        .form-group input[type="text"]:focus {
            border-color: #ffc107;
            outline: none;
        }
        .form-group textarea {
            width: 100%;
            min-height: 300px;
            padding: 12px;
            border: 2px solid #dee2e6;
            border-radius: 5px;
            font-size: 14px;
            line-height: 1.6;
            resize: vertical;
            box-sizing: border-box;
        }
        .form-group textarea:focus {
            border-color: #ffc107;
            outline: none;
        }
        .writer-info {
            background-color: #f8f9fa;
            padding: 12px;
            border-radius: 5px;
            color: #6c757d;
            font-size: 14px;
            border: 1px solid #dee2e6;
        }
        .post-info {
            background-color: #e9ecef;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            border-left: 4px solid #ffc107;
        }
        .post-info-item {
            margin-bottom: 5px;
            font-size: 14px;
            color: #495057;
        }
        .btn-container {
            text-align: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #dee2e6;
        }
        .btn {
            padding: 12px 30px;
            margin: 0 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            text-decoration: none;
            display: inline-block;
        }
        .btn-warning {
            background-color: #ffc107;
            color: #212529;
        }
        .btn-warning:hover {
            background-color: #e0a800;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        .btn-secondary:hover {
            background-color: #545b62;
        }
        .btn-danger {
            background-color: #dc3545;
            color: white;
        }
        .btn-danger:hover {
            background-color: #c82333;
        }
        .required {
            color: #dc3545;
        }
        .char-count {
            text-align: right;
            font-size: 12px;
            color: #6c757d;
            margin-top: 5px;
        }
        .warning-text {
            color: #856404;
            background-color: #fff3cd;
            border: 1px solid #ffeaa7;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="modify-header">
        <h1>✏️ 게시글 수정</h1>
        <p>게시글을 수정하세요</p>
    </div>
    
    <div class="modify-container">
        <div class="warning-text">
            ⚠️ 게시글 수정 시 수정일시가 업데이트됩니다.
        </div>
        
        <div class="post-info">
            <div class="post-info-item">
                <strong>게시글 번호:</strong> ${board.seq}
            </div>
            <div class="post-info-item">
                <strong>작성일:</strong> 
                <c:choose>
                    <c:when test="${board.regdate != null}">
                        ${board.regdate.toString().substring(0, 19).replace('T', ' ')}
                    </c:when>
                    <c:otherwise>미등록</c:otherwise>
                </c:choose>
            </div>
            <c:if test="${board.updatedate != null}">
                <div class="post-info-item">
                    <strong>최근 수정일:</strong> 
                    ${board.updatedate.toString().substring(0, 19).replace('T', ' ')}
                </div>
            </c:if>
            <div class="post-info-item">
                <strong>조회수:</strong> ${board.hit}
            </div>
        </div>
        
        <form action="/board/modify/${board.seq}" method="post" onsubmit="return validateForm()">
            <div class="form-group">
                <label for="writer">작성자</label>
                <div class="writer-info">
                    <strong>${board.writer}</strong> (수정 불가)
                </div>
            </div>
            
            <div class="form-group">
                <label for="title">제목 <span class="required">*</span></label>
                <input type="text" id="title" name="title" required 
                       value="${board.title}" maxlength="200">
                <div class="char-count">
                    <span id="titleCount">${board.title.length()}</span> / 200자
                </div>
            </div>
            
            <div class="form-group">
                <label for="content">내용 <span class="required">*</span></label>
                <textarea id="content" name="content" required>${board.content}</textarea>
                <div class="char-count">
                    <span id="contentCount">${board.content.length()}</span>자
                </div>
            </div>
            
            <div class="btn-container">
                <button type="submit" class="btn btn-warning">💾 수정완료</button>
                <a href="/board/${board.seq}" class="btn btn-secondary">취소</a>
                
                <!-- 삭제 버튼 (작성자 본인 또는 관리자만) -->
                <sec:authorize access="isAuthenticated()">
                    <sec:authentication property="name" var="currentUser" />
                    <c:if test="${currentUser == board.writer}">
                        <button type="button" class="btn btn-danger" onclick="deletePost(${board.seq})">🗑️ 삭제</button>
                    </c:if>
                </sec:authorize>
                
                <!-- 관리자는 모든 게시글 삭제 가능 -->
                <sec:authorize access="hasRole('ADMIN')">
                    <c:if test="${currentUser != board.writer}">
                        <button type="button" class="btn btn-danger" onclick="deletePost(${board.seq})">🗑️ 삭제 (관리자)</button>
                    </c:if>
                </sec:authorize>
            </div>
        </form>
    </div>

    <script>
        // 초기 글자수 설정
        window.onload = function() {
            updateTitleCount();
            updateContentCount();
        };
        
        // 제목 글자수 카운트
        document.getElementById('title').addEventListener('input', updateTitleCount);
        
        function updateTitleCount() {
            const titleLength = document.getElementById('title').value.length;
            document.getElementById('titleCount').textContent = titleLength;
            
            if (titleLength > 180) {
                document.getElementById('titleCount').style.color = '#dc3545';
            } else {
                document.getElementById('titleCount').style.color = '#6c757d';
            }
        }
        
        // 내용 글자수 카운트
        document.getElementById('content').addEventListener('input', updateContentCount);
        
        function updateContentCount() {
            const contentLength = document.getElementById('content').value.length;
            document.getElementById('contentCount').textContent = contentLength;
        }
        
        // 폼 검증
        function validateForm() {
            const title = document.getElementById('title').value.trim();
            const content = document.getElementById('content').value.trim();
            
            if (!title) {
                alert('제목을 입력해주세요.');
                document.getElementById('title').focus();
                return false;
            }
            
            if (title.length < 2) {
                alert('제목은 2글자 이상 입력해주세요.');
                document.getElementById('title').focus();
                return false;
            }
            
            if (!content) {
                alert('내용을 입력해주세요.');
                document.getElementById('content').focus();
                return false;
            }
            
            if (content.length < 10) {
                alert('내용은 10글자 이상 입력해주세요.');
                document.getElementById('content').focus();
                return false;
            }
            
            return confirm('게시글을 수정하시겠습니까?');
        }
        
        // 게시글 삭제
        function deletePost(boardId) {
            if (confirm('정말로 이 게시글을 삭제하시겠습니까?\n삭제된 게시글은 복구할 수 없습니다.')) {
                // POST 방식으로 삭제 요청
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '/board/delete/' + boardId;
                
                document.body.appendChild(form);
                form.submit();
            }
        }
        
        // 페이지 이탈 방지 (내용이 변경되었을 때)
        let originalTitle = document.getElementById('title').value;
        let originalContent = document.getElementById('content').value;
        
        window.addEventListener('beforeunload', function(e) {
            const currentTitle = document.getElementById('title').value;
            const currentContent = document.getElementById('content').value;
            
            if (currentTitle !== originalTitle || currentContent !== originalContent) {
                e.preventDefault();
                e.returnValue = '';
            }
        });
        
        // 폼 제출 시 이탈 방지 해제
        document.querySelector('form').addEventListener('submit', function() {
            window.removeEventListener('beforeunload', arguments.callee);
        });
    </script>
</body>
</html>