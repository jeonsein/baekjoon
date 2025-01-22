-- DATE_TRUNC('날짜', '남기는 부분')
-- 분화된 연도(YEAR), 분화된 연도별 대장균 크기의 편차(YEAR_DEV), 대장균 개체의 ID(ID)
-- 분화된 연도별 대장균 크기의 편차: 분화된 연도별 가장 큰 대장균의 크기 - 각 대장균의 크기
-- 결과는 연도에 대해 오름차순으로 정렬하고 같은 연도에 대해서는 대장균 크기의 편차에 대해 오름차순으로 정렬
WITH YEARLY_MAX_SIZE AS (
    SELECT 
        YEAR(DIFFERENTIATION_DATE) AS YEAR, -- 년도만 추출
        MAX(SIZE_OF_COLONY) AS MAX_SIZE -- 최대값
    FROM ECOLI_DATA
    GROUP BY YEAR(DIFFERENTIATION_DATE)
)
SELECT 
    YEAR(DIFFERENTIATION_DATE) AS YEAR,
    (YMS.MAX_SIZE - ED.SIZE_OF_COLONY) AS YEAR_DEV,
    ED.ID
FROM ECOLI_DATA ED JOIN YEARLY_MAX_SIZE YMS 
    ON YEAR(DIFFERENTIATION_DATE) = YMS.YEAR
ORDER BY YEAR, YEAR_DEV;