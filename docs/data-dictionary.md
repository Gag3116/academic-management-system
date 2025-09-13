# Data Dictionary - Academic Management System (AMS)

## Table: Student
| Field Name     | Data Type     | Constraints                        | Description                       |
|----------------|--------------|------------------------------------|-----------------------------------|
| student_id     | SERIAL       | PRIMARY KEY                        | Unique ID for each student        |
| name           | VARCHAR(100) | NOT NULL                           | Full name of the student          |
| email          | VARCHAR(100) | UNIQUE, NOT NULL                   | Contact email                     |
| dob            | DATE         |                                    | Date of birth                     |
| major          | VARCHAR(100) |                                    | Student’s major field of study    |
| enrollment_year| INT          | CHECK (enrollment_year >= 2000)    | Year the student enrolled         |

---

## Table: Teacher
| Field Name   | Data Type     | Constraints                        | Description                    |
|--------------|--------------|------------------------------------|--------------------------------|
| teacher_id   | SERIAL       | PRIMARY KEY                        | Unique ID for each teacher     |
| name         | VARCHAR(100) | NOT NULL                           | Full name of the teacher       |
| email        | VARCHAR(100) | UNIQUE, NOT NULL                   | Contact email                  |
| department   | VARCHAR(100) |                                    | Department of the teacher      |
| title        | VARCHAR(50)  |                                    | Job title (e.g. Lecturer)      |

---

## Table: Course
| Field Name   | Data Type     | Constraints                        | Description                    |
|--------------|--------------|------------------------------------|--------------------------------|
| course_id    | SERIAL       | PRIMARY KEY                        | Unique ID for each course      |
| code         | VARCHAR(20)  | UNIQUE, NOT NULL                   | Official course code           |
| title        | VARCHAR(200) | NOT NULL                           | Course title                   |
| description  | TEXT         |                                    | Detailed description           |
| credits      | INT          | CHECK (credits > 0)                | Credit value                   |
| schedule     | VARCHAR(100) |                                    | Time slot info (e.g. Mon 9-11) |
| teacher_id   | INT          | FOREIGN KEY → Teacher(teacher_id)  | Assigned teacher               |