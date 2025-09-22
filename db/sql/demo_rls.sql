-- ===========================================================
-- demo_rls.sql
-- 演示不同角色访问 grade 表的结果
-- ===========================================================

-- 学生 Alice Demo
SET ROLE student_role;
DO $$
DECLARE sid int;
BEGIN
  SELECT student_id INTO sid FROM student WHERE email='alice_demo@example.com';
  PERFORM set_config('app.user_id', sid::text, false);
END $$;
SELECT current_role, current_setting('app.user_id') AS user_id, '→ 学生 Alice Demo 看到的成绩' AS context;
TABLE grade;

-- 教师 Dr. Smith Demo
SET ROLE teacher_role;
DO $$
DECLARE tid int;
BEGIN
  SELECT teacher_id INTO tid FROM teacher WHERE email='smith_demo@example.com';
  PERFORM set_config('app.user_id', tid::text, false);
END $$;
SELECT current_role, current_setting('app.user_id') AS user_id, '→ 教师 Dr. Smith Demo 看到的成绩' AS context;
TABLE grade;

-- 管理员
SET ROLE admin_role;
SELECT current_role, 'ALL' AS user_id, '→ 管理员看到的成绩' AS context;
TABLE grade;

RESET ROLE;
