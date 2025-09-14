-- ===========================================================
-- gpa_calculation.sql
-- 计算每个学生的加权 GPA
-- ===========================================================

/*
逻辑说明：
1. 关联 student → enrollment → grade → course_offering → course
2. GPA = ∑(gpa_value * 学分) / ∑(学分)
3. 过滤掉 NULL 的成绩记录
*/

WITH student_gpa AS (
    SELECT
        s.student_id,
        s.name AS student_name,
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
    WHERE g.gpa_value IS NOT NULL
    GROUP BY s.student_id, s.name
)
SELECT * FROM student_gpa
ORDER BY gpa DESC;
