Question 1

CREATE TABLE tblSemester
(
    semesterID NUMERIC(38) PRIMARY KEY,
    semesterCode VARCHAR2(11) UNIQUE NOT NULL,
    semesterYear NUMERIC(4) DEFAULT EXTRACT(YEAR FROM CURRENT_DATE) UNIQUE NOT NULL,
    semesterSeason VARCHAR2(6) NOT NULL,
    CONSTRAINT ck_semesterID CHECK (semesterID > 0),
    CONSTRAINT ck_semesterYear CHECK (semesterYear > 2000),
    CONSTRAINT ck_semesterSeason CHECK (SemesterSeason='Fall' OR SemesterSeason='Winter' OR SemesterSeason='Summer')
);

Question 2

CREATE TABLE tblCourse
(
    courseID NUMERIC(38) PRIMARY KEY,
    courseCode VARCHAR2(6) UNIQUE NOT NULL,
    CONSTRAINT ck_courseCode CHECK (courseCode > 0)
);

CREATE TABLE tblStudent
(
    studentID NUMERIC(38) PRIMARY KEY,
    studentNumber VARCHAR2(11) UNIQUE NOT NULL,
    studentFname VARCHAR2(20),
    studentLname VARCHAR (20) NOT NULL,
    CONSTRAINT ck_studentID CHECK (studentID > 0)
);

CREATE TABLE tblInstructor 
(
    instructorID NUMERIC(38) PRIMARY KEY,
    instructorNumber VARCHAR2(15) UNIQUE NOT NULL,
    instructorFname VARCHAR2(25),
    instructorLname VARCHAR2(25) NOT NULL,
    CONSTRAINT ck_instructorID CHECK (instructorID > 0)
);

CREATE TABLE tblCourseDetail
(
    courseID NUMERIC(38),
    studentID NUMERIC(38),
    semesterID NUMERIC(38),
    instructorID NUMERIC(38),
    courseGrade VARCHAR2(2) NOT NULL,
    courseFinalGrade NUMERIC(5,2) NOT NULL,
    PRIMARY KEY (courseID, studentID, semesterID),
    FOREIGN KEY (courseID) REFERENCES tblCourse(courseID),
    FOREIGN KEY (studentID) REFERENCES tblStudent(studentID),
    FOREIGN KEY (semesterID) REFERENCES tblSemester(semesterID),
    FOREIGN KEY (instructorID) REFERENCES tblInstructor(instructorID),
    CONSTRAINT ck_courseGrade CHECK (courseGrade IN ('F', 'D', 'D+', 'C', 'C+', 'B', 'B+', 'A', 'A+')),
    CONSTRAINT ck_courseFinalGrade CHECK (courseFinalGrade >= 0 AND courseFinalGrade <= 100)
);

Question 3

ALTER TABLE tblCourse
ADD courseDesc VARCHAR(35) NOT NULL;

Question 4

ALTER TABLE tblSemester 
DROP CONSTRAINT tblSemester_uk_semesterYear; ( CHANGE THIS TO UR LOCATION) 

Question 5 

ALTER TABLE tblCourseDetail
RENAME COLUMN courseGrade
TO courseLetterGrade
;

Question 6

ALTER TABLE tblStudent
MODIFY (studentFname VARCHAR(25), studentLname VARCHAR(25))
;





---- OLD -----
CREATE TABLE tblSemester (
    SemesterID NUMERIC(38) PRIMARY KEY
    CONSTRAINT pk_SemesterID
    CHECK (SemesterID > 0),
    
    SemesterCode VARCHAR2(11)
    CONSTRAINT uniqSemesterCode
    UNIQUE NOT NULL,
    
    SemesterYear NUMERIC(4)
    DEFAULT EXTRACT(YEAR FROM CURRENT_DATE)
    CONSTRAINT ckSemesterYear
    NOT NULL UNIQUE
    CHECK (SemesterYear > 2000),
    
    SemesterSeason VARCHAR2(6)  
    CONSTRAINT sSeason
    NOT NULL
    CHECK (SemesterSeason='Fall' OR SemesterSeason='Winter' OR SemesterSeason='Summer')
);

SELECT constraint_name,

            constraint_type,

            search_condition

FROM USER_CONSTRAINTS

WHERE table_name = 'TBLSEMESTER';


SELECT constraint_name,
            constraint_type,
            search_condition
FROM USER_CONSTRAINTS
WHERE table_name = 'TBLSEMESTER';


INSERT INTO tblSemester
(SemesterID, SemesterCode,SemesterSeason)
VALUES
(1,'F12345','Fall')
;
COMMIT;


SELECT * FROM tblSemester;
INSERT INTO tblSemester
(SemesterID, SemesterCode,SemesterSeason)
VALUES
(2,'F98765','Spring')
;
COMMIT;

INSERT INTO tblSemester
(SemesterID, SemesterCode,SemesterSeason)
VALUES
(1,'G12345','Winter')
;
COMMIT;

CREATE TABLE tblCourse (
    CourseID NUMERIC(38) PRIMARY KEY
        CONSTRAINT pkCourseID  
        CHECK (CourseID > 0),
    
    CourseCode VARCHAR2(6)
        CONSTRAINT uniq_CourseCode
        UNIQUE NOT NULL
);

CREATE TABLE tblStudent (
    StudentID NUMERIC(38) PRIMARY KEY
        CONSTRAINT pkStudentID
        CHECK (StudentID > 0),
    
    StudentNumber VARCHAR2(11)
        CONSTRAINT uniqStudentNumber
        UNIQUE NOT NULL,
    
    StudentFname VARCHAR2(20),
    
    StudentLname VARCHAR2(20) NOT NULL
);

CREATE TABLE tblInstructor (
    InstructorID NUMERIC(38) PRIMARY KEY
        CONSTRAINT pkInstructorID
        CHECK (InstructorID > 0),
    
    InstructorNumber VARCHAR2(15)
        CONSTRAINT uniq_InstructorNumber
        UNIQUE NOT NULL,
    
    InstructorFname VARCHAR2(25),
    
    InstructorLname VARCHAR2(25) NOT NULL
);

CREATE TABLE tblCourseDetail (
    CourseID NUMERIC(38),
    StudentID NUMERIC(38),
    SemesterID NUMERIC(38),
    InstructorID NUMERIC(38),
    
    PRIMARY KEY (CourseID, StudentID, SemesterID),
    CONSTRAINT fk_CourseID 
        FOREIGN KEY (CourseID) REFERENCES tblCourse(CourseID),
        
    CONSTRAINT fk_StudentID 
        FOREIGN KEY (StudentID) REFERENCES tblStudent(StudentID),
        
    CONSTRAINT fk_SemesterID 
        FOREIGN KEY (SemesterID) REFERENCES tblSemester(SemesterID),
        
    CONSTRAINT fk_InstructorID 
        FOREIGN KEY (InstructorID) REFERENCES tblInstructor(InstructorID),
    
    CourseGrade VARCHAR2(2) 
        CONSTRAINT chk_CourseGrade
        CHECK (CourseGrade IN ('F','D','D+','C','C+','B','B+','A','A+')) 
        NOT NULL,
    CourseFinalGrade NUMERIC(5,2) 
        CONSTRAINT chk_CourseFinalGrade 
        CHECK (CourseFinalGrade >= 0 AND CourseFinalGrade <= 100) 
        NOT NULL
);

ALTER TABLE tblCourse
ADD CourseDesc VARCHAR2(35) NOT NULL;