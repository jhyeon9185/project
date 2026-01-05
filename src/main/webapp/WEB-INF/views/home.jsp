<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Service Hub</title>
    <style>
        @import url("https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.css");

        :root {
            --bg-gradient: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            --accent-color: #0071e3;
            --glass-bg: rgba(255, 255, 255, 0.7);
            --card-shadow: 0 20px 40px rgba(0, 0, 0, 0.08);
            --text-main: #1d1d1f;
            --text-sub: #86868b;
            --accent-blue: #0071e3;
        	--soft-bg: #ffffff;
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

        /* 배경에 은은한 원형 장식 추가 (트렌디함 한 스푼) */
        body::before {
            content: "";
            position: absolute;
            width: 500px; height: 500px;
            background: radial-gradient(circle, rgba(0,113,227,0.1) 0%, rgba(255,255,255,0) 70%);
            top: -100px; right: -100px; z-index: -1;
        }

        .main-card {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.4);
            padding: 50px 40px;
            border-radius: 32px;
            box-shadow: var(--card-shadow);
            width: 100%;
            max-width: 400px;
            text-align: center;
            /* 추가된 부분: 초기 상태 숨김 */
		    opacity: 0;
		    transform: translateY(20px);
		    transition: all 0.8s cubic-bezier(0.25, 0.1, 0.25, 1);
        }

        .logo-area {
            font-size: 24px;
            font-weight: 800;
            letter-spacing: -1px;
            margin-bottom: 40px;
            color: var(--accent-color);
        }

        h2 {
            font-size: 32px;
            font-weight: 700;
            margin: 0 0 10px 0;
            letter-spacing: -1.5px;
        }

        .welcome-text {
            color: var(--text-sub);
            font-size: 16px;
            margin-bottom: 40px;
        }

        /* 버튼 그룹 레이아웃 */
        .btn-stack {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .btn {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 16px;
            border-radius: 16px;
            font-size: 16px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s cubic-bezier(0.25, 0.1, 0.25, 1);
            border: none;
            cursor: pointer;
        }

        /* 주요 액션 버튼 (Apple Style) */
        .btn-primary {
            background-color: var(--text-main);
            color: white;
        }
        .btn-primary:hover {
            background-color: #000;
            transform: scale(1.02);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }

        /* 부가 기능 버튼 */
        .btn-secondary {
            background-color: rgba(0, 0, 0, 0.05);
            color: var(--text-main);
        }
        .btn-secondary:hover {
            background-color: rgba(0, 0, 0, 0.1);
            transform: translateY(-2px);
        }

        /* 로그아웃 (위험 요소) */
        .btn-outline {
            background: transparent;
            color: #ff3b30;
            margin-top: 10px;
            font-size: 14px;
            font-weight: 500;
        }
        .btn-outline:hover {
            text-decoration: underline;
        }

        .user-profile {
            background: white;
            padding: 20px;
            border-radius: 20px;
            margin-bottom: 30px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.03);
            display: flex;
            align-items: center;
            gap: 15px;
            text-align: left;
        }

        .avatar {
            width: 48px;
            height: 48px;
            background: #e5e5ea;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            color: var(--text-sub);
        }

        .user-meta .name { font-weight: 700; font-size: 17px; }
        .user-meta .role { font-size: 12px; color: var(--accent-color); font-weight: 600; }
        
      /* 스플래시 전체 컨테이너 */
    #splash-screen {
        position: fixed;
        top: 0; left: 0;
        width: 100%; height: 100%;
        background-color: var(--soft-bg);
        display: flex;
        justify-content: center;
        align-items: center;
        z-index: 10000;
        transition: opacity 1s cubic-bezier(0.4, 0, 0.2, 1);
    }

    .splash-content {
        text-align: center;
    }

    /* 로고 페이드인 애니메이션 */
    #splash-logo {
        font-family: 'Pretendard', sans-serif;
        font-size: 5rem;
        font-weight: 800;
        color: #1d1d1f;
        letter-spacing: -2px;
        margin: 0;
        opacity: 0;
        transform: translateY(10px);
        animation: fadeIn 1.2s forwards cubic-bezier(0.2, 0.8, 0.2, 1);
    }

    @keyframes fadeIn {
        to { opacity: 1; transform: translateY(0); }
    }

    @keyframes loadProgress {
        0% { width: 0; opacity: 1; }
        80% { width: 100px; opacity: 1; }
        100% { width: 100px; opacity: 0; }
    }

    /* 스플래시 페이드아웃 클래스 */
    .splash-fade-out {
        opacity: 0 !important;
        pointer-events: none;
    }

    /* 메인 카드 등장 애니메이션 (블러 효과 포함) */
    .main-card {
        opacity: 0;
        filter: blur(15px);
        transform: scale(0.98);
        transition: all 1.2s cubic-bezier(0.2, 0.8, 0.2, 1);
    }

    .main-card.reveal {
        opacity: 1;
        filter: blur(0);
        transform: scale(1);
    }
</style>

</head>
<body>
	<div id="splash-screen">
	    <div class="splash-content">
	        <h1 id="splash-logo">Hello</h1>
	        <div class="loading-bar"></div> </div>
	</div>
    <div class="main-card">
		
        <sec:authorize access="!isAuthenticated()">
            <h2>Welcome</h2>
            <p class="welcome-text"></p>
            <div class="btn-stack">
                <a href="/member/login" class="btn btn-primary">로그인</a>
                <a href="/member/join" class="btn btn-secondary">회원가입</a>
            </div>
        </sec:authorize>

        <sec:authorize access="isAuthenticated()">
            <div class="user-profile">
                <div class="avatar">
                    <sec:authentication property="name" var="username" />
                    ${username.substring(0,1).toUpperCase()}
                </div>
                <div class="user-meta">
                    <div class="name">${username}님</div>	
                </div>
            </div>
			
            <div class="btn-stack">
                <a href="/board/list" class="btn btn-primary">게시판 바로가기</a>
                
                <sec:authorize access="hasRole('ADMIN')">
                    <a href="/admin" class="btn btn-secondary" style="background-color: #fff2f1; color: #ff3b30;">관리자 대시보드</a>
                </sec:authorize>
                
                <a href="/member/modify" class="btn btn-secondary">회원정보 수정</a>

                <form action="/logout" method="post" id="logoutForm" style="display: none;">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                </form>
                <a href="javascript:document.getElementById('logoutForm').submit();" class="btn btn-outline">로그아웃</a>
            </div>
        </sec:authorize>
    </div>
	
	<script>
	document.addEventListener("DOMContentLoaded", () => {
        const splash = document.getElementById("splash-screen");
        const card = document.querySelector(".main-card");

        // 세션 체크 (새로고침 시 중복 방지)
        if (sessionStorage.getItem("visited")) {
            splash.style.display = "none";
            card.classList.add("reveal");
            return;
        }

        // 스플래시 시퀀스
        setTimeout(() => {
            // 1. 스플래시 화면 페이드아웃 시작
            splash.classList.add("splash-fade-out");
            
            // 2. 메인 컨텐츠 서서히 등장
            setTimeout(() => {
                card.classList.add("reveal");
                sessionStorage.setItem("visited", "true");
            }, 300); // 스플래시가 사라지기 시작할 때 같이 등장

            // 3. 완전히 사라진 후 제거
            setTimeout(() => {
                splash.style.display = "none";
            }, 1000);
        }, 1000); 
    });
	</script>
</body>
</html>