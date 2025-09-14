-- ===========================================================
-- enrollment_conflict.sql
-- 检测选课相关冲突（学生重复选课 & 课程容量超限）
-- ===========================================================

/*
1. 学生重复选课检测
   - 一个学生在同一学期里选了同一门课的多个开设
2. 课程容量超限检测
   - 实际选课人数 > 课程容量
*/

-- 学生重复选课检测
SELECT
    s.student_id,
    s.name AS student_name,
    c.code AS course_code,
    c.title AS course_title,
    t.year,
    t.semester,
    COUNT(*) AS times_enrolled
FROM student s
JOIN enrollment e ON s.student_id = e.student_id
JOIN course_offering co ON e.offering_id = co.offering_id
JOIN course c ON co.course_id = c.course_id
JOIN term t ON co.term_id = t.term_id
GROUP BY s.student_id, s.name, c.code, c.title, t.year, t.semester
HAVING COUNT(*) > 1
ORDER BY s.student_id, c.code, t.year, t.semester;


-- 课程容量超限检测
SELECT
    co.offering_id,
    c.code AS course_code,
    c.title AS course_title,
    t.year,
    t.semester,
    co.capacity,
    COUNT(e.enrollment_id) AS enrolled_students
FROM course_offering co
JOIN course c ON co.course_id = c.course_id
JOIN term t ON co.term_id = t.term_id
LEFT JOIN enrollment e ON co.offering_id = e.offering_id
GROUP BY co.offering_id, c.code, c.title, t.year, t.semester, co.capacity
HAVING COUNT(e.enrollment_id) > co.capacity
ORDER BY co.offering_id;
