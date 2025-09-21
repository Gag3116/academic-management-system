-- ===========================================================
-- indexes.sql
-- 索引优化: B-Tree & GIN
-- ===========================================================

-- 0. 删除已有索引 (保证能演示 before/after)
DROP INDEX IF EXISTS idx_student_email;
DROP INDEX IF EXISTS idx_teacher_email;
DROP INDEX IF EXISTS idx_course_code;
DROP INDEX IF EXISTS idx_student_name_trgm;
DROP INDEX IF EXISTS idx_teacher_name_trgm;
DROP INDEX IF EXISTS idx_course_title_trgm;

-- 1. 测试查询 (before optimization: 没有索引)
EXPLAIN ANALYZE SELECT * FROM student WHERE email = 'test5000@example.com';
EXPLAIN ANALYZE SELECT * FROM student WHERE name ILIKE '%Student 999%';
EXPLAIN ANALYZE SELECT * FROM course  WHERE title ILIKE '%Database%';

-- 2. 创建索引
-- B-Tree 索引
CREATE INDEX idx_student_email ON student(email);
CREATE INDEX idx_teacher_email ON teacher(email);
CREATE INDEX idx_course_code   ON course(code);

-- 确保安装 pg_trgm 扩展
CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- GIN 索引
CREATE INDEX idx_student_name_trgm ON student USING gin (name gin_trgm_ops);
CREATE INDEX idx_teacher_name_trgm ON teacher USING gin (name gin_trgm_ops);
CREATE INDEX idx_course_title_trgm ON course  USING gin (title gin_trgm_ops);

-- 3. 测试查询 (after optimization: 有索引)
EXPLAIN ANALYZE SELECT * FROM student WHERE email = 'test5000@example.com';
EXPLAIN ANALYZE SELECT * FROM student WHERE name ILIKE '%Student 999%';
EXPLAIN ANALYZE SELECT * FROM course  WHERE title ILIKE '%Database%';
