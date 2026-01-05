# BugSandwich - Ornably



![ORNABLY](https://i.pinimg.com/736x/84/a1/56/84a156ca7db6566b341cdff0e7900f1c.jpg)

> 자바 동적 웹 프로젝트 파일과 TOMCAT 9.0버전을 통한 로컬 웹 서비스 구축



# 중요! /src/main/resources/config.properties 를 추가해주어야합니다
```
# config.properties

# SOLAPI KEY AND
SOLAPI_API_KEY=
SOLAPI_API_SECRET=
SOLAPI_FROM_NUMBER=


# EMAIL_API KEY
GMAIL_API_FORM_EMAIL=
GMAIL_API_PASSWORD=

# kakao login api
KAKAO_LOGIN_API_KEY=

# kakao pay api
KAKAO_PAY_API_CID=
SECRET_KEY_DEV=
```
를 채워주어야합니다.



## 📖 목차

1. [프로젝트 소개]

2. [기술 스택]

3. [주요 기능]

4. [버전]

5. [트러블 슈팅]

---


## 📝 프로젝트 소개


- **개발 기간**: 2025.11.01 ~ 2026.01.04

- **개발 인원**: 4명 (.jsp파일 4명에서 나눠서 분담, CONTROLLER 2명, MODEL 2명)

- **프로젝트 개요**: 여러 디자인 패턴과 API, 기술을 공부 및 작업 역량 증진을 위한 프로젝트



## 🛠 기술 스택

### Frontend

- HTML, CSS, JS, jQuery, Ajax, jstl과 여러 cdn



### Backend

- Java, Servlet, Jsp, jdbc, ORACLE



### Tools

- Eclipse, DBeaver,  Git, GitHub, Notion, Excel, Google Drive, dbdiagram.io, draw.io, Figma



## ✨ 주요 기능

- **로그인/회원가입**: 회원가입 로직 - ajax를 통한 프론트에서의 여러 유효성 검사

- **상품목록**: 페이지네이션과 별점 플러그인을 통한 UI/UX 증진

- **구매 로직**: tempCartDTO와 condition (buyNow, null)을 통해 구매 유형 나누기

- **각종 API**: 카카오 결제, 카카오 지도, 카카오 주소, 카카오 로그인, GMAIL API, SOLAPI 사용



&nbsp;

## 🚀 버전
- Java dynamicWebProject 4.0
- ojdbc6.jar
- ORACLE12
- TOMCAT 9.0
	   
	     1.8 (또는 사용하신 버전)
	
	
	
|내용|버전|
|----|------|
|Java|Dynamic Web Project 4.0|
|JDK|11|
|Server|Apache Tomcat 9.0|
|DB|Oracle 12c|
|Driver|ojdbc6.jar|



## 🧨 트러블 슈팅 (Optional)

- **문제1**: api키같은 중요한 데이터 저장을 이클립스에 하였었음

- **해결1**: git push하기 전 주요 설정 데이터를 저장하는 파일을 프로젝트와 별개로 처리하였음

- **문제2**: 장바구니를 통한 구매와 상품페이지에서의 바로 구매 로직의 분기를 만들지 않아 작업도중 수정이 필요했음

- **해결2**: 이미 장바구니 구매 로직이 만들어진 시점이라 session의 tempCartDTO 를 통해 바로구매 분기를 나누어주었음



## 📜 License

[반응형 웹 템플릿](https://themewagon.com/themes/electro-bootstrap/)


