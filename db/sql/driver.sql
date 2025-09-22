-- ===========================================================
-- driver.sql
-- 一键重置 & 初始化数据库（含 Phase 4）
-- ===========================================================

-- 1. 删除所有旧表
\i db/sql/reset_only.sql

-- 2. 建表
\i db/sql/schema.sql

-- 3. 成绩映射表 + gpa_value 触发器
\i db/sql/grade_scale.sql

-- 4. GPA 自动更新存储过程
\i db/sql/procedures.sql

-- 5. 成绩改动 → GPA 自动更新触发器
\i db/sql/trigger_gpa_update.sql

-- 6. 初始化演示数据
\i db/sql/seed.sql

-- 7. 创建索引 (B-Tree + GIN)
\i db/sql/indexes.sql

-- ===========================================================
-- Phase 4: Security & Administration
-- ===========================================================

-- 8. 创建角色 (Admin / Teacher / Student)
\i db/sql/roles.sql

-- 9. 在 grade 表上应用 RLS 策略
\i db/sql/rls_grade.sql
