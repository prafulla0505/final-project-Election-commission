-- Phase 2: Nomination and Setup of  Election Commission Project.

-- Phase 2 Goals:
-- Register candidates and assign them to political parties and constituencies.
-- Set up booths and assign officers.

-- Tables Used:

use  Electioncommission;
/*



-- Candidate (Candidate_ID, Name, Party_ID, Constituency_ID, Election_ID)
Political_Party(Party_ID, Party_Name, Leader_Name, Symbol)
Constituency(Constituency_ID, Name, State, Total_Voters)
Booth(Booth_ID, Location, Constituency_ID, Officer_ID)
Officer(Officer_ID, Name, Designation, Contact)
 A. Register 10 Candidates
Ensure Party_ID, Constituency_ID, and Election_ID match existing values in your database.
*/
CREATE TABLE Candidate (
    Candidate_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Party_ID INT,
    Constituency_ID INT,
    Election_ID INT
);
INSERT INTO Candidate (Candidate_ID, Name, Party_ID, Constituency_ID, Election_ID) VALUES
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

  -- Set Up 10 Booths and Assign Officers
-- Each booth is linked to a constituency and an assigned officer.

INSERT INTO Booth (Booth_ID, Location, Constituency_ID, Officer_ID) VALUES
(1, 'Unit-4 High School', 1, 201),
(2, 'Ravenshaw College Hall', 2, 202),
(3, 'Ispat School Auditorium', 3, 203),
(4, 'Sambalpur Zilla School', 4, 204),
(5, 'Puri Town Hall', 5, 205),
(6, 'Berhampur ITI Campus', 6, 206),
(7, 'Balasore Model School', 7, 207),
(8, 'Jharsuguda Engineering School', 8, 208),
(9, 'Kendrapara Govt College', 9, 209),
(10, 'Angul Tech College', 10, 210);
-- C. Verification Queries

-- View all candidates with party and constituency info:


SELECT c.Candidate_ID, c.Name AS Candidate_Name, p.Party_Name, cs.Name AS Constituency
FROM Candidate c
JOIN Political_Party p ON c.Party_ID = p.Party_ID
JOIN Constituency cs ON c.Constituency_ID = cs.Constituency_ID;

-- View all booths with assigned officers:

SELECT b.Booth_ID, b.Location, cs.Name AS Constituency, o.Name AS Officer_Name
FROM Booth b
JOIN Constituency cs ON b.Constituency_ID = cs.Constituency_ID
JOIN Officer o ON b.Officer_ID = o.Officer_ID;

-- GROUP BY Clause
-- Count of candidates per party:

SELECT Party_ID, COUNT(*) AS Total_Candidates
FROM Candidate
GROUP BY Party_ID;

-- 2. WHERE Clause
-- List of candidates from Constituency_ID greater than 5:

SELECT Candidate_ID, Name, Constituency_ID
FROM Candidate
WHERE Constituency_ID > 5;

-- 3. ORDER BY Clause
-- List of all candidates sorted by name (alphabetical):

SELECT Candidate_ID, Name, Party_ID, Constituency_ID
FROM Candidate
ORDER BY Name ASC;
-- 4. LIKE Clause
-- Find candidates whose names start with 'R':
SELECT Candidate_ID, Name
FROM Candidate
WHERE Name LIKE 'R%';

-- 5. GROUP BY + HAVING Clause
-- Show parties with more than 1 candidate (if any):
SELECT Party_ID, COUNT(*) AS Total_Candidates
FROM Candidate
GROUP BY Party_ID
HAVING COUNT(*) > 1;

 -- Party Table

CREATE TABLE Party (
    Party_ID INT PRIMARY KEY,
    Party_Name VARCHAR(100)
);
--  Constituency Table

CREATE TABLE Constituency (
    Constituency_ID INT PRIMARY KEY,
    Constituency_Name VARCHAR(100)
);


--  1. GROUP BY + JOIN: Count of Candidates per Party Name

SELECT P.Party_Name, COUNT(*) AS Total_Candidates
FROM Candidate C
JOIN Party P ON C.Party_ID = P.Party_ID
GROUP BY P.Party_Name;

