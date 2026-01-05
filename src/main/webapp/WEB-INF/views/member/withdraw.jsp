<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Withdraw | Service Hub</title>
    <style>
        @import url("https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.css");

        :root {
            --bg-gradient: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            --accent-red: #ff3b30;
            --glass-bg: rgba(255, 255, 255, 0.75);
            --text-main: #1d1d1f;
            --text-sub: #86868b;
            --warning-bg: rgba(255, 59, 48, 0.08);
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

        /* 배경 장식 (탈퇴 페이지는 붉은색 포인트) */
        body::before {
            content: "";
            position: absolute;
            width: 500px; height: 500px;
            background: radial-gradient(circle, rgba(255,59,48,0.1) 0%, rgba(255,255,255,0) 70%);
            top: -100px; right: -100px; z-index: -1;
        }

        .withdraw-card {
            background: var(--glass-bg);
            backdrop-filter: blur(25px);
            -webkit-backdrop-filter: blur(25px);
            border: 1px solid rgba(255, 255, 255, 0.4);
            padding: 50px 40px;
            border-radius: 32px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.08);
            width: 100%;
            max-width: 440px;
            box-sizing: border-box;
            animation: slideUp 0.6s cubic-bezier(0.23, 1, 0.32, 1);
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .header {
            text-align: center;
            margin-bottom: 30px;
        }

        .header .icon {
            font-size: 40px;
            margin-bottom: 15px;
            display: block;
        }

        .header h2 {
            font-size: 28px;
            font-weight: 800;
            letter-spacing: -1.2px;
            margin: 0;
            color: var(--accent-red);
        }

        /* 경고 메시지 박스 */
        .warning-box {
            background: var(--warning-bg);
            border-radius: 20px;
            padding: 20px;
            margin-bottom: 30px;
            border: 1px solid rgba(255, 59, 48, 0.1);
        }

        .warning-box p {
            margin: 0;
            font-size: 15px;
            line-height: 1.6;
            color: #d70015;
            font-weight: 500;
        }

        /* 입력 폼 */
        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            margin-bottom: 10px;
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
            transition: all 0.2s ease;
        }

        .form-group input:focus {
            background-color: #fff;
            border-color: var(--accent-red);
            box-shadow: 0 0 0 4px rgba(255, 59, 48, 0.1);
        }

        /* 버튼 그룹 */
        .btn-stack {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .btn {
            width: 100%;
            padding: 16px;
            border-radius: 16px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            text-align: center;
            transition: all 0.3s ease;
            border: none;
            box-sizing: border-box;
        }

        .btn-danger {
            background-color: var(--accent-red);
            color: white;
        }

        .btn-danger:hover {
            background-color: #ff2d55;
            transform: scale(1.01);
            box-shadow: 0 10px 20px rgba(255, 59, 48, 0.2);
        }

        .btn-secondary {
            background-color: rgba(0, 0, 0, 0.05);
            color: var(--text-main);
        }

        .btn-secondary:hover {
            background-color: rgba(0, 0, 0, 0.1);
        }

        /* 에러 메시지 */
        .error-message {
            color: var(--accent-red);
            font-size: 13px;
            font-weight: 600;
            margin-top: -15px;
            margin-bottom: 20px;
            padding-left: 4px;
        }
    </style>
</head>
<body>

    <div class="withdraw-card">
        <div class="header">
            <span class="icon">⚠️</span>
            <h2>회원 탈퇴</h2>
        </div>
        
        <div class="warning-box">
            <p>탈퇴 시 모든 데이터가 삭제되며,<br>이 작업은 되돌릴 수 없습니다.</p>
        </div>
        
        <form action="/member/withdraw" method="post">
            <div class="form-group">
                <label for="password">Password Confirmation</label>
                <input type="password" id="password" name="password" 
                       placeholder="현재 비밀번호를 입력하세요" required>
            </div>

            <c:if test="${error != null}">
                <div class="error-message">
                    * ${error}
                </div>
            </c:if>
            
            <div class="btn-stack">
                <button type="submit" class="btn btn-danger" 
                        onclick="return confirm('정말로 탈퇴하시겠습니까? 모든 정보가 사라집니다.')">
                    탈퇴 확정
                </button>
                <a href="/member/modify" class="btn btn-secondary">탈퇴 취소</a>
            </div>
        </form>
    </div>

</body>
</html>