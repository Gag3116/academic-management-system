-- ===========================================================
-- conflict_detection.sql
-- 检测选课与容量冲突
-- ===========================================================

/*
1. 学生重复选课检测
   逻辑：
   - 学生 → enrollment → course_offering → course
   - 如果同一学生在同一学期选了同一门课程超过一次 → 冲突
*/

-- 学生重复选课
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


 /*
2. 课程容量超限检测
   逻辑：
   - course_offering.capacity 与实际选课人数对比
*/

-- 容量超限检测
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
