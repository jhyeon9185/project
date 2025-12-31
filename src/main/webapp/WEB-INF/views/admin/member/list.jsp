<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 관리</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f8f9fa;
        }
        .header {
            background-color: #dc3545;
            color: white;
            padding: 20px;
            text-align: center;
            margin-bottom: 30px;
            border-radius: 10px;
        }
        .member-table {
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th {
            background-color: #343a40;
            color: white;
            padding: 15px;
            text-align: left;
            font-weight: bold;
        }
        td {
            padding: 12px 15px;
            border-bottom: 1px solid #dee2e6;
        }
        tr:hover {
            background-color: #f8f9fa;
            cursor: pointer;
        }
        .member-id {
            color: #007bff;
            font-weight: bold;
        }
        .role-badge {
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
        }
        .role-admin {
            background-color: #dc3545;
            color: white;
        }
        .role-member {
            background-color: #28a745;
            color: white;
        }
        .enabled-yes {
            color: #28a745;
            font-weight: bold;
        }
        .enabled-no {
            color: #dc3545;
            font-weight: bold;
        }
        .btn-container {
            margin: 20px 0;
            text-align: center;
        }
        .btn {
            padding: 10px 20px;
            margin: 0 10px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            display: inline-block;
        }
        .btn:hover {
            background-color: #0056b3;
        }
        .btn-secondary {
            background-color: #6c757d;
        }
        .btn-secondary:hover {
            background-color: #545b62;
        }
        .stats {
            display: flex;
            justify-content: space-around;
            margin-bottom: 20px;
        }
        .stat-card {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            flex: 1;
            margin: 0 10px;
        }
        .stat-number {
            font-size: 24px;
            font-weight: bold;
            color: #007bff;
        }
        .stat-label {
            color: #6c757d;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>👥 회원 관리</h1>
        <p>전체 회원 목록을 관리할 수 있습니다.</p>
    </div>

    <div class="stats">
        <div class="stat-card">
            <div class="stat-number">${totalMembers}</div>
            <div class="stat-label">전체 회원</div>
        </div>
        <div class="stat-card">
            <div class="stat-number">${adminCount}</div>
            <div class="stat-label">관리자</div>
        </div>
        <div class="stat-card">
            <div class="stat-number">${memberCount}</div>
            <div class="stat-label">일반 회원</div>
        </div>
    </div>

    <div class="member-table">
        <table>
            <thead>
                <tr>
                    <th>아이디</th>
                    <th>이름</th>
                    <th>이메일</th>
                    <th>권한</th>
                    <th>가입일</th>
                    <th>활성화</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="member" items="${memberList}">
                    <tr onclick="location.href='/admin/member/detail/${member.id}'">
                        <td class="member-id">${member.id}</td>
                        <td>${member.name}</td>
                        <td>${member.email}</td>
                        <td>
                            <c:choose>
                                <c:when test="${member.role != null && member.role == 'ADMIN'}">
                                    <span class="role-badge role-admin">관리자</span>
                                </c:when>
                                <c:when test="${member.role != null}">
                                    <span class="role-badge role-member">일반회원</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="role-badge" style="background-color: #6c757d; color: white;">미설정</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${member.regdate != null}">
                                    ${member.regdate.toString().substring(0, 16).replace('T', ' ')}
                                </c:when>
                                <c:otherwise>
                                    <span style="color: #6c757d;">미등록</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${member.enabled}">
                                    <span class="enabled-yes">활성</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="enabled-no">비활성</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="btn-container">
        <a href="/admin" class="btn btn-secondary">관리자 메인</a>
        <a href="/board/list" class="btn">게시판으로</a>
    </div>
</body>
</html>