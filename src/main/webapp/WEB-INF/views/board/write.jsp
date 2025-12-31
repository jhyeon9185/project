<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 작성</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f8f9fa;
        }
        .write-header {
            background-color: #28a745;
            color: white;
            padding: 20px;
            text-align: center;
            border-radius: 10px;
            margin-bottom: 20px;
        }
        .write-container {
            max-width: 800px;
            margin: 0 auto;
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: bold;
            font-size: 14px;
        }
        .form-group input[type="text"] {
            width: 100%;
            padding: 12px;
            border: 2px solid #dee2e6;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
        }
        .form-group input[type="text"]:focus {
            border-color: #28a745;
            outline: none;
        }
        .form-group textarea {
            width: 100%;
            min-height: 300px;
            padding: 12px;
            border: 2px solid #dee2e6;
            border-radius: 5px;
            font-size: 14px;
            line-height: 1.6;
            resize: vertical;
            box-sizing: border-box;
        }
        .form-group textarea:focus {
            border-color: #28a745;
            outline: none;
        }
        .writer-info {
            background-color: #f8f9fa;
            padding: 12px;
            border-radius: 5px;
            color: #6c757d;
            font-size: 14px;
            border: 1px solid #dee2e6;
        }
        .btn-container {
            text-align: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #dee2e6;
        }
        .btn {
            padding: 12px 30px;
            margin: 0 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            text-decoration: none;
            display: inline-block;
        }
        .btn-success {
            background-color: #28a745;
            color: white;
        }
        .btn-success:hover {
            background-color: #1e7e34;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        .btn-secondary:hover {
            background-color: #545b62;
        }
        .required {
            color: #dc3545;
        }
        .char-count {
            text-align: right;
            font-size: 12px;
            color: #6c757d;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <div class="write-header">
        <h1>✏️ 게시글 작성</h1>
        <p>새로운 게시글을 작성해보세요!</p>
    </div>
    
    <div class="write-container">
        <form action="/board/write" method="post" onsubmit="return validateForm()">
            <div class="form-group">
                <label for="writer">작성자</label>
                <div class="writer-info">
                    <sec:authentication property="name" var="currentUser" />
                    <strong>${currentUser}</strong> (현재 로그인한 사용자)
                </div>
            </div>
            
            <div class="form-group">
                <label for="title">제목 <span class="required">*</span></label>
                <input type="text" id="title" name="title" required 
                       placeholder="게시글 제목을 입력하세요" maxlength="200">
                <div class="char-count">
                    <span id="titleCount">0</span> / 200자
                </div>
            </div>
            
            <div class="form-group">
                <label for="content">내용 <span class="required">*</span></label>
                <textarea id="content" name="content" required 
                          placeholder="게시글 내용을 입력하세요&#10;&#10;• 다른 사용자를 존중하는 내용으로 작성해주세요&#10;• 광고성 게시글은 삭제될 수 있습니다"></textarea>
                <div class="char-count">
                    <span id="contentCount">0</span>자
                </div>
            </div>
            
            <div class="btn-container">
                <button type="submit" class="btn btn-success">📝 작성완료</button>
                <a href="/board/list" class="btn btn-secondary">취소</a>
            </div>
        </form>
    </div>

    <script>
        // 제목 글자수 카운트
        document.getElementById('title').addEventListener('input', function() {
            const titleLength = this.value.length;
            document.getElementById('titleCount').textContent = titleLength;
            
            if (titleLength > 180) {
                document.getElementById('titleCount').style.color = '#dc3545';
            } else {
                document.getElementById('titleCount').style.color = '#6c757d';
            }
        });
        
        // 내용 글자수 카운트
        document.getElementById('content').addEventListener('input', function() {
            const contentLength = this.value.length;
            document.getElementById('contentCount').textContent = contentLength;
        });
        
        // 폼 검증
        function validateForm() {
            const title = document.getElementById('title').value.trim();
            const content = document.getElementById('content').value.trim();
            
            if (!title) {
                alert('제목을 입력해주세요.');
                document.getElementById('title').focus();
                return false;
            }
            
            if (title.length < 2) {
                alert('제목은 2글자 이상 입력해주세요.');
                document.getElementById('title').focus();
                return false;
            }
            
            if (!content) {
                alert('내용을 입력해주세요.');
                document.getElementById('content').focus();
                return false;
            }
            
            if (content.length < 10) {
                alert('내용은 10글자 이상 입력해주세요.');
                document.getElementById('content').focus();
                return false;
            }
            
            return confirm('게시글을 작성하시겠습니까?');
        }
        
        // 페이지 이탈 방지 (내용이 있을 때)
        window.addEventListener('beforeunload', function(e) {
            const title = document.getElementById('title').value.trim();
            const content = document.getElementById('content').value.trim();
            
            if (title || content) {
                e.preventDefault();
                e.returnValue = '';
            }
        });
        
        // 폼 제출 시 이탈 방지 해제
        document.querySelector('form').addEventListener('submit', function() {
            window.removeEventListener('beforeunload', arguments.callee);
        });
    </script>
</body>
</html>