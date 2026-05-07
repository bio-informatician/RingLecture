# MySQL Docker Setup and SQL Demo

Do the SSH to the computer pool or use your computer if you have Docker. Check with:
```bash
docker version
```

# Pull MySQL Image from Docker Hub

```bash
docker pull mysql:oraclelinux9
```

---

# Run the MySQL Server Instance

```bash
docker run --name mock-mysql -e MYSQL_ROOT_PASSWORD=mypass -d mysql:oraclelinux9
```

---

# Create a Docker Network

```bash
docker network create mock-network
```

---

# Add the Server to the Network

```bash
docker network connect mock-network mock-mysql
```

---

# Connect to the Server from Another Instance

```bash
docker run -it --network mock-network --rm mysql mysql -h mock-mysql -u root -p
```

---

# Access the Bash Shell in the Container

```bash
docker exec -it mock-mysql bash
```

Then access MySQL:

```bash
mysql -u root -p
```

---

# Create a Database

```sql
CREATE DATABASE testdb;
USE testdb;
```

---

# Create Tables

## Course Table

```sql
CREATE TABLE course (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL
);
```

## Student Table

```sql
CREATE TABLE student (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email_address VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);
```

## Enrolment Table

```sql
CREATE TABLE enrolment (
    course_id INT NOT NULL,
    student_id INT NOT NULL,
    enrolment_datetime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

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
```

---

# Insert Sample Data

## Insert Courses

```sql
INSERT INTO course (name, description, price)
VALUES
('MySQL Basics', 'Introduction to MySQL databases', 49.99),
('Web Development', 'HTML, CSS, JavaScript fundamentals', 99.99),
('Python Programming', 'Learn Python from scratch', 79.99);
```

## Insert Students

```sql
INSERT INTO student (email_address, password)
VALUES
('alice@example.com', 'alicepass'),
('bob@example.com', 'bobpass'),
('charlie@example.com', 'charliepass');
```

## Insert Enrolments

```sql
INSERT INTO enrolment (course_id, student_id)
VALUES
(1, 1),
(1, 2),
(2, 1),
(3, 3);
```

---

# Join Query

```sql
SELECT
    s.email_address,
    c.name AS course_name,
    e.enrolment_datetime
FROM enrolment e
JOIN student s
    ON e.student_id = s.id
JOIN course c
    ON e.course_id = c.id;
```

---

# Execute Query from Docker

```bash
docker exec -i mock-mysql mysql -u root -p -e "
USE testdb;
SELECT
    s.email_address,
    c.name AS course_name,
    e.enrolment_datetime
FROM enrolment e
JOIN student s ON e.student_id = s.id
JOIN course c ON e.course_id = c.id;
"
```

---

# Delete MySQL from Docker

```bash
docker rm -f $(docker ps -aq --filter ancestor=mysql)
docker rm -f mock-mysql
docker volume prune -f
docker network rm mock-network
docker rmi mysql:oraclelinux9 mysql:latest
```
