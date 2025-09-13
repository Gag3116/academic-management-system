-- ===============================================
-- Academic Management System · seed.sql
-- 演示数据插入
-- ===============================================

-- 1. 学生
INSERT INTO student (name, email, dob, major, enrollment_year) VALUES
('Alice Zhang', 'alice.zhang@example.com', '2002-03-15', 'Computer Science', 2021),
('Ben Li', 'ben.li@example.com', '2001-07-20', 'Information Systems', 2020),
('Cathy Wang', 'cathy.wang@example.com', '2003-01-10', 'Software Engineering', 2022);

-- 2. 教师
INSERT INTO teacher (name, email, department, title) VALUES
('Dr. David Chen', 'david.chen@example.com', 'Computer Science', 'Lecturer'),
('Prof. Emma Smith', 'emma.smith@example.com', 'Information Systems', 'Professor');

-- 3. 学期
INSERT INTO term (year, semester) VALUES
(2025, 'Spring'),
(2025, 'Fall');

-- 4. 课程
INSERT INTO course (code, title, credits) VALUES
('CS101', 'Introduction to Programming', 15),
('IS201', 'Database Systems', 15),
('SE301', 'Software Engineering Project', 30);

-- 5. 课程开设
INSERT INTO course_offering (section, capacity, term_id, course_id) VALUES
('A', 50, 1, 1),  -- Spring 2025, CS101
('B', 40, 1, 2),  -- Spring 2025, IS201
('A', 30, 2, 3);  -- Fall 2025, SE301

-- 6. 授课教师
INSERT INTO offering_instructor (offering_id, teacher_id) VALUES
(1, 1),  -- Dr. David teaches CS101A
(2, 2),  -- Prof. Emma teaches IS201B
(3, 2);  -- Prof. Emma teaches SE301A

-- 7. 选课
INSERT INTO enrollment (student_id, offering_id, enrollment_date) VALUES
(1, 1, '2025-02-10'),
(2, 1, '2025-02-11'),
(2, 2, '2025-02-11'),
(3, 3, '2025-08-01');

-- 8. 成绩
INSERT INTO grade (enrollment_id, grade, gpa_value, recorded_at) VALUES
(1, 'A', 4.0, '2025-06-20'),
(2, 'B+', 3.3, '2025-06-20'),
(3, 'A-', 3.7, '2025-06-21');

-- 9. 出勤
INSERT INTO attendance (enrollment_id, date, status) VALUES
(1, '2025-03-01', 'Present'),
(1, '2025-03-02', 'Absent'),
(2, '2025-03-01', 'Present'),
(3, '2025-03-01', 'Late');
