-- -------------------------------------------------------------
--  Database Creation and Selection
-- -------------------------------------------------------------
--  Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS library_management_system;
--  Select the database to use
USE library_management_system;
-- -------------------------------------------------------------
--  Table Creation: Books
-- -------------------------------------------------------------
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(13) NOT NULL UNIQUE,
    publication_year INT,
    publisher VARCHAR(255),
    author_id INT,
    -- Foreign Key to authors table
    genre_id INT,
    -- Foreign Key to genres table
    date_added TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- -------------------------------------------------------------
--  Table Creation: Authors
-- -------------------------------------------------------------
CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    birth_date DATE,
    nationality VARCHAR(100)
);
-- -------------------------------------------------------------
-- Table Creation: Genres
-- -------------------------------------------------------------
CREATE TABLE genres (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);
-- -------------------------------------------------------------
--  Table Creation: Members
-- -------------------------------------------------------------
CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone_number VARCHAR(20),
    address VARCHAR(255),
    membership_date DATE NOT NULL,
    account_status ENUM('Active', 'Inactive', 'Suspended') DEFAULT 'Active' NOT NULL
);
-- -------------------------------------------------------------
--  Table Creation: Loans (formerly BookLoans)
-- -------------------------------------------------------------
CREATE TABLE loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    -- Foreign Key to books table
    member_id INT NOT NULL,
    -- Foreign Key to members table
    loan_date DATE NOT NULL,
    return_date DATE,
    status ENUM('Loaned', 'Returned', 'Overdue') DEFAULT 'Loaned' NOT NULL,
    CONSTRAINT chk_return_date CHECK (return_date >= loan_date)
);
-- -------------------------------------------------------------
--  Table Creation: Reservations
-- -------------------------------------------------------------
CREATE TABLE reservations (
    reservation_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    -- Foreign Key to books table
    member_id INT NOT NULL,
    -- Foreign Key to members table
    reservation_date DATETIME NOT NULL,
    status ENUM('Pending', 'Active', 'Cancelled', 'Completed') DEFAULT 'Pending' NOT NULL
);
-- -------------------------------------------------------------
--  Table Creation: Fines
-- -------------------------------------------------------------
CREATE TABLE fines (
    fine_id INT AUTO_INCREMENT PRIMARY KEY,
    loan_id INT NOT NULL,
    -- Foreign Key to loans table
    member_id INT NOT NULL,
    -- Foreign Key to members table
    fine_amount DECIMAL(10, 2) NOT NULL,
    payment_status ENUM('Pending', 'Paid', 'Waived') DEFAULT 'Pending' NOT NULL,
    date_incurred TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_fine_amount CHECK (fine_amount >= 0)
);
-- -------------------------------------------------------------
--  Adding Foreign Key Constraints
-- -------------------------------------------------------------
--  Foreign Key for books.author_id
ALTER TABLE books
ADD CONSTRAINT fk_books_author_id FOREIGN KEY (author_id) REFERENCES authors(author_id) ON DELETE
SET NULL;
--  Foreign Key for books.genre_id
ALTER TABLE books
ADD CONSTRAINT fk_books_genre_id FOREIGN KEY (genre_id) REFERENCES genres(genre_id) ON DELETE
SET NULL;
--  Foreign Key for loans.book_id
ALTER TABLE loans
ADD CONSTRAINT fk_loans_book_id FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE;
--  Foreign Key for loans.member_id
ALTER TABLE loans
ADD CONSTRAINT fk_loans_member_id FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE;
--  Foreign Key for reservations.book_id
ALTER TABLE reservations
ADD CONSTRAINT fk_reservations_book_id FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE;
--  Foreign Key for reservations.member_id
ALTER TABLE reservations
ADD CONSTRAINT fk_reservations_member_id FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE;
--  Foreign Key for fines.loan_id
ALTER TABLE fines
ADD CONSTRAINT fk_fines_loan_id FOREIGN KEY (loan_id) REFERENCES loans(loan_id) ON DELETE CASCADE;
--  Foreign Key for fines.member_id
ALTER TABLE fines
ADD CONSTRAINT fk_fines_member_id FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE;
-- -------------------------------------------------------------
--  Description of the Database Structure
-- -------------------------------------------------------------
/*
 This SQL script creates a database for a Library Management System with the following tables and relationships:
 
 Tables:
 - books: Stores information about books, including title, ISBN, publication year, publisher, author, and genre.
 - authors: Stores information about authors, including first name, last name, birth date, and nationality.
 - genres: Stores information about book genres.
 - members: Stores information about library members, including contact details and membership status.
 - loans:  Stores information about book loans, including the book, member, loan date, return date, and loan status.
 - reservations: Stores information about book reservations made by members.
 - fines: Stores information about fines incurred by members for overdue loans.
 
 Relationships:
 - One-to-Many:
 - An author can write multiple books (authors -> books).
 - A genre can be associated with multiple books (genres -> books).
 - A member can borrow multiple books (members -> loans).
 - A book can be borrowed multiple times (books -> loans).
 - A member can make multiple reservations (members -> reservations).
 - A book can be reserved multiple times (books -> reservations).
 - A loan can have one fine (loans -> fines).
 - A member can have multiple fines (members -> fines).
 
 - Many-to-Many:
 -  Handled implicitly through the loans and reservations tables.
 
 Constraints:
 - PRIMARY KEY:  Uniquely identifies each record in a table.
 - FOREIGN KEY: Establishes relationships between tables.
 - NOT NULL: Ensures that a column cannot have a NULL value.
 - UNIQUE: Ensures that all values in a column are distinct.
 - DEFAULT:  Specifies a default value for a column.
 - CHECK: Ensures that values in a column satisfy a specific condition (e.g., return date not before loan date, fine amount not negative).
 - AUTO_INCREMENT:  Automatically generates a unique numeric value for a column.
 - TIMESTAMP: Stores both date and time.
 
 This database design provides a solid foundation for managing a library's operations, including book cataloging, member management,
 book lending, reservations, and fine tracking.  The use of appropriate data types, constraints, and relationships ensures data
 integrity and consistency.
 */