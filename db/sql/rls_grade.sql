-- ===========================================================
-- rls_grade.sql
-- Phase 4: 行级安全策略（学生 / 教师 / 管理员）
-- ===========================================================

BEGIN;

ALTER TABLE grade ENABLE ROW LEVEL SECURITY;

-- 学生策略：只能看到自己的成绩
DROP POLICY IF EXISTS student_view_own_grades ON grade;
CREATE POLICY student_view_own_grades
ON grade
FOR SELECT
TO student_role
USING (
  EXISTS (
    SELECT 1
    FROM enrollment e
    WHERE e.enrollment_id = grade.enrollment_id
      AND e.student_id = current_setting('app.user_id', true)::int
  )
);

-- 教师策略：只能看到自己授课课程的学生成绩
DROP POLICY IF EXISTS teacher_view_class_grades ON grade;
CREATE POLICY teacher_view_class_grades
ON grade
FOR SELECT
TO teacher_role
USING (
  EXISTS (
    SELECT 1
    FROM enrollment e
    JOIN course_offering co ON e.offering_id = co.offering_id
    JOIN offering_instructor oi ON oi.offering_id = co.offering_id
    WHERE e.enrollment_id = grade.enrollment_id
      AND oi.teacher_id = current_setting('app.user_id', true)::int
  )
);

-- 管理员策略：可以看到所有成绩
DROP POLICY IF EXISTS admin_view_all ON grade;
CREATE POLICY admin_view_all
ON grade
FOR SELECT
TO admin_role
USING (true);

COMMIT;
