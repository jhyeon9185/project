<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <style>
        /* Pretendard 폰트 임포트 */
        @import url("https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.css");

        :root {
            --primary-color: #0071e3;
            --bg-color: #f5f5f7;
            --card-bg: #ffffff;
            --text-main: #1d1d1f;
            --text-sub: #86868b;
            --border-soft: #d2d2d7;
            --success-color: #34c759;
            --error-color: #ff3b30;
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

        .join-container {
            background-color: var(--card-bg);
            padding: 60px 50px;
            border-radius: 30px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.04);
            width: 460px;
            max-width: 100%;
        }

        .join-container h2 {
            text-align: center;
            margin-bottom: 40px;
            font-size: 32px;
            font-weight: 700;
            letter-spacing: -1.2px;
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

        .input-wrapper {
            display: flex;
            gap: 8px;
        }

        .form-group input {
            width: 100%;
            padding: 16px;
            border: 1px solid var(--border-soft);
            border-radius: 12px;
            box-sizing: border-box;
            font-size: 16px;
            font-family: inherit;
            transition: all 0.2s ease;
        }

        .form-group input:focus {
            border-color: var(--primary-color);
            outline: none;
            box-shadow: 0 0 0 4px rgba(0, 113, 227, 0.1);
        }

        /* 중복확인 버튼 스타일 */
        .check-btn {
            padding: 0 20px;
            background-color: #f5f5f7;
            color: var(--text-main);
            border: 1px solid var(--border-soft);
            border-radius: 12px;
            cursor: pointer;
            font-weight: 600;
            white-space: nowrap;
            transition: all 0.2s;
        }

        .check-btn:hover {
            background-color: #e8e8ed;
        }

        .check-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .check-result {
            margin-top: 8px;
            font-size: 13px;
            padding-left: 4px;
        }
        .check-result.success { color: var(--success-color); }
        .check-result.error { color: var(--error-color); }

        /* 가입 버튼 - 블랙 스타일 */
        .join-btn {
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

        .join-btn:hover {
            background-color: #000000;
            transform: translateY(-1px);
        }

        .admin-help {
            font-size: 12px;
            color: var(--text-sub);
            margin-top: 6px;
            display: block;
            line-height: 1.4;
        }

        /* 하단 푸터 링크 */
        .footer-nav {
            margin-top: 40px;
            padding-top: 25px;
            border-top: 1px solid #f2f2f2;
            text-align: center;
        }

        .nav-link {
            font-size: 14px;
            color: var(--text-sub);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.2s;
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
    <div class="join-container">
        <h2>회원가입</h2>
        
        <form action="/member/join" method="post">
            <div class="form-group">
                <label for="username">아이디 <span class="required">*</span></label>
                <div class="input-wrapper">
                    <input type="text" id="username" name="id" required placeholder="아이디 입력">
                    <button type="button" id="checkIdBtn" class="check-btn">중복확인</button>
                </div>
                <div id="idCheckResult" class="check-result"></div>
            </div>
            
            <div class="form-group">
                <label for="password">비밀번호 <span class="required">*</span></label>
                <input type="password" id="password" name="password" required placeholder="비밀번호 입력">
            </div>
            
            <div class="form-group">
                <label for="passwordConfirm">비밀번호 확인 <span class="required">*</span></label>
                <input type="password" id="passwordConfirm" name="passwordConfirm" required placeholder="비밀번호 재입력">
            </div>
            
            <div class="form-group">
                <label for="email">이메일 <span class="required">*</span></label>
                <input type="email" id="email" name="email" required placeholder="example@mail.com">
            </div>
            
            <div class="form-group">
                <label for="name">이름 <span class="required">*</span></label>
                <input type="text" id="name" name="name" required placeholder="이름 입력">
            </div>
            
            <div class="form-group">
                <label for="phone">전화번호</label>
                <input type="tel" id="phone" name="phone" placeholder="010-0000-0000">
            </div>
            
            <div class="form-group">
                <label for="adminCode">관리자 코드</label>
                <input type="password" id="adminCode" name="adminCode" placeholder="관리자 코드 입력 (선택사항)">
                <span class="admin-help">관리자 전용 가입 시에만 입력해 주세요.</span>
            </div>
            
            <button type="submit" class="join-btn">가입하기</button>
        </form>
        
        <div class="footer-nav">
            <a href="/member/login" class="nav-link">이미 계정이 있으신가요? 로그인</a>
        </div>
    </div>

    <script>
        let isIdChecked = false;
        
        document.getElementById('checkIdBtn').addEventListener('click', function() {
            const username = document.getElementById('username').value.trim();
            const resultDiv = document.getElementById('idCheckResult');
            const checkBtn = document.getElementById('checkIdBtn');
            
            if (!username) {
                resultDiv.innerHTML = '아이디를 입력해주세요.';
                resultDiv.className = 'check-result error';
                return;
            }
            
            checkBtn.disabled = true;
            checkBtn.textContent = '확인 중';
            
            fetch('/member/check-id', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'id=' + encodeURIComponent(username)
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    resultDiv.innerHTML = data.message;
                    resultDiv.className = data.isDuplicated ? 'check-result error' : 'check-result success';
                    isIdChecked = !data.isDuplicated;
                } else {
                    resultDiv.innerHTML = data.message;
                    resultDiv.className = 'check-result error';
                    isIdChecked = false;
                }
            })
            .catch(error => {
                resultDiv.innerHTML = '연결 오류가 발생했습니다.';
                resultDiv.className = 'check-result error';
            })
            .finally(() => {
                checkBtn.disabled = false;
                checkBtn.textContent = '중복확인';
            });
        });
        
        document.getElementById('username').addEventListener('input', () => {
            isIdChecked = false;
            document.getElementById('idCheckResult').innerHTML = '';
        });

        document.querySelector('form').addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            const passwordConfirm = document.getElementById('passwordConfirm').value;
            
            if (!isIdChecked) {
                e.preventDefault();
                alert('아이디 중복확인이 필요합니다.');
                return;
            }
            
            if (password !== passwordConfirm) {
                e.preventDefault();
                alert('비밀번호가 일치하지 않습니다.');
                document.getElementById('passwordConfirm').focus();
            }
        });
    </script>
</body>
</html>