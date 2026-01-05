<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시글 작성</title>
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
            --error-color: #ff3b30;
        }

        body {
            font-family: 'Pretendard', -apple-system, sans-serif;
            margin: 0;
            padding: 0;
            background-color: var(--bg-color);
            color: var(--text-main);
            -webkit-font-smoothing: antialiased;
        }

        /* 상단 네비게이션 */
        .top-nav {
            position: sticky;
            top: 0;
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(20px);
            z-index: 100;
            border-bottom: 1px solid #f2f2f2;
            padding: 0 40px;
            height: 52px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .nav-logo { font-weight: 700; font-size: 18px; text-decoration: none; color: var(--text-main); }
        .nav-link { font-size: 13px; text-decoration: none; color: var(--text-sub); font-weight: 500; }

        /* 헤더 섹션 */
        .write-header {
            padding: 80px 20px 40px;
            text-align: center;
        }
        .write-header h1 {
            font-size: 34px;
            font-weight: 700;
            letter-spacing: -1.2px;
            margin-bottom: 8px;
        }
        .write-header p {
            color: var(--text-sub);
            font-size: 17px;
        }

        /* 메인 컨테이너 */
        .write-container {
            max-width: 800px;
            margin: 0 auto 100px;
            background-color: var(--card-bg);
            padding: 60px;
            border-radius: 28px;
            box-shadow: 0 12px 40px rgba(0,0,0,0.03);
        }

        /* 폼 스타일 */
        .form-group {
            margin-bottom: 32px;
        }
        .form-group label {
            display: block;
            margin-bottom: 10px;
            color: var(--text-main);
            font-weight: 600;
            font-size: 15px;
        }

        /* 입력 필드 공통 */
        .form-group input[type="text"], 
        .form-group textarea {
            width: 100%;
            padding: 16px;
            border: 1px solid var(--border-soft);
            border-radius: 12px;
            font-size: 16px;
            font-family: inherit;
            box-sizing: border-box;
            background-color: #ffffff;
            transition: all 0.2s ease;
        }

        .form-group input[type="text"]:focus, 
        .form-group textarea:focus {
            border-color: var(--primary-color);
            outline: none;
            box-shadow: 0 0 0 4px rgba(0, 113, 227, 0.1);
        }

        .form-group textarea {
            min-height: 400px;
            line-height: 1.6;
            resize: none;
        }

        /* 작성자 정보 바 */
        .writer-info {
            padding-bottom: 20px;
            margin-bottom: 30px;
            border-bottom: 1px solid #f2f2f2;
            color: var(--text-sub);
            font-size: 14px;
        }
        .writer-info strong {
            color: var(--text-main);
            margin-right: 4px;
        }

        /* 글자수 카운트 */
        .char-count {
            text-align: right;
            font-size: 12px;
            color: var(--text-sub);
            margin-top: 8px;
        }

        /* 버튼 영역 */
        .btn-container {
            display: flex;
            justify-content: center;
            gap: 12px;
            margin-top: 50px;
            padding-top: 30px;
            border-top: 1px solid #f2f2f2;
        }

        .btn {
            padding: 12px 32px;
            border-radius: 40px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            text-decoration: none;
            border: none;
        }

        .btn-submit { background-color: #1d1d1f; color: #ffffff; }
        .btn-submit:hover { background-color: #000000; transform: translateY(-1px); }

        .btn-cancel { background-color: #f5f5f7; color: var(--text-main); }
        .btn-cancel:hover { background-color: #e8e8ed; }

        .required {
            color: var(--primary-color);
            margin-left: 2px;
        }
    </style>
</head>
<body>

    <nav class="top-nav">
        <div class="nav-links">
            <a href="/board/list" class="nav-link">목록으로 돌아가기</a>
        </div>
    </nav>

    <div class="write-header">
        <h1>게시글 작성</h1>
        <p>새로운 소식을 공유해 주세요</p>
    </div>
    
    <div class="write-container">
        <form action="/board/write" method="post" onsubmit="return validateForm()">
            <div class="writer-info">
                <sec:authentication property="name" var="currentUser" />
                작성자 <strong>${currentUser}</strong>
            </div>
            
            <div class="form-group">
                <label for="title">제목<span class="required">*</span></label>
                <input type="text" id="title" name="title" required 
                       placeholder="제목을 입력하세요" maxlength="200">
                <div class="char-count">
                    <span id="titleCount">0</span> / 200
                </div>
            </div>
            
            <div class="form-group">
                <label for="content">내용<span class="required">*</span></label>
                <textarea id="content" name="content" required 
                          placeholder="내용을 입력하세요 (타인을 존중하는 마음을 담아주세요)"></textarea>
                <div class="char-count">
                    <span id="contentCount">0</span>자
                </div>
            </div>
            
            <div class="btn-container">
                <button type="submit" class="btn btn-submit">작성 완료</button>
                <a href="/board/list" class="btn btn-cancel">취소</a>
            </div>
        </form>
    </div>

    <script>
        // 제목 글자수 카운트
        document.getElementById('title').addEventListener('input', function() {
            const len = this.value.length;
            const countEl = document.getElementById('titleCount');
            countEl.textContent = len;
            countEl.style.color = len > 180 ? 'var(--error-color)' : 'var(--text-sub)';
        });
        
        // 내용 글자수 카운트
        document.getElementById('content').addEventListener('input', function() {
            document.getElementById('contentCount').textContent = this.value.length;
        });
        
        // 폼 검증
        function validateForm() {
            const title = document.getElementById('title').value.trim();
            const content = document.getElementById('content').value.trim();
            
            if (title.length < 2) {
                alert('제목은 2글자 이상 입력해 주세요.');
                return false;
            }
            if (content.length < 10) {
                alert('내용은 10글자 이상 입력해 주세요.');
                return false;
            }
            return confirm('게시글을 등록하시겠습니까?');
        }
        
        // 페이지 이탈 방지
        let isSubmitting = false;
        document.querySelector('form').addEventListener('submit', () => { isSubmitting = true; });

        window.addEventListener('beforeunload', function(e) {
            const title = document.getElementById('title').value.trim();
            const content = document.getElementById('content').value.trim();
            
            if (!isSubmitting && (title || content)) {
                e.preventDefault();
                e.returnValue = '';
            }
        });
    </script>
</body>
</html>