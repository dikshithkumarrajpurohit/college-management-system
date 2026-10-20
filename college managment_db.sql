CREATE DATABASE IF NOT EXISTS campus_management_db;

USE campus_management_db;

CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    city VARCHAR(50)
);

INSERT INTO students
(student_name, email, phone, city)
VALUES
('Aditya Rao', 'aditya.rao@example.com', '9867101001', 'Visakhapatnam'),
('Nisha Reddy', 'nisha.reddy@example.com', '9867101002', 'Hyderabad'),
('Varun Das', 'varun.das@example.com', '9867101003', 'Vijayawada'),
('Pavani Shah', 'pavani.shah@example.com', '9867101004', 'Visakhapatnam'),
('Abhishek Jain', 'abhishek.jain@example.com', '9867101005', 'Guntur'),
('Mounika Rao', 'mounika.rao@example.com', '9867101006', 'Kakinada'),
('Teja Kumar', 'teja.kumar@example.com', '9867101007', 'Hyderabad'),
('Ishani Patel', 'ishani.patel@example.com', '9867101008', 'Rajahmundry'),
('Chaitanya Roy', 'chaitanya.roy@example.com', '9867101009', 'Visakhapatnam'),
('Neeraj Verma', 'neeraj.verma@example.com', '9867101010', 'Tirupati');

SELECT * FROM students;

UPDATE students
SET city = 'Bengaluru'
WHERE student_id = 1;

SELECT *
FROM students
WHERE city = 'Hyderabad';

SELECT *
FROM students
WHERE student_name LIKE 'S%';

SELECT COUNT(*) AS total_students
FROM students;

SELECT DISTINCT city
FROM students;

DELETE FROM students
WHERE student_id = 10;

USE campus_management_db;

CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL UNIQUE,
    duration_months INT NOT NULL,
    course_fee DECIMAL(10,2) NOT NULL,
    CONSTRAINT chk_course_fee
        CHECK (course_fee >= 0)
);

INSERT INTO courses
(course_name, duration_months, course_fee)
VALUES
('Excel and Power BI', 3, 14500),
('SQL Database Management', 2, 10000),
('Digital Marketing', 4, 22000),
('Python for Analytics', 5, 28000),
('Business Intelligence', 3, 19000);

SELECT * FROM courses;

SELECT *
FROM courses
WHERE course_fee > 15000;

SELECT *
FROM courses
ORDER BY course_fee DESC;

SELECT *
FROM courses
WHERE course_fee BETWEEN 12000 AND 25000;

SELECT course_name, course_fee
FROM courses
WHERE course_fee = (
    SELECT MAX(course_fee)
    FROM courses
);

SELECT AVG(course_fee) AS average_course_fee
FROM courses;

SELECT COUNT(*) AS total_courses
FROM courses;

UPDATE courses
SET course_fee = 15500
WHERE course_id = 1;

DELETE FROM courses
WHERE course_id = 5;

USE campus_management_db;

CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE,
    status VARCHAR(20) DEFAULT 'Active',
    fee_paid DECIMAL(10,2) DEFAULT 0,

    CONSTRAINT fk_enrollment_student
        FOREIGN KEY (student_id)
        REFERENCES students(student_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_enrollment_course
        FOREIGN KEY (course_id)
        REFERENCES courses(course_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT chk_fee_paid
        CHECK (fee_paid >= 0),

    CONSTRAINT chk_enrollment_status
        CHECK (status IN ('Active', 'Completed', 'Dropped'))
);

INSERT INTO enrollments
(student_id, course_id, enrollment_date, status, fee_paid)
VALUES
(1, 1, '2026-07-01', 'Active', 5000),
(1, 2, '2026-07-03', 'Active', 4000),
(2, 3, '2026-07-05', 'Active', 10000),
(2, 4, '2026-07-07', 'Active', 12000),
(3, 2, '2026-07-09', 'Completed', 8000),
(3, 3, '2026-07-11', 'Active', 6000),
(4, 1, '2026-07-13', 'Completed', 10000),
(4, 4, '2026-07-15', 'Active', 9000),
(5, 3, '2026-07-17', 'Active', 11000),
(5, 2, '2026-07-19', 'Active', 7000),
(6, 1, '2026-07-21', 'Active', 3000),
(7, 3, '2026-07-23', 'Completed', 15000),
(8, 4, '2026-07-25', 'Dropped', 5000),
(9, 1, '2026-07-27', 'Active', 6500),
(6, 4, '2026-07-29', 'Active', 8000);

SELECT * FROM enrollments;

SELECT * FROM enrollments
WHERE status = 'Active';

SELECT * FROM enrollments
WHERE status = 'Completed';

SELECT SUM(fee_paid) AS total_fees_collected
FROM enrollments;

SELECT COUNT(*) AS total_enrollments
FROM enrollments;

SELECT status, COUNT(*) AS total
FROM enrollments
GROUP BY status;

SELECT
    s.student_name,
    c.course_name,
    e.enrollment_date,
    e.status,
    e.fee_paid
FROM students s
INNER JOIN enrollments e
    ON s.student_id = e.student_id
INNER JOIN courses c
    ON e.course_id = c.course_id;
    
    SELECT
    s.student_name,
    c.course_name
FROM students s
INNER JOIN enrollments e
    ON s.student_id = e.student_id
INNER JOIN courses c
    ON e.course_id = c.course_id
WHERE c.course_name = 'Excel and Power BI';

SELECT
    c.course_name,
    COUNT(e.enrollment_id) AS total_enrollments
FROM courses c
LEFT JOIN enrollments e
    ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;

SELECT s.student_id, s.student_name
FROM students s
LEFT JOIN enrollments e
    ON s.student_id = e.student_id
WHERE e.enrollment_id IS NULL;

SELECT
    s.student_name,
    c.course_name,
    c.course_fee,
    e.fee_paid,
    (c.course_fee - e.fee_paid) AS remaining_fee
FROM students s
INNER JOIN enrollments e
    ON s.student_id = e.student_id
INNER JOIN courses c
    ON e.course_id = c.course_id;

SELECT COUNT(*) AS total_students
FROM students;

SELECT COUNT(*) AS total_courses
FROM courses;

SELECT AVG(course_fee) AS average_course_fee
FROM courses;

SELECT MAX(course_fee) AS highest_course_fee
FROM courses;

SELECT MIN(course_fee) AS lowest_course_fee
FROM courses;

SELECT SUM(fee_paid) AS total_fees_collected
FROM enrollments;

SELECT city, COUNT(*) AS total_students
FROM students
GROUP BY city;

SELECT status, COUNT(*) AS total_enrollments
FROM enrollments
GROUP BY status;

SELECT
    c.course_name,
    COUNT(e.enrollment_id) AS total_enrollments
FROM courses c
JOIN enrollments e
    ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
HAVING COUNT(e.enrollment_id) > 2;

SELECT DISTINCT city
FROM students;

SELECT course_name, course_fee
FROM courses
WHERE course_fee = (
    SELECT MAX(course_fee)
    FROM courses
);

SELECT course_name, course_fee
FROM courses
WHERE course_fee > (
    SELECT AVG(course_fee)
    FROM courses
);

SELECT student_name
FROM students
WHERE student_id IN (
    SELECT student_id
    FROM enrollments
    WHERE course_id = (
        SELECT course_id
        FROM courses
        WHERE course_name = 'Excel and Power BI'
    )
);

SELECT student_id, student_name
FROM students
WHERE student_id NOT IN (
    SELECT student_id
    FROM enrollments
);

DESCRIBE students;

DESCRIBE courses;

DESCRIBE enrollments;

SHOW CREATE TABLE enrollments;

CREATE OR REPLACE VIEW student_enrollment_view AS
SELECT
    s.student_id,
    s.student_name,
    c.course_name,
    e.enrollment_date,
    e.status,
    e.fee_paid
FROM students s
JOIN enrollments e
    ON s.student_id = e.student_id
JOIN courses c
    ON e.course_id = c.course_id;

SELECT * FROM student_enrollment_view;

CREATE INDEX idx_student_name
ON students(student_name);

CREATE INDEX idx_enrollment_status
ON enrollments(status);

SHOW INDEX FROM students;


SHOW INDEX FROM enrollments;

START TRANSACTION;

UPDATE enrollments
SET fee_paid = fee_paid + 100
WHERE enrollment_id = 1;

SELECT * FROM enrollments
WHERE enrollment_id = 1;

ROLLBACK;

SELECT * FROM enrollments
WHERE enrollment_id = 1;

START TRANSACTION;

SELECT * FROM students;

COMMIT;

SELECT * FROM students;

SELECT * FROM courses;

SELECT * FROM enrollments;

SELECT 'Students' AS table_name, COUNT(*) AS total
FROM students

UNION ALL

SELECT 'Courses', COUNT(*)
FROM courses

UNION ALL

SELECT 'Enrollments', COUNT(*)
FROM enrollments;

SELECT
    s.student_name,
    c.course_name,
    c.course_fee,
    e.fee_paid,
    e.status
FROM students s
JOIN enrollments e
    ON s.student_id = e.student_id
JOIN courses c
    ON e.course_id = c.course_id
ORDER BY s.student_name;
