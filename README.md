# Academic Management System (AMS)

## 📖 Overview

The **Academic Management System (AMS)** is a personal portfolio project designed to demonstrate **database administration and development skills**.  
It is built with **PostgreSQL on AWS RDS**, focusing on design, implementation, optimization, security, and operations.  
Additionally, the project includes **AI-driven extensions** such as course recommendation and career path analysis.

---

## 🎯 Objectives

- Database design: ERD, UML, DFD, Data Dictionary  
- Implementation: PostgreSQL schema on AWS RDS  
- Advanced SQL: joins, window functions, stored procedures, triggers  
- Optimization: indexes and `EXPLAIN ANALYZE`  
- Security: roles, permissions, Row-Level Security (RLS)  
- Operations: backup, PITR, CloudWatch monitoring  
- AI extensions: course recommendation, career path analysis, performance prediction  

---

## 🗂️ Project Structure

```text
academic-management-system/
│
├── db/               SQL scripts (DDL, DML, procedures, triggers, indexes)
│   ├── migrations/   Table definitions
│   ├── sql/          Queries and test scripts
│   └── ai/           AI extension SQL
│
├── docs/             Diagrams and design documents
│   ├── erd.png       ER diagram
│   ├── dfd.png       Data flow diagram
│   ├── uml.png       UML class diagram
│   └── data-dictionary.md
│
├── reports/          Performance analysis and optimization results
│
├── api/              Demo Java (Spring Boot) API
│
└── PROJECT_PLAN.md   Project plan with phases and tasks
```

---

## Project Phases

1. **Requirements & Design** – SRS, ERD, UML, DFD, Data Dictionary  
2. **Database Implementation** – Deploy RDS, create schema, CRUD SQL  
3. **Advanced SQL & Optimization** – GPA queries, ranking, conflict detection, stored procedures, triggers, indexing  
4. **Security & Administration** – Roles, permissions, RLS, backups, PITR, CloudWatch monitoring  
5. **Documentation & Demo** – Updated diagrams, reports, demo API endpoints  
6. **AI Extensions** – CareerGoal, CourseTag, CareerCourseMap tables, recommendations, prediction  

---

## Tech Stack

- Database: PostgreSQL 15 (AWS RDS)  
- Language: SQL, Java (Spring Boot demo API)  
- Cloud: AWS RDS, CloudWatch  
- Tools: pgAdmin, Git/GitHub, diagramming tools  

---

## Progress Tracking

Project plan and progress are tracked in:  
[PROJECT_PLAN.md](./PROJECT_PLAN.md)

---

## Author

**Garry Li (Peishuo Li)**  
Master of Information Technology (First Class Honours), University of Auckland  
Seeking roles in **Database Administration / Backend Development / Cloud Engineering**  

