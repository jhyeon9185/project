<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원정보 수정</title>
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
        .modify-container {
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            width: 400px;
            max-width: 100%;
        }
        .modify-container h2 {
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
        .form-group input[readonly] {
            background-color: #f8f9fa;
            color: #6c757d;
        }
        .modify-btn {
            width: 100%;
            padding: 12px;
            background-color: #ffc107;
            color: #212529;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-bottom: 10px;
            font-weight: bold;
        }
        .modify-btn:hover {
            background-color: #e0a800;
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
        .required {
            color: red;
        }
        .info-text {
            font-size: 12px;
            color: #666;
            margin-top: 5px;
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
                <div class="info-text">* 아이디는 변경할 수 없습니다.</div>
            </div>
            
            <div class="form-group">
                <label for="password">새 비밀번호 <span class="required">*</span></label>
                <input type="password" id="password" name="password" required placeholder="새 비밀번호를 입력하세요">
            </div>
            
            <div class="form-group">
                <label for="passwordConfirm">새 비밀번호 확인 <span class="required">*</span></label>
                <input type="password" id="passwordConfirm" name="passwordConfirm" required placeholder="새 비밀번호를 다시 입력하세요">
            </div>
            
            <div class="form-group">
                <label for="name">이름 <span class="required">*</span></label>
                <input type="text" id="name" name="name" value="${member.name}" required placeholder="이름을 입력하세요">
            </div>
            
            <div class="form-group">
                <label for="email">이메일 <span class="required">*</span></label>
                <input type="email" id="email" name="email" value="${member.email}" required placeholder="이메일을 입력하세요">
            </div>
            
            <div class="form-group">
                <label for="phone">전화번호</label>
                <input type="tel" id="phone" name="phone" value="${member.phone}" placeholder="전화번호를 입력하세요 (선택사항)">
            </div>
            
            <button type="submit" class="modify-btn">정보 수정</button>
        </form>
        
        <button type="button" class="back-btn" onclick="history.back()">이전 페이지</button>
        <button type="button" class="back-btn" onclick="location.href='/home'" style="margin-top: 5px;">홈으로</button>
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