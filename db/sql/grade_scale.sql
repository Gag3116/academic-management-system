-- ===========================================================
-- grade_scale.sql
-- 新西兰 9 分制成绩映射表 + 自动 GPA 填充触发器
-- ===========================================================

-- 1. 创建成绩映射表
CREATE TABLE IF NOT EXISTS grade_scale (
  grade VARCHAR(5) PRIMARY KEY,
  gpa_value INT NOT NULL CHECK (gpa_value BETWEEN 0 AND 9)
);

-- 2. 插入映射数据 (NZ 9 分制)
INSERT INTO grade_scale (grade, gpa_value) VALUES
('A+', 9),
('A', 8),
('A-', 7),
('B+', 6),
('B', 5),
('B-', 4),
('C+', 3),
('C', 2),
('C-', 1),
('D', 0),
('E', 0),
('F', 0)
ON CONFLICT (grade) DO NOTHING;  -- 避免重复插入

-- 3. 创建触发器函数
CREATE OR REPLACE FUNCTION set_gpa_value()
RETURNS TRIGGER AS $$
BEGIN
  -- 从映射表查找对应的 gpa_value
  SELECT gs.gpa_value INTO NEW.gpa_value
  FROM grade_scale gs
  WHERE gs.grade = NEW.grade;

  -- 如果成绩不合法，抛出错误
  IF NEW.gpa_value IS NULL THEN
    RAISE EXCEPTION 'Invalid grade: %', NEW.grade;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 4. 给 grade 表加触发器
DROP TRIGGER IF EXISTS trg_set_gpa_value ON grade;

CREATE TRIGGER trg_set_gpa_value
BEFORE INSERT OR UPDATE ON grade
FOR EACH ROW
EXECUTE FUNCTION set_gpa_value();
