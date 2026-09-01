-- ============================================
-- 打字练习平台 - 新 Supabase 项目一键建表
-- 使用方法：Supabase → SQL Editor → 粘贴全部 → Run
-- ============================================

-- 1. 删除旧表（如果有）
DROP TABLE IF EXISTS student_stats CASCADE;
DROP TABLE IF EXISTS exercise_completions CASCADE;
DROP TABLE IF EXISTS exercises CASCADE;
DROP TABLE IF EXISTS class_members CASCADE;
DROP TABLE IF EXISTS classes CASCADE;
DROP TABLE IF EXISTS user_data CASCADE;
DROP TABLE IF EXISTS profiles CASCADE;

-- 2. 用户档案表
CREATE TABLE profiles (
  user_id TEXT PRIMARY KEY,
  username TEXT NOT NULL,
  password_hash TEXT NOT NULL,
  role TEXT DEFAULT 'student',
  student_no TEXT DEFAULT '',
  created_at BIGINT DEFAULT 0
);

-- 3. 用户游戏数据表
CREATE TABLE user_data (
  user_id TEXT PRIMARY KEY,
  pet JSONB DEFAULT '{}',
  scores JSONB DEFAULT '{}',
  records JSONB DEFAULT '[]',
  theme TEXT DEFAULT 'ocean',
  class_ids TEXT[] DEFAULT '{}',
  teacher_exercises JSONB DEFAULT '[]',
  student_no TEXT DEFAULT '',
  updated_at BIGINT DEFAULT 0
);

-- 4. 班级表
CREATE TABLE classes (
  id TEXT PRIMARY KEY,
  teacher_id TEXT NOT NULL,
  name TEXT NOT NULL,
  invite_code TEXT NOT NULL,
  student_ids TEXT[] DEFAULT '{}',
  exercises JSONB DEFAULT '[]',
  created_at BIGINT DEFAULT 0
);

-- 5. 班级成员表
CREATE TABLE class_members (
  class_id TEXT NOT NULL,
  student_id TEXT NOT NULL,
  PRIMARY KEY (class_id, student_id)
);

-- 6. 教师练习表
CREATE TABLE exercises (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  class_id UUID NOT NULL,
  teacher_id UUID NOT NULL,
  title TEXT NOT NULL,
  text TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 7. 练习完成记录表
CREATE TABLE exercise_completions (
  exercise_id UUID NOT NULL,
  student_id UUID NOT NULL,
  completed BOOLEAN DEFAULT false,
  completed_at TIMESTAMPTZ,
  PRIMARY KEY (exercise_id, student_id)
);

-- 8. 学生统计表
CREATE TABLE student_stats (
  user_id UUID PRIMARY KEY,
  username TEXT DEFAULT '',
  student_no TEXT DEFAULT '',
  last_title TEXT DEFAULT '',
  last_speed INTEGER DEFAULT 0,
  last_accuracy INTEGER DEFAULT 0,
  last_duration REAL DEFAULT 0,
  last_chars INTEGER DEFAULT 0,
  total_practices INTEGER DEFAULT 0,
  avg_speed INTEGER DEFAULT 0,
  max_speed INTEGER DEFAULT 0,
  avg_accuracy INTEGER DEFAULT 0,
  active_days INTEGER DEFAULT 0,
  total_xp INTEGER DEFAULT 0,
  stars INTEGER DEFAULT 0,
  pet_count INTEGER DEFAULT 0,
  max_level_pets INTEGER DEFAULT 0,
  highest_stage INTEGER DEFAULT 0,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 9. 关闭 RLS（允许匿名访问）
ALTER TABLE profiles DISABLE ROW LEVEL SECURITY;
ALTER TABLE user_data DISABLE ROW LEVEL SECURITY;
ALTER TABLE classes DISABLE ROW LEVEL SECURITY;
ALTER TABLE class_members DISABLE ROW LEVEL SECURITY;
ALTER TABLE exercises DISABLE ROW LEVEL SECURITY;
ALTER TABLE exercise_completions DISABLE ROW LEVEL SECURITY;
ALTER TABLE student_stats DISABLE ROW LEVEL SECURITY;
