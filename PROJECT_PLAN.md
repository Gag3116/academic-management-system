# Academic Management System (AMS) - Project Plan

## 📖 Overview

This project demonstrates database administration and development skills using **PostgreSQL on AWS RDS**.  
It covers design, implementation, optimization, security, operations, and AI-driven extensions.  
Progress is tracked here in Markdown.

---

## 🗂️ Project Phases & Tasks

### Phase 1: Requirements & Design

- [ ] Write Software Requirements Specification (SRS)
- [ ] Define user roles (Admin / Teacher / Student)
- [ ] Create ER Diagram (core entities + AI extension entities)
- [ ] Create Data Flow Diagram (student enrollment, grading, recommendation)
- [ ] Create UML Class Diagram (entities & relationships)
- [ ] Write Data Dictionary (Student, Teacher, Course, Enrollment, Grade, Attendance, CareerGoal, CourseTag, CareerCourseMap)

### Phase 2: Database Implementation

- [ ] Deploy PostgreSQL on AWS RDS
- [ ] Configure parameter group & security group
- [ ] Create `Student` table
- [ ] Create `Teacher` table
- [ ] Create `Course` table
- [ ] Create `Enrollment` table
- [ ] Create `Grade` table
- [ ] Create `Attendance` table
- [ ] Create `CareerGoal` table
- [ ] Create `CourseTag` table
- [ ] Create `CareerCourseMap` table
- [ ] Insert sample demo data
- [ ] Implement CRUD SQL scripts for all tables

### Phase 3: Advanced SQL & Optimization

- [ ] Write GPA calculation query
- [ ] Write ranking query (window functions)
- [ ] Write course conflict detection query
- [ ] Implement stored procedure: GPA auto-update
- [ ] Implement trigger: cascade delete on course removal
- [ ] Create indexes (B-Tree on PK/FK, GIN for text search)
- [ ] Run `EXPLAIN ANALYZE` before/after optimization

### Phase 4: Security & Administration

- [ ] Create `Admin` role
- [ ] Create `Teacher` role
- [ ] Create `Student` role
- [ ] Apply Row-Level Security (RLS) on `Grade`
- [ ] Configure automated RDS backups
- [ ] Demonstrate Point-in-Time Recovery (PITR)
- [ ] Enable CloudWatch monitoring
- [ ] Configure alerts (CPU, IOPS, connections)

### Phase 5: Documentation & Demo

- [ ] Update ER Diagram, DFD, UML, Data Dictionary
- [ ] Write Final Report (design, SQL, optimization, security, ops)
- [ ] Build lightweight Java API demo
  - [ ] Implement endpoint: `/student/grades`
  - [ ] Implement endpoint: `/teacher/courses`

### Phase 6: AI Extensions (Optional but Highlight Feature)

- [ ] Extend database to support AI features
  - [ ] Create `CareerGoal` table
  - [ ] Create `CourseTag` table
  - [ ] Create `CareerCourseMap` table
- [ ] Implement rule-based course recommendation
- [ ] Implement career path recommendation (query from `CareerCourseMap`)
- [ ] (Optional) Integrate ML model for performance prediction
- [ ] Build demo API endpoints
  - [ ] `/student/recommend-courses`
  - [ ] `/student/career-path`

---

## ✅ Progress Tracking

- **Current Phase**: Phase 1 – Requirements & Design  
- **Next Focus**: ER Diagram & relational schema (with AI extension tables)  
- **Completion Target**: ~6 weeks for core DB system, AI extensions in Phase 6  

---

## 📌 Notes

- SQL scripts stored in `/db/sql`  
- Diagrams stored in `/docs`  
- Reports stored in `/reports`  
- AI extension scripts in `/db/ai`  