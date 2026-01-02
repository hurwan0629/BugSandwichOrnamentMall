CREATE TABLE ITEM (  -- 상품 테이블
	ITEM_PK INT PRIMARY KEY, -- PK
	ITEM_NAME VARCHAR(100),    -- 상품명
	ITEM_PRICE INT,          -- 상품 가격
	ITEM_STOCK INT,          -- 상품 재고
	ITEM_DESCRIPTION VARCHAR(3000), -- 상품 설명
	ITEM_IMAGE_URL VARCHAR(255)    -- 상품 이미지 경로
);

INSERT INTO ITEM (ITEM_PK, ITEM_NAME, ITEM_PRICE, ITEM_STOCK, ITEM_DESCRIPTION, ITEM_IMAGE_URL) VALUES
(1, '골드 오너먼트', 15000, 10, '반짝이는 금색 장식 오너먼트', '/images/item1.jpg');

INSERT INTO ITEM (ITEM_PK, ITEM_NAME, ITEM_PRICE, ITEM_STOCK, ITEM_DESCRIPTION, ITEM_IMAGE_URL) VALUES
(2, '실버 오너먼트', 12000, 5, '은색 장식 오너먼트', '/images/item2.jpg');

INSERT INTO ITEM (ITEM_PK, ITEM_NAME, ITEM_PRICE, ITEM_STOCK, ITEM_DESCRIPTION, ITEM_IMAGE_URL) VALUES
(3, '레드 오너먼트', 10000, 0, '빨간색 장식 오너먼트 (품절)', '/images/item3.jpg');

INSERT INTO ITEM (ITEM_PK, ITEM_NAME, ITEM_PRICE, ITEM_STOCK, ITEM_DESCRIPTION, ITEM_IMAGE_URL) VALUES
(4, '블루 오너먼트', 11000, 0, '파란색 장식 오너먼트 (품절)', '/images/item4.jpg');

INSERT INTO ITEM (ITEM_PK, ITEM_NAME, ITEM_PRICE, ITEM_STOCK, ITEM_DESCRIPTION, ITEM_IMAGE_URL) VALUES
(5, '그린 오너먼트', 13000, 7, '녹색 장식 오너먼트', '/images/item5.jpg');


-- 테이블 드랍
DROP TABLE ITEM;

-- 테이블 강제 드랍
DROP TABLE ITEM CASCADE CONSTRAINTS;

-- 시퀀스
CREATE SEQUENCE ITEM_SEQ
START WITH 2000
INCREMENT BY 1
NOCACHE;

-- 상품 전체 출력 PK최신순 (페이지네이션으로 변경 예정)
SELECT 
    ITEM_PK,
    ITEM_NAME,
    ITEM_PRICE,
    ITEM_STOCK,
    ITEM_IMAGE_URL,
    AVG_STAR,
    TOTAL_COUNT
FROM (
    SELECT 
        I.ITEM_PK,
        I.ITEM_NAME,
        I.ITEM_PRICE,
        I.ITEM_STOCK,
        I.ITEM_IMAGE_URL,
        NVL(ROUND(AVG(R.REVIEW_STAR), 2), 0) AS AVG_STAR,
        COUNT(*) OVER() AS TOTAL_COUNT,  -- 전체 행 수
        ROW_NUMBER() OVER (
            ORDER BY (CASE WHEN ITEM_STOCK = 0 THEN 1 ELSE 0 END), I.ITEM_PK DESC
        ) AS RN
    FROM ITEM I
    LEFT JOIN REVIEW R
        ON I.ITEM_PK = R.ITEM_PK
    GROUP BY 
        I.ITEM_PK,
        I.ITEM_NAME,
        I.ITEM_PRICE,
        I.ITEM_STOCK,
        I.ITEM_IMAGE_URL
) 
WHERE RN BETWEEN ? AND ?;

-- 상품 검색어 출력 (같은 이름은 PK순) (페이지네이션으로 변경 예정)
SELECT *
FROM (
    SELECT 
        I.ITEM_PK,
        I.ITEM_NAME,
        I.ITEM_PRICE,
        I.ITEM_STOCK,
        I.ITEM_DESCRIPTION,
        I.ITEM_IMAGE_URL,
        NVL(ROUND(AVG(R.REVIEW_STAR), 2), 0) AS AVG_STAR,
        COUNT(*) OVER() AS TOTAL_COUNT,  -- 전체 행 수
        ROW_NUMBER() OVER (
            ORDER BY (CASE WHEN ITEM_STOCK = 0 THEN 1 ELSE 0 END), I.ITEM_PK DESC
        ) AS RN
    FROM ITEM I
    LEFT JOIN REVIEW R
        ON I.ITEM_PK = R.ITEM_PK
    WHERE I.ITEM_NAME LIKE '%고양이%'
    GROUP BY 
        I.ITEM_PK,
        I.ITEM_NAME,
        I.ITEM_PRICE,
        I.ITEM_STOCK,
        I.ITEM_DESCRIPTION,
        I.ITEM_IMAGE_URL
) 
WHERE RN BETWEEN ? AND ?;


-- 평점 높은순으로 출력 ) 평점이 같을 때는 리뷰 많은 순으로 출력
SELECT
    ITEM_PK,
    ITEM_NAME,
    ITEM_PRICE,
    REVIEW_COUNT,
    AVG_STAR,
    TOTAL_COUNT
FROM (
    SELECT 
        I.ITEM_PK,
        I.ITEM_NAME,
        I.ITEM_PRICE,
        COUNT(R.REVIEW_PK) AS REVIEW_COUNT, -- 리뷰 개수 
        NVL(ROUND(AVG(R.REVIEW_STAR), 2), 0) AS AVG_STAR, -- 별점 평균
        COUNT(*) OVER() AS TOTAL_COUNT,  -- 전체 행 수
        ROW_NUMBER() OVER (
            ORDER BY 
                (CASE WHEN I.ITEM_STOCK = 0 THEN 1 ELSE 0 END),
                NVL(ROUND(AVG(R.REVIEW_STAR), 2), 0) DESC,
                COUNT(R.REVIEW_PK) DESC,
                I.ITEM_PK DESC
        ) AS RN
    FROM ITEM I
    LEFT JOIN REVIEW R
        ON I.ITEM_PK = R.ITEM_PK
    GROUP BY 
        I.ITEM_PK,
        I.ITEM_NAME,
        I.ITEM_PRICE,
        I.ITEM_STOCK
)
WHERE RN BETWEEN ? AND ?;  


-- 상품 상세보기 pk 
SELECT 
    I.ITEM_PK,
    I.ITEM_NAME,
    I.ITEM_PRICE,
    I.ITEM_STOCK,
    I.ITEM_DESCRIPTION,
    I.ITEM_IMAGE_URL,
    NVL(ROUND(AVG(R.REVIEW_STAR)), 0) AS AVG_STAR -- 평점 평균
FROM ITEM I
LEFT JOIN REVIEW R
    ON I.ITEM_PK = R.ITEM_PK
WHERE I.ITEM_PK = ?
GROUP BY 
    I.ITEM_PK,
    I.ITEM_NAME,
    I.ITEM_PRICE,
    I.ITEM_STOCK,
    I.ITEM_DESCRIPTION,
    I.ITEM_IMAGE_URL;

--  상품 구매시 재고 감소 (재고 없으면 false)
UPDATE ITEM
SET ITEM_STOCK = ITEM_STOCK - ?
WHERE ITEM_PK = ?;

