# Software Requirements Specification (SRS)
## Academic Management System (AMS)

**Version:** 1.0  
**Date:** 2025-09-13  
**Owner:** Garry Li (Peishuo Li)

---

## 1. Introduction
### 1.1 Purpose
The Academic Management System (AMS) manages academic data and workflows for students, teachers, and administrators. It focuses on robust database design and operations on PostgreSQL (AWS RDS) and provides foundations for AI-driven features.

### 1.2 Scope
Core capabilities include student/teacher/course management, enrollment, grading, attendance, reporting/analytics, security, backup/recovery, monitoring, and AI-ready extensions.

### 1.3 Definitions & Abbreviations
- **AMS**: Academic Management System  
- **RDS**: Amazon Relational Database Service  
- **RLS**: Row-Level Security  
- **PITR**: Point-in-Time Recovery

### 1.4 References
- Project Plan: `PROJECT_PLAN.md`  
- Data Dictionary: `docs/data-dictionary.md` (to be produced)  
- ERD/DFD/UML: `docs/erd.png`, `docs/dfd.png`, `docs/uml.png` (to be produced)

---

## 2. Stakeholders & Roles
### 2.1 Stakeholders
- **Admin**: Operates the system, manages users/courses, ensures security/backup/monitoring.  
- **Teacher**: Manages assigned courses, records grades, tracks attendance, views reports.  
- **Student**: Enrolls in courses, views grades/transcripts, receives recommendations.

### 2.2 Personas (brief)
- **Student (Undergraduate)**: Needs clear schedule, progress tracking, and course suggestions.  
- **Teacher (Lecturer)**: Needs simple grading and attendance workflows.  
- **Admin (DB/Ops)**: Needs reliable operations, security, and auditability.

---

## 3. Functional Requirements
> Requirements are labeled **FR-xxx** with key acceptance criteria **AC-xxx**.

### 3.1 Student Management
- **FR-001**: Create/read/update/delete student profiles (name, email, dob, major, enrollment_year).  
  - **AC-001**: CRUD succeeds with validation and unique identifiers.

### 3.2 Teacher Management
- **FR-010**: CRUD teacher records (name, email, department, title).  
  - **AC-010**: Teacher must be linkable to courses.

### 3.3 Course Management
- **FR-020**: CRUD course records (code, title, description, credits, schedule/time slots).  
  - **AC-020**: Course can be assigned to one or more teachers.

### 3.4 Enrollment Management
- **FR-030**: Students enroll/drop courses; system prevents time conflicts.  
  - **AC-030**: Conflict detection query rejects overlapping time slots.

### 3.5 Grade Management
- **FR-040**: Teachers record/update grades per student per course; students can view.  
  - **AC-040**: GPA calculation reflects latest grades.

### 3.6 Attendance Management
- **FR-050**: Teachers record attendance by course session; students can view history.  
  - **AC-050**: Attendance is queryable per student/course/date range.

### 3.7 Reporting & Analytics
- **FR-060**: GPA reports and cohort ranking using window functions.  
  - **AC-060**: Queries return within performance SLAs (see NFR).

### 3.8 Security & Access Control
- **FR-070**: Role-based access (Admin/Teacher/Student) with least privilege.  
  - **AC-070**: Students can only see their own grades; teachers only for assigned courses (RLS).

### 3.9 Operations & Monitoring
- **FR-080**: Automated backups and PITR; CloudWatch monitoring and alerts.  
  - **AC-080**: Recovery procedure verified; alerts configured for CPU/IOPS/connections.

### 3.10 AI Extensions (Foundational)
- **FR-090**: Persist student career goals; tag courses; map careers to courses with relevance.  
  - **AC-090**: Data model supports rule-based recommendations initially.

---

## 4. Non-Functional Requirements
> Labeled **NFR-xxx**.

- **NFR-001 Availability**: RDS multi-AZ, automated backups; service target 99.9%.  
- **NFR-002 Performance**: Typical read queries ≤ 1s for datasets up to tens of thousands of rows.  
- **NFR-003 Scalability**: Schema supports horizontal growth in enrollments and attendance logs.  
- **NFR-004 Security**: RBAC + RLS; encrypted at rest (RDS) and in transit (TLS).  
- **NFR-005 Recoverability**: PITR verified; documented runbook.  
- **NFR-006 Observability**: CloudWatch metrics/alarms; slow query logs reviewed.

---

## 5. Data Model Overview (High-Level)
> Detailed schema in Data Dictionary; ERD will visualize these entities and relationships.

Core entities:
- **Student**, **Teacher**, **Course**, **Enrollment**, **Grade**, **Attendance**

AI-ready entities:
- **CareerGoal** (student_id, career_name, priority_level)  
- **CourseTag** (course_id, tag_name)  
- **CareerCourseMap** (career_name, course_id, relevance_score)

Key relationships:
- Student ⟷ Enrollment ⟷ Course  
- Teacher ⟷ Course  
- Course ⟷ Grade (per student)  
- Course ⟷ Attendance (per session)  
- Student ⟷ CareerGoal; Course ⟷ CourseTag; Career ⟷ Course (mapping)

---

## 6. Constraints & Assumptions
- DBMS: PostgreSQL 15 on AWS RDS.  
- Demo API: Java (Spring Boot) for limited endpoints.  
- No complex UI; focus on database artifacts and evidence (SQL, plans, scripts).

---

## 7. Acceptance Criteria (Phase 1 DoD)
- This SRS stored at `docs/srs.md`, reviewed and versioned.  
- ERD/DFD/UML and Data Dictionary drafted under `docs/`.  
- Requirements traceable: FR/NFR IDs referenced in Data Dictionary and SQL implementation notes.

---

## 8. Out of Scope (Phase 1)
- Full-featured UI, comprehensive auth federation (Cognito/SSO), or advanced ML models (placeholder only).

---

## 9. Glossary
- **Career Path**: A target profession (e.g., Data Engineer) guided by recommended courses.  
- **Conflict Detection**: Prevent overlapping course times in enrollment.

---

## 10. Change Log
- **v1.0 (2025-09-13)**: Initial SRS draft created.