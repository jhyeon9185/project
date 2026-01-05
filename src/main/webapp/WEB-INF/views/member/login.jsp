<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In | Service Hub</title>
    <style>
        @import url("https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.css");

        :root {
            --bg-gradient: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            --accent-color: #0071e3;
            --glass-bg: rgba(255, 255, 255, 0.75);
            --text-main: #1d1d1f;
            --text-sub: #86868b;
            --error-red: #ff3b30;
        }

        body {
            font-family: 'Pretendard', sans-serif;
            background: var(--bg-gradient);
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: var(--text-main);
            overflow: hidden;
        }

        /* 배경 장식 요소 */
        body::before {
            content: "";
            position: absolute;
            width: 600px; height: 600px;
            background: radial-gradient(circle, rgba(0,113,227,0.15) 0%, rgba(255,255,255,0) 70%);
            bottom: -150px; left: -150px; z-index: -1;
        }

        .login-card {
            background: var(--glass-bg);
            backdrop-filter: blur(25px);
            -webkit-backdrop-filter: blur(25px);
            border: 1px solid rgba(255, 255, 255, 0.4);
            padding: 60px 50px;
            border-radius: 32px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.08);
            width: 100%;
            max-width: 440px;
            box-sizing: border-box;
            animation: fadeIn 0.6s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .login-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .login-header h2 {
            font-size: 32px;
            font-weight: 800;
            letter-spacing: -1.5px;
            margin: 0 0 10px 0;
        }

        .login-header p {
            color: var(--text-sub);
            font-size: 16px;
        }

        /* 폼 요소 스타일 */
        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-size: 13px;
            font-weight: 600;
            color: var(--text-sub);
            padding-left: 4px;
        }

        .form-group input {
            width: 100%;
            padding: 16px 20px;
            border: 1px solid rgba(0, 0, 0, 0.05);
            border-radius: 16px;
            box-sizing: border-box;
            background-color: rgba(255, 255, 255, 0.5);
            font-size: 16px;
            outline: none;
            transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .form-group input:focus {
            background-color: #fff;
            border-color: var(--accent-color);
            box-shadow: 0 0 0 4px rgba(0, 113, 227, 0.1);
        }

        /* 로그인 버튼 (Primary) */
        .login-btn {
            width: 100%;
            padding: 16px;
            background-color: var(--text-main);
            color: #fff;
            border: none;
            border-radius: 16px;
            cursor: pointer;
            font-size: 17px;
            font-weight: 600;
            margin-top: 10px;
            transition: all 0.3s ease;
        }

        .login-btn:hover {
            background-color: #000;
            transform: scale(1.01);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }

        /* 에러 메시지 */
        .error-message {
            background-color: rgba(255, 59, 48, 0.1);
            color: var(--error-red);
            padding: 14px;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 500;
            text-align: center;
            margin-bottom: 24px;
            border: 1px solid rgba(255, 59, 48, 0.2);
        }

        /* 하단 액션 */
        .footer-action {
            margin-top: 32px;
            text-align: center;
            border-top: 1px solid rgba(0, 0, 0, 0.05);
            padding-top: 24px;
        }

        .footer-action p {
            font-size: 14px;
            color: var(--text-sub);
            margin-bottom: 16px;
        }

        .join-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 100%;
            padding: 14px;
            background-color: rgba(0, 0, 0, 0.04);
            color: var(--text-main);
            text-decoration: none;
            font-weight: 600;
            font-size: 15px;
            border-radius: 16px;
            transition: all 0.2s;
        }

        .join-btn:hover {
            background-color: rgba(0, 0, 0, 0.08);
        }

        /* CSRF 토큰 처리를 위한 스타일 (필요시) */
        .hidden { display: none; }
    </style>
</head>

<body>

    <div class="login-card">
        <div class="login-header">
            <h1>Login</h1>
        </div>

        <c:if test="${param.error != null}">
            <div class="error-message">
                아이디 또는 비밀번호를 다시 확인해주세요.
            </div>
        </c:if>

        <form action="/member/login" method="post">
            <div class="form-group">
                <label for="username">ID</label>
                <input type="text" id="username" name="username" placeholder="아이디" required autofocus>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="비밀번호" required>
            </div>
            
            <%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> --%>
            
            <button type="submit" class="login-btn">로그인</button>
        </form>
        
        <div class="footer-action">
            <p>아직 계정이 없으신가요?</p>
            <a href="/member/join" class="join-btn">계정 생성하기</a>
        </div>
    </div>

</body>
</html>