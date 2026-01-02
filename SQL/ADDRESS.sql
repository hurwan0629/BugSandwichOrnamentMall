CREATE TABLE ADDRESS(
	ADDRESS_PK INT PRIMARY KEY,
	ACCOUNT_PK INT, --FK
	ADDRESS_NAME VARCHAR(50),
	ADDRESS_IS_DEFAULT NUMBER(1) DEFAULT 0,
	ADDRESS_POSTAL_CODE VARCHAR(20),
	ADDRESS_LINE1 VARCHAR(100),
	ADDRESS_LINE2 VARCHAR(200),
	
	CONSTRAINT FK_ACCOUNT_ADDRESS FOREIGN KEY (ACCOUNT_PK) REFERENCES ACCOUNT(ACCOUNT_PK)
);
-- 리뷰PK,회원PK(FK),배송지명,기본주소지 설정,우편번호,주소1(시군구),주소2(상세주소)
-- FK 연결하고 명시적 선언
--CONSTRAINT= FK연결에 쓸 이름
--실제연결=FOREIGN KEY (ACCOUNT_PK) REFERENCES ACCOUNT(ACCOUNT_PK)
--회원가입시 입력한 주소가 기본배송지 = 넘버(1)
--배송지 추가시 추가된 주소는 일반주소지 = 디폴트 

--어카운트 테이블 조인여부
--회원가입시 기본주소 필요함 --> 조인은 셀렉트에서 사용하는것이므로 조인 필요없음
--마이페이지에서 주소보여주기 --> 배송지보여주기가 목적이기때문에 조인이 필요없음

DROP TABLE ADDRESS;
--테이블 드랍

DROP TABLE ADDRESS CASCADE CONSTRAINTS;
-- 강제 테이블 드랍

CREATE SEQUENCE ADDRESS_SEQ
START WITH 1000
INCREMENT BY 1
NOCACHE
NOCYCLE;
-- 배송지 PK를 자동생성해주고 노사이클로 순환멈춤
-- 노사이클 -> 1~9999까지 숫자가 다 생성되면 멈춘다
-- 사이클이면 다시 1번으로 돌아감

DROP SEQUENCE ADDRESS_SEQ;
-- 시퀀스 삭제

--필요한거
--배송지 선택
--배송지 등록
--배송지 목록
--배송지 삭제

-- 배송지 등록
-- 필요한거 사용자 pk,주소PK,배송지이름,우편번호,기본주소지여부,기본주소,상세주소
INSERT INTO ADDRESS (
    ADDRESS_PK, ACCOUNT_PK, ADDRESS_NAME, ADDRESS_POSTAL_CODE,
    ADDRESS_IS_DEFAULT, ADDRESS_LINE1, ADDRESS_LINE2
) VALUES (
    ADDRESS_SEQ.NEXTVAL, '2', '집', '12345', '1', '서울시 강남구', '4층'
);

--배송지 선택

--기존 기본배송지 해제하기
UPDATE ADDRESS SET ADDRESS_IS_DEFAULT = 0
WHERE ACCOUNT_PK = '2';

--선택한 배송지를 기본으로 설정하기
UPDATE ADDRESS SET ADDRESS_IS_DEFAULT = 1
WHERE ADDRESS_PK = '2'
	AND ACCOUNT_PK = '2';


-- 배송지목록
SELECT ADDRESS_PK,
       ADDRESS_NAME,
       ADDRESS_IS_DEFAULT,
       ADDRESS_POSTAL_CODE,
       ADDRESS_LINE1,
       ADDRESS_LINE2
FROM ADDRESS
WHERE ACCOUNT_PK = '2';


--배송지 삭제
DELETE FROM ADDRESS
WHERE ADDRESS_PK = '4'
AND ACCOUNT_PK = '2';
--회원PK에 해당하는 배송지를 배송지pk 이용하여 삭제









