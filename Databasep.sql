
--TASK 2 
CREATE TABLE Course (
  course_id INT PRIMARY KEY,
  department VARCHAR(255),
  course_number INT,
  course_name VARCHAR(255),
  semester VARCHAR(255),
  year INT
);
-- Create Student table
CREATE TABLE Student (
  student_id INT PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  course_id INT,
  FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

-- Create Assignment table
CREATE TABLE Assignment (
  assignment_id INT PRIMARY KEY,
  category VARCHAR(255),
  percentage DECIMAL(5,2),
  course_id INT,
  FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

-- Create Grades table
CREATE TABLE Grades (
  grade_id INT PRIMARY KEY,
  assignment_id INT,
  student_id INT,
  score DECIMAL(5,2),
  FOREIGN KEY (assignment_id) REFERENCES Assignment(assignment_id),
  FOREIGN KEY (student_id) REFERENCES Student(student_id)
);
SELECT * FROM Grades;
-- Insert values into Course table
INSERT INTO Course (course_id, department, course_number, course_name, semester, year)
VALUES (1, 'Computer Science', 101, 'Intro to Computer Science', 'Fall', 2022),(2, 'Math', 102, 'Intro to Linear Algebra', 'Fall', 2022),(3, 'Computer Science', 432, 'Database Systems', 'Spring', 2023);

-- Insert values into Student table
INSERT INTO Student (student_id, first_name, last_name, course_id)
VALUES (1, 'John', 'Doe', 1),
       (2, 'Jane', 'Smith', 1),
       (3, 'David', 'Johnson', 1),
      (4, 'Joe', 'Quin', 1),
      (5, 'Myah', 'Lane', 1),
      (6, 'Tori', 'Quacks', 1);

-- Insert values into Assignment table
INSERT INTO Assignment (assignment_id, category, percentage, course_id)
VALUES (1, 'Participation', 10.0, 1),
       (2, 'Homework', 20.0, 1),
       (3, 'Tests', 50.0, 1),
       (4, 'Projects', 20.0, 1),
       (5, 'Midterm', 35.0, 1);

-- Insert values into Grades table
INSERT INTO Grades (grade_id, assignment_id, student_id, score)
VALUES (1, 1, 1, 8.5),
       (2, 2, 1, 92.0),
       (3, 3, 1, 75.0),
       (4, 4, 1, 88.0),
       (5, 1, 2, 9.0),
       (6, 2, 2, 88.5),
       (7, 3, 2, 82.0),
       (8, 4, 2, 95.0),
       (9, 1, 3, 7.0),
       (10, 2, 3, 78.0),
       (11, 3, 3, 90.0),
       (12, 4, 3, 91.5),
      (13, 1, 4, 9.0),
       (14, 2, 4, 86);


--TASK 4-12
    -- Average score
SELECT AVG(score) AS average_score
FROM Grades
WHERE assignment_id = 2;

-- Highest score
SELECT MAX(score) AS highest_score
FROM Grades
WHERE assignment_id = 2;

-- Lowest score
SELECT MIN(score) AS lowest_score
FROM Grades
WHERE assignment_id = 2;

-- retrieve all students in a given course (e.g., course_id = 1):
SELECT s.* FROM Student s
JOIN Course c ON s.course_id = c.course_id
WHERE c.course_id = 1;

 SELECT * FROM Course;

-- Add an assignment to a course (e.g., course_id = 1):
-- INSERT INTO Assignment (assignment_id, category, percentage, course_id)
-- VALUES (5, 'Final Exam', 30.0, 1);

INSERT INTO Assignment (assignment_id, category, percentage, course_id) 
VALUES ('Final Exam', 'test', 30.0, 'CS101Fall2022');

 SELECT * FROM Assignment;

SELECT Student.name, Student.last_name, Assignment.name, Course.grade 
FROM Course 
JOIN Student ON Course.student_id = Student.student_id 
JOIN Assignment ON Course.course_id = Assignment.course_id 
WHERE Enrollment.course_id = 'CS101Fall2022';

-- Change the percentages of categories for a course (e.g., course_id = 1, new percentage for Homework = 30%):
UPDATE Assignment
SET percentage = 30.0
WHERE category = 'Homework' AND course_id = 1;

--add 2 points to the score of each student on assignment 3 
 SELECT * FROM Grades;
UPDATE Grades
SET score = score + 2
WHERE assignment_id = 3;
--SELECT * FROM Grades;

-- Add 2 points to the score of students whose last name contains a 'Q':
Update Grades
SET score = score + 2
WHERE student_id IN (
  SELECT student_id
  FROM student
  WHERE last_name LIKE '%Q%'
  );
--Compute the grade for a student (e.g., student_id = 1):
SELECT s.first_name, s.last_name, SUM(a.percentage * g.score / 100) AS grade
FROM Student s
JOIN Grades g ON s.student_id = g.student_id
JOIN Assignment a ON g.assignment_id = a.assignment_id
GROUP BY s.first_name, s.last_name
HAVING s.student_id = 1;
-- compute grade for a student where the lowest is dropped
SELECT s.first_name,s.last_name, SUM(a.percentage * (g.score - min_score.min_score) / 100) AS grade 
FROM Student s 
JOIN Grades g ON s.student_id = g.student_id
JOIN Assignment a ON g.assignment_id = a.assignment_id 
JOIN (SELECT student_id,MIN(score) AS min_score FROM Grades GROUP BY student_id) AS min_score ON s.student_id = min_score.student_id 
WHERE s.student_id =2
GROUP BY s.first_name,s.last_name;

-- SELECT * FROM Assignment;
-- TASK 3
-- SELECT * FROM Course;
-- SELECT * FROM Student;
-- SELECT * FROM Assignment;
SELECT * FROM Grades;
