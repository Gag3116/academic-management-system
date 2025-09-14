-- ===========================================================
-- procedures.sql
-- 存储过程：自动更新 GPA
-- ===========================================================

-- 创建或替换存储过程
CREATE OR REPLACE PROCEDURE update_gpa(p_student_id INT DEFAULT NULL)
LANGUAGE plpgsql
AS $$
BEGIN
    IF p_student_id IS NULL THEN
        -- 更新所有学生的 GPA
        UPDATE student s
        SET gpa = sub.gpa
        FROM (
            SELECT
                s.student_id,
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
            GROUP BY s.student_id
        ) sub
        WHERE s.student_id = sub.student_id;

    ELSE
        -- 更新单个学生的 GPA
        UPDATE student s
        SET gpa = sub.gpa
        FROM (
            SELECT
                s.student_id,
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
              AND s.student_id = p_student_id
            GROUP BY s.student_id
        ) sub
        WHERE s.student_id = sub.student_id;
    END IF;
END;
$$;
