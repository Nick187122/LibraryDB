-- Library Management System Database
-- Created by Nicholas Oyiolo
-- Date: May 10, 2025

-- Create database
CREATE DATABASE IF NOT EXISTS LibraryDB;
USE LibraryDB;

-- Members table
CREATE TABLE Members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    membership_date DATE NOT NULL,
    membership_status ENUM('Active', 'Expired', 'Suspended') DEFAULT 'Active',
    CONSTRAINT chk_email CHECK (email LIKE '%@%.%')
);

-- Authors table
CREATE TABLE Authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    bio TEXT,
    nationality VARCHAR(50)
);

-- Publishers table
CREATE TABLE Publishers (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address TEXT,
    contact_email VARCHAR(100),
    website VARCHAR(100)
);

-- Books table
CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    publisher_id INT,
    publication_year INT,
    edition INT,
    category VARCHAR(50),
    total_copies INT NOT NULL DEFAULT 1,
    available_copies INT NOT NULL DEFAULT 1,
    shelf_location VARCHAR(20),
    FOREIGN KEY (publisher_id) REFERENCES Publishers(publisher_id),
    CONSTRAINT chk_copies CHECK (available_copies <= total_copies AND total_copies >= 0)
);

-- Book-Author relationship (M-M)
CREATE TABLE BookAuthors (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

-- Loans table
CREATE TABLE Loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    loan_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    status ENUM('Active', 'Returned', 'Overdue') DEFAULT 'Active',
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    CONSTRAINT chk_dates CHECK (due_date >= loan_date AND (return_date IS NULL OR return_date >= loan_date))
);

-- Fines table
CREATE TABLE Fines (
    fine_id INT AUTO_INCREMENT PRIMARY KEY,
    loan_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    issue_date DATE NOT NULL,
    payment_date DATE,
    status ENUM('Pending', 'Paid') DEFAULT 'Pending',
    FOREIGN KEY (loan_id) REFERENCES Loans(loan_id),
    CONSTRAINT chk_amount CHECK (amount >= 0)
);

-- Staff table
CREATE TABLE Staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    position VARCHAR(50) NOT NULL,
    hire_date DATE NOT NULL,
    salary DECIMAL(10,2)
);

-- Reservations table
CREATE TABLE Reservations (
    reservation_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    reservation_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Pending', 'Fulfilled', 'Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

-- Create indexes for performance
CREATE INDEX idx_books_title ON Books(title);
CREATE INDEX idx_members_name ON Members(last_name, first_name);
CREATE INDEX idx_loans_dates ON Loans(loan_date, due_date);
CREATE INDEX idx_fines_status ON Fines(status);
