-- ===============================================
-- Academic Management System · schema.sql
-- 基于 Data Dictionary & ERD 定义的 9 张表
-- ===============================================

-- 学生表
CREATE TABLE IF NOT EXISTS student (
  student_id      SERIAL PRIMARY KEY,
  name            VARCHAR(100) NOT NULL,
  email           VARCHAR(100) UNIQUE NOT NULL,
  dob             DATE,
  major           VARCHAR(100),
  enrollment_year INT CHECK (enrollment_year BETWEEN 1990 AND 2099)
);

-- 教师表
CREATE TABLE IF NOT EXISTS teacher (
  teacher_id  SERIAL PRIMARY KEY,
  name        VARCHAR(100) NOT NULL,
  email       VARCHAR(100) UNIQUE NOT NULL,
  department  VARCHAR(100),
  title       VARCHAR(50)
);

-- 学期表
CREATE TABLE IF NOT EXISTS term (
  term_id   SERIAL PRIMARY KEY,
  year      INT NOT NULL,
  semester  VARCHAR(20) NOT NULL  -- e.g. Spring, Fall
);

-- 课程表
CREATE TABLE IF NOT EXISTS course (
  course_id  SERIAL PRIMARY KEY,
  code       VARCHAR(20) UNIQUE NOT NULL,  -- e.g. CS101
  title      VARCHAR(100) NOT NULL,
  credits    INT NOT NULL
);

-- 课程开设表
CREATE TABLE IF NOT EXISTS course_offering (
  offering_id SERIAL PRIMARY KEY,
  section     VARCHAR(10),
  capacity    INT,
  term_id     INT NOT NULL REFERENCES term(term_id) ON DELETE CASCADE,
  course_id   INT NOT NULL REFERENCES course(course_id) ON DELETE CASCADE,
  day_of_week VARCHAR(10),   -- 上课星期几 (Monday–Sunday)
  start_time  TIME,          -- 上课开始时间
  end_time    TIME           -- 上课结束时间
);


-- 授课教师表（多对多关系）
CREATE TABLE IF NOT EXISTS offering_instructor (
  offering_instructor_id SERIAL PRIMARY KEY,
  offering_id INT NOT NULL REFERENCES course_offering(offering_id) ON DELETE CASCADE,
  teacher_id  INT NOT NULL REFERENCES teacher(teacher_id) ON DELETE CASCADE
);

-- 选课表
CREATE TABLE IF NOT EXISTS enrollment (
  enrollment_id   SERIAL PRIMARY KEY,
  student_id      INT NOT NULL REFERENCES student(student_id) ON DELETE CASCADE,
  offering_id     INT NOT NULL REFERENCES course_offering(offering_id) ON DELETE CASCADE,
  enrollment_date DATE DEFAULT CURRENT_DATE
);

-- 成绩表
CREATE TABLE IF NOT EXISTS grade (
  grade_id     SERIAL PRIMARY KEY,
  enrollment_id INT NOT NULL UNIQUE REFERENCES enrollment(enrollment_id) ON DELETE CASCADE,
  grade        VARCHAR(5),
  gpa_value    FLOAT,
  recorded_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 出勤表
CREATE TABLE IF NOT EXISTS attendance (
  attendance_id SERIAL PRIMARY KEY,
  enrollment_id INT NOT NULL REFERENCES enrollment(enrollment_id) ON DELETE CASCADE,
  date          DATE NOT NULL,
  status        VARCHAR(10) CHECK (status IN ('Present','Absent','Late','Excused'))
);
