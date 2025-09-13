# Software Requirements Specification (SRS)
## Academic Management System (AMS)

**Version:** 1.1  
**Date:** 2025-09-14  
**Owner:** Garry Li (Peishuo Li)

---

## 1. Introduction
### 1.1 Purpose
The Academic Management System (AMS) manages students, teachers, courses, and course offerings within academic institutions.  
It supports enrollment, grading, and attendance tracking across multiple terms, and provides foundations for AI-driven features.

### 1.2 Scope
Core functions include:
- Student, teacher, course management
- Term and course offering management
- Enrollment, grade, and attendance tracking
- Reports and analytics (GPA, ranking, conflict detection)
- Security, backup, monitoring
- AI-ready extensions (career path and course recommendations)

---

## 2. Stakeholders & Roles
- **Admin**: Manage system entities, configure settings, perform operations (backup, monitoring).  
- **Teacher**: Teach assigned course offerings, record grades, track attendance.  
- **Student**: Enroll in course offerings, view grades, view attendance, get recommendations.  

---

## 3. Functional Requirements
### 3.1 Term Management
- Create, view, update terms (year + semester).  
- Ensure uniqueness of (year, semester).  

### 3.2 Course Offering Management
- Create course offerings tied to a term and a course.  
- Assign one or more instructors via OfferingInstructor.  
- Define schedule, section, and capacity.  

### 3.3 Enrollment
- Students enroll in specific course offerings.  
- System prevents duplicate enrollments and detects time conflicts.  

### 3.4 Grades
- Teachers record one grade per student per course offering.  
- Support GPA calculation and cohort ranking.  

### 3.5 Attendance
- Teachers record attendance per date per course offering.  
- Students can view attendance history.  

### 3.6 Reports & Analytics
- Generate GPA transcripts.  
- Ranking queries using window functions.  
- Attendance summary reports.  

### 3.7 Security & Administration
- Role-based access control (Admin/Teacher/Student).  
- Row-Level Security (RLS) to restrict access.  
- Backup & PITR enabled via AWS RDS.  

### 3.8 AI Extensions
- Persist student career goals.  
- Tag courses with relevant skills.  
- Map careers to courses → recommend offerings.

---

## 4. Non-Functional Requirements
- **Availability**: 99.9% uptime (AWS RDS multi-AZ).  
- **Performance**: Queries return ≤ 1s for datasets up to tens of thousands of rows.  
- **Scalability**: Supports multiple terms, thousands of students, and offerings.  
- **Security**: RBAC + RLS; data encrypted at rest and in transit.  
- **Recoverability**: PITR + automated backups.  
- **Observability**: CloudWatch metrics/alerts, slow query logs.  

---

## 5. Data Model Overview
Core entities:
- **Student, Teacher, Course, Term, CourseOffering, OfferingInstructor**  
Business entities:
- **Enrollment, Grade, Attendance**  
AI-ready entities:
- **CareerGoal, CourseTag, CareerCourseMap**  

Key relationships:
- Term ⟷ CourseOffering  
- Course ⟷ CourseOffering  
- Teacher ⟷ OfferingInstructor ⟷ CourseOffering  
- Student ⟷ Enrollment/Grade/Attendance ⟷ CourseOffering  

---

## 6. Constraints & Assumptions
- DBMS: PostgreSQL 15 on AWS RDS.  
- Demo API: Java (Spring Boot).  
- No full UI required; focus is on DB + API demonstration.  

---

## 7. Acceptance Criteria
- SRS, Data Dictionary, ERD, DFD, UML produced and stored in `docs/`.  
- Schema supports multiple terms, multiple teachers per course offering.  
- Requirements traceable to implemented SQL.  

---

## 8. Change Log
- **v1.0 (2025-09-13)**: Initial draft.  
- **v1.1 (2025-09-14)**: Added Term, CourseOffering, OfferingInstructor to support multiple terms and multi-instructor scenarios.  