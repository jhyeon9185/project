<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Account Settings</title>
    <style>
        /* 폰트 임포트 */
        @import url("https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.css");

        :root {
            --primary-color: #0071e3;
            --bg-color: #f5f5f7;
            --card-bg: #ffffff;
            --text-main: #1d1d1f;
            --text-sub: #86868b;
            --border-soft: #d2d2d7;
        }

        body {
            font-family: 'Pretendard', -apple-system, sans-serif;
            background-color: var(--bg-color);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            padding: 40px 20px;
            box-sizing: border-box;
            color: var(--text-main);
            -webkit-font-smoothing: antialiased;
        }

        .modify-container {
            background-color: var(--card-bg);
            padding: 60px 50px;
            border-radius: 30px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.04);
            width: 440px;
            max-width: 100%;
        }

        .modify-container h2 {
            text-align: center;
            margin-bottom: 40px;
            font-size: 32px;
            font-weight: 700;
            letter-spacing: -1px;
        }

        .form-group {
            margin-bottom: 24px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: var(--text-main);
            font-weight: 600;
            font-size: 14px;
            padding-left: 4px;
        }

        .form-group input {
            width: 100%;
            padding: 16px;
            border: 1px solid var(--border-soft);
            border-radius: 12px;
            box-sizing: border-box;
            font-size: 16px;
            font-family: inherit;
            background-color: #ffffff;
            transition: all 0.2s ease;
        }

        .form-group input:focus {
            border-color: var(--primary-color);
            outline: none;
            box-shadow: 0 0 0 4px rgba(0, 113, 227, 0.1);
        }

        /* 아이디와 같은 읽기 전용 필드 */
        .form-group input[readonly] {
            background-color: #f9f9fb;
            color: var(--text-sub);
            border-color: #e5e5e7;
            cursor: not-allowed;
        }

        .info-text {
            font-size: 12px;
            color: var(--text-sub);
            margin-top: 6px;
            padding-left: 4px;
        }

        /* 메인 수정 버튼 - 블랙 스타일 */
        .modify-btn {
            width: 100%;
            padding: 16px;
            background-color: #1d1d1f;
            color: #ffffff;
            border: none;
            border-radius: 14px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            margin-top: 20px;
            transition: all 0.2s;
        }

        .modify-btn:hover {
            background-color: #000000;
            transform: translateY(-1px);
        }

        /* 하단 보조 내비게이션 - 텍스트 링크 스타일 */
        .footer-nav {
            margin-top: 40px;
            padding-top: 25px;
            border-top: 1px solid #f2f2f2;
            display: flex;
            justify-content: center;
            gap: 24px;
        }

        .nav-link {
            font-size: 14px;
            color: var(--text-sub);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.2s;
            background: none;
            border: none;
            cursor: pointer;
            padding: 0;
        }

        .nav-link:hover {
            color: var(--text-main);
        }

        .required {
            color: var(--primary-color);
            margin-left: 2px;
        }
    </style>
</head>
<body>
    <div class="modify-container">
        <h2>회원정보 수정</h2>
        
        <form action="/member/modify" method="post">
            <div class="form-group">
                <label for="id">아이디</label>
                <input type="text" id="id" name="id" value="${member.id}" readonly>
                <div class="info-text">아이디는 변경할 수 없습니다.</div>
            </div>
            
            <div class="form-group">
                <label for="password">새 비밀번호<span class="required">*</span></label>
                <input type="password" id="password" name="password" required placeholder="새 비밀번호 입력">
            </div>
            
            <div class="form-group">
                <label for="passwordConfirm">새 비밀번호 확인<span class="required">*</span></label>
                <input type="password" id="passwordConfirm" name="passwordConfirm" required placeholder="비밀번호 재입력">
            </div>
            
            <div class="form-group">
                <label for="name">이름<span class="required">*</span></label>
                <input type="text" id="name" name="name" value="${member.name}" required>
            </div>
            
            <div class="form-group">
                <label for="email">이메일<span class="required">*</span></label>
                <input type="email" id="email" name="email" value="${member.email}" required>
            </div>
            
            <div class="form-group">
                <label for="phone">전화번호</label>
                <input type="tel" id="phone" name="phone" value="${member.phone}" placeholder="010-0000-0000">
            </div>
            
            <button type="submit" class="modify-btn">저장하기</button>
        </form>
        
        <div class="footer-nav">
            <button type="button" class="nav-link" onclick="history.back()">뒤로가기</button>
            <button type="button" class="nav-link" onclick="location.href='/home'">홈으로</button>
            <a href="/member/withdraw" class="nav-link" style="color: #dc3545;text-decoration: none;margin-top: 3px;">회원탈퇴</a>
        </div>
    </div>

    <script>
        // 비밀번호 확인 검증
        document.querySelector('form').addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            const passwordConfirm = document.getElementById('passwordConfirm').value;
            
            if (password !== passwordConfirm) {
                e.preventDefault();
                alert('비밀번호가 일치하지 않습니다.');
                document.getElementById('passwordConfirm').focus();
            }
        });
    </script>
</body>
</html>