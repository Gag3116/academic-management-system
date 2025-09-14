-- ===========================================================
-- trigger_gpa_update.sql
-- 触发器：当成绩插入/更新时，自动调用 GPA 更新过程
-- ===========================================================

-- 确保存储过程存在
-- CALL update_gpa(student_id);

CREATE OR REPLACE FUNCTION trg_update_gpa_after_grade()
RETURNS TRIGGER AS $$
DECLARE
    v_student_id INT;
BEGIN
    -- 找到这条成绩对应的学生
    SELECT e.student_id INTO v_student_id
    FROM enrollment e
    WHERE e.enrollment_id = NEW.enrollment_id;

    -- 调用存储过程更新该学生的 GPA
    CALL update_gpa(v_student_id);

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 删除旧触发器（如果存在）
DROP TRIGGER IF EXISTS trg_update_gpa ON grade;

-- 创建触发器：在 grade 插入或更新后触发
CREATE TRIGGER trg_update_gpa
AFTER INSERT OR UPDATE ON grade
FOR EACH ROW
EXECUTE FUNCTION trg_update_gpa_after_grade();
