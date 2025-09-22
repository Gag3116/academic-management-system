-- ===========================================================
-- Phase 4 / Step 1: Create base roles (admin/teacher/student)
-- ===========================================================

BEGIN;

-- 1. 创建 admin_role
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'admin_role') THEN
    CREATE ROLE admin_role NOLOGIN INHERIT;
    COMMENT ON ROLE admin_role IS 'Application admin group role (full access via BYPASSRLS)';
  END IF;
END $$;

-- 2. 创建 teacher_role
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'teacher_role') THEN
    CREATE ROLE teacher_role NOLOGIN INHERIT;
    COMMENT ON ROLE teacher_role IS 'Application teacher group role (teaching-related data)';
  END IF;
END $$;

-- 3. 创建 student_role
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'student_role') THEN
    CREATE ROLE student_role NOLOGIN INHERIT;
    COMMENT ON ROLE student_role IS 'Application student group role (self-related data)';
  END IF;
END $$;

-- 4. 授予三类角色连接数据库权限
DO $$
DECLARE
  dbname text := current_database();
BEGIN
  EXECUTE format('GRANT CONNECT ON DATABASE %I TO admin_role', dbname);
  EXECUTE format('GRANT CONNECT ON DATABASE %I TO teacher_role', dbname);
  EXECUTE format('GRANT CONNECT ON DATABASE %I TO student_role', dbname);
END $$;

-- 5. 授予三类角色使用 public schema 的权限
GRANT USAGE ON SCHEMA public TO admin_role, teacher_role, student_role;

-- 6. 授予三类角色对所有现有表的只读权限
GRANT SELECT ON ALL TABLES IN SCHEMA public TO admin_role, teacher_role, student_role;

-- 7. 设置默认权限：未来新建表也会自动给这三类角色只读权限
ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT ON TABLES TO admin_role, teacher_role, student_role;

COMMIT;
