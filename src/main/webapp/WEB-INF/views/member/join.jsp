<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            padding: 20px;
            box-sizing: border-box;
        }
        .join-container {
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            width: 400px;
            max-width: 100%;
        }
        .join-container h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #333;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #555;
            font-weight: bold;
        }
        .form-group input, .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 14px;
        }
        .form-group input:focus, .form-group select:focus {
            border-color: #007bff;
            outline: none;
        }
        .join-btn {
            width: 100%;
            padding: 12px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-bottom: 10px;
        }
        .join-btn:hover {
            background-color: #1e7e34;
        }
        .back-btn {
            width: 100%;
            padding: 10px;
            background-color: #6c757d;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 5px;
        }
        .back-btn:hover {
            background-color: #545b62;
        }
        .login-link {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 5px;
        }
        .login-link:hover {
            background-color: #0056b3;
        }
        .required {
            color: red;
        }
        .check-btn {
            padding: 10px 15px;
            background-color: #17a2b8;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            white-space: nowrap;
            min-width: 80px;
        }
        .check-btn:hover {
            background-color: #138496;
        }
        .check-btn:disabled {
            background-color: #6c757d;
            cursor: not-allowed;
        }
        .check-result {
            margin-top: 5px;
            font-size: 14px;
            font-weight: bold;
        }
        .check-result.success {
            color: #28a745;
        }
        .check-result.error {
            color: #dc3545;
        }
    </style>
</head>
<body>
    <div class="join-container">
        <h2>회원가입</h2>
        <form action="/member/join" method="post">
            <div class="form-group">
                <label for="username">아이디 <span class="required">*</span></label>
                <div style="display: flex; gap: 10px;">
                    <input type="text" id="username" name="id" required placeholder="아이디를 입력하세요" style="flex: 1;">
                    <button type="button" id="checkIdBtn" class="check-btn">중복확인</button>
                </div>
                <div id="idCheckResult" class="check-result"></div>
            </div>
            
            <div class="form-group">
                <label for="password">비밀번호 <span class="required">*</span></label>
                <input type="password" id="password" name="password" required placeholder="비밀번호를 입력하세요">
            </div>
            
            <div class="form-group">
                <label for="passwordConfirm">비밀번호 확인 <span class="required">*</span></label>
                <input type="password" id="passwordConfirm" name="passwordConfirm" required placeholder="비밀번호를 다시 입력하세요">
            </div>
            
            <div class="form-group">
                <label for="email">이메일 <span class="required">*</span></label>
                <input type="email" id="email" name="email" required placeholder="이메일을 입력하세요">
            </div>
            
            <div class="form-group">
                <label for="name">이름 <span class="required">*</span></label>
                <input type="text" id="name" name="name" required placeholder="이름을 입력하세요">
            </div>
            
            <div class="form-group">
                <label for="phone">전화번호</label>
                <input type="tel" id="phone" name="phone" placeholder="전화번호를 입력하세요 (선택사항)">
            </div>
            
            <div class="form-group">
                <label for="adminCode">관리자 코드 (선택사항)</label>
                <input type="password" id="adminCode" name="adminCode" placeholder="관리자 코드를 입력하세요 (일반 회원은 비워두세요)">
                <small style="color: #666; font-size: 12px;">* 관리자 코드를 입력하면 관리자 권한으로 가입됩니다.</small>
            </div>
            
            <button type="submit" class="join-btn">회원가입</button>
        </form>
        
        <button type="button" class="login-link" onclick="location.href='/member/login'">이미 계정이 있으신가요? 로그인</button>
    </div>

    <script>
        let isIdChecked = false; // 중복체크 완료 여부
        
        // ID 중복체크 버튼 클릭
        document.getElementById('checkIdBtn').addEventListener('click', function() {
            const username = document.getElementById('username').value.trim();
            const resultDiv = document.getElementById('idCheckResult');
            const checkBtn = document.getElementById('checkIdBtn');
            
            if (!username) {
                resultDiv.innerHTML = '아이디를 입력해주세요.';
                resultDiv.className = 'check-result error';
                return;
            }
            
            // 버튼 비활성화
            checkBtn.disabled = true;
            checkBtn.textContent = '확인중...';
            resultDiv.innerHTML = '';
            
            // AJAX 요청
            fetch('/member/check-id', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'id=' + encodeURIComponent(username)
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    if (data.isDuplicated) {
                        resultDiv.innerHTML = data.message;
                        resultDiv.className = 'check-result error';
                        isIdChecked = false;
                    } else {
                        resultDiv.innerHTML = data.message;
                        resultDiv.className = 'check-result success';
                        isIdChecked = true;
                    }
                } else {
                    resultDiv.innerHTML = data.message;
                    resultDiv.className = 'check-result error';
                    isIdChecked = false;
                }
            })
            .catch(error => {
                console.error('Error:', error);
                resultDiv.innerHTML = '중복 체크 중 오류가 발생했습니다.';
                resultDiv.className = 'check-result error';
                isIdChecked = false;
            })
            .finally(() => {
                // 버튼 다시 활성화
                checkBtn.disabled = false;
                checkBtn.textContent = '중복확인';
            });
        });
        
        // 아이디 입력 필드 변경시 중복체크 상태 초기화
        document.getElementById('username').addEventListener('input', function() {
            isIdChecked = false;
            document.getElementById('idCheckResult').innerHTML = '';
        });

        // 비밀번호 확인 검증 및 중복체크 확인
        document.querySelector('form').addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            const passwordConfirm = document.getElementById('passwordConfirm').value;
            
            // 중복체크 확인
            if (!isIdChecked) {
                e.preventDefault();
                alert('아이디 중복체크를 해주세요.');
                document.getElementById('username').focus();
                return;
            }
            
            // 비밀번호 확인
            if (password !== passwordConfirm) {
                e.preventDefault();
                alert('비밀번호가 일치하지 않습니다.');
                document.getElementById('passwordConfirm').focus();
                return;
            }
        });
    </script>
</body>
</html>