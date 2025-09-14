-- ===========================================================
-- ranking.sql
-- 基于 GPA 的学生排名查询（使用窗口函数）
-- ===========================================================

/*
逻辑说明：
1. 在 gpa_calculation.sql 的结果基础上扩展窗口函数
2. 提供三种排名方式：
   - 全校排名
   - 按专业排名
   - 按学期排名（需要 enrollment → term）
*/

WITH student_gpa AS (
    SELECT
        s.student_id,
        s.name AS student_name,
        s.major,
        t.year,
        t.semester,
        ROUND(
            SUM(g.gpa_value * c.credits)::NUMERIC
            / NULLIF(SUM(c.credits), 0),
            2
        ) AS gpa
    FROM student s
    JOIN enrollment e ON s.student_id = e.student_id
    JOIN grade g ON e.enrollment_id = g.enrollment_id
    JOIN course_offering co ON e.offering_id = co.offering_id
    JOIN course c ON co.course_id = c.course_id
    JOIN term t ON co.term_id = t.term_id
    WHERE g.gpa_value IS NOT NULL
    GROUP BY s.student_id, s.name, s.major, t.year, t.semester
)

SELECT 
    student_id,
    student_name,
    major,
    year,
    semester,
    gpa,
    RANK() OVER (ORDER BY gpa DESC) AS overall_rank,             -- 全校排名
    RANK() OVER (PARTITION BY major ORDER BY gpa DESC) AS major_rank, -- 按专业排名
    RANK() OVER (PARTITION BY year, semester ORDER BY gpa DESC) AS term_rank -- 按学期排名
FROM student_gpa
ORDER BY overall_rank;
