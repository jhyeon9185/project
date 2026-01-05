<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Admin Console</title>
    <style>
        /* Pretendard 폰트 임포트 */
        @import url("https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.css");

        :root {
            --admin-main: #1d1d1f;
            --admin-accent: #0071e3;
            --bg-color: #f5f5f7;
            --card-bg: #ffffff;
            --text-sub: #86868b;
        }

        body {
            font-family: 'Pretendard', -apple-system, sans-serif;
            margin: 0;
            padding: 0;
            background-color: var(--bg-color);
            color: var(--admin-main);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            -webkit-font-smoothing: antialiased;
        }

        .admin-wrapper {
            width: 100%;
            max-width: 900px;
            padding: 40px 20px;
        }

        /* 헤더 섹션 */
        .admin-header {
            text-align: left;
            margin-bottom: 40px;
            padding-left: 10px;
        }
        .admin-header h1 {
            font-size: 38px;
            font-weight: 800;
            margin: 0;
            letter-spacing: -1.5px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .admin-header h1 span {
            font-size: 14px;
            background: #ff3b30;
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            letter-spacing: 0;
            vertical-align: middle;
        }
        .admin-header p {
            color: var(--text-sub);
            font-size: 17px;
            margin-top: 10px;
        }

        /* 그리드 메뉴 레이아웃 */
        .admin-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .admin-card {
            background-color: var(--card-bg);
            padding: 40px;
            border-radius: 24px;
            text-decoration: none;
            color: inherit;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            border: 1px solid rgba(0,0,0,0.02);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .admin-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.08);
            border-color: var(--admin-accent);
        }

        .admin-card h3 {
            font-size: 22px;
            margin: 0 0 10px 0;
            font-weight: 700;
        }

        .admin-card p {
            color: var(--text-sub);
            font-size: 15px;
            margin: 0;
            line-height: 1.5;
        }

        .card-icon {
            font-size: 32px;
            margin-bottom: 20px;
        }

        /* 하단 보조 버튼 영역 */
        .admin-footer {
            margin-top: 40px;
            display: flex;
            justify-content: center;
            gap: 30px;
        }

        .footer-btn {
            color: var(--text-sub);
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: color 0.2s;
        }

        .footer-btn:hover {
            color: var(--admin-main);
        }

        /* 로그아웃 전용 강조 */
        .btn-logout {
            color: #ff3b30;
        }

        @media (max-width: 600px) {
            .admin-grid { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>

    <div class="admin-wrapper">
        <header class="admin-header">
            <h1>관리자 페이지 <span>admin</span></h1>
            <p>관리자 대시보드입니다.</p>
        </header>
        
        <div class="admin-grid">
            <a href="/board/list" class="admin-card">
                <div>
                    <h3>콘텐츠 관리</h3>
                    <p>게시글 모니터링 및 관리</p>
                </div>
            </a>

            <a href="/admin/member/list" class="admin-card">
                <div>
                    <h3>사용자 관리</h3>
                    <p>회원 목록 확인 및 권한 변경,<br>계정 상태를 제어</p>
                </div>
            </a>
        </div>

        <div class="admin-footer">
            <a href="/home" class="footer-btn">메인 화면</a>
            <a href="/member/login" class="footer-btn btn-logout">로그아웃</a>
        </div>
    </div>

</body>
</html>