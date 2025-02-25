


CREATE TABLE Students (
    StudentID SERIAL PRIMARY KEY,
    StudentName VARCHAR(100) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender VARCHAR(10) CHECK (Gender IN ('Male', 'Female', 'Other')),
    EnrollmentDate DATE NOT NULL,
    Major VARCHAR(100) NOT NULL
);


CREATE TABLE Courses (
    CourseID SERIAL PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    Department VARCHAR(100) NOT NULL,
    Credits INT CHECK (Credits > 0)
);


CREATE TABLE Professors (
    ProfessorID SERIAL PRIMARY KEY,
    ProfessorName VARCHAR(100) NOT NULL,
    Department VARCHAR(100) NOT NULL
);

CREATE TABLE Enrollments (
    EnrollmentID SERIAL PRIMARY KEY,
    StudentID INT REFERENCES Students(StudentID) ON DELETE CASCADE,
    CourseID INT REFERENCES Courses(CourseID) ON DELETE CASCADE,
    EnrollmentDate DATE NOT NULL
);


CREATE TABLE Grades (
    GradeID SERIAL PRIMARY KEY,
    StudentID INT REFERENCES Students(StudentID) ON DELETE CASCADE,
    CourseID INT REFERENCES Courses(CourseID) ON DELETE CASCADE,
    Grade VARCHAR(2) CHECK (Grade IN ('A', 'B', 'C', 'D', 'F')),
    Semester VARCHAR(10) NOT NULL
);


CREATE TABLE Departments (
    DepartmentID SERIAL PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL,
    Dean VARCHAR(100) NOT NULL
);


CREATE TABLE Attendance (
    AttendanceID SERIAL PRIMARY KEY,
    StudentID INT REFERENCES Students(StudentID) ON DELETE CASCADE,
    CourseID INT REFERENCES Courses(CourseID) ON DELETE CASCADE,
    Date DATE NOT NULL,
    Status VARCHAR(10) CHECK (Status IN ('Present', 'Absent'))
);

-- Students
INSERT INTO Students (StudentName, DateOfBirth, Gender, EnrollmentDate, Major) VALUES
('Alice Johnson', '2001-05-10', 'Female', '2023-08-15', 'Computer Science'),
('Bob Smith', '2000-07-20', 'Male', '2023-08-15', 'Mathematics'),
('Charlie Brown', '1999-12-05', 'Male', '2022-09-01', 'Physics'),
('Diana Prince', '2002-01-25', 'Female', '2023-08-15', 'Computer Science'),
('Ethan Hunt', '2001-03-30', 'Male', '2022-09-01', 'Mathematics');

-- Courses
INSERT INTO Courses (CourseName, Department, Credits) VALUES
('Database Systems', 'Computer Science', 3),
('Linear Algebra', 'Mathematics', 4),
('Quantum Mechanics', 'Physics', 3),
('Operating Systems', 'Computer Science', 3),
('Calculus', 'Mathematics', 4);

-- Professors
INSERT INTO Professors (ProfessorName, Department) VALUES
('Dr. Emily Carter', 'Computer Science'),
('Dr. John Watson', 'Mathematics'),
('Dr. Alan Turing', 'Computer Science'),
('Dr. Marie Curie', 'Physics'),
('Dr. Isaac Newton', 'Mathematics');

-- Enrollments
INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate) VALUES
(1, 1, '2024-01-10'),
(2, 2, '2024-01-12'),
(3, 3, '2024-01-15'),
(4, 4, '2024-01-18'),
(5, 5, '2024-01-20');

-- Grades
INSERT INTO Grades (StudentID, CourseID, Grade, Semester) VALUES
(1, 1, 'A', 'Fall 2023'),
(2, 2, 'B', 'Fall 2023'),
(3, 3, 'C', 'Fall 2023'),
(4, 4, 'A', 'Fall 2023'),
(5, 5, 'B', 'Fall 2023');

-- Departments
INSERT INTO Departments (DepartmentName, Dean) VALUES
('Computer Science', 'Dr. Emily Carter'),
('Mathematics', 'Dr. John Watson'),
('Physics', 'Dr. Marie Curie'),
('Engineering', 'Dr. Nikola Tesla'),
('Biology', 'Dr. Rosalind Franklin');

-- Attendance
INSERT INTO Attendance (StudentID, CourseID, Date, Status) VALUES
(1, 1, '2024-02-10', 'Present'),
(2, 2, '2024-02-10', 'Absent'),
(3, 3, '2024-02-10', 'Present'),
(4, 4, '2024-02-10', 'Present'),
(5, 5, '2024-02-10', 'Absent');



-- Queries:

-- 1. Retrieve the average grade for each course.
select c.CourseName, 
    ROUND(avg(case 
        when g.Grade = 'A' then 4.0
        when g.Grade = 'B' then 3.0
        when g.Grade = 'C' then 2.0
        when g.Grade = 'D' then 1.0
        when g.Grade = 'F' then 0.0
    end), 2) as AverageGPA
from Grades g
join Courses c on g.CourseID = c.CourseID
group by c.CourseName
order by AverageGPA DESC;

-- 2. Find the top 5 students with the highest GPA.
select s.StudentID, s.StudentName, 
    ROUND(avg(case 
        when g.Grade = 'A' then 4.0
        when g.Grade = 'B' then 3.0
        when g.Grade = 'C' then 2.0
        when g.Grade = 'D' then 1.0
        when g.Grade = 'F' then 0.0
    end), 2) as GPA
from Grades g
join Students s on g.StudentID = s.StudentID
group by s.StudentID, s.StudentName
order by GPA desc
limit 5;

-- 3. Count the number of students enrolled in each major.
select Major, count(*) as StudentCount
from Students
group by Major;

-- 4. Identify the courses with the highest student enrollment.
select c.CourseName, count(e.StudentID) as EnrollmentCount
from Enrollments e
join Courses c on e.CourseID = c.CourseID
group by c.CourseName
order by EnrollmentCount desc;

-- 5. Calculate the student retention rate.
select ROUND((count(DISTINCT StudentID) filter (where EnrollmentDate < '2023-01-01')::DECIMAL / count(distinct StudentID) * 100), 2) AS RetentionRate
from Students;

-- 6. Find the professors teaching the most courses.
select p.ProfessorName, count(c.CourseID) as CoursesTaught
from Professors p
join Courses c on p.Department = c.Department
group by p.ProfessorName
order by CoursesTaught desc;

-- 7. List students who have failed more than one course.
select s.StudentID, s.StudentName, count(g.Grade) as FailedCourses
from Grades g
join Students s on g.StudentID = s.StudentID
where g.Grade = 'F'
group by s.StudentID, s.StudentName
HAVING COUNT(g.Grade) > 1;

-- 8. Analyze semester-wise student performance trends.
select Semester, ROUND(avg(case 
        when Grade = 'A' then 4.0
        when Grade = 'B' then 3.0
        when Grade = 'C' then 2.0
        when Grade = 'D' then 1.0
        when Grade = 'F' then 0.0
    end), 2) as AvgGPA
from Grades
group by Semester
order by Semester;

-- 9. Calculate the percentage of students passing each course.
select c.CourseName, 
    ROUND((count(g.Grade) filter (where g.Grade in ('A', 'B', 'C'))::DECIMAL / count(g.Grade) * 100), 2) AS PassRate
from Grades g
join Courses c ON g.CourseID = c.CourseID
group by c.CourseName
order by PassRate DESC;

-- 10. Find students who changed their major after enrollment.
select StudentID, StudentName
from Students
where StudentID in (
    select distinct StudentID
    from Enrollments
    group by StudentID
    having count(distinct Major) > 1
);

-- 11. Determine the course completion rate.
select c.CourseName, 
    ROUND((count(g.Grade) filter (where g.Grade is not null)::DECIMAL / COUNT(e.StudentID) * 100), 2) AS CompletionRate
from Enrollments e
left join Grades g on e.StudentID = g.StudentID and e.CourseID = g.CourseID
join Courses c on e.CourseID = c.CourseID
group by c.CourseName;

-- 12. Identify professors whose students have the highest average grades.
select p.ProfessorName, 
    ROUND(avg(case 
        when g.Grade = 'A' then 4.0
        when g.Grade = 'B' then 3.0
        when g.Grade = 'C' then 2.0
        when g.Grade = 'D' then 1.0
        when g.Grade = 'F' then 0.0
    end), 2) as AvgGPA
from Professors p
join Courses c on p.Department = c.Department
join Grades g on c.CourseID = g.CourseID
group by p.ProfessorName
order by AvgGPA desc;

--13 Calculate the attendance rate for each student

select a.StudentID, s.StudentName, 
       count(case when a.Status = 'Present' then 1 end) * 100.0 / count(*) as AttendanceRate
from Attendance a
join Students s on a.StudentID = s.StudentID
group by a.StudentID, s.StudentName;

--14 Identify the most frequently skipped courses.
select c.CourseID, c.CourseName, 
       count(case when a.Status = 'Absent' then 1 end) as Absences
from Attendance a
join Courses c on a.CourseID = c.CourseID
group by c.CourseID, c.CourseName
order by Absences DESC;

--15 Find the department with the highest student enrollment.
select s.Major as Department, count(*) as StudentCount
from Students s
group by s.Major
order by StudentCount DESC
limit 3;

