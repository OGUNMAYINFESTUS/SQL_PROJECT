Project Title
Library Management System (MySQL)



Description of what your project does.
Project Description: Library Management System

This project involves the design and implementation of a database management system for a library. The system is designed to manage core library operations, including:

Book Cataloging:  Storing and organizing information about the library's collection of books.

Member Management:  Tracking library members, their contact information, and membership status.

Book Lending:  Managing the process of lending books to members, including loan dates and return dates.

Book Reservations:  Handling book reservations made by members.

Fine Tracking:  Calculating and tracking fines for overdue books.

The database is structured to ensure data integrity and efficiency, with relationships defined between different entities (e.g., authors, books, members, loans).  The system uses a relational database model and is implemented using SQL.


How to run/setup the project (or import SQL)
How to Run the Project:

Install MySQL: If you don't have it already, download and install MySQL Server from the official website.

Set up MySQL:

Open the MySQL command-line client or a MySQL administration tool (like MySQL Workbench).

Log in using your MySQL credentials.

Create the Database:

Execute the following SQL command to create the database:

CREATE DATABASE IF NOT EXISTS library_management_system;

Select the Database:

Execute the following SQL command to select the database:

USE library_management_system;

Create the Tables:

Execute the SQL code provided in the "Library Management System (MySQL)" document (the CREATE TABLE statements) to create the tables in the database. You can either:

Copy and paste the entire SQL script into your MySQL client and run it.

Save the SQL script to a file (e.g., library_management.sql) and then execute that file from your MySQL client.  In MySQL Workbench, you can do this by going to File -> Open SQL Script... and then clicking the "Execute" button.  In the MySQL command-line client, you can use the source command:

source /path/to/your/library_management.sql;

(Replace /path/to/your/library_management.sql with the actual path to your file.)

Verify the Setup:

After executing the script, you can verify that the tables have been created successfully by running the following SQL command:

SHOW TABLES;

This will display a list of the tables in the library_management_system database.

Once you have completed these steps, your database will be set up and ready to use. You can then populate the tables with data and begin using the system.


Screenshot or link to your ERD

The repo must include:
