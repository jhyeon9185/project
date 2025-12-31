<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 상세보기</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            margin: 0; 
            padding: 20px; 
            background-color: #f8f9fa; 
        }
        .post-header { 
            background-color: #17a2b8; 
            color: white; 
            padding: 20px; 
            text-align: center; 
            border-radius: 10px;
            margin-bottom: 20px;
        }
        .content { 
            background-color: white;
            padding: 30px; 
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            max-width: 800px;
            margin: 0 auto;
        }
        .post-info { 
            background-color: #f8f9fa; 
            padding: 20px; 
            margin-bottom: 20px; 
            border-radius: 8px;
            border-left: 4px solid #17a2b8;
        }
        .post-content {
            padding: 20px;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            margin-bottom: 30px;
            min-height: 200px;
            line-height: 1.6;
        }
        .btn-container {
            text-align: center;
            margin-top: 30px;
        }
        .btn { 
            padding: 12px 24px; 
            margin: 0 5px; 
            color: white; 
            text-decoration: none; 
            border-radius: 5px; 
            display: inline-block;
            border: none;
            cursor: pointer;
            font-size: 14px;
        }
        .btn-primary { background-color: #007bff; }
        .btn-primary:hover { background-color: #0056b3; }
        .btn-success { background-color: #28a745; }
        .btn-success:hover { background-color: #1e7e34; }
        .btn-warning { background-color: #ffc107; color: #212529; }
        .btn-warning:hover { background-color: #e0a800; }
        .btn-danger { background-color: #dc3545; }
        .btn-danger:hover { background-color: #c82333; }
        .btn-secondary { background-color: #6c757d; }
        .btn-secondary:hover { background-color: #545b62; }
        .writer-info {
            color: #007bff;
            font-weight: bold;
        }
        .date-info {
            color: #6c757d;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="post-header">
        <h1>📄 게시글 상세보기</h1>
        <p>게시글 번호: ${board.id}</p>
    </div>
    
    <div class="content">
        <div class="post-info">
            <h2>${board.title}</h2>
            <p><strong>작성자:</strong> <span class="writer-info">${board.writer}</span></p>
            <p><strong>작성일:</strong> <span class="date-info">
                <c:choose>
                    <c:when test="${board.regdate != null}">
                        ${board.regdate.toString().substring(0, 19).replace('T', ' ')}
                    </c:when>
                    <c:otherwise>미등록</c:otherwise>
                </c:choose>
            </span></p>
            <c:if test="${board.moddate != null}">
                <p><strong>수정일:</strong> <span class="date-info">
                    ${board.moddate.toString().substring(0, 19).replace('T', ' ')}
                </span></p>
            </c:if>
            <p><strong>조회수:</strong> ${board.viewCount}</p>
        </div>
        
        <div class="post-content">
            <c:choose>
                <c:when test="${not empty board.content}">
                    ${board.content}
                </c:when>
                <c:otherwise>
                    <p style="color: #6c757d; text-align: center;">내용이 없습니다.</p>
                </c:otherwise>
            </c:choose>
        </div>
        
        <div class="btn-container">
            <!-- 목록으로 버튼 (모든 사용자) -->
            <a href="/board/list" class="btn btn-secondary">목록으로</a>
            
            <!-- 게시글 작성 버튼 (로그인한 사용자) -->
            <sec:authorize access="isAuthenticated()">
                <a href="/board/write" class="btn btn-success">게시글 작성</a>
            </sec:authorize>
            
            <!-- 수정/삭제 버튼 (작성자 본인만) -->
            <sec:authorize access="isAuthenticated()">
                <sec:authentication property="name" var="currentUser" />
                <c:if test="${currentUser == board.writer}">
                    <a href="/board/modify/${board.id}" class="btn btn-warning">수정</a>
                    <button type="button" class="btn btn-danger" onclick="deletePost(${board.id})">삭제</button>
                </c:if>
            </sec:authorize>
            
            <!-- 관리자는 모든 게시글 수정/삭제 가능 -->
            <sec:authorize access="hasRole('ADMIN')">
                <c:if test="${currentUser != board.writer}">
                    <a href="/board/modify/${board.id}" class="btn btn-warning">수정 (관리자)</a>
                    <button type="button" class="btn btn-danger" onclick="deletePost(${board.id})">삭제 (관리자)</button>
                </c:if>
            </sec:authorize>
        </div>
    </div>

    <script>
        function deletePost(boardId) {
            if (confirm('정말로 이 게시글을 삭제하시겠습니까?')) {
                // POST 방식으로 삭제 요청
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '/board/delete/' + boardId;
                
                // CSRF 토큰이 필요한 경우 추가
                const csrfInput = document.createElement('input');
                csrfInput.type = 'hidden';
                csrfInput.name = '_method';
                csrfInput.value = 'DELETE';
                form.appendChild(csrfInput);
                
                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</body>
</html>