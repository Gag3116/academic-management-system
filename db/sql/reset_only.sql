-- ===========================================================
-- reset_only.sql
-- 清空 Academic Management System 数据库（删除所有表）
-- ===========================================================

DROP TABLE IF EXISTS attendance CASCADE;
DROP TABLE IF EXISTS grade CASCADE;
DROP TABLE IF EXISTS enrollment CASCADE;
DROP TABLE IF EXISTS offering_instructor CASCADE;
DROP TABLE IF EXISTS course_offering CASCADE;
DROP TABLE IF EXISTS course CASCADE;
DROP TABLE IF EXISTS term CASCADE;
DROP TABLE IF EXISTS teacher CASCADE;
DROP TABLE IF EXISTS student CASCADE;
DROP TABLE IF EXISTS grade_scale CASCADE;
