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
---

## Table: Enrollment
| Field Name   | Data Type     | Constraints                                | Description                    |
|--------------|--------------|--------------------------------------------|--------------------------------|
| enrollment_id| SERIAL       | PRIMARY KEY                                | Unique ID for enrollment       |
| student_id   | INT          | FOREIGN KEY → Student(student_id) NOT NULL | Student who enrolled           |
| course_id    | INT          | FOREIGN KEY → Course(course_id) NOT NULL   | Enrolled course                |
| enrollment_date | DATE      | DEFAULT CURRENT_DATE                       | Date of enrollment             |

---

## Table: Grade
| Field Name   | Data Type     | Constraints                                | Description                    |
|--------------|--------------|--------------------------------------------|--------------------------------|
| grade_id     | SERIAL       | PRIMARY KEY                                | Unique ID for grade record     |
| student_id   | INT          | FOREIGN KEY → Student(student_id) NOT NULL | Student                        |
| course_id    | INT          | FOREIGN KEY → Course(course_id) NOT NULL   | Course                         |
| grade        | VARCHAR(5)   | CHECK (grade IN ('A','B','C','D','F'))     | Letter grade                   |
| gpa_value    | NUMERIC(3,2) | CHECK (gpa_value >= 0.0 AND gpa_value <=4.0)| GPA equivalent                 |
| recorded_at  | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP                  | Time when grade was recorded   |

---

## Table: Attendance
| Field Name   | Data Type     | Constraints                                | Description                    |
|--------------|--------------|--------------------------------------------|--------------------------------|
| attendance_id| SERIAL       | PRIMARY KEY                                | Unique ID for attendance record|
| student_id   | INT          | FOREIGN KEY → Student(student_id) NOT NULL | Student                        |
| course_id    | INT          | FOREIGN KEY → Course(course_id) NOT NULL   | Course                         |
| attendance_date | DATE      | NOT NULL                                   | Date of the class              |
| status       | VARCHAR(10)  | CHECK (status IN ('Present','Absent','Late')) | Attendance status              |