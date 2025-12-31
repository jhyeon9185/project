<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 상세정보</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f8f9fa;
        }
        .header {
            background-color: #17a2b8;
            color: white;
            padding: 20px;
            text-align: center;
            margin-bottom: 30px;
            border-radius: 10px;
        }
        .detail-container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            max-width: 600px;
            margin: 0 auto;
        }
        .detail-row {
            display: flex;
            margin-bottom: 20px;
            padding: 15px;
            border-bottom: 1px solid #dee2e6;
        }
        .detail-row:last-child {
            border-bottom: none;
        }
        .detail-label {
            font-weight: bold;
            color: #495057;
            width: 120px;
            flex-shrink: 0;
        }
        .detail-value {
            color: #212529;
            flex: 1;
        }
        .role-badge {
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 14px;
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
        .status-active {
            color: #28a745;
            font-weight: bold;
        }
        .status-inactive {
            color: #dc3545;
            font-weight: bold;
        }
        .btn-container {
            margin-top: 30px;
            text-align: center;
        }
        .btn {
            padding: 12px 24px;
            margin: 0 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
        }
        .btn-primary {
            background-color: #007bff;
            color: white;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .btn-warning {
            background-color: #ffc107;
            color: #212529;
        }
        .btn-warning:hover {
            background-color: #e0a800;
        }
        .btn-danger {
            background-color: #dc3545;
            color: white;
        }
        .btn-danger:hover {
            background-color: #c82333;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        .btn-secondary:hover {
            background-color: #545b62;
        }
        .member-id {
            font-size: 18px;
            font-weight: bold;
            color: #007bff;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>👤 회원 상세정보</h1>
        <p>회원의 상세 정보를 확인하고 관리할 수 있습니다.</p>
    </div>

    <div class="detail-container">
        <div class="detail-row">
            <div class="detail-label">아이디:</div>
            <div class="detail-value member-id">${member.id}</div>
        </div>

        <div class="detail-row">
            <div class="detail-label">이름:</div>
            <div class="detail-value">${member.name}</div>
        </div>

        <div class="detail-row">
            <div class="detail-label">이메일:</div>
            <div class="detail-value">${member.email}</div>
        </div>

        <div class="detail-row">
            <div class="detail-label">전화번호:</div>
            <div class="detail-value">
                <c:choose>
                    <c:when test="${empty member.phone}">
                        <span style="color: #6c757d;">등록되지 않음</span>
                    </c:when>
                    <c:otherwise>
                        ${member.phone}
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="detail-row">
            <div class="detail-label">권한:</div>
            <div class="detail-value">
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
            </div>
        </div>

        <div class="detail-row">
            <div class="detail-label">가입일:</div>
            <div class="detail-value">
                <c:choose>
                    <c:when test="${member.regdate != null}">
                        ${member.regdate.toString().substring(0, 19).replace('T', ' ')}
                    </c:when>
                    <c:otherwise>
                        <span style="color: #6c757d;">미등록</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="detail-row">
            <div class="detail-label">계정 상태:</div>
            <div class="detail-value">
                <c:choose>
                    <c:when test="${member.enabled}">
                        <span class="status-active">✅ 활성화</span>
                    </c:when>
                    <c:otherwise>
                        <span class="status-inactive">❌ 비활성화</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <div class="btn-container">
        <a href="/admin/member/list" class="btn btn-secondary">목록으로</a>
    </div>
</body>
</html>