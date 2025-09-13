-- ===============================================
-- Academic Management System · crud.sql
-- 各表 CRUD 示例
-- ===============================================

-- ========== Student ==========
-- Create
INSERT INTO student (name, email, dob, major, enrollment_year)
VALUES ('Test Student', 'test@student.com', '2000-01-01', 'CS', 2024)
RETURNING *;

-- Read
SELECT * FROM student WHERE student_id = 1;

-- Update
UPDATE student SET major = 'Data Science'
WHERE student_id = 1
RETURNING *;

-- Delete
DELETE FROM student WHERE student_id = 1;


-- ========== Teacher ==========
INSERT INTO teacher (name, email, department, title)
VALUES ('Test Teacher', 'teacher@test.com', 'CS Dept', 'Lecturer')
RETURNING *;

SELECT * FROM teacher WHERE teacher_id = 1;

UPDATE teacher SET title = 'Senior Lecturer'
WHERE teacher_id = 1
RETURNING *;

DELETE FROM teacher WHERE teacher_id = 1;


-- ========== Term ==========
INSERT INTO term (year, semester) VALUES (2026, 'Spring') RETURNING *;
SELECT * FROM term WHERE term_id = 1;
UPDATE term SET semester = 'Fall' WHERE term_id = 1 RETURNING *;
DELETE FROM term WHERE term_id = 1;


-- ========== Course ==========
INSERT INTO course (code, title, credits) VALUES ('CS999', 'AI Fundamentals', 15) RETURNING *;
SELECT * FROM course WHERE code = 'CS999';
UPDATE course SET title = 'Advanced AI' WHERE code = 'CS999' RETURNING *;
DELETE FROM course WHERE code = 'CS999';


-- ========== Course Offering ==========
INSERT INTO course_offering (section, capacity, term_id, course_id)
VALUES ('C', 20, 1, 1) RETURNING *;

SELECT * FROM course_offering WHERE offering_id = 1;

UPDATE course_offering SET capacity = 60 WHERE offering_id = 1 RETURNING *;

DELETE FROM course_offering WHERE offering_id = 1;


-- ========== Offering Instructor ==========
INSERT INTO offering_instructor (offering_id, teacher_id) VALUES (1, 1) RETURNING *;
SELECT * FROM offering_instructor WHERE offering_instructor_id = 1;
UPDATE offering_instructor SET teacher_id = 2 WHERE offering_instructor_id = 1 RETURNING *;
DELETE FROM offering_instructor WHERE offering_instructor_id = 1;


-- ========== Enrollment ==========
INSERT INTO enrollment (student_id, offering_id, enrollment_date)
VALUES (1, 1, CURRENT_DATE) RETURNING *;

SELECT * FROM enrollment WHERE enrollment_id = 1;

UPDATE enrollment SET enrollment_date = '2025-02-20'
WHERE enrollment_id = 1 RETURNING *;

DELETE FROM enrollment WHERE enrollment_id = 1;


-- ========== Grade ==========
INSERT INTO grade (enrollment_id, grade, gpa_value) VALUES (1, 'A', 4.0) RETURNING *;
SELECT * FROM grade WHERE grade_id = 1;
UPDATE grade SET grade = 'B+' WHERE grade_id = 1 RETURNING *;
DELETE FROM grade WHERE grade_id = 1;


-- ========== Attendance ==========
INSERT INTO attendance (enrollment_id, date, status)
VALUES (1, '2025-03-01', 'Present') RETURNING *;

SELECT * FROM attendance WHERE attendance_id = 1;

UPDATE attendance SET status = 'Absent' WHERE attendance_id = 1 RETURNING *;

DELETE FROM attendance WHERE attendance_id = 1;
