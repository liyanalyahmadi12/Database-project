CREATE Database DBProject

USE DBProject


---first step is creating the five tables and exucting them one by one 
-- Create Trainee Table---------------------------------------------
CREATE TABLE Trainee (
    trainee_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    gender VARCHAR(10),
    email VARCHAR(100) UNIQUE NOT NULL,
    background VARCHAR(100)
);

-- Create Trainer Table---------------------------------------------------
CREATE TABLE Trainer (
    trainer_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    specialty VARCHAR(100),
    phone VARCHAR(15),
    email VARCHAR(100) UNIQUE NOT NULL
);

-- Create Course Table---------------------------------------------------
CREATE TABLE Course (
    course_id INT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    category VARCHAR(50),
    duration_hours INT,
    level VARCHAR(20)
);

-- Create Schedule Table---------------------------------------------------
CREATE TABLE Schedule (
    schedule_id INT PRIMARY KEY,
    course_id INT,
    trainer_id INT,
    start_date DATE,
    end_date DATE,
    time_slot VARCHAR(20),
    FOREIGN KEY (course_id) REFERENCES Course(course_id),
    FOREIGN KEY (trainer_id) REFERENCES Trainer(trainer_id)
);

-- Create Enrollment Table---------------------------------------------------
CREATE TABLE Enrollment (
    enrollment_id INT PRIMARY KEY,
    trainee_id INT,
    course_id INT,
    enrollment_date DATE,
    FOREIGN KEY (trainee_id) REFERENCES Trainee(trainee_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);


-- the seconed step is the DML - INSERT SAMPLE DATA we are going to insert the data one by one as providded 

-- Insert Trainee data---------------------------------------------------
INSERT INTO Trainee (trainee_id, name, gender, email, background) VALUES
(1, 'Aisha Al-Harthy', 'Female', 'aisha@example.com', 'Engineering'),
(2, 'Sultan Al-Farsi', 'Male', 'sultan@example.com', 'Business'),
(3, 'Mariam Al-Saadi', 'Female', 'mariam@example.com', 'Marketing'),
(4, 'Omar Al-Balushi', 'Male', 'omar@example.com', 'Computer Science'),
(5, 'Fatma Al-Hinai', 'Female', 'fatma@example.com', 'Data Science');
-- Verify TRAINEE data insertion
SELECT 'TRAINEE TABLE DATA:' AS info;     -----i wanted to make sure that the data i wrote is saved that why i verified it 
SELECT * FROM TRAINEE ORDER BY trainee_id;

-- Insert Trainer data---------------------------------------------------
INSERT INTO Trainer (trainer_id, name, specialty, phone, email) VALUES
(1, 'Khalid Al-Maawali', 'Databases', '96891234567', 'khalid@example.com'),
(2, 'Noura Al-Kindi', 'Web Development', '96892345678', 'noura@example.com'),
(3, 'Salim Al-Harthy', 'Data Science', '96893456789', 'salim@example.com');
-- Verify TRAINER data insertion
SELECT 'TRAINER TABLE DATA:' AS info; -----i wanted to make sure that the data i wrote is saved that why i verified it
SELECT * FROM TRAINER ORDER BY trainer_id;
-- Insert Course data---------------------------------------------------
INSERT INTO Course (course_id, title, category, duration_hours, level) VALUES
(1, 'Database Fundamentals', 'Databases', 20, 'Beginner'),
(2, 'Web Development Basics', 'Web', 30, 'Beginner'),
(3, 'Data Science Introduction', 'Data Science', 25, 'Intermediate'),
(4, 'Advanced SQL Queries', 'Databases', 15, 'Advanced');
-- Verify COURSE data insertion
SELECT 'COURSE TABLE DATA:' AS info; -----i wanted to make sure that the data i wrote is saved that why i verified it
SELECT * FROM COURSE ORDER BY course_id;
-- Insert Schedule data---------------------------------------------------
INSERT INTO Schedule (schedule_id, course_id, trainer_id, start_date, end_date, time_slot) VALUES
(1, 1, 1, '2025-07-01', '2025-07-10', 'Morning'),
(2, 2, 2, '2025-07-05', '2025-07-20', 'Evening'),
(3, 3, 3, '2025-07-10', '2025-07-25', 'Weekend'),
(4, 4, 1, '2025-07-15', '2025-07-22', 'Morning');
-- Verify SCHEDULE data insertion
SELECT 'SCHEDULE TABLE DATA:' AS info;    -----i wanted to make sure that the data i wrote is saved that why i verified it
SELECT * FROM SCHEDULE ORDER BY schedule_id;
-- Insert Enrollment data---------------------------------------------------
INSERT INTO Enrollment (enrollment_id, trainee_id, course_id, enrollment_date) VALUES
(1, 1, 1, '2025-06-01'),
(2, 2, 1, '2025-06-02'),
(3, 3, 2, '2025-06-03'),
(4, 4, 3, '2025-06-04'),
(5, 5, 3, '2025-06-05'),
(6, 1, 4, '2025-06-06');

-- Summary of all inserted data just to make sure all went well
SELECT 'DATA INSERTION SUMMARY:' AS info;

SELECT 
    'TRAINEE' AS table_name, 
    COUNT(*) AS record_count 
FROM TRAINEE
UNION ALL
SELECT 
    'TRAINER' AS table_name, 
    COUNT(*) AS record_count 
FROM TRAINER
UNION ALL
SELECT 
    'COURSE' AS table_name, 
    COUNT(*) AS record_count 
FROM COURSE
UNION ALL
SELECT 
    'SCHEDULE' AS table_name, 
    COUNT(*) AS record_count 
FROM SCHEDULE
UNION ALL
SELECT 
    'ENROLLMENT' AS table_name, 
    COUNT(*) AS record_count 
FROM ENROLLMENT;
--the third step is the queries--------------------------------------------------- 
------------TRAINEE PERSPECTIVE QUERIES---------------------------------------------------

-- 1. Show all available courses (title, level, category)-----------------
-- Retrieve a list of all courses offered by the institute///////////////////
SELECT title, level, category
FROM Course
ORDER BY category, level;

-- 2. View beginner-level Data Science courses----------------------------
-- Filter courses to show only beginner-level Data Science courses/////////////
SELECT title, level, category, duration_hours
FROM Course
WHERE level = 'Beginner' AND category = 'Data Science';

-- 3. Show courses this trainee is enrolled in (example for trainee_id = 1)---------
-- Display course titles for a specific trainee's enrollments//////////////////////
SELECT c.title, c.category, c.level
FROM Course c
JOIN Enrollment e ON c.course_id = e.course_id
WHERE e.trainee_id = 1;

-- 4. View the schedule (start_date, time_slot) for the trainee's enrolled courses---------
-- Show scheduled dates and time slots for trainee's courses//////////////////////////////
SELECT c.title, s.start_date, s.end_date, s.time_slot
FROM Course c
JOIN Enrollment e ON c.course_id = e.course_id
JOIN Schedule s ON c.course_id = s.course_id
WHERE e.trainee_id = 1
ORDER BY s.start_date;

-- 5. Count how many courses the trainee is enrolled in--------------------------
-- Return the number of courses for a specific trainee//////////////////////////
SELECT COUNT(*) as total_courses
FROM Enrollment
WHERE trainee_id = 1;

-- 6. Show course titles, trainer names, and time slots the trainee is attending-------------
-- Join tables to show complete course and trainer information/////////////////////////////
SELECT c.title, t.name as trainer_name, s.time_slot, s.start_date
FROM Course c
JOIN Enrollment e ON c.course_id = e.course_id
JOIN Schedule s ON c.course_id = s.course_id
JOIN Trainer t ON s.trainer_id = t.trainer_id
WHERE e.trainee_id = 1
ORDER BY s.start_date;

----now we are moving to the trainer queries---------------------------------------------------
-- TRAINER PERSPECTIVE QUERIES---------------------------------------------------

-- 1. List all courses the trainer is assigned to (example for trainer_id = 1)--------
-- Show course titles assigned to a specific trainer////////////////////////////
SELECT c.title, c.category, c.level, c.duration_hours
FROM Course c
JOIN Schedule s ON c.course_id = s.course_id
WHERE s.trainer_id = 1;

-- 2. Show upcoming sessions (with dates and time slots)-----------
-- Display future sessions for a specific trainer//////////////////
SELECT c.title, s.start_date, s.end_date, s.time_slot
FROM Course c
JOIN Schedule s ON c.course_id = s.course_id
WHERE s.trainer_id = 1 
  AND s.start_date >= CAST(GETDATE() AS DATE)
ORDER BY s.start_date;

-- 3. See how many trainees are enrolled in each of your courses--------------
-- Count trainees per course for a specific trainer//////////////////////////
SELECT c.title, COUNT(e.trainee_id) as enrolled_trainees
FROM Course c
JOIN Schedule s ON c.course_id = s.course_id
LEFT JOIN Enrollment e ON c.course_id = e.course_id
WHERE s.trainer_id = 1
GROUP BY c.course_id, c.title;

-- 4. List names and emails of trainees in each of your courses--------------------
-- Show trainee details for courses taught by a specific trainer/////////////////////
SELECT c.title, tr.name as trainee_name, tr.email
FROM Course c
JOIN Schedule s ON c.course_id = s.course_id
JOIN Enrollment e ON c.course_id = e.course_id
JOIN Trainee tr ON e.trainee_id = tr.trainee_id
WHERE s.trainer_id = 1
ORDER BY c.title, tr.name;

-- 5. Show the trainer's contact info and assigned courses-------------------------
-- Return trainer details with their assigned courses/////////////////////////////
SELECT t.name, t.phone, t.email, c.title
FROM Trainer t
JOIN Schedule s ON t.trainer_id = s.trainer_id
JOIN Course c ON s.course_id = c.course_id
WHERE t.trainer_id = 1;

-- 6. Count the number of courses the trainer teaches------------------------------
-- Find how many different courses a trainer is teaching////////////////////////////
SELECT COUNT(DISTINCT s.course_id) as courses_taught
FROM Schedule s
WHERE s.trainer_id = 1;

---now moving to the admin queries---------------------------------------------------
-- ADMIN PERSPECTIVE QUERIES---------------------------------------------------

-- 1. Add a new course (INSERT statement)
-- Insert a new course into the Course table
INSERT INTO Course (course_id, title, category, duration_hours, level)
VALUES (5, 'Python Programming', 'Programming', 40, 'Beginner');

-- 2. Create a new schedule for a trainer
-- Insert a new schedule entry
INSERT INTO Schedule (schedule_id, course_id, trainer_id, start_date, end_date, time_slot)
VALUES (5, 5, 2, '2025-08-01', '2025-08-30', 'Evening');

-- 3. View all trainee enrollments with course title and schedule info
-- Comprehensive view of enrollments with course and schedule details
SELECT tr.name as trainee_name, tr.email, c.title as course_title, 
       s.start_date, s.end_date, s.time_slot, t.name as trainer_name
FROM Trainee tr
JOIN Enrollment e ON tr.trainee_id = e.trainee_id
JOIN Course c ON e.course_id = c.course_id
JOIN Schedule s ON c.course_id = s.course_id
JOIN Trainer t ON s.trainer_id = t.trainer_id
ORDER BY tr.name, s.start_date;

-- 4. Show how many courses each trainer is assigned to
-- Count courses per trainer
SELECT t.name, t.email, COUNT(DISTINCT s.course_id) as courses_assigned
FROM Trainer t
LEFT JOIN Schedule s ON t.trainer_id = s.trainer_id
GROUP BY t.trainer_id, t.name, t.email
ORDER BY courses_assigned DESC;

-- 5. List all trainees enrolled in "Database Fundamentals"---------------------------------------------------
-- Retrieve trainee details for a specific course---------------------------------------------------
SELECT tr.name, tr.email, tr.background
FROM Trainee tr
JOIN Enrollment e ON tr.trainee_id = e.trainee_id
JOIN Course c ON e.course_id = c.course_id
WHERE c.title = 'Database Fundamentals';

-- 6. Identify the course with the highest number of enrollments
-- Rank courses by enrollment count
SELECT c.title, COUNT(e.trainee_id) as enrollment_count
FROM Course c
LEFT JOIN Enrollment e ON c.course_id = e.course_id
GROUP BY c.course_id, c.title
ORDER BY enrollment_count DESC
LIMIT 1;

-- Alternative query to show all courses ranked by enrollment
SELECT c.title, COUNT(e.trainee_id) as enrollment_count
FROM Course c
LEFT JOIN Enrollment e ON c.course_id = e.course_id
GROUP BY c.course_id, c.title
ORDER BY enrollment_count DESC;

-- 7. Display all schedules sorted by start date---------------------------------------------------
-- Select all schedule information ordered by start date---------------------------------------------------
SELECT s.schedule_id, c.title as course_title, t.name as trainer_name,
       s.start_date, s.end_date, s.time_slot
FROM Schedule s
JOIN Course c ON s.course_id = c.course_id
JOIN Trainer t ON s.trainer_id = t.trainer_id
ORDER BY s.start_date ASC;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- Check Foreign Key Relationships
SELECT 'FOREIGN KEY RELATIONSHIP VERIFICATION:' AS info;

-- Verify Schedule-Course relationships
SELECT 
    'Schedule-Course Relationships' AS relationship_type,
    s.schedule_id,
    s.course_id,
    c.title AS course_title,
    s.trainer_id,
    t.name AS trainer_name
FROM SCHEDULE s
JOIN COURSE c ON s.course_id = c.course_id
JOIN TRAINER t ON s.trainer_id = t.trainer_id
ORDER BY s.schedule_id;

-- Verify Enrollment-Trainee-Course relationships
SELECT 
    'Enrollment Relationships' AS relationship_type,
    e.enrollment_id,
    e.trainee_id,
    tr.name AS trainee_name,
    e.course_id,
    c.title AS course_title,
    e.enrollment_date
FROM ENROLLMENT e
JOIN TRAINEE tr ON e.trainee_id = tr.trainee_id
JOIN COURSE c ON e.course_id = c.course_id
ORDER BY e.enrollment_id;