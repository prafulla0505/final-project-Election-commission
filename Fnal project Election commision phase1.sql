-- database queries--------------
/*
Project Title:
Election Commission Management System

*/


/*
Introduction 

The Election Commission Management System is designed to streamline and digitalize electoral processes, ensuring transparent,
 fair, and efficient elections. The Election Commission is a constitutional authority responsible for conducting elections in
 democratic countries. This project simulates the real-time operations of election bodies by implementing database systems 
 to manage voter records, candidates, constituencies, political parties, polling booths, election results, and officials.
The system includes modules to register voters, manage nominations for candidates, store political party details,
 and track election phases across different constituencies. It allows administrators to manage election schedules, 
 polling booth arrangements, and deploy officers and staff to respective stations. After voting, it records votes, tallies results, and declares winners based on majority or constituency-specific criteria.
Our project is divided into four phases:

 SQL-based project on the Election Commission, covering:

1.Project Title

2.Introduction (250 words)

3.Entity-Relationship (ER) Diagram

4.Database Schema (10 Tables)

5.Sample SQL Code

6. 4 Phases of Execution

7.Insert Sample Data

The system includes modules to register voters, manage nominations for candidates, store political party details, and track election phases across different constituencies. It allows administrators to manage election schedules, polling booth arrangements, and deploy officers and staff to respective stations. After voting, it records votes, tallies results, and declares winners based on majority or constituency-specific criteria.

Our project is divided into four phases:

Data Collection

Nomination and Election Setup

Voting and Counting

Result Declaration and Reporting

This SQL project includes the complete database schema, sample queries for data manipulation, and reports for analyzing 
election trends.
 It helps election authorities automate tasks and ensures better data accuracy, security, and monitoring.
 With structured tables and relational integrity,
 the system supports a scalable and organized electoral data management environment.
 
 
Voter
Candidate
Constituency
Political Party
Election
Booth
Officer
Vote
Result
Phase
Database Schema (10 Tables)
Voter
Candidate
Constituency
Political_Party
Election
Booth
Officer
Vote
Result
Phase
*/

create database Electioncommission;
use  Electioncommission;


-- Voter Table
CREATE TABLE Voter (
    Voter_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    Gender VARCHAR(10),
    Address TEXT,
    Constituency_ID INT
);

INSERT INTO Voter VALUES
(101, 'Amit Roy', 34, 'Male', 'Bhubaneswar', 1),
(102, 'Sneha Das', 29, 'Female', 'Cuttack', 2),
(103, 'Rahul Sharma', 41, 'Male', 'Rourkela', 3),
(104, 'Pooja Mohanty', 36, 'Female', 'Sambalpur', 4),
(105, 'Sunil Sahu', 25, 'Male', 'Puri', 5),
(106, 'Rina Swain', 30, 'Female', 'Berhampur', 6),
(107, 'Manas Ranjan', 27, 'Male', 'Balasore', 7),
(108, 'Tanya Tripathy', 33, 'Female', 'Jharsuguda', 8),
(109, 'Debasis Behera', 45, 'Male', 'Kendrapara', 9),
(110, 'Shweta Panda', 31, 'Female', 'Angul', 10);

-- Candidate Table
CREATE TABLE Candidate (
    Candidate_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Party_ID INT,
    Constituency_ID INT,
    Election_ID INT
);
INSERT INTO Candidate VALUES
(1, 'Sunita Nayak', 1, 1, 1),
(2, 'Rajeev Sahu', 2, 2, 1),
(3, 'Anjali Panda', 3, 3, 1),
(4, 'Subham Das', 4, 4, 1),
(5, 'Rekha Mohanty', 5, 5, 1),
(6, 'Ajay Bhoi', 6, 6, 1),
(7, 'Prerna Behera', 7, 7, 1),
(8, 'Manoj Patnaik', 8, 8, 1),
(9, 'Rashmi Barik', 9, 9, 1),
(10, 'Ritik Kar', 10, 10, 1);

-- Constituency Table
CREATE TABLE Constituency (
    Constituency_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    State VARCHAR(100),
    Total_Voters INT
);
INSERT INTO Constituency VALUES
(1, 'Bhubaneswar', 'Odisha', 500000),
(2, 'Cuttack', 'Odisha', 480000),
(3, 'Rourkela', 'Odisha', 450000),
(4, 'Sambalpur', 'Odisha', 300000),
(5, 'Puri', 'Odisha', 275000),
(6, 'Berhampur', 'Odisha', 320000),
(7, 'Balasore', 'Odisha', 290000),
(8, 'Jharsuguda', 'Odisha', 210000),
(9, 'Kendrapara', 'Odisha', 250000),
(10, 'Angul', 'Odisha', 260000);


-- Political Party Table
CREATE TABLE Political_Party (
    Party_ID INT PRIMARY KEY,
    Party_Name VARCHAR(100),
    Leader_Name VARCHAR(100),
    Symbol VARCHAR(50)
);
INSERT INTO Political_Party VALUES
(1, 'People Party', 'Rahul Das', 'Hand'),
(2, 'National Front', 'Meera Patil', 'Lotus'),
(3, 'Unity Party', 'Anil Soren', 'Star'),
(4, 'Progressive Union', 'Fatima Khan', 'Sun'),
(5, 'Democratic Voice', 'Karan Singh', 'Tree'),
(6, 'Jan Shakti', 'Pooja Yadav', 'Circle'),
(7, 'New Hope', 'Sanjay Pillai', 'Torch'),
(8, 'Rural Power', 'Binod Nayak', 'Tractor'),
(9, 'Modern Alliance', 'Devika Rao', 'Book'),
(10, 'Future Party', 'Neelima Verma', 'Globe');


-- Election Table
CREATE TABLE Election (
    Election_ID INT PRIMARY KEY,
    Election_Name VARCHAR(100),
    Year INT,
    Phase_ID INT
);
INSERT INTO Election VALUES
(1, 'Odisha Assembly Election', 2024, 1),
(2, 'Lok Sabha Election', 2024, 1),
(3, 'Municipal Election', 2025, 2),
(4, 'By-Election Cuttack', 2025, 3),
(5, 'Rajya Sabha Election', 2025, 4),
(6, 'Odisha Assembly Election', 2019, 1),
(7, 'Panchayat Election', 2023, 2),
(8, 'By-Election Rourkela', 2025, 3),
(9, 'State Legislative Election', 2025, 2),
(10, 'Ward No. 12 Election', 2025, 4);


-- Booth Table
CREATE TABLE Booth (
    Booth_ID INT PRIMARY KEY,
    Location VARCHAR(150),
    Constituency_ID INT,
    Officer_ID INT
);
INSERT INTO Booth VALUES
(1, 'Unit-4 School', 1, 1),
(2, 'Ravenshaw College', 2, 2),
(3, 'Ispat School', 3, 3),
(4, 'Town Hall', 4, 4),
(5, 'Model School', 5, 5),
(6, 'Govt ITI', 6, 6),
(7, 'Town High School', 7, 7),
(8, 'Zilla School', 8, 8),
(9, 'Municipal High School', 9, 9),
(10, 'Tech College', 10, 10);


-- Officer Table
CREATE TABLE Officer (
    Officer_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Designation VARCHAR(50),
    Contact VARCHAR(15)
);
INSERT INTO Officer VALUES
(1, 'Ramesh Rao', 'Presiding Officer', '9876543210'),
(2, 'Nikita Jena', 'Returning Officer', '8765432190'),
(3, 'Anup Sen', 'Polling Officer', '7654321890'),
(4, 'Divya Satpathy', 'Supervisor', '6543219870'),
(5, 'Ravi Das', 'Security In-charge', '5432198760'),
(6, 'Tanmay Rout', 'IT Officer', '4321987650'),
(7, 'Pallavi Nair', 'Observer', '3219876540'),
(8, 'Amit Tiwari', 'Counting Officer', '2198765430'),
(9, 'Kiran Mehta', 'Logistics Head', '1987654321'),
(10, 'Sunita Pati', 'Booth Manager', '9876541230');

-- Vote Table
CREATE TABLE Vote (
    Vote_ID INT PRIMARY KEY,
    Voter_ID INT,
    Candidate_ID INT,
    Booth_ID INT
);
INSERT INTO Vote VALUES
(1, 101, 1, 1),
(2, 102, 2, 2),
(3, 103, 3, 3),
(4, 104, 4, 4),
(5, 105, 5, 5),
(6, 106, 6, 6),
(7, 107, 7, 7),
(8, 108, 8, 8),
(9, 109, 9, 9),
(10, 110, 10, 10);

-- Result Table
CREATE TABLE Result (
    Result_ID INT PRIMARY KEY,
    Candidate_ID INT,
    Constituency_ID INT,
    Total_Votes INT
);
INSERT INTO Result VALUES
(1, 1, 1, 325480),
(2, 2, 2, 300250),
(3, 3, 3, 290000),
(4, 4, 4, 180000),
(5, 5, 5, 175000),
(6, 6, 6, 185000),
(7, 7, 7, 190000),
(8, 8, 8, 120000),
(9, 9, 9, 150000),
(10, 10, 10, 160000);

-- Phase Table
CREATE TABLE Phase (
    Phase_ID INT PRIMARY KEY,
    Phase_Name VARCHAR(100),
    Start_Date DATE,
    End_Date DATE
);

INSERT INTO Phase VALUES
(1, 'Phase 1', '2024-04-01', '2024-04-10'),
(2, 'Phase 2', '2024-04-11', '2024-04-20'),
(3, 'Phase 3', '2024-04-21', '2024-04-30'),
(4, 'Phase 4', '2024-05-01', '2024-05-10'),
(5, 'Re-Election Phase', '2024-05-15', '2024-05-20'),
(6, 'Counting Phase', '2024-05-21', '2024-05-25'),
(7, 'Announcement Phase', '2024-05-26', '2024-05-30'),
(8, 'Preparation Phase', '2024-03-01', '2024-03-10'),
(9, 'Training Phase', '2024-03-11', '2024-03-20'),
(10, 'Logistics Phase', '2024-03-21', '2024-03-31');
/*
-- Phases of Execution
Phase 1: Data Collection
Register voters and officers

Add constituencies and parties

Phase 2: Nomination and Setup
Register candidates and assign them to parties/constituencies

Set up booths and assign officers

Phase 3: Voting and Counting
Cast votes in the system

Count votes per candidate per constituency

Phase 4: Result Declaration
Display candidate-wise result

Announce winners per constituency

Generate reports by party, state, or phase

Phase 1: Data Collection
Register voters and officers

Phase 1 Objective:
Register voters and officers into the database.
 Required Tables:

Voter
Officer
We’ll cover:
SQL INSERT statements for registering 10 voters and 10 officers
SELECT queries to verify successful registration
Optional queries to fetch registered data per constituency or designation
View all registered voters:
*/

SELECT * FROM Voter;

-- Count total number of voters:

SELECT COUNT(*) AS Total_Voters FROM Voter;

-- Group voters by constituency:
SELECT Constituency_ID, COUNT(*) AS Voters_Per_Constituency
FROM Voter
GROUP BY Constituency_ID;

-- List female voters only:
SELECT * FROM Voter
WHERE Gender = 'Female';

-- Find voters above age 40:

SELECT * FROM Voter
WHERE Age > 40;

-- B. Verify Officer Registration
-- View all registered officers:

SELECT * FROM Officer;

-- Count total number of officers:
SELECT COUNT(*) AS Total_Officers FROM Officer;

-- Group officers by designation:
SELECT Designation, COUNT(*) AS Officers_Per_Designation
FROM Officer
GROUP BY Designation;

-- Show officers with mobile numbers starting with ‘98’:

SELECT * FROM Officer
WHERE Contact LIKE '98%';

-- List officers whose designation contains the word 'Officer':

SELECT * FROM Officer
WHERE Designation LIKE '%Officer%';
