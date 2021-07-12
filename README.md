# media_playing_board
- 개발 기간 : 2021.05.01 ~ 2021.06.30
- 유형 : 팀 프로젝트
- 역할
  - S3 버킷에 접근해 영상을 재생시키고, 자막 관련한 모든 기능들을 제작.
  - Toast Gird를 사용하여 게시판 제작.
  - 회원가입 시 Twilio API를 이용해 헨드폰 인증 구현.
  - 비밀번호 찾기 시 Java Mail API 를 이용해 임시 비밀번호 전송 구현.
  - 메인화면에서 포스터 클릭시 해당 에피소드 동적 생성 제작.
  - 관리자 통계 화면에서 멤버, 영상과 관련된 통계자료 출력 .
## 개발 목적
- 기존의 동영상 플랫폼에 자막 선택 기능을 넣어 영어를 쉽게 접할 수 있도록 하기 위한 서비스.
- 영어 공부만을 위한 사이트가 아닌 컨텐츠를 즐기면서 영어에 대한 거부감 없이 다가가기 위한 플랫폼.

## 구현하고자 하는 기능
- 영상 재생시 자막을 클릭하면 자막이 재생되는 위치로 영상 재생구간 이동.
- 북마크 클릭시 해당 자막을 저장, 북마크 화면에서 자막 클릭시 해당 영상 자막 재생시점으로 이동.
- 시청중인 목록 생성.
- 메인화면에서 해당 영상 포스터를 노출시키고, 포스터 클릭시 관련 에피소드를 보여주고, 에피소드 클릭시 재생화면으로 이동.
- S3 버킷을 이용하여 클라우드에서 파일을 불러와 페이지에 출력.

## 개발환경
- JAVA
- Spring
- JSP
- AJAX
- mybatis
- apache tomcat
- javascript
- JQuery

## 사용한 API
- AWS S3
- Twilio API
- KakaoTalk API
- JAVA Mail API
- Toast UI Grid 

## DB ERD설계 및 생성(Oracle)
![YANADO_ERD](https://user-images.githubusercontent.com/84821387/125220213-48283880-e301-11eb-865f-859157d8c87a.png)
[ERD_SQL_QUERY.txt](https://github.com/seowoo-jin/movie_play/files/6798688/ERD_SQL_QUERY.txt)



## 구현 화면

### 1. 로그인 및 회원가입
![회원가입_1](https://user-images.githubusercontent.com/84821387/125232063-d6f38000-e316-11eb-80ae-92f79ef1ddb5.jpg)
![회원가입_2](https://user-images.githubusercontent.com/84821387/125232069-da870700-e316-11eb-9903-b26705d9e4eb.jpg)

***
### 2. 메인화면
![메인화면_gif](https://user-images.githubusercontent.com/84821387/125229314-7f064a80-e311-11eb-9093-b22dcaed2456.gif)

***
### 3. 동영상 재생
![동영상 재생_gif](https://user-images.githubusercontent.com/84821387/125233982-af061b80-e31a-11eb-9391-2982fb5f1e21.gif)
***
### 4. 관리자 페이지
![관리자 페이지1](https://user-images.githubusercontent.com/84821387/125234425-ac57f600-e31b-11eb-8a73-b08e62374fea.jpg)
![관리자 페이지2](https://user-images.githubusercontent.com/84821387/125234428-ae21b980-e31b-11eb-9ca0-2a233a350d4a.jpg)
![관리자 페이지3](https://user-images.githubusercontent.com/84821387/125234431-af52e680-e31b-11eb-82c0-c494b132e9ef.jpg)
![관리자 페이지4](https://user-images.githubusercontent.com/84821387/125234434-afeb7d00-e31b-11eb-857c-052131d68cd3.jpg)
![관리자 페이지5](https://user-images.githubusercontent.com/84821387/125234435-b0841380-e31b-11eb-9173-be3ad776d8fc.jpg)
***
### 5. 유저 페이지

![유져 게시판1](https://user-images.githubusercontent.com/84821387/125234629-0953ac00-e31c-11eb-83bb-949c09f68192.jpg)
![유저 게시판2](https://user-images.githubusercontent.com/84821387/125234617-0658bb80-e31c-11eb-8422-d8b1d680fc29.jpg)
![유저 게시판3](https://user-images.githubusercontent.com/84821387/125234622-08227f00-e31c-11eb-8d36-02bdfef4da19.jpg)
![유저 게시판4](https://user-images.githubusercontent.com/84821387/125234624-08bb1580-e31c-11eb-973e-ab99703d1d47.jpg)
![유저 게시판5](https://user-images.githubusercontent.com/84821387/125234627-0953ac00-e31c-11eb-918e-b7771a165beb.jpg)
***

