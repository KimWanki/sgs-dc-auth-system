SGS-DC-Auth-System
===

--------- 필수 기능 ----------
- [x] 사용자 DB 설계
- [x] 가입, 로그인 페이지
- [x] 인증 서버(API)
- [x] RDBMS(MySQL)
- [x] Password Encryption(salt + 암호화)
- [x] 유지 관리 페이지(admin/backoffice)

<!-- --------- 필수 기능 ----------
- [ ] E-mail 인증
- [ ] 비밀번호 찾기
- [ ] 캐시
 -->


### 아키텍쳐

![](https://i.imgur.com/yTETyGX.png)

### 서버구현 - RestAPI 형식으로 구성
---

**네이티브 앱과 통신하기 위한 모바일 서버 구축**

1. **사용자 DB 설계**
   
   ![image](https://user-images.githubusercontent.com/57824307/146759032-c0c696c5-3a0a-47f1-af82-9179eb7c14c0.png)

   **Users Table**
    |column|내용|속성|
    |---|---|---|
    |email|이메일 저장|VARCHAR(50)|
    |password|비밀번호 저장|VARCHAR(65)|
    |name|이름 저장|VARCHAR(20)|
    |nickname|별칭 저장|VARCHAR(20)|
    |salt|유저별 salt값 저장|VARCHAR(65)|


2. API 서버 구현 

|API ||
|--|--|
|Language| Node.js |
|Framework | Express |
|Authorization | JWT |

암호화 방식 : sha512 + salt

Auth 인증에 따른 token 발급의 경우, 모바일 접속 환경을 고려하여 expiredTime을 길게 설정함.

### 클라이언트 구현
---
2. **가입, 로그인 페이지**

|일반 로그인|관리자 로그인|회원가입|
|---|---|---|
|![로그인](https://user-images.githubusercontent.com/57824307/146747127-275869c3-3694-4237-9f7e-ce38cc687ee4.gif)|![관리자 페이지](https://user-images.githubusercontent.com/57824307/146763162-c9ff8528-ba87-4342-8089-a8ed04929a40.gif)|![회원가입](https://user-images.githubusercontent.com/57824307/146747136-4cc78087-898c-498b-90e9-b7e4e36f6e7d.gif)|

|로그인|새 글 쓰기|로그인 실패|로그인 성공|
|:-:|:-:|:-:|:-:|
|<img src = "https://i.imgur.com/hookXgC.png" width = 200>|<img src = "https://i.imgur.com/THvgAQl.png" width = 200>|<img src = "https://i.imgur.com/thUQnWG.png" width = 200>|<img src = "https://i.imgur.com/Y3EGl4X.png" width = 200>|

- UserDefault를 활용한 자동 로그인
- 일반 유저 로그인 시 유저 정보 반영 화면 구성
- 관리자 화면 구성 시 모든 유저 정보 출력

|회원가입|중복 이메일 확인|비밀번호 입력|회원가입|
|:-:|:-:|:-:|:-:|
|<img src = "https://i.imgur.com/Tuaxq1C.png" width = 200>|<img src = "https://i.imgur.com/1UDtzNe.png" width = 200>|<img src = "https://i.imgur.com/YfbbNOP.png" width = 200>|<img src = "https://i.imgur.com/bM5sJ2K.png" width = 200>|

- Keyboard 위 accessoryButton 구성


|일반 로그인|관리자 로그인|
|:-:|:-:|
|<img src = "https://i.imgur.com/Y3EGl4X.png" width = 200>|<img src = "https://user-images.githubusercontent.com/57824307/146762809-4edb7466-d0f8-4a3d-b413-0c67685e01de.png" width = 200>|



