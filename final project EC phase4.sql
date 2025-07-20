-- --------Phase 4: Result Declaration (SQL Queries)
use  Electioncommission;

 SELECT 
    C.Candidate_ID,
    C.Name AS Candidate_Name,
    P.Party_Name,
    CN.Constituency_Name,
    COUNT(V.Vote_ID) AS Total_Votes
FROM Vote V
JOIN Candidate C ON V.Candidate_ID = C.Candidate_ID
JOIN Party P ON C.Party_ID = P.Party_ID
JOIN Constituency CN ON C.Constituency_ID = CN.Constituency_ID
GROUP BY C.Candidate_ID, C.Name, P.Party_Name, CN.Constituency_Name
ORDER BY CN.Constituency_Name, Total_Votes DESC;

-- Generate Reports by Phase (using Election table)
select*from Election;

   C.Candidate_ID,
  --  C.Name AS Candidate_Name,
    -- P.Party_Name,
    -- CN.Constituency_Name,
 --   COUNT(V.Vote_ID) AS Total_Votes
FROM Vote V
JOIN Candidate C ON V.Candidate_ID = C.Candidate_ID
JOIN Party P ON C.Party_ID = P.Party_ID
JOIN Constituency CN ON C.Constituency_ID = CN.Constituency_ID
GROUP BY C.Candidate_ID, C.Name, P.Party_Name, CN.Constituency_ID, CN.Constituency_Name
HAVING COUNT(V.Vote_ID) = (
    SELECT MAX(Vote_Count) FROM (
        SELECT COUNT(V1.Vote_ID) AS Vote_Count
        FROM Vote V1
        JOIN Candidate C1 ON V1.Candidate_ID = C1.Candidate_ID
        WHERE C1.Constituency_ID = C.Constituency_ID
        GROUP BY V1.Candidate_ID
    ) AS VoteCounts
)

ORDER BY CN.Constituency_Name;

--  3. 🧮 Generate Reports by Part
SELECT 
    P.Party_Name,
    COUNT(V.Vote_ID) AS Total_Votes
FROM Vote V
JOIN Candidate C ON V.Candidate_ID = C.Candidate_ID
JOIN Party P ON C.Party_ID = P.Party_ID
GROUP BY P.Party_Name
ORDER BY Total_Votes DESC;

-- 4.  Generate Reports by State (if state info exists)
-- If you have a State column in the Constituency table, for example:

ALTER TABLE Constituency ADD State_Name VARCHAR(100);

SELECT 
    CN.State_Name,
    COUNT(V.Vote_ID) AS Total_Votes
FROM Vote V
JOIN Candidate C ON V.Candidate_ID = C.Candidate_ID
JOIN Constituency CN ON C.Constituency_ID = CN.Constituency_ID
GROUP BY CN.State_Name
ORDER BY Total_Votes DESC;

-- 5. 📆 Generate Reports by Phase (using Election table)

SELECT 
    E.Phase,
    COUNT(V.Vote_ID) AS Total_Votes
FROM Vote V
JOIN Candidate C ON V.Candidate_ID = C.Candidate_ID
JOIN Election E ON C.Election_ID = E.Election_ID
GROUP BY E.Phase
ORDER BY E.Phase;
