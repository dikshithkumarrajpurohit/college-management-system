# College Management System Using MySQL

## Project Description
The College Management System is a database project developed using MySQL. It stores and manages student information, course details, and student enrollments.

## Objectives
- Store student details.
- Maintain course information and course fees.
- Manage student enrollments.
- Track enrollment status and fees paid.
- Retrieve information using SQL queries.

## Database Name
`campus_management_db`

## Tables Used

### 1. Students
Stores student information.

- `student_id` – Primary key
- `student_name` – Student name
- `email` – Student email
- `phone` – Contact number
- `city` – Student city

### 2. Courses
Stores information about available courses.

- `course_id` – Primary key
- `course_name` – Course name
- `duration_months` – Course duration
- `course_fee` – Course fee

### 3. Enrollments
Connects students with their selected courses.

- `enrollment_id` – Primary key
- `student_id` – Foreign key
- `course_id` – Foreign key
- `enrollment_date` – Enrollment date
- `status` – Enrollment status
- `fee_paid` – Fee paid by the student

## SQL Concepts Used
- Database and table creation
- Primary keys and foreign keys
- Constraints: `NOT NULL`, `UNIQUE`, `CHECK`, and `DEFAULT`
- CRUD operations
- JOIN queries
- Aggregate functions: `COUNT()`, `SUM()`, `AVG()`, `MAX()`, and `MIN()`
- Subqueries
- `GROUP BY` and `HAVING`
- Views and indexes
- Transactions using `COMMIT` and `ROLLBACK`

## How to Run
1. Open MySQL Workbench.
2. Open the `college_management.sql` file.
3. Execute the SQL statements in the correct order.
4. Run the SELECT queries to view the results.

## Tools Used
- MySQL
- MySQL Workbench
- GitHub

## Conclusion
This project demonstrates how MySQL can be used to create and manage a relational database for student information, courses, and enrollments. It also demonstrates relationships between tables and commonly used SQL operations.

