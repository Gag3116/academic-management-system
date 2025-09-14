-- ===========================================================
-- time_conflict.sql
-- 检测课程时间冲突（学生 & 教师）
-- ===========================================================

/*
逻辑：
1. 学生时间冲突
   - 一个学生同一学期，选了同一天且时间重叠的课程
2. 教师时间冲突
   - 一个教师同一学期，被安排在同一天且时间重叠的课程
*/

-- 学生时间冲突
SELECT
    s.student_id,
    s.name AS student_name,
    c1.code AS course_code_1,
    c2.code AS course_code_2,
    t.year,
    t.semester,
    co1.day_of_week,
    co1.start_time || ' - ' || co1.end_time AS course1_time,
    co2.start_time || ' - ' || co2.end_time AS course2_time
FROM student s
JOIN enrollment e1 ON s.student_id = e1.student_id
JOIN enrollment e2 ON s.student_id = e2.student_id AND e1.enrollment_id < e2.enrollment_id
JOIN course_offering co1 ON e1.offering_id = co1.offering_id
JOIN course_offering co2 ON e2.offering_id = co2.offering_id
JOIN course c1 ON co1.course_id = c1.course_id
JOIN course c2 ON co2.course_id = c2.course_id
JOIN term t ON co1.term_id = t.term_id AND co2.term_id = t.term_id
WHERE co1.day_of_week = co2.day_of_week
  AND co1.start_time < co2.end_time
  AND co2.start_time < co1.end_time
ORDER BY s.student_id, t.year, t.semester;

-- 教师时间冲突
SELECT
    te.teacher_id,
    te.name AS teacher_name,
    c1.code AS course_code_1,
    c2.code AS course_code_2,
    t.year,
    t.semester,
    co1.day_of_week,
    co1.start_time || ' - ' || co1.end_time AS course1_time,
    co2.start_time || ' - ' || co2.end_time AS course2_time
FROM teacher te
JOIN offering_instructor oi1 ON te.teacher_id = oi1.teacher_id
JOIN offering_instructor oi2 ON te.teacher_id = oi2.teacher_id AND oi1.offering_instructor_id < oi2.offering_instructor_id
JOIN course_offering co1 ON oi1.offering_id = co1.offering_id
JOIN course_offering co2 ON oi2.offering_id = co2.offering_id
JOIN course c1 ON co1.course_id = c1.course_id
JOIN course c2 ON co2.course_id = c2.course_id
JOIN term t ON co1.term_id = t.term_id AND co2.term_id = t.term_id
WHERE co1.day_of_week = co2.day_of_week
  AND co1.start_time < co2.end_time
  AND co2.start_time < co1.end_time
ORDER BY te.teacher_id, t.year, t.semester;
