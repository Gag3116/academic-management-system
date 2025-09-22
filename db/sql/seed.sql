-- ===========================================================
-- seed.sql
-- Academic Management System 演示数据 (含 Phase 4 RLS Demo)
-- ===========================================================

-- 清空数据（确保可重复执行）
TRUNCATE attendance, grade, enrollment, offering_instructor, course_offering,
         course, term, teacher, student
RESTART IDENTITY CASCADE;

-- 学生（基础）
INSERT INTO student (name, email, dob, major, enrollment_year) VALUES
('Alice Zhang', 'alice@example.com', '2002-05-10', 'Computer Science', 2020),
('Bob Li', 'bob@example.com', '2001-08-15', 'Information Systems', 2019),
('Charlie Wang', 'charlie@example.com', '2003-01-22', 'Mathematics', 2021),
('Diana Wu', 'diana@example.com', '2000-11-30', 'Computer Science', 2018);

-- 教师（基础）
INSERT INTO teacher (name, email, department, title) VALUES
('Dr. Chen', 'chen@example.com', 'CS', 'Professor'),
('Dr. Liu', 'liu@example.com', 'Math', 'Associate Professor');

-- 学期
INSERT INTO term (year, semester) VALUES
(2023, 'Fall'),
(2024, 'Spring');

-- 课程
INSERT INTO course (code, title, credits) VALUES
('CS101', 'Intro to Computer Science', 3),
('CS201', 'Database Systems', 4),
('MATH101', 'Calculus I', 3);

-- 课程开设
INSERT INTO course_offering (section, capacity, term_id, course_id, day_of_week, start_time, end_time) VALUES
('A', 2, 1, 1, 'Monday',  '09:00', '11:00'),
('A', 3, 1, 2, 'Monday',  '10:00', '12:00'),
('B', 50, 1, 3, 'Tuesday', '09:00', '11:00'),
('A', 40, 2, 1, 'Wednesday', '14:00', '16:00'),
('A', 40, 2, 2, 'Thursday',  '09:00', '11:00');

-- 授课教师
INSERT INTO offering_instructor (offering_id, teacher_id) VALUES
(1, 1), (2, 1), (3, 2), (4, 1), (5, 2);

-- 选课
INSERT INTO enrollment (student_id, offering_id, enrollment_date) VALUES
(1, 1, '2023-09-01'),
(1, 2, '2023-09-01'),
(1, 1, '2023-09-02'),
(2, 1, '2023-09-02'),
(3, 3, '2023-09-03'),
(4, 4, '2024-02-15'),
(4, 5, '2024-02-15');

-- 成绩
INSERT INTO grade (enrollment_id, grade) VALUES
(1, 'A'),
(2, 'B+'),
(3, 'A-'),
(4, 'B'),
(5, 'C'),
(6, 'A'),
(7, 'B');

-- ===========================================================
-- Phase 4 Demo Data (RLS 演示用)
-- ===========================================================

-- 学生（Demo）
INSERT INTO student (name, email, dob, major, enrollment_year, gpa)
VALUES 
('Alice Demo', 'alice_demo@example.com', '2002-05-01', 'Computer Science', 2021, 0.0),
('Bob Demo',   'bob_demo@example.com',   '2001-09-10', 'Mathematics',     2020, 0.0);

-- 教师（Demo）
INSERT INTO teacher (name, email, department, title)
VALUES
('Dr. Smith Demo', 'smith_demo@example.com', 'Computer Science', 'Professor'),
('Dr. Lee Demo',   'lee_demo@example.com',   'Mathematics',      'Associate Professor');

-- 学期（Demo）
INSERT INTO term (year, semester) VALUES (2025, 'Fall');

-- 课程（Demo）
INSERT INTO course (code, title, credits)
VALUES 
('CS101_DEMO',   'Intro to Computer Science (Demo)', 3),
('MATH201_DEMO', 'Advanced Mathematics (Demo)',      4);

-- 课程开设（Demo）
INSERT INTO course_offering (section, capacity, term_id, course_id, day_of_week, start_time, end_time)
VALUES
('A', 30, (SELECT term_id FROM term WHERE year=2025 AND semester='Fall'), 
        (SELECT course_id FROM course WHERE code='CS101_DEMO'), 'Monday',  '09:00', '10:30'),
('B', 30, (SELECT term_id FROM term WHERE year=2025 AND semester='Fall'), 
        (SELECT course_id FROM course WHERE code='MATH201_DEMO'), 'Tuesday', '11:00', '12:30');

-- 指定授课教师（Demo）
INSERT INTO offering_instructor (offering_id, teacher_id)
VALUES
((SELECT offering_id FROM course_offering co JOIN course c ON co.course_id=c.course_id WHERE c.code='CS101_DEMO'), 
 (SELECT teacher_id FROM teacher WHERE email='smith_demo@example.com')),
((SELECT offering_id FROM course_offering co JOIN course c ON co.course_id=c.course_id WHERE c.code='MATH201_DEMO'), 
 (SELECT teacher_id FROM teacher WHERE email='lee_demo@example.com'));

-- 学生选课（Demo）
INSERT INTO enrollment (student_id, offering_id, enrollment_date)
VALUES
((SELECT student_id FROM student WHERE email='alice_demo@example.com'),
 (SELECT offering_id FROM course_offering co JOIN course c ON co.course_id=c.course_id WHERE c.code='CS101_DEMO'),
 CURRENT_DATE),
((SELECT student_id FROM student WHERE email='bob_demo@example.com'),
 (SELECT offering_id FROM course_offering co JOIN course c ON co.course_id=c.course_id WHERE c.code='MATH201_DEMO'),
 CURRENT_DATE);

-- 成绩（Demo）
INSERT INTO grade (enrollment_id, grade, gpa_value)
VALUES
((SELECT e.enrollment_id FROM enrollment e JOIN student s ON e.student_id=s.student_id 
  JOIN course_offering co ON e.offering_id=co.offering_id 
  JOIN course c ON co.course_id=c.course_id 
  WHERE s.email='alice_demo@example.com' AND c.code='CS101_DEMO'), 'A', 4.0),
((SELECT e.enrollment_id FROM enrollment e JOIN student s ON e.student_id=s.student_id 
  JOIN course_offering co ON e.offering_id=co.offering_id 
  JOIN course c ON co.course_id=c.course_id 
  WHERE s.email='bob_demo@example.com' AND c.code='MATH201_DEMO'), 'B', 3.0);
