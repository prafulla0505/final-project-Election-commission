-- Phase 3: Voting and Counting System in SQL
use  Electioncommission;

/*
We'll now simulate:

Casting votes – each vote is for a candidate in a booth (linked to a constituency).

Counting votes – get the number of votes per candidate per constituency.

 Step 1: Create Vote Table
*/
--  1. Casting Votes
-- Each vote is cast by a voter for a candidate at a booth (and the booth is linked to a constituency).
-- Step A: Vote Table Definition

CREATE TABLE Vote (
    Vote_ID INT PRIMARY KEY,
    Voter_ID INT,
    Candidate_ID INT,
    Booth_ID INT,
    Vote_Time DATETIME
);
drop table vote;
-- Candidate_ID refers to Candidate table
 -- Booth_ID refers to Booth table
 -- Voter_ID refers to Voter table

 -- Step B: Sample Vote Data Insertion

INSERT INTO Vote (Vote_ID, Voter_ID, Candidate_ID, Booth_ID, Vote_Time) VALUES
(1, 101, 1, 1, '2025-07-20 08:00:00'),
(2, 102, 2, 2, '2025-07-20 08:10:00'),
(3, 103, 3, 3, '2025-07-20 08:20:00'),
(4, 104, 1, 1, '2025-07-20 08:30:00'),
(5, 105, 2, 2, '2025-07-20 08:40:00'),
(6, 106, 3, 3, '2025-07-20 08:50:00'),
(7, 107, 4, 4, '2025-07-20 09:00:00'),
(8, 108, 1, 1, '2025-07-20 09:10:00'),
(9, 109, 5, 5, '2025-07-20 09:20:00'),
(10, 110, 1, 1, '2025-07-20 09:30:00');
-- 2. Counting Votes Per Candidate Per Constituency
-- This SQL query joins Vote, Candidate, and Constituency tables to get vote counts per candidate per constituency:
SELECT 
    C.Candidate_ID,
    C.Name AS Candidate_Name,
    CN.Constituency_Name,
    COUNT(V.Vote_ID) AS Total_Votes
FROM Vote V
JOIN Candidate C ON V.Candidate_ID = C.Candidate_ID
JOIN Constituency CN ON C.Constituency_ID = CN.Constituency_ID
GROUP BY C.Candidate_ID, C.Name, CN.Constituency_Name
ORDER BY CN.Constituency_Name, Total_Votes DESC;

-- Explanation:
-- JOINs Candidate and Constituency to get full details.

-- GROUP BY Candidate and Constituency.

-- COUNT gives the number of votes per candidate.

-- ORDER BY sorts by constituency and then highest votes.

-- Each vote is linked to a voter, candidate, and booth.
--  Step 2: Insert Sample Votes (10 for illustration)

INSERT INTO Vote (Vote_ID, Voter_ID, Candidate_ID, Booth_ID, Vote_Time) VALUES
(1, 101, 1, 1, '2025-07-20 09:00:00'),
(2, 102, 2, 2, '2025-07-20 09:15:00'),
(3, 103, 3, 3, '2025-07-20 09:20:00'),
(4, 104, 1, 1, '2025-07-20 09:25:00'),
(5, 105, 2, 2, '2025-07-20 09:30:00'),
(6, 106, 3, 3, '2025-07-20 09:45:00'),
(7, 107, 1, 1, '2025-07-20 10:00:00'),
(8, 108, 4, 4, '2025-07-20 10:10:00'),
(9, 109, 5, 5, '2025-07-20 10:20:00'),
(10, 110, 1, 1, '2025-07-20 10:30:00');

--  Step 3: Count Votes per Candidate per Constituency

SELECT 
    C.Candidate_ID,
    C.Name AS Candidate_Name,
    CN.Constituency_Name,
    COUNT(V.Vote_ID) AS Total_Votes
FROM Vote V
JOIN Candidate C ON V.Candidate_ID = C.Candidate_ID
JOIN Constituency CN ON C.Constituency_ID = CN.Constituency_ID
GROUP BY C.Candidate_ID, C.Name, CN.Constituency_Name
ORDER BY CN.Constituency_Name, Total_Votes DESC;

--  Output Explanation:
-- Groups votes by candidate and constituency.
-- Shows how many votes each candidate received in their constituency.
-- Orders by constituency and descending vote count.

-- Final Voting & Counting System (With Winners and Party Totals)
-- We’ll implement:

-- Winner per Constituency

-- Total Votes per Party

-- Vote Constraint: One Vote per Voter

-- ER Diagram Summary (textual)

-- 1. 🥇 Final Winner per Constituency
-- This query gets the top-voted candidate in each constituency:

SELECT 
    sub.Constituency_Name,
    sub.Candidate_Name,
    sub.Total_Votes
FROM (
    SELECT 
        CN.Constituency_Name,
        C.Name AS Candidate_Name,
        COUNT(V.Vote_ID) AS Total_Votes,
        RANK() OVER (PARTITION BY CN.Constituency_Name ORDER BY COUNT(V.Vote_ID) DESC) AS vote_rank
    FROM Vote V
    JOIN Candidate C ON V.Candidate_ID = C.Candidate_ID
    JOIN Constituency CN ON C.Constituency_ID = CN.Constituency_ID
    GROUP BY CN.Constituency_Name, C.Name
) sub
WHERE sub.vote_rank = 1;

--  Explanation:

-- Uses RANK() to find the top candidate(s) per constituency.

-- PARTITION BY breaks ranking by constituency.

-- 2. 🧮 Total Votes per Party
-- To count votes received by each party:
SELECT 
    P.Party_Name,
    COUNT(V.Vote_ID) AS Total_Votes
FROM Vote V
JOIN Candidate C ON V.Candidate_ID = C.Candidate_ID
JOIN Party P ON C.Party_ID = P.Party_ID
GROUP BY P.Party_Name
ORDER BY Total_Votes DESC;

--  3.  One Vote per Voter Constraint
-- To enforce 1 vote per voter, alter your Vote table:

ALTER TABLE Vote
ADD CONSTRAINT Unique_Voter UNIQUE (Voter_ID);

-- Prevents a voter from casting multiple votes.

/*
Voter(Voter_ID, Name, Age, Gender, Address)
Officer(Officer_ID, Name, Contact)
Party(Party_ID, Party_Name)
Constituency(Constituency_ID, Constituency_Name)
Booth(Booth_ID, Location, Constituency_ID, Officer_ID)
Candidate(Candidate_ID, Name, Party_ID, Constituency_ID, Election_ID)
Vote(Vote_ID, Voter_ID, Candidate_ID, Booth_ID, Vote_Time)
Election(Election_ID, Phase, Date)
🔗 Relationships:

Candidate → Party (many-to-one)

Candidate → Constituency (many-to-one)

Booth → Constituency (many-to-one)

Booth → Officer (many-to-one)

Vote → Candidate, Voter, Booth (many-to-one)

Election → Candidate (many-to-one)

*/
/*
Phase 4: Result Declaration & Reporting
This phase includes:

🏆 Declaring winners per constituency

🧮 Generating total party-wise results

📄 Creating reports/tables for final results

🔷 1. 🏆 Declare Winner per Constituency
We use RANK() to determine the candidate with the most votes in each constituency:
*/

-- Winners per constituency

-- Final Election Result Table + Insert Winners (Phase 4 Complete)
-- Step 1: Create the Election_Result Table

CREATE TABLE Election_Result (
    Result_ID INT PRIMARY KEY AUTO_INCREMENT,
    Election_ID INT,
    Constituency_Name VARCHAR(100),
    Candidate_Name VARCHAR(100),
    Party_Name VARCHAR(100),
    Total_Votes INT
);
DROP TABLE Election_Result ;
-- WE can also add Date_Declared, Status, etc., if needed.

-- Step 2: Insert Final Winners into Election_Result
-- This query inserts one winner per constituency (even if there’s a tie – both will be inserted):

INSERT INTO Election_Result (Election_ID, Constituency_Name, Candidate_Name, Party_Name, Total_Votes)
SELECT 
    1 AS Election_ID,result.Constituency_Name,result.Candidate_Name,result.Party_Name,result.Total_Votes
FROM (
    SELECT 
        CN.Constituency_Name,
        C.Name AS Candidate_Name,
        P.Party_Name,
        COUNT(V.Vote_ID) AS Total_Votes,
        RANK() OVER (PARTITION BY CN.Constituency_ID ORDER BY COUNT(V.Vote_ID) DESC) AS rank_in_constituency
    FROM Vote V
    JOIN Candidate C ON V.Candidate_ID = C.Candidate_ID
    JOIN Party P ON C.Party_ID = P.Party_ID
    JOIN Constituency CN ON C.Constituency_ID = CN.Constituency_ID
    GROUP BY CN.Constituency_ID, CN.Constituency_Name, C.Name, P.Party_Name
) AS result
 
-- 2. 🧮 Party-Wise Vote Summary
-- To see how many votes each party received across all constituencies:

SELECT 
    P.Party_Name,
    COUNT(V.Vote_ID) AS Total_Votes
FROM Vote V
JOIN Candidate C ON V.Candidate_ID = C.Candidate_ID
JOIN Party P ON C.Party_ID = P.Party_ID
GROUP BY P.Party_Name
ORDER BY Total_Votes DESC;

INSERT INTO Election_Result (Election_ID, Constituency_Name, Candidate_Name, Party_Name, Total_Votes)
SELECT 
    1 AS Election_ID,
    result.Constituency_Name,
    result.Candidate_Name,
    result.Party_Name,
    result.Total_Votes
FROM (
    SELECT 
        CN.Constituency_Name,
        C.Name AS Candidate_Name,
        P.Party_Name,
        COUNT(V.Vote_ID) AS Total_Votes,
        RANK() OVER (PARTITION BY CN.Constituency_Name ORDER BY COUNT(V.Vote_ID) DESC) AS rank_in_constituency
    FROM Vote V
    JOIN Candidate C ON V.Candidate_ID = C.Candidate_ID
    JOIN Party P ON C.Party_ID = P.Party_ID
    JOIN Constituency CN ON C.Constituency_ID = CN.Constituency_ID
    GROUP BY CN.Constituency_Name, C.Name, P.Party_Name
) AS result
WHERE result.rank_in_constituency = 1;
