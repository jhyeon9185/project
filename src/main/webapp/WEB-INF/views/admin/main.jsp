<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 페이지</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 50px; }
        .admin-header { background-color: #dc3545; color: white; padding: 20px; text-align: center; }
        .content { padding: 30px; background-color: #f8f9fa; margin-top: 20px; }
        .btn { padding: 10px 20px; margin: 10px; background-color: #007bff; color: white; text-decoration: none; border-radius: 5px; }
    </style>
</head>
<body>
    <div class="admin-header">
        <h1>🔧 관리자 페이지</h1>
        <p>관리자 권한으로 로그인되었습니다.</p>
    </div>
    
    <div class="content">
        <h2>관리자 메뉴</h2>
        <p>관리자만 접근할 수 있는 페이지입니다.</p>
        
        <a href="/board/list" class="btn">게시판 관리</a>
        <a href="/admin/member/list" class="btn" style="background-color: #28a745;">회원 관리</a>
        <a href="/home" class="btn">홈으로</a>
        <a href="/member/login" class="btn">로그아웃</a>
    </div>
</body>
</html>