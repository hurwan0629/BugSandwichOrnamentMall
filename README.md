# BugSandwich - Ornably

![ORNABLY](https://i.pinimg.com/736x/84/a1/56/84a156ca7db6566b341cdff0e7900f1c.jpg)
    

> 자바 동적 웹 프로젝트 파일과 TOMCAT 9.0버전을 통한 로컬 웹 서비스 구축
> 

# 중요! /src/main/resources/config.properties 를 추가해주어야합니다

```
# config.properties

# SOLAPI KEY AND
SOLAPI_API_KEY=YOUR_KEY
SOLAPI_API_SECRET=YOUR_SECRET
SOLAPI_FROM_NUMBER=YOUR_NUMBER

# EMAIL_API KEY
GMAIL_API_FORM_EMAIL=YOUR_EMAIL
GMAIL_API_PASSWORD=YOUR_PASSWORD

# KAKAO_LOGIN_API
KAKAO_LOGIN_API_KEY=YOUR_KEY

# KAKO_PAY_API
KAKAO_PAY_API_CID=YOUR_KEY
SECRET_KEY_DEV=YOUR_SECRET
```

## 📖 목차

1. [프로젝트 소개]
2. [기술 스택]
3. [주요 기능]
4. [버전]
5. [트러블 슈팅]

---

## 📝 프로젝트 소개

- **개발 기간**: 2025.11.19 ~ 2026.01.08
- **개발 인원**: 4명 (프론트 페이지 4명에서 나눠서 분담, Controller 2명, Model 2명)
- **프로젝트 개요**: 여러 디자인 패턴과 API, 기술을 공부 및 작업 역량 증진을 위한 프로젝트

## 🛠 기술 스택

### Frontend

- Html, Css, Js, jQuery, Jstl, 비동기와 여러 Cdn

### Backend

- Java, Servlet, Jsp, Jdbc, Oracle

### Tools

- Eclipse, DBeaver, Git, GitHub, Notion, Excel, Google Drive, [dbdiagram.io](http://dbdiagram.io/), [draw.io](http://draw.io/), Figma

## ✨ 주요 기능

- **로그인/회원가입**: 회원가입 로직 - 비동기를 통한 프론트에서의 여러 유효성 검사
- **상품목록**: 페이지네이션과 별점 플러그인을 통한 UI/UX 증진
- **구매 로직**: tempCartDTO와 condition (buyNow, null)을 통해 구매 유형 나누기
- **각종 API**: 카카오 결제, 카카오 지도, 카카오 주소, 카카오 로그인, Gmail API, SOLAPI 사용

## 🚀 버전

| 내용 | 버전 |
| --- | --- |
| Java | Dynamic Web Project 4.0 |
| JDK | 8, 11 |
| Server | Apache Tomcat 9.0 |
| DB | Oracle 11g, 18c XE |
| Driver | ojdbc6.jar |

## 🧨 확인 사항

### **1. 민감 정보(API Key) 노출 위험 관리**

- **문제1**: API 키와 같은 중요 데이터가 소스 코드 내에 하드코딩되어 Git에 노출될 위험 발생
- **해결1**: `config.properties` 파일을 생성하여 설정을 분리하고, `.gitignore`에 등록하여 보안을 강화함

### 2. 구매 방식에 따른 로직 중복 및 데이터 전달 문제

- **문제2**: '장바구니 구매'와 '상세페이지 즉시 구매'의 데이터 형식이 달라 중복 로직이 발생할 가능성 확인
- **해결2**: 세션(Session) 기반의 `tempCartDTO`를 도입. 어떤 경로로 진입하든 동일한 DTO 객체에 담아 주문 서블릿으로 넘겨줌으로써 코드 재사용성을 높이고 유지보수를 용이하게 함
