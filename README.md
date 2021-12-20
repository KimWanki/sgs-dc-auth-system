SGS-DC-Auth-System
===

--------- 필수 기능 ----------
- [x] 사용자 DB 설계
- [x] 가입, 로그인 페이지
- [x] 인증 서버(API)
- [x] RDBMS(MySQL)
- [x] Password Encryption(salt + 암호화?)
- [x] 유지 관리 페이지(admin/backoffice)

<!-- --------- 필수 기능 ----------
- [ ] E-mail 인증
- [ ] 비밀번호 찾기
- [ ] 캐시

 -->
 
 
<!-- **도구 List**
ER Diagram => https://www.erdcloud.com/
 -->
<!--  ![](https://i.imgur.com/WFdQp2c.png) -->


### 아키텍쳐


### 서버구현 - RestAPI 형식으로 구성
---

**네이티브 앱과 통신하기 위한 모바일 서버 구축**

1. **사용자 DB 설계**
   
   **Users Table**
    |column|내용|속성|
    |---|---|---|
    |email|이메일 저장|VARCHAR(50)|
    |password|비밀번호 저장|VARCHAR(20)|
    |name|이름 저장|VARCHAR(12)|
    |nickname|별칭 저장|VARCHAR(12)|


2. API 서버 구현 

|API ||
|--|--|
|Language| Node.js |
|Framework | Express |
|Authorization | JWT |

암호화 방식 : sha512 + salt

Auth 인증에 따른 access token의 경우, 모바일 접속 환경을 고려하여 expiredTime을 보다 길게 설정함.

### 클라이언트 구현
---
2. **가입, 로그인 페이지**

|로그인|새 글 쓰기|로그인 실패|로그인 성공|
|:-:|:-:|:-:|:-:|
|<img src = "https://i.imgur.com/hookXgC.png" width = 200>|<img src = "https://i.imgur.com/THvgAQl.png" width = 200>|<img src = "https://i.imgur.com/thUQnWG.png" width = 200>|<img src = "https://i.imgur.com/Y3EGl4X.png" width = 200>|

- UserDefault를 활용한 자동 로그인

|회원가입|중복 이메일 확인|비밀번호 입력|회원가입|
|:-:|:-:|:-:|:-:|
|<img src = "https://i.imgur.com/Tuaxq1C.png" width = 200>|<img src = "https://i.imgur.com/1UDtzNe.png" width = 200>|<img src = "https://i.imgur.com/YfbbNOP.png" width = 200>|<img src = "https://i.imgur.com/bM5sJ2K.png" width = 200>|

- Keyboard 위 accessoryButton 구성


|일반 로그인|관리자 로그인|
|:-:|:-:|
|<img src = "https://i.imgur.com/Y3EGl4X.png" width = 200>|<img src = "https://i.imgur.con/Y3EGX.png" width = 200>|




