<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Board List</title>
    <style>
        /* Pretendard 폰트 임포트 */
        @import url("https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.css");

        :root {
            --primary-color: #0071e3;
            --bg-color: #f5f5f7;
            --card-bg: #ffffff;
            --text-main: #1d1d1f;
            --text-sub: #86868b;
            --border-soft: #f2f2f2;
        }

        body { 
            font-family: 'Pretendard', -apple-system, sans-serif; 
            margin: 0; 
            padding: 0; 
            background-color: var(--bg-color); 
            color: var(--text-main);
            -webkit-font-smoothing: antialiased;
        }

        /* 1. 상단 내비게이션 바 추가 (깔끼함의 핵심) */
        /* 내비바 수정 */
	.top-nav {
	    position: sticky;
	    top: 0;
	    background: rgba(255, 255, 255, 0.8);
	    backdrop-filter: blur(20px);
	    z-index: 100;
	    border-bottom: 1px solid var(--border-soft);
	    padding: 0 40px;
	    height: 52px;
	    display: flex;
	    justify-content: space-between; /* 양 끝으로 배치 */
	    align-items: center;
	}
	
	/* 기존 하단 로그아웃 버튼 관련 스타일은 삭제하거나 아래로 대체 */
	.logout-btn-wrap {
	    display: none; /* 이제 내비바에 있으므로 숨김 처리 */
	}
        .nav-logo { font-weight: 700; font-size: 18px; text-decoration: none; color: var(--text-main); }
        .nav-menu { display: flex; gap: 24px; }
        .nav-link { font-size: 13px; text-decoration: none; color: var(--text-sub); font-weight: 500; transition: color 0.2s; }
        .nav-link:hover { color: var(--text-main); }

        /* 헤더 섹션 */
        .board-header { 
            padding: 80px 20px 40px; 
            text-align: center; 
        }
        .board-header h1 {
            font-size: 42px;
            font-weight: 700;
            margin-bottom: 8px;
            letter-spacing: -1.2px;
        }
        .board-header p {
            color: var(--text-sub);
            font-size: 18px;
            font-weight: 400;
        }

        /* 메인 컨텐츠 컨테이너 */
        .content { 
            max-width: 1000px;
            margin: 0 auto 100px;
            background-color: var(--card-bg);
            padding: 48px; 
            border-radius: 28px;
            box-shadow: 0 12px 40px rgba(0,0,0,0.03);
        }

        /* 컨트롤 영역 */
        .board-controls {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 32px;
        }
        .board-stats { font-size: 14px; color: var(--text-sub); font-weight: 500; }

        /* 테이블 스타일 */
        .board-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 40px;
        }
        .board-table th {
            padding: 16px 8px;
            text-align: center;
            font-size: 13px;
            color: var(--text-sub);
            border-bottom: 1px solid var(--text-main);
            font-weight: 600;
        }
        .board-table td {
            padding: 20px 8px;
            border-bottom: 1px solid var(--border-soft);
            text-align: center;
            font-size: 15px;
        }
        .board-table tr:hover td { background-color: #fafafa; }

        .title-link {
            color: var(--text-main);
            text-decoration: none;
            font-weight: 600;
            transition: color 0.2s;
        }
        .title-link:hover { color: var(--primary-color); }

        .reply-count {
            display: inline-block;
            margin-left: 8px;
            padding: 2px 6px;
            background-color: var(--primary-color);
            color: white;
            font-size: 12px;
            font-weight: 500;
            border-radius: 10px;
            min-width: 16px;
            text-align: center;
            line-height: 1.2;
        }

        /* 버튼: 캡슐 스타일 */
        .btn-write { 
            padding: 10px 24px; 
            background-color: #000; 
            color: #fff; 
            text-decoration: none; 
            border-radius: 40px; 
            font-size: 14px; 
            font-weight: 600;
            transition: transform 0.2s;
        }
        .btn-write:hover { transform: scale(1.02); }

        /* 페이징 */
        .pagination {
            display: flex;
            justify-content: center;
            gap: 6px;
            margin-top: 20px;
        }
        .pagination a, .pagination span {
            min-width: 32px;
            height: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            font-size: 14px;
            color: var(--text-sub);
            border-radius: 8px;
        }
        .pagination .current { background-color: var(--border-soft); color: var(--text-main); font-weight: 700; }

        /* 하단 푸터 영역 (여기로 이동) */
        .footer-info {
            margin-top: 60px;
            text-align: center;
            border-top: 1px solid var(--border-soft);
            padding-top: 30px;
        }
        .footer-info p { font-size: 12px; color: #d2d2d7; }
    </style>
</head>
<body>

    <nav class="top-nav">
	    <div class="nav-menu">
	        <a href="/home" class="nav-logo">Home</a>
	        <sec:authorize access="hasRole('ADMIN')">
	            <a href="/admin" class="nav-link" style="margin-top: 3px;color: #FF3B30;">관리자 대시보드</a>
	        </sec:authorize>
	    </div>
	
	    <div class="nav-menu">
	        <sec:authorize access="isAuthenticated()">
	            <span class="nav-link" style="color: var(--text-main); font-weight: 600;">
	                <sec:authentication property="principal.username"/>님
	            </span>
	            <a href="/member/modify" class="nav-link">정보 수정</a>
	            <form action="/logout" method="post" id="logoutForm" style="display: none;">
	                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	            </form>
	            <a href="javascript:document.getElementById('logoutForm').submit();" class="nav-link" style="color: #999999;">로그아웃</a>
	        </sec:authorize>
	        
	        <sec:authorize access="!isAuthenticated()">
	            <a href="/member/login" class="nav-link">로그인</a>
	            <a href="/member/join" class="btn-write" style="padding: 4px 12px; font-size: 12px;">회원가입</a>
	        </sec:authorize>
	    </div>
	</nav>

    <header class="board-header">
        <h1>게시판</h1>
    </header>
    
    <main class="content">
        <div class="board-controls">
            <div class="board-stats">
                전체 게시글 <strong>${pageDTO.total}</strong>
            </div>
            
            <div>
                <sec:authorize access="isAuthenticated()">
                    <a href="/board/write" class="btn-write">게시글 작성하기</a>
                </sec:authorize>
                <sec:authorize access="!isAuthenticated()">
                    <a href="/member/login" class="nav-link">로그인하고 글 작성하기</a>
                </sec:authorize>
            </div>
        </div>
        
        <c:choose>
            <c:when test="${not empty boardList}">
                <table class="board-table">
                    <thead>
                        <tr>
                            <th width="8%">번호</th>
                            <th width="54%">제목</th>
                            <th width="15%">작성자</th>
                            <th width="15%">날짜</th>
                            <th width="8%">조회수</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="board" items="${boardList}">
                            <tr>
                                <td>${board.seq}</td>
                                <td style="text-align: left;">
                                    <a href="/board/${board.seq}" class="title-link">
                                        ${board.title}
                                        <c:if test="${replyCountMap[board.seq] > 0}">
                                            <span class="reply-count">${replyCountMap[board.seq]}</span>
                                        </c:if>
                                    </a>
                                </td>
                                <td>${board.writer}</td>
                                <td style="color: var(--text-sub); font-size: 13px;">
                                    <c:choose>
                                        <c:when test="${board.regdate != null}">${board.regdate.toString().substring(0, 10)}</c:when>
                                        <c:otherwise>-</c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="font-weight: 500;">${board.hit}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <div style="text-align: center; padding: 100px 0; color: var(--text-sub);">
                    게시글이 존재하지 않습니다.
                </div>
            </c:otherwise>
        </c:choose>
        
        <c:if test="${pageDTO.totalPages > 1}">
            <div class="pagination">
                <c:if test="${pageDTO.prev}"><a href="/board/list?page=${pageDTO.startPage - 1}&size=${pageDTO.size}">Prev</a></c:if>
                <c:forEach begin="${pageDTO.startPage}" end="${pageDTO.endPage}" var="pageNum">
                    <c:choose>
                        <c:when test="${pageNum == pageDTO.page}"><span class="current">${pageNum}</span></c:when>
                        <c:otherwise><a href="/board/list?page=${pageNum}&size=${pageDTO.size}">${pageNum}</a></c:otherwise>
                    </c:choose>
                </c:forEach>
                <c:if test="${pageDTO.next}"><a href="/board/list?page=${pageDTO.endPage + 1}&size=${pageDTO.size}">Next</a></c:if>
            </div>
        </c:if>

        <footer class="footer-info">
            <p>© 2026 Your Service. All rights reserved.</p>
        </footer>
    </main>
</body>
</html>