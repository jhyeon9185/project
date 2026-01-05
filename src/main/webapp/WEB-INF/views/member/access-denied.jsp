<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Access Denied</title>
    <style>
        @import url("https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.css");

        :root {
            --danger-red: #ff3b30;
            --dark-bg: #0a0a0a;
            --text-gray: #86868b;
        }

        body {
            font-family: 'Pretendard', sans-serif;
            background-color: var(--dark-bg);
            color: white;
            margin: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
            -webkit-font-smoothing: antialiased;
        }

        .error-container {
            text-align: center;
            padding: 40px;
            z-index: 2;
        }

        /* 403 글리치 효과 */
        .error-code {
            font-size: 150px;
            font-weight: 900;
            margin: 0;
            line-height: 1;
            color: var(--danger-red);
            position: relative;
            letter-spacing: -5px;
            animation: glitch 1s infinite;
        }

        .error-code::before, .error-code::after {
            content: "403";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            opacity: 0.8;
        }

        .error-code::before {
            color: #00ffff;
            z-index: -1;
            animation: glitch-anim 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94) both infinite;
        }

        .error-code::after {
            color: #ff00ff;
            z-index: -2;
            animation: glitch-anim-2 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94) reverse both infinite;
        }

        h2 {
            font-size: 28px;
            font-weight: 700;
            margin-top: 20px;
            letter-spacing: -1px;
        }

        p {
            color: var(--text-gray);
            font-size: 16px;
            margin-bottom: 40px;
            line-height: 1.5;
        }

        /* 경고 버튼 스타일 */
        .btn-group {
            display: flex;
            justify-content: center;
            gap: 15px;
        }

        .btn {
            padding: 14px 28px;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .btn-home {
            background-color: var(--danger-red);
            color: white;
            border: none;
        }

        .btn-home:hover {
            background-color: #d70015;
            box-shadow: 0 0 20px rgba(255, 59, 48, 0.4);
        }

        .btn-outline {
            background-color: transparent;
            color: white;
        }

        .btn-outline:hover {
            background-color: rgba(255, 255, 255, 0.05);
            border-color: white;
        }

        /* 배경 노이즈 효과 */
        .noise {
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: url('https://grainy-gradients.vercel.app/noise.svg');
            opacity: 0.05;
            pointer-events: none;
            z-index: 1;
        }

        /* 애니메이션 정의 */
        @keyframes glitch-anim {
            0% { transform: translate(0); }
            20% { transform: translate(-3px, 3px); }
            40% { transform: translate(-3px, -3px); }
            60% { transform: translate(3px, 3px); }
            80% { transform: translate(3px, -3px); }
            100% { transform: translate(0); }
        }

        @keyframes glitch-anim-2 {
            0% { transform: translate(0); }
            20% { transform: translate(3px, -3px); }
            40% { transform: translate(3px, 3px); }
            60% { transform: translate(-3px, -3px); }
            80% { transform: translate(-3px, 3px); }
            100% { transform: translate(0); }
        }
    </style>
</head>
<body>
    <div class="noise"></div>
    
    <div class="error-container">
        <h1 class="error-code">403</h1>
        <h2>접근 권한이 거부되었습니다</h2>
        <p>
            귀하의 계정은 이 영역에 진입할 수 있는 권한이 없습니다.<br>
            비정상적인 접근 시도가 기록될 수 있습니다.
        </p>
        
        <div class="btn-group">
            <button class="btn btn-home" onclick="location.href='/home'">안전한 곳으로 이동</button>
            <button class="btn btn-outline" onclick="location.href='/member/login'">인증하기</button>
            <button class="btn btn-outline" onclick="history.back()">이전으로</button>
        </div>
    </div>

    <script>
        // 무작위로 화면이 흔들리는 듯한 효과 (선택사항)
        setInterval(() => {
            if(Math.random() > 0.98) {
                document.body.style.transform = `translate(${Math.random()*5}px, ${Math.random()*5}px)`;
                setTimeout(() => {
                    document.body.style.transform = 'translate(0,0)';
                }, 50);
            }
        }, 100);
    </script>
</body>
</html>