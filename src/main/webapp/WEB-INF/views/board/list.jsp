<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판 목록</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            margin: 0; 
            padding: 20px; 
            background-color: #f8f9fa; 
        }
        .board-header { 
            background-color: #28a745; 
            color: white; 
            padding: 20px; 
            text-align: center; 
            border-radius: 10px;
            margin-bottom: 20px;
        }
        .content { 
            max-width: 1000px;
            margin: 0 auto;
            background-color: white;
            padding: 30px; 
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .board-controls {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #dee2e6;
        }
        .board-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
        }
        .board-table th {
            background-color: #343a40;
            color: white;
            padding: 15px;
            text-align: center;
            font-weight: bold;
        }
        .board-table td {
            padding: 12px;
            border-bottom: 1px solid #dee2e6;
            text-align: center;
        }
        .board-table tr:hover {
            background-color: #f8f9fa;
        }
        .title-link {
            color: #007bff;
            text-decoration: none;
            font-weight: bold;
        }
        .title-link:hover {
            color: #0056b3;
            text-decoration: underline;
        }
        .writer-info {
            color: #6c757d;
            font-size: 14px;
        }
        .date-info {
            color: #6c757d;
            font-size: 13px;
        }
        .hit-count {
            color: #28a745;
            font-weight: bold;
        }
        .btn { 
            padding: 10px 20px; 
            margin: 5px; 
            color: white; 
            text-decoration: none; 
            border-radius: 5px; 
            display: inline-block;
            border: none;
            cursor: pointer;
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
        .btn-container {
            text-align: center;
            margin-top: 20px;
        }
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 30px 0;
            gap: 5px;
        }
        .pagination a, .pagination span {
            padding: 8px 12px;
            margin: 0 2px;
            text-decoration: none;
            border: 1px solid #dee2e6;
            border-radius: 4px;
            color: #007bff;
            background-color: white;
        }
        .pagination a:hover {
            background-color: #e9ecef;
            color: #0056b3;
        }
        .pagination .current {
            background-color: #007bff;
            color: white;
            border-color: #007bff;
            font-weight: bold;
        }
        .pagination .disabled {
            color: #6c757d;
            background-color: #f8f9fa;
            border-color: #dee2e6;
            cursor: not-allowed;
        }
        .no-posts {
            text-align: center;
            padding: 50px;
            color: #6c757d;
            font-size: 18px;
        }
        .board-stats {
            color: #6c757d;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="board-header">
        <h1>📋 게시판 목록</h1>
        <p>자유롭게 소통하는 공간입니다.</p>
    </div>
    
    <div class="content">
        <div class="board-controls">
            <div class="board-stats">
                <strong>전체 게시글: ${pageDTO.total}개 (${pageDTO.page}/${pageDTO.totalPages} 페이지)</strong>
            </div>
            
            <!-- 게시글 작성 버튼 (로그인한 사용자만) -->
            <div>
                <sec:authorize access="isAuthenticated()">
                    <a href="/board/write" class="btn btn-success">✏️ 게시글 작성</a>
                </sec:authorize>
                <sec:authorize access="!isAuthenticated()">
                    <a href="/member/login" class="btn btn-primary">로그인 후 작성 가능</a>
                </sec:authorize>
            </div>
        </div>
        
        <c:choose>
            <c:when test="${not empty boardList}">
                <table class="board-table">
                    <thead>
                        <tr>
                            <th width="8%">번호</th>
                            <th width="50%">제목</th>
                            <th width="15%">작성자</th>
                            <th width="15%">작성일</th>
                            <th width="8%">조회수</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="board" items="${boardList}" varStatus="status">
                            <tr>
                                <td>${board.seq}</td>
                                <td style="text-align: left;">
                                    <a href="/board/${board.seq}" class="title-link">
                                        ${board.title}
                                    </a>
                                </td>
                                <td>
                                    <span class="writer-info">${board.writer}</span>
                                </td>
                                <td>
                                    <span class="date-info">
                                        <c:choose>
                                            <c:when test="${board.regdate != null}">
                                                ${board.regdate.toString().substring(0, 10)}
                                            </c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </span>
                                </td>
                                <td>
                                    <span class="hit-count">${board.hit}</span>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <div class="no-posts">
                    <p>📝 아직 작성된 게시글이 없습니다.</p>
                    <sec:authorize access="isAuthenticated()">
                        <a href="/board/write" class="btn btn-success">첫 번째 게시글 작성하기</a>
                    </sec:authorize>
                </div>
            </c:otherwise>
        </c:choose>
        
        <!-- 페이징 네비게이션 -->
        <c:if test="${pageDTO.totalPages > 1}">
            <div class="pagination">
                <!-- 이전 페이지 그룹 -->
                <c:if test="${pageDTO.prev}">
                    <a href="/board/list?page=${pageDTO.startPage - 1}&size=${pageDTO.size}">이전</a>
                </c:if>
                <c:if test="${!pageDTO.prev}">
                    <span class="disabled">이전</span>
                </c:if>
                
                <!-- 페이지 번호들 -->
                <c:forEach begin="${pageDTO.startPage}" end="${pageDTO.endPage}" var="pageNum">
                    <c:choose>
                        <c:when test="${pageNum == pageDTO.page}">
                            <span class="current">${pageNum}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="/board/list?page=${pageNum}&size=${pageDTO.size}">${pageNum}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                
                <!-- 다음 페이지 그룹 -->
                <c:if test="${pageDTO.next}">
                    <a href="/board/list?page=${pageDTO.endPage + 1}&size=${pageDTO.size}">다음</a>
                </c:if>
                <c:if test="${!pageDTO.next}">
                    <span class="disabled">다음</span>
                </c:if>
            </div>
        </c:if>
        
        <div class="btn-container">
            <a href="/home" class="btn btn-secondary">홈으로</a>
            
            <sec:authorize access="isAuthenticated()">
                <a href="/member/modify" class="btn btn-warning">회원정보 수정</a>
            </sec:authorize>
            
            <!-- 관리자만 볼 수 있는 버튼 -->
            <sec:authorize access="hasRole('ADMIN')">
                <a href="/admin" class="btn btn-danger">관리자 페이지</a>
            </sec:authorize>
        </div>
    </div>
</body>
</html>