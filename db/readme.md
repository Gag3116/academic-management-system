# Academic Management System · Database

## 📌 Overview

This directory contains all database-related files for the **Academic Management System (AMS)**.  
The implementation is based on the **Data Dictionary** and **ERD** defined in the design phase.

Contents:

- **schema.sql** → Defines the 9 core tables
- **seed.sql** → Inserts demonstration data
- **crud.sql** → Provides CRUD operation examples
- **test.sql** → A minimal script for environment validation

---

## 🚀 Usage

### 1. Install PostgreSQL

Make sure **PostgreSQL 15** (or a compatible version) is installed locally.

### 2. Create User and Database

In `psql`, run:

```sql
CREATE ROLE dbadmin WITH LOGIN PASSWORD 'StrongPass2025';
CREATE DATABASE student_mgmt OWNER dbadmin;
GRANT ALL PRIVILEGES ON DATABASE student_mgmt TO dbadmin;
```

### 3. Initialize Schema and Data

```bash
psql -U dbadmin -d student_mgmt -h localhost -f db/sql/schema.sql
psql -U dbadmin -d student_mgmt -h localhost -f db/sql/seed.sql
```

### 4. Test CRUD Operations

```bash
psql -U dbadmin -d student_mgmt -h localhost -f db/sql/crud.sql
```

### 5. Verify

```bash
psql -U dbadmin -d student_mgmt -h localhost
\dt          -- list all tables
SELECT * FROM student;
```

---

## 📂 File Descriptions

- sql/schema.sql → Core schema (9 tables: Student, Teacher, Term, Course, CourseOffering, OfferingInstructor, Enrollment, Grade, Attendance)
- sql/seed.sql → Sample data for demonstration
- sql/crud.sql → Example CRUD operations for all tables
- sql/test.sql → Minimal script to validate environment setup

---
