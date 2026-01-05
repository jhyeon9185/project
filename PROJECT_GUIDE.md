# Spring MVC 게시판 프로젝트 가이드

## 📁 프로젝트 구조

```
src/main/java/org/zerock/
├── controller/          # 요청 처리 (MVC의 C)
│   ├── BoardController.java      # 게시판 CRUD
│   ├── MemberController.java     # 회원 관리
│   ├── ReplyController.java      # 댓글 REST API
│   └── AdminController.java      # 관리자 기능
├── service/             # 비즈니스 로직
│   ├── BoardService.java / BoardServiceImpl.java
│   ├── MemberService.java / MemberServiceImpl.java
│   └── ReplyService.java / ReplyServiceImpl.java
├── mapper/              # MyBatis 인터페이스
│   ├── BoardMapper.java
│   ├── MemberMapper.java
│   └── ReplyMapper.java
├── dto/                 # 데이터 전송 객체
│   ├── BoardDTO.java
│   ├── MemberDTO.java
│   ├── ReplyDTO.java
│   └── PageDTO.java     # 페이징 처리
└── security/            # Spring Security 설정
    ├── SecurityConfig.java
    ├── CustomUserDetailsService.java
    ├── CustomLoginSuccessHandler.java
    └── Custom403Handler.java

src/main/resources/
└── mapper/              # MyBatis XML 쿼리
    ├── BoardMapper.xml
    ├── MemberMapper.xml
    └── ReplyMapper.xml
```

---

## 🔐 Spring Security 설정

### SecurityConfig.java 핵심 구조

```java
@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        
        // 1. URL별 접근 권한 설정
        http.authorizeHttpRequests(auth -> auth
            .requestMatchers("/admin/**").hasRole("ADMIN")           // 관리자만
            .requestMatchers("/board/write").hasAnyRole("USER", "ADMIN", "MEMBER")  // 로그인 필요
            .requestMatchers("/board/**").permitAll()                // 누구나 접근
            .requestMatchers("/", "/home", "/member/login", "/member/join").permitAll()
            .anyRequest().authenticated()
        );

        // 2. 로그인 설정
        http.formLogin(config -> {
            config.loginPage("/member/login");           // 커스텀 로그인 페이지
            config.failureUrl("/member/login?error=true"); // 실패 시 이동
            config.successHandler(new CustomLoginSuccessHandler()); // 성공 핸들러
        });

        // 3. 로그아웃 설정
        http.logout(config -> {
            config.logoutUrl("/logout");
            config.deleteCookies("JSESSIONID", "remember-me");
        });

        return http.build();
    }
}
```

### 인증 흐름

```
[로그인 요청] → [CustomUserDetailsService.loadUserByUsername()]
                         ↓
              [MemberMapper.findById(username)]
                         ↓
              [MemberDTO 반환 (UserDetails 구현체)]
                         ↓
              [Spring Security가 비밀번호 검증]
                         ↓
              [CustomLoginSuccessHandler → 역할별 리다이렉트]
```

### CustomUserDetailsService.java

```java
@Service
public class CustomUserDetailsService implements UserDetailsService {
    
    private final MemberMapper memberMapper;
    
    @Override
    public UserDetails loadUserByUsername(String username) {
        MemberDTO member = memberMapper.findById(username);
        
        if (member == null) {
            throw new UsernameNotFoundException("User not found");
        }
        
        member.addRole(member.getRole());  // 권한 추가
        return member;  // MemberDTO가 UserDetails 구현
    }
}
```

---

## 📝 게시판 CRUD

### 데이터 흐름

```
[JSP] ←→ [Controller] ←→ [Service] ←→ [Mapper] ←→ [DB]
```

### BoardController.java 핵심 메서드

| HTTP | URL | 메서드 | 설명 |
|------|-----|--------|------|
| GET | /board/list | list() | 목록 조회 (페이징) |
| GET | /board/{id} | view() | 상세 조회 |
| GET | /board/write | writeForm() | 작성 폼 |
| POST | /board/write | write() | 작성 처리 |
| GET | /board/modify/{id} | modifyForm() | 수정 폼 |
| POST | /board/modify/{id} | modify() | 수정 처리 |
| POST | /board/delete/{id} | delete() | 삭제 처리 |

### BoardMapper.xml 쿼리

```xml
<!-- 목록 조회 (페이징) -->
<select id="findAllWithPaging" resultMap="boardMap">
    SELECT seq, title, content, writer, regdate, hit, delflag
    FROM board
    WHERE delflag = FALSE
    ORDER BY regdate DESC
    LIMIT #{limit} OFFSET #{offset}
</select>

<!-- 작성 -->
<insert id="insert" useGeneratedKeys="true" keyProperty="seq">
    INSERT INTO board (title, content, writer, regdate, hit, delflag)
    VALUES (#{title}, #{content}, #{writer}, #{regdate}, #{hit}, FALSE)
</insert>

<!-- 수정 -->
<update id="update">
    UPDATE board 
    SET title = #{title}, content = #{content}, updatedate = #{updatedate}
    WHERE seq = #{seq} AND delflag = FALSE
</update>

<!-- 삭제 (논리적 삭제) -->
<update id="delete">
    UPDATE board SET delflag = TRUE WHERE seq = #{seq}
</update>
```

### 논리적 삭제 vs 물리적 삭제

```
물리적 삭제: DELETE FROM board WHERE seq = 1  (데이터 완전 삭제)
논리적 삭제: UPDATE board SET delflag = TRUE  (삭제 플래그만 변경)
```

이 프로젝트는 **논리적 삭제** 사용 → 데이터 복구 가능, 통계 유지

---

## 📄 페이징 처리

### PageDTO.java 핵심 로직

```java
@Data
public class PageDTO {
    private int page = 1;        // 현재 페이지
    private int size = 10;       // 페이지당 게시글 수
    private int total;           // 전체 게시글 수
    
    private int startPage;       // 네비게이션 시작 번호
    private int endPage;         // 네비게이션 끝 번호
    private int totalPages;      // 전체 페이지 수
    private boolean prev;        // 이전 그룹 존재 여부
    private boolean next;        // 다음 그룹 존재 여부
    
    private static final int PAGE_GROUP_SIZE = 10;
    
    // total 설정 시 자동 계산
    public void setTotal(int total) {
        this.total = total;
        calcPageInfo();
    }
    
    private void calcPageInfo() {
        // 전체 페이지 수
        totalPages = (int) Math.ceil((double) total / size);
        
        // 네비게이션 범위 계산
        int tempEndPage = (int) Math.ceil((double) page / PAGE_GROUP_SIZE) * PAGE_GROUP_SIZE;
        startPage = tempEndPage - PAGE_GROUP_SIZE + 1;
        endPage = Math.min(tempEndPage, totalPages);
        
        // 이전/다음 버튼 활성화 여부
        prev = startPage > 1;
        next = endPage < totalPages;
    }
    
    // MyBatis용 OFFSET/LIMIT
    public int getOffset() { return (page - 1) * size; }
    public int getLimit() { return size; }
}
```

### 페이징 계산 예시

```
전체 게시글: 415개, 현재 페이지: 15

totalPages = ceil(415 / 10) = 42
tempEndPage = ceil(15 / 10) * 10 = 20
startPage = 20 - 10 + 1 = 11
endPage = min(20, 42) = 20
prev = 11 > 1 = true
next = 20 < 42 = true

결과: [Prev] 11 12 13 14 [15] 16 17 18 19 20 [Next]
```

### Controller에서 사용

```java
@GetMapping("/list")
public String list(Model model, 
                   @RequestParam(defaultValue = "1") int page,
                   @RequestParam(defaultValue = "10") int size) {
    
    PageDTO pageDTO = new PageDTO(page, size);
    List<BoardDTO> boardList = boardService.findAllWithPaging(pageDTO);
    
    model.addAttribute("boardList", boardList);
    model.addAttribute("pageDTO", pageDTO);
    
    return "board/list";
}
```

### JSP 페이징 네비게이션

```jsp
<c:if test="${pageDTO.totalPages > 1}">
    <div class="pagination">
        <c:if test="${pageDTO.prev}">
            <a href="/board/list?page=${pageDTO.startPage - 1}">Prev</a>
        </c:if>
        
        <c:forEach begin="${pageDTO.startPage}" end="${pageDTO.endPage}" var="pageNum">
            <c:choose>
                <c:when test="${pageNum == pageDTO.page}">
                    <span class="current">${pageNum}</span>
                </c:when>
                <c:otherwise>
                    <a href="/board/list?page=${pageNum}">${pageNum}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        
        <c:if test="${pageDTO.next}">
            <a href="/board/list?page=${pageDTO.endPage + 1}">Next</a>
        </c:if>
    </div>
</c:if>
```

---

## 👤 회원 관리

### MemberService 주요 기능

| 메서드 | 설명 |
|--------|------|
| join() | 회원가입 (비밀번호 암호화) |
| findById() | 회원 조회 |
| update() | 정보 수정 |
| delete() | 회원 탈퇴 (논리적 삭제) |
| deletePwd() | 비밀번호 확인 후 탈퇴 |
| isUsernameDuplicated() | ID 중복 체크 |

### 회원가입 시 역할 부여

```java
// MemberServiceImpl.java
public void join(MemberDTO memberDTO) {
    // 비밀번호 암호화
    memberDTO.setPassword(passwordEncoder.encode(memberDTO.getPassword()));
    
    // 관리자 코드 "1234" 입력 시 ADMIN, 아니면 MEMBER
    if ("1234".equals(memberDTO.getAdminCode())) {
        memberDTO.setRole("ADMIN");
    } else {
        memberDTO.setRole("MEMBER");
    }
    
    memberMapper.insert(memberDTO);
}
```

---

## 💬 댓글 시스템

### REST API 구조 (ReplyController)

| HTTP | URL | 설명 |
|------|-----|------|
| GET | /api/replies/{bno} | 댓글 목록 |
| POST | /api/replies | 댓글 작성 |
| PUT | /api/replies/{rno} | 댓글 수정 |
| DELETE | /api/replies/{rno} | 댓글 삭제 |

### AJAX 댓글 등록 예시

```javascript
function addReply() {
    const replyText = document.getElementById('replyText').value;
    
    fetch('/api/replies', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
            bno: ${board.seq},
            replyText: replyText
        })
    })
    .then(response => response.json())
    .then(data => {
        loadReplies();  // 댓글 목록 새로고침
    });
}
```

---

## 🗄️ DB 테이블 구조

### board 테이블
```sql
CREATE TABLE board (
    seq INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    content TEXT,
    writer VARCHAR(50) NOT NULL,
    regdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedate TIMESTAMP,
    hit INT DEFAULT 0,
    delflag BOOLEAN DEFAULT FALSE
);
```

### members 테이블
```sql
CREATE TABLE members (
    id VARCHAR(50) PRIMARY KEY,
    password VARCHAR(200) NOT NULL,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(200) NOT NULL,
    role VARCHAR(20) DEFAULT 'MEMBER',
    phone VARCHAR(20),
    regdate TIMESTAMP DEFAULT NOW(),
    enabled BOOLEAN DEFAULT TRUE
);
```

### reply 테이블
```sql
CREATE TABLE reply (
    rno INT AUTO_INCREMENT PRIMARY KEY,
    bno INT NOT NULL,
    replyText VARCHAR(500) NOT NULL,
    replyer VARCHAR(50) NOT NULL,
    replydate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedate TIMESTAMP,
    deflag BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (bno) REFERENCES board(seq) ON DELETE CASCADE
);
```

---

## 🔑 핵심 포인트 요약

1. **계층 구조**: Controller → Service → Mapper → DB
2. **Security**: URL 패턴별 권한 설정, UserDetailsService로 인증
3. **페이징**: PageDTO에서 OFFSET/LIMIT 계산, MyBatis에서 쿼리 처리
4. **논리적 삭제**: delflag/enabled 컬럼으로 삭제 표시 (데이터 보존)
5. **비밀번호**: BCryptPasswordEncoder로 암호화 저장
