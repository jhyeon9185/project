<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Member Management | Admin</title>
    <style>
        @import url("https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.css");

        :root {
            --primary-color: #0071e3;
            --bg-color: #f5f5f7;
            --card-bg: #ffffff;
            --text-main: #1d1d1f;
            --text-sub: #86868b;
            --border-soft: #f2f2f2;
            --admin-red: #ff3b30;
            --member-green: #34c759;
        }

        body {
            font-family: 'Pretendard', -apple-system, sans-serif;
            margin: 0;
            padding: 0;
            background-color: var(--bg-color);
            color: var(--text-main);
            -webkit-font-smoothing: antialiased;
        }

        /* 1. 상단 GNB 통합 (하단 링크들을 여기로 이동) */
        .top-nav {
            position: sticky;
            top: 0;
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            z-index: 100;
            border-bottom: 1px solid var(--border-soft);
            padding: 0 40px;
            height: 52px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .nav-group { display: flex; gap: 24px; align-items: center; }
        .nav-link { 
            font-size: 13px; 
            text-decoration: none; 
            color: var(--text-sub); 
            font-weight: 500; 
            transition: color 0.2s;
        }
        .nav-link:hover { color: var(--text-main); }
        .nav-link.active { color: var(--primary-color); font-weight: 700; }
        .nav-link.logout { color: var(--admin-red); }

        .container {
            max-width: 1100px;
            margin: 0 auto;
            padding: 60px 20px 100px;
        }

        .header-section {
            text-align: left;
            margin-bottom: 40px;
        }
        .header-section h1 {
            font-size: 34px;
            font-weight: 800;
            margin: 0 0 8px 0;
            letter-spacing: -1.5px;
        }
        .header-section p {
            color: var(--text-sub);
            font-size: 16px;
            margin: 0;
        }

        /* 통계 영역 */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-bottom: 40px;
        }
        .stat-card {
            background: var(--card-bg);
            padding: 24px;
            border-radius: 24px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.02);
            border: 1px solid rgba(0,0,0,0.02);
        }
        .stat-label { font-size: 13px; color: var(--text-sub); font-weight: 600; margin-bottom: 8px; }
        .stat-number { font-size: 32px; font-weight: 800; color: var(--text-main); letter-spacing: -1px; }

        /* 테이블 영역 */
        .table-container {
            background: var(--card-bg);
            border-radius: 28px;
            padding: 10px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.03);
            overflow: hidden;
        }
        table { width: 100%; border-collapse: collapse; }
        th {
            padding: 18px 16px;
            text-align: left;
            font-size: 12px;
            font-weight: 700;
            color: var(--text-sub);
            text-transform: uppercase;
            letter-spacing: 0.05em;
            border-bottom: 1px solid var(--border-soft);
        }
        td { padding: 20px 16px; font-size: 14px; border-bottom: 1px solid var(--border-soft); }
        tr:last-child td { border-bottom: none; }
        tr:hover td { background-color: #fafafa; cursor: pointer; }

        .member-id { font-weight: 700; color: var(--text-main); }

        /* 배지 및 상태 */
        .badge {
            display: inline-flex;
            align-items: center;
            padding: 4px 10px;
            border-radius: 8px;
            font-size: 11px;
            font-weight: 700;
        }
        .badge-admin { background-color: #fff2f1; color: var(--admin-red); }
        .badge-member { background-color: #f2faf3; color: var(--member-green); }
        
        .status-dot {
            display: inline-block;
            width: 7px; height: 7px;
            border-radius: 50%;
            margin-right: 6px;
        }
        .status-active { background-color: var(--member-green); box-shadow: 0 0 8px var(--member-green); }
        .status-inactive { background-color: var(--admin-red); }

        .date-text { color: var(--text-sub); font-size: 13px; font-variant-numeric: tabular-nums; }

        @media (max-width: 768px) {
            .stats-grid { grid-template-columns: 1fr; }
            .top-nav { padding: 0 20px; }
        }
    </style>
</head>
<body>

    <nav class="top-nav">
        <div class="nav-group">
            <a href="/home" class="nav-link">Home</a>
            <a href="/admin" class="nav-link">Dashboard</a>
            <a href="/board/list" class="nav-link">Board</a>
            <a href="/admin/member/list" class="nav-link active">MemberList</a>
        </div>
        <div class="nav-group">
            <form action="/logout" method="post" id="logoutForm" style="display: none;">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            </form>
            <a href="javascript:document.getElementById('logoutForm').submit();" class="nav-link logout">Logout</a>
        </div>
    </nav>

    <div class="container">
        <div class="header-section">
            <h1>사용자 관리</h1>
            <p>회원 정보 확인 및 서비스 이용 권한을 관리합니다.</p>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-label">총 회원</div>
                <div class="stat-number">${totalMembers}</div>
            </div>
            <div class="stat-card">
                <div class="stat-label">관리자</div>
                <div class="stat-number">${adminCount}</div>
            </div>
            <div class="stat-card">
                <div class="stat-label">일반회원</div>
                <div class="stat-number">${memberCount}</div>
            </div>
        </div>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th width="15%">ID</th>
                        <th width="15%">이름</th>
                        <th width="25%">이메일</th>
                        <th width="15%">권한</th>
                        <th width="18%">가입날짜</th>
                        <th width="12%">현재 상태</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="member" items="${memberList}">
                        <tr onclick="location.href='/admin/member/detail/${member.id}'">
                            <td class="member-id">${member.id}</td>
                            <td style="font-weight: 600;">${member.name}</td>
                            <td>${member.email}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${member.role == 'ADMIN'}">
                                        <span class="badge badge-admin">ADMIN</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-member">MEMBER</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="date-text">
                                <c:choose>
                                    <c:when test="${member.regdate != null}">
                                        ${member.regdate.toString().substring(0, 10)}
                                    </c:when>
                                    <c:otherwise>-</c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${member.enabled}">
                                        <span style="font-size: 13px; font-weight: 600; color: var(--member-green);">
                                            <span class="status-dot status-active"></span>Active
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="font-size: 13px; font-weight: 600; color: var(--admin-red);">
                                            <span class="status-dot status-inactive"></span>Banned
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>