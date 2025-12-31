<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>접근 거부</title>
</head>
<body>
    <div class="error-container">
        <h1>403 - 접근 거부</h1>
        <p>이 페이지에 접근할 권한이 없습니다.</p>
        <p>관리자 권한이 필요한 페이지입니다.</p>
        
        <button onclick="location.href='/home'">홈으로</button>
        <button onclick="location.href='/member/login'">로그인</button>
        <button onclick="history.back()">이전 페이지</button>
    </div>
</body>
</html>
