# Data Dictionary - Academic Management System (AMS)
**Version:** 1.1  
**Date:** 2025-09-14  

This document defines the core entities, fields, data types, constraints, and descriptions for AMS.

---

## Table: Term
| Field       | Data Type     | Constraints               | Description              |
|-------------|--------------|---------------------------|--------------------------|
| term_id     | SERIAL       | PRIMARY KEY               | Unique ID for the term   |
| year        | INT          | NOT NULL                  | Academic year (e.g. 2025)|
| semester    | VARCHAR(10)  | NOT NULL                  | Semester (e.g. "S1","S2","Summer") |
| UNIQUE(year, semester) |   | Ensures term uniqueness   |

---

## Table: Course
| Field       | Data Type     | Constraints               | Description              |
|-------------|--------------|---------------------------|--------------------------|
| course_id   | SERIAL       | PRIMARY KEY               | Unique ID for each course|
| code        | VARCHAR(20)  | UNIQUE, NOT NULL          | Course code (e.g. "CS101") |
| title       | VARCHAR(200) | NOT NULL                  | Course title             |
| description | TEXT         |                           | Detailed description     |
| credits     | INT          | CHECK (credits > 0)       | Credit value             |

---

## Table: CourseOffering
| Field        | Data Type     | Constraints                     | Description                          |
|--------------|---------------|---------------------------------|--------------------------------------|
| offering_id  | SERIAL        | PRIMARY KEY                     | Unique ID for course offering        |
| course_id    | INT           | FK → Course(course_id) NOT NULL | Course being offered                 |
| term_id      | INT           | FK → Term(term_id) NOT NULL     | Term when the course is offered      |
| section      | VARCHAR(10)   |                                 | Section identifier (e.g. "A", "B")  |
| capacity     | INT           |                                 | Maximum number of students allowed   |

---

## Table: Teacher
| Field       | Data Type     | Constraints               | Description              |
|-------------|--------------|---------------------------|--------------------------|
| teacher_id  | SERIAL       | PRIMARY KEY               | Unique ID for each teacher|
| name        | VARCHAR(100) | NOT NULL                  | Teacher’s full name      |
| email       | VARCHAR(100) | UNIQUE, NOT NULL          | Contact email            |
| department  | VARCHAR(100) |                           | Teacher’s department     |
| title       | VARCHAR(50)  |                           | Title (e.g. Lecturer)    |

---

## Table: OfferingInstructor
| Field       | Data Type     | Constraints                     | Description              |
|-------------|---------------|---------------------------------|--------------------------|
| offering_id | INT           | FK → CourseOffering(offering_id) NOT NULL | Course offering |
| teacher_id  | INT           | FK → Teacher(teacher_id) NOT NULL | Teacher assigned        |
| UNIQUE(offering_id, teacher_id) | | Prevents duplicate assignments |

---

## Table: Student
| Field          | Data Type     | Constraints                        | Description                    |
|----------------|--------------|------------------------------------|--------------------------------|
| student_id     | SERIAL       | PRIMARY KEY                        | Unique ID for each student     |
| name           | VARCHAR(100) | NOT NULL                           | Full name of the student       |
| email          | VARCHAR(100) | UNIQUE, NOT NULL                   | Contact email                  |
| dob            | DATE         |                                    | Date of birth                  |
| major          | VARCHAR(100) |                                    | Student’s major                |
| enrollment_year| INT          | CHECK (enrollment_year >= 2000)    | Year the student enrolled      |

---

## Table: Enrollment
| Field          | Data Type     | Constraints                                | Description         |
|----------------|---------------|--------------------------------------------|---------------------|
| enrollment_id  | SERIAL        | PRIMARY KEY                                | Enrollment record   |
| student_id     | INT           | FK → Student(student_id) NOT NULL          | Enrolled student    |
| offering_id    | INT           | FK → CourseOffering(offering_id) NOT NULL  | Enrolled offering   |
| enrollment_date| DATE          | DEFAULT CURRENT_DATE                       | Date of enrollment  |
| UNIQUE(student_id, offering_id)|                                            | Prevents duplicate  |

---

## Table: Grade
| Field       | Data Type     | Constraints                                | Description         |
|-------------|---------------|--------------------------------------------|---------------------|
| grade_id    | SERIAL        | PRIMARY KEY                                | Grade record ID     |
| student_id  | INT           | FK → Student(student_id) NOT NULL          | Student             |
| offering_id | INT           | FK → CourseOffering(offering_id) NOT NULL  | Course offering     |
| grade       | VARCHAR(5)    | CHECK (grade IN ('A','B','C','D','F'))     | Letter grade        |
| gpa_value   | NUMERIC(3,2)  | CHECK (gpa_value >= 0 AND gpa_value <= 4)  | GPA equivalent      |
| recorded_at | TIMESTAMP     | DEFAULT CURRENT_TIMESTAMP                  | Time recorded       |
| UNIQUE(student_id, offering_id) |                                         | One grade per student per offering |

---

## Table: Attendance
| Field          | Data Type     | Constraints                                | Description         |
|----------------|---------------|--------------------------------------------|---------------------|
| attendance_id  | SERIAL        | PRIMARY KEY                                | Attendance record   |
| student_id     | INT           | FK → Student(student_id) NOT NULL          | Student             |
| offering_id    | INT           | FK → CourseOffering(offering_id) NOT NULL  | Course offering     |
| attendance_date| DATE          | NOT NULL                                   | Class date          |
| status         | VARCHAR(10)   | CHECK (status IN ('Present','Absent','Late')) | Attendance status |
| UNIQUE(student_id, offering_id, attendance_date) |                          | One record per date |

---