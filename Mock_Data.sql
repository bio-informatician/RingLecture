USE learning_platform;

-- =========================================
-- COURSE
-- =========================================
INSERT INTO course (name, description, price, is_progress_limit)
VALUES
('Java Fundamentals', 'Learn core Java programming', 99.99, TRUE),
('Web Development Bootcamp', 'HTML CSS JavaScript Full Course', 149.99, FALSE),
('Database Design', 'Relational database modeling and SQL', 89.99, TRUE);

-- =========================================
-- STUDENT (10 RECORDS)
-- =========================================
INSERT INTO student (email_address, password)
VALUES
('student1@example.com', 'pass1'),
('student2@example.com', 'pass2'),
('student3@example.com', 'pass3'),
('student4@example.com', 'pass4'),
('student5@example.com', 'pass5'),
('student6@example.com', 'pass6'),
('student7@example.com', 'pass7'),
('student8@example.com', 'pass8'),
('student9@example.com', 'pass9'),
('student10@example.com', 'pass10');

-- =========================================
-- MODULE
-- =========================================
INSERT INTO module (course_id, name, number)
VALUES
(1, 'Java Basics', 1),
(1, 'Object Oriented Programming', 2),
(2, 'HTML & CSS', 1),
(2, 'JavaScript', 2),
(3, 'SQL Basics', 1);

-- =========================================
-- LESSON (10 RECORDS)
-- =========================================
INSERT INTO lesson (
    module_id,
    name,
    number,
    video_url,
    lesson_detail,
    course_order
)
VALUES
(1, 'Introduction to Java', 1, 'https://example.com/java1', 'Java introduction', 1),
(1, 'Variables and Data Types', 2, 'https://example.com/java2', 'Variables in Java', 2),
(1, 'Control Flow', 3, 'https://example.com/java3', 'If else and loops', 3),
(2, 'Classes and Objects', 1, 'https://example.com/java4', 'OOP basics', 4),
(2, 'Inheritance', 2, 'https://example.com/java5', 'Inheritance in Java', 5),
(3, 'HTML Introduction', 1, 'https://example.com/html1', 'HTML basics', 6),
(3, 'CSS Styling', 2, 'https://example.com/css1', 'CSS fundamentals', 7),
(4, 'JavaScript Basics', 1, 'https://example.com/js1', 'JS intro', 8),
(5, 'Introduction to SQL', 1, 'https://example.com/sql1', 'SQL basics', 9),
(5, 'Database Relationships', 2, 'https://example.com/sql2', 'One-to-many relationships', 10);

-- =========================================
-- QUIZ
-- =========================================
INSERT INTO quiz (
    course_id,
    name,
    number,
    course_order,
    min_pass_score,
    is_pass_required
)
VALUES
(1, 'Java Quiz 1', 1, 1, 70, TRUE),
(1, 'Java Quiz 2', 2, 2, 75, TRUE),
(2, 'Frontend Quiz', 1, 1, 60, FALSE),
(3, 'SQL Quiz', 1, 1, 80, TRUE);

-- =========================================
-- QUIZ QUESTION
-- =========================================
INSERT INTO quiz_question (quiz_id, question_title)
VALUES
(1, 'What is JVM?'),
(1, 'What is a variable?'),
(2, 'What is inheritance?'),
(3, 'What does HTML stand for?'),
(4, 'What is a primary key?');

-- =========================================
-- QUIZ ANSWER
-- =========================================
INSERT INTO quiz_answer (
    question_id,
    answer_text,
    is_correct,
    min_pass_score
)
VALUES
(1, 'Java Virtual Machine', TRUE, 1),
(1, 'Java Vendor Machine', FALSE, 0),
(2, 'Stores data', TRUE, 1),
(2, 'Runs loops', FALSE, 0),
(3, 'Reuse of parent class features', TRUE, 1),
(4, 'HyperText Markup Language', TRUE, 1),
(5, 'Unique identifier for a record', TRUE, 1);

-- =========================================
-- ENROLMENT
-- =========================================
INSERT INTO enrolment (
    course_id,
    student_id,
    enrolment_datetime,
    completed_datetime
)
VALUES
(1, 1, NOW(), NULL),
(1, 2, NOW(), NULL),
(1, 3, NOW(), NULL),
(2, 4, NOW(), NULL),
(2, 5, NOW(), NULL),
(2, 6, NOW(), NULL),
(3, 7, NOW(), NULL),
(3, 8, NOW(), NULL),
(3, 9, NOW(), NULL),
(1, 10, NOW(), NULL);

-- =========================================
-- STUDENT LESSON
-- =========================================
INSERT INTO student_lesson (
    student_id,
    lesson_id,
    completed_datetime
)
VALUES
(1, 1, NOW()),
(1, 2, NOW()),
(2, 1, NOW()),
(3, 3, NOW()),
(4, 6, NOW()),
(5, 7, NOW()),
(6, 8, NOW()),
(7, 9, NOW()),
(8, 10, NOW()),
(9, 9, NOW());

-- =========================================
-- STUDENT QUIZ ATTEMPT
-- =========================================
INSERT INTO student_quiz_attempt (
    student_id,
    quiz_id,
    attempt_datetime,
    score_achieved
)
VALUES
(1, 1, NOW(), 85),
(2, 1, NOW(), 60),
(3, 2, NOW(), 90),
(4, 3, NOW(), 75),
(5, 3, NOW(), 55),
(6, 3, NOW(), 88),
(7, 4, NOW(), 92),
(8, 4, NOW(), 81),
(9, 4, NOW(), 79),
(10, 1, NOW(), 95);
