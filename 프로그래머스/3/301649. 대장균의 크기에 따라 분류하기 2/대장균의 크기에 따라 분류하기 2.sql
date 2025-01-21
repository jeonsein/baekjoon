-- 대장균 개체의 크기를 내림차순으로 정렬했을 때,
-- 상위 0% ~ 25% 를 'CRITICAL', 
-- 26% ~ 50% 를 'HIGH', 
-- 51% ~ 75% 를 'MEDIUM', 76% ~ 100% 를 'LOW'
-- SELECT: 대장균 개체의 ID(ID) 와 분류된 이름(COLONY_NAME)
-- 결과는 개체의 ID 에 대해 오름차순 정렬. 
-- 단, 총 데이터의 수는 4의 배수이며
-- 같은 사이즈의 대장균 개체가 서로 다른 이름으로 분류되는 경우는 없습니다.

WITH RankedData AS (
    SELECT 
        ID, 
        SIZE_OF_COLONY,
        ROW_NUMBER() OVER (ORDER BY SIZE_OF_COLONY DESC) AS rank_num,
        (SELECT COUNT(*) FROM ECOLI_DATA) AS total_count
    FROM ECOLI_DATA
)
SELECT 
    ID,
    CASE 
        WHEN rank_num <= total_count * 0.25 THEN 'CRITICAL'
        WHEN rank_num <= total_count * 0.50 THEN 'HIGH'
        WHEN rank_num <= total_count * 0.75 THEN 'MEDIUM'
        ELSE 'LOW'
    END AS COLONY_NAME
FROM RankedData
ORDER BY ID;
