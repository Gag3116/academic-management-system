-- ===========================================================
-- seed.sql
-- Academic Management System 演示数据 (含冲突场景)
-- ===========================================================

-- 清空数据（确保可重复执行）
TRUNCATE attendance, grade, enrollment, offering_instructor, course_offering,
         course, term, teacher, student
RESTART IDENTITY CASCADE;

-- 学生
INSERT INTO student (name, email, dob, major, enrollment_year) VALUES
('Alice Zhang', 'alice@example.com', '2002-05-10', 'Computer Science', 2020),
('Bob Li', 'bob@example.com', '2001-08-15', 'Information Systems', 2019),
('Charlie Wang', 'charlie@example.com', '2003-01-22', 'Mathematics', 2021),
('Diana Wu', 'diana@example.com', '2000-11-30', 'Computer Science', 2018);

-- 教师
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

-- 课程开设（含时间）
INSERT INTO course_offering (section, capacity, term_id, course_id, day_of_week, start_time, end_time) VALUES
-- Term 1: 2023 Fall
('A', 2, 1, 1, 'Monday',  '09:00', '11:00'),  -- CS101 (容量 2，容易超额)
('A', 3, 1, 2, 'Monday',  '10:00', '12:00'),  -- CS201 (和 CS101 时间冲突)
('B', 50, 1, 3, 'Tuesday', '09:00', '11:00'), -- MATH101 (正常)

-- Term 2: 2024 Spring
('A', 40, 2, 1, 'Wednesday', '14:00', '16:00'), -- CS101
('A', 40, 2, 2, 'Thursday',  '09:00', '11:00'); -- CS201

-- 授课教师
INSERT INTO offering_instructor (offering_id, teacher_id) VALUES
(1, 1), -- Dr. Chen: CS101 (Fall)
(2, 1), -- Dr. Chen: CS201 (Fall) → 教师时间冲突
(3, 2), -- Dr. Liu: MATH101 (Fall)
(4, 1), -- Dr. Chen: CS101 (Spring)
(5, 2); -- Dr. Liu: CS201 (Spring)

-- 选课
INSERT INTO enrollment (student_id, offering_id, enrollment_date) VALUES
-- Alice: 故意制造重复选课 + 时间冲突
(1, 1, '2023-09-01'), -- CS101 Fall
(1, 2, '2023-09-01'), -- CS201 Fall (时间冲突)
(1, 1, '2023-09-02'), -- 再次选 CS101 Fall (重复选课)

-- Bob: 容量冲突
(2, 1, '2023-09-02'), -- CS101 Fall (容量=2 已经满了)

-- Charlie: 正常选课
(3, 3, '2023-09-03'), -- MATH101 Fall

-- Diana: Spring 学期课程
(4, 4, '2024-02-15'), -- CS101 Spring
(4, 5, '2024-02-15'); -- CS201 Spring

-- 成绩（使用 9 分制）
INSERT INTO grade (enrollment_id, grade) VALUES
(1, 'A'),
(2, 'B+'),
(3, 'A-'),
(4, 'B'),
(5, 'C'),
(6, 'A'),
(7, 'B');
