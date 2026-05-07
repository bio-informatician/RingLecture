CREATE DATABASE IF NOT EXISTS learning_platform;
USE learning_platform;

-- =========================================
-- COURSE
-- =========================================
CREATE TABLE course (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    is_progress_limit BOOLEAN NOT NULL DEFAULT FALSE
);

-- =========================================
-- STUDENT
-- =========================================
CREATE TABLE student (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email_address VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

-- =========================================
-- MODULE
-- =========================================
CREATE TABLE module (
    id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    number INT NOT NULL,

    CONSTRAINT fk_module_course
        FOREIGN KEY (course_id)
        REFERENCES course(id)
        ON DELETE CASCADE
);

-- =========================================
-- LESSON
-- =========================================
CREATE TABLE lesson (
    id INT AUTO_INCREMENT PRIMARY KEY,
    module_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    number INT NOT NULL,
    video_url TEXT,
    lesson_detail TEXT,
    course_order INT NOT NULL,

    CONSTRAINT fk_lesson_module
        FOREIGN KEY (module_id)
        REFERENCES module(id)
        ON DELETE CASCADE
);

-- =========================================
-- QUIZ
-- =========================================
CREATE TABLE quiz (
    id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    number INT NOT NULL,
    course_order INT NOT NULL,
    min_pass_score DECIMAL(5,2),
    is_pass_required BOOLEAN NOT NULL DEFAULT FALSE,

    CONSTRAINT fk_quiz_course
        FOREIGN KEY (course_id)
        REFERENCES course(id)
        ON DELETE CASCADE
);

-- =========================================
-- QUIZ QUESTION
-- =========================================
CREATE TABLE quiz_question (
    id INT AUTO_INCREMENT PRIMARY KEY,
    quiz_id INT NOT NULL,
    question_title TEXT NOT NULL,

    CONSTRAINT fk_quiz_question_quiz
        FOREIGN KEY (quiz_id)
        REFERENCES quiz(id)
        ON DELETE CASCADE
);

-- =========================================
-- QUIZ ANSWER
-- =========================================
CREATE TABLE quiz_answer (
    id INT AUTO_INCREMENT PRIMARY KEY,
    question_id INT NOT NULL,
    answer_text TEXT NOT NULL,
    is_correct BOOLEAN NOT NULL DEFAULT FALSE,
    min_pass_score DECIMAL(5,2),

    CONSTRAINT fk_quiz_answer_question
        FOREIGN KEY (question_id)
        REFERENCES quiz_question(id)
        ON DELETE CASCADE
);

-- =========================================
-- ENROLMENT
-- =========================================
CREATE TABLE enrolment (
    course_id INT NOT NULL,
    student_id INT NOT NULL,
    enrolment_datetime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    completed_datetime DATETIME NULL,

    PRIMARY KEY (course_id, student_id),

    CONSTRAINT fk_enrolment_course
        FOREIGN KEY (course_id)
        REFERENCES course(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_enrolment_student
        FOREIGN KEY (student_id)
        REFERENCES student(id)
        ON DELETE CASCADE
);

-- =========================================
-- STUDENT LESSON
-- =========================================
CREATE TABLE student_lesson (
    student_id INT NOT NULL,
    lesson_id INT NOT NULL,
    completed_datetime DATETIME NULL,

    PRIMARY KEY (student_id, lesson_id),

    CONSTRAINT fk_student_lesson_student
        FOREIGN KEY (student_id)
        REFERENCES student(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_student_lesson_lesson
        FOREIGN KEY (lesson_id)
        REFERENCES lesson(id)
        ON DELETE CASCADE
);

-- =========================================
-- STUDENT QUIZ ATTEMPT
-- =========================================
CREATE TABLE student_quiz_attempt (
    student_id INT NOT NULL,
    quiz_id INT NOT NULL,
    attempt_datetime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    score_achieved DECIMAL(5,2),

    PRIMARY KEY (student_id, quiz_id, attempt_datetime),

    CONSTRAINT fk_student_quiz_attempt_student
        FOREIGN KEY (student_id)
        REFERENCES student(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_student_quiz_attempt_quiz
        FOREIGN KEY (quiz_id)
        REFERENCES quiz(id)
        ON DELETE CASCADE
);
