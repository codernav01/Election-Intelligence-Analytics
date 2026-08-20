/*=====================================================================
                    PART 9 : DATABASE SETUP
=======================================================================
Project  : Decoding the 2026 Tamil Nadu Assembly Election
Database : election_intelligence_analytics
Module   : Database Initialization
=======================================================================

OBJECTIVE

Create the project database required for storing
the cleaned Tamil Nadu Assembly Election datasets.

The tables will be automatically created during
the CSV import process using MySQL Workbench.
=====================================================================*/

# STEP 1 : Create Database
CREATE DATABASE election_intelligence_analytics;

# STEP 2 : Use Database
USE election_intelligence_analytics;

# STEP 3 : Verify Active Database
SELECT DATABASE();

/*=====================================================================
                    PART 10 : DATA IMPORT & INITIAL VALIDATION
=======================================================================

Project  : Decoding the 2026 Tamil Nadu Assembly Election
Database : election_intelligence_analytics
Module   : CSV Import & Data Verification

=======================================================================
OBJECTIVE

Import all cleaned datasets using
MySQL Workbench → Table Data Import Wizard.

The tables will be created automatically during import.

Datasets

1. constituency_master_clean.csv
2. election_2021_clean.csv
3. election_2026_clean.csv
=====================================================================*/

# STEP 1 : Verify Imported Tables
SHOW TABLES;

# STEP 2 : Verify Constituency Master Dataset

SELECT COUNT(*) AS total_rows
FROM constituency_master_clean;

# STEP 3 : Verify Election 2021 Dataset
SELECT COUNT(*) AS total_rows
FROM election_2021_clean;

SELECT DISTINCT election_year
FROM election_2021_clean;

# STEP 4 : Verify Election 2026 Dataset
SELECT COUNT(*) AS total_rows
FROM election_2026_clean;

SELECT DISTINCT election_year
FROM election_2026_clean;

# STEP 5 : Final Import Summary
SELECT COUNT(*) AS constituency_master
FROM constituency_master_clean;

SELECT COUNT(*) AS election_2021
FROM election_2021_clean;

SELECT COUNT(*) AS election_2026
FROM election_2026_clean;

/*=====================================================================
PART 10 COMPLETED

✓ Database Created Successfully
✓ Three Datasets Imported Successfully
✓ Initial Validation Completed

Database is Ready for SQL Data Validation (Part 11)
=====================================================================*/

/*=====================================================================
                    PART 11 : SQL DATA VALIDATION
=======================================================================
Project  : Decoding the 2026 Tamil Nadu Assembly Election
Database : election_intelligence_analytics
Module   : SQL Data Validation

=======================================================================

OBJECTIVE

Validate all imported datasets before starting
business analytics.

This phase verifies that the cleaned datasets are
complete, consistent, accurate and analytics-ready.

=======================================================================
VALIDATION CHECKS

✓ Row Count Validation
✓ NULL Value Validation
✓ Duplicate Record Validation
✓ Constituency Coverage Validation
✓ Referential Integrity Validation
✓ Vote Value Validation
✓ Turnout Validation
✓ Reservation Category Validation
✓ Region Validation
✓ Election Year Validation
=====================================================================*/

# STEP 1 : Select Database
USE election_intelligence_analytics;

# STEP 2 : Row Count Validation

SELECT'constituency_master_clean' AS dataset,
COUNT(*) AS total_records
FROM constituency_master_clean
UNION ALL
SELECT'election_2021_clean',
COUNT(*)FROM election_2021_clean
UNION ALL
SELECT'election_2026_clean',
COUNT(*)FROM election_2026_clean;

# STEP 3 : NULL Value Validation
SELECT
    SUM(ac_number IS NULL) AS ac_number_null,
    SUM(constituency IS NULL) AS constituency_null,
    SUM(district IS NULL) AS district_null,
    SUM(region IS NULL) AS region_null,
    SUM(reserved IS NULL) AS reserved_null
FROM constituency_master_clean;

SELECT
    SUM(ac_number IS NULL) AS ac_number_null,
    SUM(constituency IS NULL) AS constituency_null,
    SUM(candidate IS NULL) AS candidate_null,
    SUM(party IS NULL) AS party_null,
    SUM(votes IS NULL) AS votes_null,
    SUM(turnout IS NULL) AS turnout_null
FROM election_2021_clean;

SELECT
    SUM(ac_number IS NULL) AS ac_number_null,
    SUM(constituency IS NULL) AS constituency_null,
    SUM(candidate IS NULL) AS candidate_null,
    SUM(party IS NULL) AS party_null,
    SUM(votes IS NULL) AS votes_null,
    SUM(turnout IS NULL) AS turnout_null
FROM election_2026_clean;

# STEP 4 : Duplicate Record Validation
SELECT
    ac_number,
    COUNT(*) AS duplicate_count
FROM constituency_master_clean
GROUP BY ac_number
HAVING COUNT(*) > 1;

SELECT ac_number,candidate,party,
COUNT(*) AS duplicate_count
FROM election_2021_clean
GROUP BY ac_number,candidate,party
HAVING COUNT(*) > 1;

SELECT ac_number,candidate,party,
COUNT(*) AS duplicate_count
FROM election_2026_clean
GROUP BY ac_number,candidate,party
HAVING COUNT(*) > 1;

# STEP 5 : Constituency Coverage Validation
SELECT COUNT(DISTINCT ac_number) AS total_constituencies
FROM constituency_master_clean;

SELECT COUNT(DISTINCT ac_number) AS total_constituencies
FROM election_2021_clean;

SELECT COUNT(DISTINCT ac_number) AS total_constituencies
FROM election_2026_clean;

# STEP 6 : Referential Integrity Validation
SELECT e.ac_number,e.constituency
FROM election_2021_clean e
LEFT JOIN constituency_master_clean c
ON e.ac_number = c.ac_number
WHERE c.ac_number IS NULL;

SELECT e.ac_number,e.constituency
FROM election_2026_clean e
LEFT JOIN constituency_master_clean c
ON e.ac_number = c.ac_number
WHERE c.ac_number IS NULL;

# STEP 7 : Vote Value Validation
SELECT * FROM election_2021_clean
WHERE votes < 0;

SELECT * FROM election_2026_clean
WHERE votes < 0;

# STEP 8 : Turnout Validation
SELECT
    MIN(turnout) AS minimum_turnout,
    MAX(turnout) AS maximum_turnout
FROM election_2021_clean;

SELECT
    MIN(turnout) AS minimum_turnout,
    MAX(turnout) AS maximum_turnout
FROM election_2026_clean;

# STEP 9 : Reservation Category Validation
SELECT reserved,
COUNT(*) AS total_constituencies
FROM constituency_master_clean
GROUP BY reserved
ORDER BY reserved;

# STEP 10 : Region Validation
SELECT region,
COUNT(*) AS total_constituencies
FROM constituency_master_clean
GROUP BY region
ORDER BY region;

# STEP 11 : Election Year Validation
SELECT election_year,
COUNT(*) AS total_records
FROM election_2021_clean
GROUP BY election_year;

SELECT election_year,
COUNT(*) AS total_records
FROM election_2026_clean
GROUP BY election_year;

# STEP 12 : Final Validation Summary
SELECT
    (SELECT COUNT(*) FROM constituency_master_clean) AS master_records,
    (SELECT COUNT(*) FROM election_2021_clean) AS election_2021_records,
    (SELECT COUNT(*) FROM election_2026_clean) AS election_2026_records,
    (SELECT COUNT(DISTINCT ac_number) FROM constituency_master_clean) AS master_constituencies,
    (SELECT COUNT(DISTINCT ac_number) FROM election_2021_clean) AS election2021_constituencies,
    (SELECT COUNT(DISTINCT ac_number) FROM election_2026_clean) AS election2026_constituencies;

/*=====================================================================
PART 11 COMPLETED
✓ Row Count Verified
✓ NULL Values Verified
✓ Duplicate Records Verified
✓ Constituency Coverage Verified
✓ Referential Integrity Verified
✓ Vote Values Verified
✓ Turnout Verified
✓ Reservation Categories Verified
✓ Regions Verified
✓ Election Year Verified

Database Status
READY FOR SQL ANALYTICS
Next Module
PART 12 : SQL ANALYTICS LAYER

=====================================================================*/

/*=====================================================================
                    PART 12 : SQL ANALYTICS LAYER
=======================================================================
Project  : Decoding the 2026 Tamil Nadu Assembly Election
Database : election_intelligence_analytics
Module   : SQL Analytics Layer
=======================================================================

OBJECTIVE

Create reusable analytical views that simplify
business reporting, dashboard development and
advanced SQL analytics.

These views act as the semantic layer between
the cleaned datasets and reporting tools.

=======================================================================
VIEWS CREATED

✓ Winner View (2021)
✓ Winner View (2026)
✓ Runner-up View (2021)
✓ Runner-up View (2026)
✓ Party Summary View
✓ Region Summary View

=====================================================================*/

# STEP 1 : Winner View (2021)
CREATE OR REPLACE VIEW vw_winner_2021 AS
SELECT constituency,ac_number,candidate,party,votes,turnout,vote_percentage
FROM(SELECT*,ROW_NUMBER() 
OVER(PARTITION BY ac_number ORDER BY votes DESC) AS vote_rank
FROM election_2021_clean) ranked
WHERE vote_rank = 1;

# STEP 2 : Winner View (2026)
CREATE OR REPLACE VIEW vw_winner_2026 AS

SELECT constituency,ac_number,candidate,party,votes,turnout,vote_percentage
FROM(SELECT*,ROW_NUMBER() 
OVER(PARTITION BY ac_number ORDER BY votes DESC) AS vote_rank
FROM election_2026_clean) ranked
WHERE vote_rank = 1;

# STEP 3 : Runner-up View (2021)
CREATE OR REPLACE VIEW vw_runnerup_2021 AS

SELECT constituency,ac_number,candidate,
party,votes,vote_percentage
FROM(SELECT*,ROW_NUMBER() 
OVER(PARTITION BY ac_number
ORDER BY votes DESC) AS vote_rank FROM election_2021_clean) ranked
WHERE vote_rank = 2;

# STEP 4 : Runner-up View (2026)
CREATE OR REPLACE VIEW vw_runnerup_2026 AS

SELECT constituency,ac_number,candidate,party,votes,vote_percentage
FROM(SELECT*,ROW_NUMBER() 
OVER(PARTITION BY ac_number ORDER BY votes DESC) AS vote_rank 
FROM election_2026_clean) ranked
WHERE vote_rank = 2;

# STEP 5 : Party Summary View
CREATE OR REPLACE VIEW vw_party_summary AS
SELECT party,
    COUNT(*) AS total_candidates,
    SUM(votes) AS total_votes,
    ROUND(AVG(votes),2) AS average_votes,
    ROUND(AVG(vote_percentage),2) AS average_vote_percentage
FROM election_2026_clean
GROUP BY party;

# STEP 6 : Region Summary View
CREATE OR REPLACE VIEW vw_region_summary AS
SELECT c.region,
    COUNT(DISTINCT e.ac_number) AS total_constituencies,
    COUNT(*) AS total_candidates,
    SUM(e.votes) AS total_votes,
    ROUND(AVG(e.vote_percentage),2) AS average_vote_percentage
FROM election_2026_clean e
INNER JOIN constituency_master_clean c
ON e.ac_number = c.ac_number
GROUP BY c.region;

/*=====================================================================
PART 12A COMPLETED:- 

✓ Winner View (2021) Created
✓ Winner View (2026) Created
✓ Runner-up View (2021) Created
✓ Runner-up View (2026) Created
✓ Party Summary View Created
✓ Region Summary View Created

Next Module
PART 12B

Reserved Summary View
Constituency Summary View
Vote Share Summary View
Winning Margin Summary View
Analytics Layer Validation
=====================================================================*/

# STEP 7 : Reserved Category Summary View
CREATE OR REPLACE VIEW vw_reserved_summary AS
SELECT c.reserved,
    COUNT(DISTINCT e.ac_number) AS total_constituencies,
    COUNT(*) AS total_candidates,
    SUM(e.votes) AS total_votes,
    ROUND(AVG(e.vote_percentage),2) AS average_vote_percentage
FROM election_2026_clean e
INNER JOIN constituency_master_clean c
ON e.ac_number = c.ac_number
GROUP BY c.reserved;

# STEP 8 : Constituency Summary View
CREATE OR REPLACE VIEW vw_constituency_summary AS
SELECT ac_number,constituency,
    COUNT(*) AS total_candidates,
    SUM(votes) AS total_votes,
    MAX(votes) AS highest_votes,
    MIN(votes) AS lowest_votes,
    ROUND(AVG(vote_percentage),2) AS average_vote_percentage
FROM election_2026_clean
GROUP BY ac_number,constituency;

# STEP 9 : Party Vote Share Summary View
CREATE OR REPLACE VIEW vw_vote_share_summary AS
SELECT party,
    SUM(votes) AS total_votes,
    ROUND(SUM(votes) * 100 /(SELECT SUM(votes)
FROM election_2026_clean),2) AS vote_share_percentage
FROM election_2026_clean
GROUP BY party;

# STEP 10 : Winning Margin Summary View
CREATE OR REPLACE VIEW vw_margin_summary AS
SELECT w.ac_number,
    w.constituency,
    w.party AS winning_party,
    w.candidate AS winning_candidate,
    w.votes AS winner_votes,
    r.votes AS runnerup_votes,
    (w.votes - r.votes) AS winning_margin
FROM vw_winner_2026 w
INNER JOIN vw_runnerup_2026 r
ON w.ac_number = r.ac_number;

# STEP 11 : Analytics Layer Validation
SHOW FULL TABLES
WHERE Table_type = 'VIEW';


SELECT * FROM vw_winner_2021
LIMIT 10;

SELECT * FROM vw_winner_2026
LIMIT 10;

SELECT * FROM vw_runnerup_2021
LIMIT 10;

SELECT * FROM vw_runnerup_2026
LIMIT 10;

SELECT * FROM vw_party_summary
ORDER BY total_votes DESC;

SELECT * FROM vw_region_summary
ORDER BY total_votes DESC;

SELECT * FROM vw_reserved_summary
ORDER BY total_votes DESC;

SELECT * FROM vw_constituency_summary
LIMIT 10;

SELECT * FROM vw_vote_share_summary
ORDER BY vote_share_percentage DESC;

SELECT * FROM vw_margin_summary
ORDER BY winning_margin DESC
LIMIT 10;

# STEP 12 : Final Analytics Layer Summary
SELECT
    (SELECT COUNT(*) FROM vw_winner_2021) AS winner_view_2021,
    (SELECT COUNT(*) FROM vw_winner_2026) AS winner_view_2026,
    (SELECT COUNT(*) FROM vw_runnerup_2021) AS runnerup_view_2021,
    (SELECT COUNT(*) FROM vw_runnerup_2026) AS runnerup_view_2026,
    (SELECT COUNT(*) FROM vw_party_summary) AS party_summary,
    (SELECT COUNT(*) FROM vw_region_summary) AS region_summary,
    (SELECT COUNT(*) FROM vw_reserved_summary) AS reserved_summary,
    (SELECT COUNT(*) FROM vw_constituency_summary) AS constituency_summary,
    (SELECT COUNT(*) FROM vw_vote_share_summary) AS vote_share_summary,
    (SELECT COUNT(*) FROM vw_margin_summary) AS margin_summary;

/*=====================================================================
PART 12 COMPLETED

✓ Winner Views Created
✓ Runner-up Views Created
✓ Party Summary View Created
✓ Region Summary View Created
✓ Reserved Category Summary View Created
✓ Constituency Summary View Created
✓ Vote Share Summary View Created
✓ Winning Margin Summary View Created
✓ Analytics Layer Validated

Database Status
READY FOR ADVANCED SQL ANALYTICS

Next Module
PART 13 : ADVANCED SQL ANALYTICS

=====================================================================*/

/*=====================================================================
                    PART 13 : ADVANCED SQL ANALYTICS
=======================================================================
Project  : Decoding the 2026 Tamil Nadu Assembly Election

Database : election_intelligence_analytics

Module   : Advanced SQL Analytics

=======================================================================

OBJECTIVE

Apply advanced SQL analytical techniques to the cleaned
election datasets.

This module demonstrates modern SQL features commonly
used by Data Analysts, BI Developers and Analytics
Engineers.

The objective is to showcase advanced SQL capabilities
before moving to business-focused research analytics.

=======================================================================
TOPICS COVERED
✓ Window Functions
    • ROW_NUMBER()
    • RANK()
    • DENSE_RANK()
    • LAG()
    • LEAD()
    • NTILE()
    • PERCENT_RANK()
    • CUME_DIST()
✓ CASE Expressions
✓ Common Table Expressions (CTEs)
✓ Aggregate Analysis
✓ Correlated Subqueries
✓ Scalar Subqueries
✓ Multi-row Subqueries
✓ Analytical Summary

=====================================================================*/

# STEP 1 : ROW_NUMBER()
# Assign a unique sequential rank to every candidate within each constituency based on votes received.

SELECT constituency,ac_number,candidate,party,votes,
ROW_NUMBER()
OVER(PARTITION BY ac_number ORDER BY votes DESC) AS candidate_row_number
FROM election_2026_clean;

# STEP 2 : RANK()
# If two candidates receive the same number of votes, the next rank is skipped.

SELECT constituency,ac_number,candidate,party,votes,
RANK()OVER(PARTITION BY ac_number ORDER BY votes DESC) AS candidate_rank
FROM election_2026_clean;

# STEP 3 : DENSE_RANK()
# Assign ranking without skipping numbers.Useful for leaderboard style reporting.

SELECT constituency,
ac_number,candidate,party,votes,
DENSE_RANK()
OVER(PARTITION BY ac_number ORDER BY votes DESC) AS candidate_dense_rank
FROM election_2026_clean;

# STEP 4 : LAG()
# Compare every candidate with the previous ranked candidate within the same constituency.Useful for vote comparison analysis.

SELECT constituency,ac_number,candidate,party,votes,LAG(votes)
OVER(PARTITION BY ac_number ORDER BY votes DESC) AS previous_candidate_votes,votes -LAG(votes)
OVER(PARTITION BY ac_number ORDER BY votes DESC) AS vote_difference
FROM election_2026_clean;

# STEP 5 : LEAD()
# Compare each candidate with the next ranked candidate within the same constituency.Useful for analysing competition between candidates.

SELECT constituency,ac_number,candidate,party,
votes,LEAD(votes)
OVER(PARTITION BY ac_number ORDER BY votes DESC) AS next_candidate_votes,LEAD(candidate)
OVER(PARTITION BY ac_number ORDER BY votes DESC) AS next_candidate
FROM election_2026_clean;

# STEP 6 : NTILE()
# Divide candidates into four performance groups based on votes received.

# Quartile 1 = Highest Performing Candidates
# Quartile 4 = Lowest Performing Candidates
SELECT constituency,ac_number,candidate,party,votes,
NTILE(4)
OVER(PARTITION BY ac_number ORDER BY votes DESC) AS performance_quartile
FROM election_2026_clean;

# STEP 7 : PERCENT_RANK()
# Calculate each candidate's relative ranking within the constituency.
# Value ranges from 0 to 1. Higher values indicate lower ranking.

SELECT constituency,ac_number,candidate,party,votes,
ROUND(PERCENT_RANK()
OVER(PARTITION BY ac_number ORDER BY votes DESC),4) AS P_Rank
FROM election_2026_clean;

# STEP 8 : CUME_DIST()
# Calculate cumulative distribution of candidates within every constituency.Useful for percentile-based reporting.

SELECT constituency,
ac_number,candidate,party,votes,
ROUND(CUME_DIST()
OVER(PARTITION BY ac_number ORDER BY votes DESC),4) AS cumulative_distribution
FROM election_2026_clean;

# STEP 9 : CASE Statement
# Categorize candidates into vote-performance groups based on the total votes received.
# Useful for executive reporting and dashboard segmentation.

SELECT constituency,ac_number,candidate,party,votes,
CASE
	WHEN votes >= 100000 THEN 'Very High'
	WHEN votes >= 75000 THEN 'High'
	WHEN votes >= 50000 THEN 'Medium'
	ELSE 'Low'END AS vote_category FROM election_2026_clean ORDER BY votes DESC;

# STEP 10 : Common Table Expression (CTE)
# Identify the Top 3 candidates from every constituency. 
# This demonstrates the use of CTE together with ROW_NUMBER() for reusable analytical queries.

WITH ranked_candidates AS
(SELECT constituency,ac_number,candidate,party,votes,vote_percentage,ROW_NUMBER()
OVER(PARTITION BY ac_number ORDER BY votes DESC) AS candidate_rank FROM election_2026_clean)
SELECT constituency,ac_number,candidate,party,votes,vote_percentage,candidate_rank
FROM ranked_candidates
WHERE candidate_rank <= 3
ORDER BY ac_number,candidate_rank;

# STEP 11 : Aggregate Analysis
# Summarize party-wise election performance. Useful for executive dashboards and business reporting.

SELECT party,
	COUNT(*) AS total_candidates,
    SUM(votes) AS total_votes,
    ROUND(AVG(votes),2) AS average_votes,
    MIN(votes) AS minimum_votes,
    MAX(votes) AS maximum_votes,
    ROUND(AVG(vote_percentage),2) AS average_vote_percentage
FROM election_2026_clean
GROUP BY party
ORDER BY total_votes DESC;

# STEP 12 : Correlated Subquery
# Identify candidates who received more votes than the average candidate within the same constituency.
# Useful for identifying above-average performers.

SELECT e.constituency,e.ac_number,e.candidate,e.party,e.votes
FROM election_2026_clean e
JOIN(SELECT ac_number,AVG(votes) AS avg_votes FROM election_2026_clean
GROUP BY ac_number) avg_votes_table
ON e.ac_number = avg_votes_table.ac_number WHERE e.votes > avg_votes_table.avg_votes
ORDER BY e.constituency,e.votes DESC;

# STEP 13 : Scalar Subquery
# Identify candidate(s) receiving the highest number of votes across the entire election.
# Useful for identifying the overall best performer.

SELECT constituency,candidate,party,votes
FROM election_2026_clean
WHERE votes = (SELECT MAX(votes)FROM election_2026_clean);

# STEP 14 : Multi-row Subquery
# Retrieve all candidates from constituencies where DMK secured the winning position.
# This demonstrates the use of IN with a subquery.

SELECT constituency,ac_number,candidate,party,votes
FROM election_2026_clean
WHERE ac_number IN
(SELECT ac_number FROM vw_winner_2026 WHERE party = 'DMK')
ORDER BY constituency,votes DESC;

# STEP 15 : Analytical Summary
# Generate a high-level statistical summary of the 2026 election dataset.
# Useful for validating dataset completeness before business reporting.

SELECT
    COUNT(DISTINCT ac_number) AS total_constituencies,
    COUNT(DISTINCT party) AS total_parties,
    COUNT(DISTINCT candidate) AS total_candidates,
    COUNT(*) AS total_records,
    SUM(votes) AS total_votes,
    ROUND(AVG(votes),2) AS average_votes,
    MAX(votes) AS highest_votes,
    MIN(votes) AS lowest_votes,
    ROUND(AVG(vote_percentage),2) AS average_vote_percentage
FROM election_2026_clean;

/*=====================================================================
PART 13 COMPLETED
✓ Window Functions Demonstrated
    • ROW_NUMBER()
    • RANK()
    • DENSE_RANK()
    • LAG()
    • LEAD()
    • NTILE()
    • PERCENT_RANK()
    • CUME_DIST()
✓ CASE Expression Demonstrated
✓ Common Table Expression (CTE) Demonstrated
✓ Aggregate Analysis Completed
✓ Correlated Subquery Demonstrated
✓ Scalar Subquery Demonstrated
✓ Multi-row Subquery Demonstrated
✓ Analytical Summary Generated

-----------------------------------------------------------------------
Database Status
ADVANCED SQL ANALYTICS COMPLETED SUCCESSFULLY

Ready For
PART 14 : RESEARCH QUESTION ANALYTICS
=====================================================================*/

/*=====================================================================
                    PART 14 : RESEARCH QUESTION ANALYTICS
=======================================================================
Project  : Decoding the 2026 Tamil Nadu Assembly Election

Database : election_intelligence_analytics
Module   : Research Question Analytics
=======================================================================

OBJECTIVE

Answer the selected business research questions
using the reusable SQL Analytics Layer.

This module transforms analytical results into
business-focused insights by exploring the key
election stories identified during the project.

The analysis focuses on connected research stories
rather than isolated reports, providing a structured
understanding of electoral performance and political
trends.
=======================================================================
RESEARCH STORIES

✓ Story 1 : Geographic Story
✓ Story 2 : Flip Story
✓ Story 3 : Vote Share Story

=======================================================================
EXPECTED OUTCOME

Business-ready analytical insights suitable for

✓ Executive Reporting
✓ Power BI Dashboard Development
✓ Data Storytelling
✓ Decision Support
=====================================================================*/

/*---------------------------------------------------------------
RESEARCH STORY 1 : GEOGRAPHIC STORY

Objective

Analyse seat distribution across the six editorial
regions and identify the dominant political party
within each region.
---------------------------------------------------------------*/

# STEP 1 : Region-wise Seat Distribution (2021)
SELECT cm.region,w.party,
COUNT(*) AS seats_won
FROM vw_winner_2021 w
INNER JOIN constituency_master_clean cm
ON w.ac_number = cm.ac_number
GROUP BY cm.region, w.party
ORDER BY cm.region,seats_won DESC;

# STEP 2 : Region-wise Seat Distribution (2026)
SELECT cm.region,w.party,
COUNT(*) AS seats_won
FROM vw_winner_2026 w
INNER JOIN constituency_master_clean cm
ON w.ac_number = cm.ac_number
GROUP BY cm.region,w.party
ORDER BY cm.region,seats_won DESC;

# STEP 3 : Region-wise Vote Performance
SELECT cm.region,e.party,
SUM(e.votes) AS total_votes,
ROUND(AVG(e.vote_percentage),2) AS average_vote_percentage
FROM election_2026_clean e
INNER JOIN constituency_master_clean cm
ON e.ac_number = cm.ac_number
GROUP BY cm.region,e.party
ORDER BY cm.region, total_votes DESC;

/*---------------------------------------------------------------
BUSINESS INSIGHT

This analysis identifies:
✓ Regional political dominance
✓ Party performance across regions
✓ Regional vote concentration

These insights explain how geography influenced
the overall election outcome.
---------------------------------------------------------------*/

/*---------------------------------------------------------------
RESEARCH STORY 2 : FLIP STORY

Objective

Identify constituencies that changed their winning
political party between 2021 and 2026.
---------------------------------------------------------------*/

# STEP 4 : Constituencies That Changed Winning Party
SELECT w2021.ac_number, w2021.constituency, w2021.party AS winning_party_2021, w2026.party AS winning_party_2026
FROM vw_winner_2021 w2021
INNER JOIN vw_winner_2026 w2026
ON w2021.ac_number = w2026.ac_number
WHERE
    w2021.party <> w2026.party
ORDER BY
    w2021.constituency;

# STEP 5 : Party Flip Summary
SELECT w2021.party AS from_party, w2026.party AS to_party, 
COUNT(*) AS flipped_constituencies
FROM vw_winner_2021 w2021
INNER JOIN vw_winner_2026 w2026
ON w2021.ac_number = w2026.ac_number
WHERE w2021.party <> w2026.party
GROUP BY w2021.party,w2026.party
ORDER BY flipped_constituencies DESC;

# STEP 6 : Stable Constituencies
SELECT COUNT(*) AS stable_constituencies
FROM vw_winner_2021 w2021
INNER JOIN vw_winner_2026 w2026
ON w2021.ac_number = w2026.ac_number
WHERE w2021.party = w2026.party;

/*---------------------------------------------------------------
BUSINESS INSIGHT
This analysis explains:
✓ Constituencies that changed political control
✓ Parties gaining new constituencies
✓ Parties losing constituencies
✓ Overall electoral stability between
  the two elections.
---------------------------------------------------------------*/

/*---------------------------------------------------------------
RESEARCH STORY 3 : VOTE SHARE STORY

Objective

Analyse state-wide and regional vote share to identify
the strongest political parties and understand how
vote concentration influenced the election outcome.
---------------------------------------------------------------*/

# STEP 7 : State-wide Vote Share (2026)
SELECT party,SUM(votes) AS total_votes,
ROUND(SUM(votes) * 100 /(SELECT SUM(votes)
FROM election_2026_clean),2) AS vote_share_percentage
FROM election_2026_clean
GROUP BY party
ORDER BY total_votes DESC;

# STEP 8 : Regional Vote Share
SELECT cm.region,e.party,
SUM(e.votes) AS total_votes,
ROUND(SUM(e.votes) * 100 /SUM(SUM(e.votes)) OVER
(PARTITION BY cm.region),2) AS regional_vote_share
FROM election_2026_clean e
INNER JOIN constituency_master_clean cm
ON e.ac_number = cm.ac_number
GROUP BY cm.region,e.party
ORDER BY cm.region,regional_vote_share DESC;

# STEP 9 : Leading Party in Every Region
WITH regional_votes AS
(SELECT cm.region,e.party,
SUM(e.votes) AS total_votes,
ROW_NUMBER()
OVER(PARTITION BY cm.region ORDER BY SUM(e.votes) DESC) AS ranking
FROM election_2026_clean e
INNER JOIN constituency_master_clean cm
ON e.ac_number = cm.ac_number
GROUP BY cm.region,e.party)
SELECT region,party,total_votes
FROM regional_votes
WHERE ranking = 1 ORDER BY region;

/*---------------------------------------------------------------
BUSINESS INSIGHT
This analysis identifies
✓ State-wide vote share
✓ Regional vote share
✓ Leading political party in every region

These insights explain whether the winning party
dominated uniformly or relied on regional strength.

---------------------------------------------------------------*/

/*---------------------------------------------------------------
EXECUTIVE SUMMARY
Overall Election Comparison
---------------------------------------------------------------*/

# STEP 10 : Seat Comparison (2021 vs 2026)
SELECT p.party,
COALESCE(s2021.seats_2021,0) AS seats_2021,
COALESCE(s2026.seats_2026,0) AS seats_2026,
COALESCE(s2026.seats_2026,0)-COALESCE(s2021.seats_2021,0)
AS seat_change FROM(SELECT DISTINCT party
FROM election_2021_clean
UNION
SELECT DISTINCT party
FROM election_2026_clean) p
LEFT JOIN(SELECT party,COUNT(*) AS seats_2021
FROM vw_winner_2021
GROUP BY party) s2021
ON p.party = s2021.party
LEFT JOIN(SELECT party,COUNT(*) AS seats_2026
FROM vw_winner_2026
GROUP BY party) s2026
ON p.party = s2026.party
ORDER BY seat_change DESC;

# STEP 11 : Executive Dashboard KPI
SELECT(SELECT COUNT(*) FROM vw_winner_2026)AS total_constituencies,
(SELECT COUNT(DISTINCT party)FROM election_2026_clean)AS political_parties,
(SELECT COUNT(*)FROM vw_winner_2021)AS winners_2021,
(SELECT COUNT(*)FROM vw_winner_2026)AS winners_2026,
(SELECT ROUND(AVG(vote_percentage),2)FROM election_2026_clean)AS average_vote_percentage,
(SELECT SUM(votes)FROM election_2026_clean)AS total_votes_polled;

# STEP 12 : Research Analytics Status
SELECT 'Research Question Analytics Completed Successfully'AS project_status,
CURDATE() AS completion_date;

/*=====================================================================
PART 14 COMPLETED

RESEARCH STORIES COMPLETED
✓ Geographic Story
    • Region-wise Seat Distribution
    • Regional Vote Performance
    • Regional Political Dominance
✓ Flip Story
    • Flipped Constituencies
    • Stable Constituencies
    • Party-wise Seat Changes
✓ Vote Share Story
    • State-wide Vote Share
    • Regional Vote Share
    • Leading Party by Region
-----------------------------------------------------------------------

EXECUTIVE SUMMARY GENERATED

✓ Seat Comparison (2021 vs 2026)
✓ Executive Dashboard KPIs
✓ Business Insights Ready
✓ Power BI Ready Outputs
-----------------------------------------------------------------------

Database Status
RESEARCH QUESTION ANALYTICS COMPLETED SUCCESSFULLY

Ready For
PART 15 : DASHBOARD VIEWS
=====================================================================*/

/*=====================================================================
                    PART 15 : DASHBOARD VIEWS
=======================================================================
Project  : Decoding the 2026 Tamil Nadu Assembly Election
Database : election_intelligence_analytics
Module   : Dashboard Views (Power BI Ready)

=======================================================================
OBJECTIVE

Create dashboard-ready SQL Views that can be directly
connected to Power BI.

These views expose clean, reusable business datasets,
minimizing transformations inside Power BI and keeping
business logic centralized within SQL.
=======================================================================
DASHBOARD VIEWS

✓ Dashboard KPI View
✓ Dashboard Fact View
✓ Party Performance View
✓ Region Performance View
✓ Reserved Category View
✓ Vote Share View
✓ Winning Margin View
✓ Constituency Summary View
=======================================================================
EXPECTED OUTCOME

✓ Power BI Ready Dataset
✓ Centralized Business Logic
✓ Reusable Dashboard Layer
✓ Enterprise-style Reporting Model
=====================================================================*/

# STEP 1 : Dashboard KPI View

CREATE OR REPLACE VIEW vw_dashboard_kpi AS
SELECT
    COUNT(*) AS total_constituencies,
    COUNT(DISTINCT party) AS total_parties,
    SUM(votes) AS total_winning_votes,
    ROUND(AVG(vote_percentage),2) AS average_vote_percentage
FROM vw_winner_2026;

# STEP 2 : Dashboard Fact View

CREATE OR REPLACE VIEW vw_dashboard AS
SELECT w.ac_number,w.constituency,cm.district,cm.region,cm.reserved,w.candidate,w.party,w.votes,w.vote_percentage,w.turnout
FROM vw_winner_2026 w
INNER JOIN constituency_master_clean cm
ON w.ac_number = cm.ac_number;

# STEP 3 : Dashboard Party Summary View

CREATE OR REPLACE VIEW vw_dashboard_party_summary AS
SELECT party,
    COUNT(*) AS seats_won,
    SUM(votes) AS total_votes,
    ROUND(AVG(votes),2) AS average_votes,
    ROUND(AVG(vote_percentage),2) AS average_vote_percentage
FROM vw_winner_2026
GROUP BY party
ORDER BY seats_won DESC;

# STEP 4 : Dashboard Region Summary View

CREATE OR REPLACE VIEW vw_dashboard_region_summary AS
SELECT cm.region,w.party,
    COUNT(*) AS seats_won,
    SUM(w.votes) AS total_votes,
    ROUND(AVG(w.vote_percentage),2) AS average_vote_percentage
FROM vw_winner_2026 w
INNER JOIN constituency_master_clean cm
ON w.ac_number = cm.ac_number
GROUP BY cm.region,w.party;

# STEP 5 : Dashboard Reserved Category View

CREATE OR REPLACE VIEW vw_dashboard_reserved_summary AS
SELECT cm.reserved,w.party,
    COUNT(*) AS seats_won,
    SUM(w.votes) AS total_votes
FROM vw_winner_2026 w
INNER JOIN constituency_master_clean cm
ON w.ac_number = cm.ac_number
GROUP BY cm.reserved,w.party;

# STEP 6 : Dashboard Vote Share View

CREATE OR REPLACE VIEW vw_dashboard_vote_share AS

SELECT party,total_votes,vote_share_percentage
FROM vw_vote_share_summary;

# STEP 7 : Dashboard Winning Margin View

CREATE OR REPLACE VIEW vw_dashboard_margin AS
SELECT ac_number,constituency,winning_party,winning_candidate,winner_votes,runnerup_votes,winning_margin
FROM vw_margin_summary;

# STEP 8 : Dashboard Constituency Summary View

CREATE OR REPLACE VIEW vw_dashboard_constituency AS
SELECT cs.ac_number,cs.constituency,cm.district,cm.region,cm.reserved,cs.total_candidates,cs.total_votes,cs.highest_votes,cs.lowest_votes,cs.average_vote_percentage
FROM vw_constituency_summary cs
INNER JOIN constituency_master_clean cm
ON cs.ac_number = cm.ac_number;

# STEP 9 : Dashboard View Validation

SHOW FULL TABLES WHERE TABLE_TYPE='VIEW';
SELECT * FROM vw_dashboard_kpi;
SELECT * FROM vw_dashboard LIMIT 10;
SELECT * FROM vw_dashboard_party_summary;
SELECT * FROM vw_dashboard_region_summary;
SELECT * FROM vw_dashboard_reserved_summary;
SELECT * FROM vw_dashboard_vote_share;
SELECT * FROM vw_dashboard_margin LIMIT 10;
SELECT * FROM vw_dashboard_constituency LIMIT 10;

# STEP 10 : Dashboard Layer Status

SELECT 'Dashboard Views Created Successfully' AS dashboard_status,
CURDATE() AS creation_date;

/*=====================================================================
PART 15 COMPLETED
DASHBOARD VIEWS CREATED

✓ Dashboard KPI View
✓ Dashboard Fact View
✓ Party Performance View
✓ Region Performance View
✓ Reserved Category View
✓ Vote Share View
✓ Winning Margin View
✓ Constituency Summary View

-----------------------------------------------------------------------
DASHBOARD LAYER VALIDATED

✓ View Validation Completed
✓ Power BI Ready Dataset
✓ Centralized Business Logic
✓ Reusable Dashboard Layer

-----------------------------------------------------------------------

Database Status
POWER BI DASHBOARD LAYER READY

Ready For
PART 16 : PERFORMANCE OPTIMIZATION
=====================================================================*/

/*=====================================================================
                    PART 16 : PERFORMANCE OPTIMIZATION
=======================================================================
Project  : Decoding the 2026 Tamil Nadu Assembly Election
Database : election_intelligence_analytics
Module   : Performance Optimization
=======================================================================
OBJECTIVE

Optimize the analytical SQL environment for improved
query performance, dashboard responsiveness and
maintainability.

This phase focuses on query-driven optimization using
indexes, execution plans and database statistics rather
than changing business logic.

=======================================================================
OPTIMIZATION TASKS

✓ Database Statistics Refresh
✓ Index Creation
✓ Composite Index Creation
✓ Query Execution Plan Analysis
✓ Join Performance Validation
✓ Dashboard Query Optimization
✓ Index Verification

=======================================================================
EXPECTED OUTCOME

✓ Faster Analytical Queries
✓ Improved Join Performance
✓ Optimized Dashboard Refresh
✓ Enterprise-style SQL Optimization
=====================================================================*/

# STEP 1 : Select Database
USE election_intelligence_analytics;

# STEP 2 : Refresh Database Statistics
ANALYZE TABLE constituency_master_clean;
ANALYZE TABLE election_2021_clean;
ANALYZE TABLE election_2026_clean;

# STEP 3 : Create Primary Join Indexes

CREATE INDEX idx_master_ac
ON constituency_master_clean(ac_number);

CREATE INDEX idx_2021_ac
ON election_2021_clean(ac_number);

CREATE INDEX idx_2026_ac
ON election_2026_clean(ac_number);

# STEP 4 : Create Analytics Indexes
CREATE INDEX idx_2021_party
ON election_2021_clean(party(50));

CREATE INDEX idx_2026_party
ON election_2026_clean(party(50));

# STEP 5 : Composite Index 
CREATE INDEX idx_2021_ac_votes
ON election_2021_clean
(ac_number,votes);
CREATE INDEX idx_2026_ac_votes
ON election_2026_clean
(ac_number,votes);
CREATE INDEX idx_region_reserved
ON constituency_master_clean
(region(30),reserved(10));

# STEP 6 : Verify Created Indexes
SHOW INDEX
FROM constituency_master_clean;

SHOW INDEX
FROM election_2021_clean;

SHOW INDEX
FROM election_2026_clean;

# STEP 7 : Query Execution Plan Analysis
# Verify how MySQL executes frequently used analytical queries using EXPLAIN.

EXPLAIN
SELECT party,
COUNT(*) AS total_seats
FROM vw_winner_2026
GROUP BY party;

EXPLAIN

SELECT cm.region,
SUM(e.votes) AS total_votes
FROM election_2026_clean e
INNER JOIN constituency_master_clean cm
ON e.ac_number = cm.ac_number
GROUP BY cm.region;

EXPLAIN
SELECT party,
SUM(votes) AS total_votes
FROM election_2026_clean
GROUP BY party;

# STEP 8 : Optimize Tables
# Refresh table storage and statistics for better analytical performance.

OPTIMIZE TABLE constituency_master_clean;
OPTIMIZE TABLE election_2021_clean;
OPTIMIZE TABLE election_2026_clean;

# STEP 9 : Database Statistics
# Review table statistics after optimization
SHOW TABLE STATUS FROM election_intelligence_analytics;

# STEP 10 : Index Verification
# Verify all indexes created during the performance optimization phase.

SELECT TABLE_NAME,INDEX_NAME,COLUMN_NAME,SEQ_IN_INDEX
FROM information_schema.STATISTICS
WHERE TABLE_SCHEMA = 'election_intelligence_analytics'
ORDER BY TABLE_NAME,INDEX_NAME,SEQ_IN_INDEX;

# STEP 11 : Performance Validation
# Validate execution plans for common dashboard queries.
EXPLAIN
SELECT w.party,
COUNT(*) AS seats,
SUM(w.votes) AS total_votes
FROM vw_winner_2026 w
GROUP BY w.party;

EXPLAIN
SELECT cm.region,
COUNT(*) AS total_seats
FROM vw_winner_2026 w
INNER JOIN constituency_master_clean cm
ON w.ac_number = cm.ac_number
GROUP BY cm.region;

# STEP 12 : Performance Optimization Status
SELECT'Performance Optimization Completed Successfully'
AS optimization_status,
CURDATE()AS optimization_date;

/*=====================================================================
PART 16 COMPLETED
PERFORMANCE OPTIMIZATION COMPLETED

✓ Database Statistics Refreshed
✓ Primary Join Indexes Created
✓ Analytics Indexes Created
✓ Composite Indexes Created
✓ Query Execution Plans Verified
✓ Join Performance Validated
✓ Dashboard Queries Optimized
✓ Index Metadata Verified
-----------------------------------------------------------------------
DATABASE STATUS
OPTIMIZED FOR SQL ANALYTICS
OPTIMIZED FOR POWER BI REPORTING
READY FOR FINAL PROJECT VALIDATION
-----------------------------------------------------------------------
Next Module

PART 17 : FINAL PROJECT VALIDATION
=====================================================================*/

/*=====================================================================
                    PART 17 : FINAL PROJECT VALIDATION
=======================================================================
Project  : Decoding the 2026 Tamil Nadu Assembly Election
Database : election_intelligence_analytics
Module   : Final Project Validation
=======================================================================

OBJECTIVE

Perform a comprehensive validation of the completed
SQL project to ensure database integrity, analytical
accuracy, dashboard readiness and production
readiness.

Unlike Part 11 (Data Validation), this phase validates
the complete SQL solution including the Analytics Layer,
Research Analytics, Dashboard Views and Performance
Optimization.

=======================================================================
VALIDATION AREAS

✓ Database Validation
✓ Table Validation
✓ Row Count Validation
✓ Analytics View Validation
✓ Dashboard View Validation
✓ Winner & Runner-up Validation
✓ Join Validation
✓ NULL Value Validation
✓ Vote Statistics Validation
✓ Index Validation
✓ Database Statistics
✓ Production Readiness Validation

=======================================================================
EXPECTED OUTCOME

✓ Fully Validated SQL Database
✓ Analytics Layer Verified
✓ Dashboard Layer Verified
✓ Power BI Ready Database
✓ Production-ready SQL Project
=====================================================================*/

# STEP 1 : Select Database
USE election_intelligence_analytics;

# STEP 2 : Verify Active Database
SELECT DATABASE() AS current_database;

# STEP 3 : Verify All Tables
SHOW TABLES;

# STEP 4 : Verify All Views
SHOW FULL TABLES
WHERE TABLE_TYPE='VIEW';

# STEP 5 : Validate Dataset Row Counts
SELECT'Constituency Master' AS dataset,
COUNT(*) AS total_records FROM constituency_master_clean
UNION ALL
SELECT'Election 2021',
COUNT(*) FROM election_2021_clean
UNION ALL
SELECT'Election 2026',
COUNT(*) FROM election_2026_clean;

# STEP 6 : Validate Winner & Runner-up Views
SELECT COUNT(*) AS winners_2021
FROM vw_winner_2021;

SELECT COUNT(*) AS winners_2026
FROM vw_winner_2026;

SELECT COUNT(*) AS runnerup_2021
FROM vw_runnerup_2021;

SELECT COUNT(*) AS runnerup_2026
FROM vw_runnerup_2026;

-- Expected Result:
-- Each Winner and Runner-up view should contain
-- one record for every Assembly Constituency.

# STEP 7 : Validate Referential Integrity
SELECT COUNT(*) AS matched_records
FROM election_2026_clean e
INNER JOIN constituency_master_clean c
ON e.ac_number = c.ac_number;

-- Expected Result:
-- Every election record should successfully match
-- one constituency in the master dataset.

# STEP 8 : Validate NULL Values
SELECT SUM(ac_number IS NULL) AS ac_number_null,
SUM(candidate IS NULL) AS candidate_null,
SUM(party IS NULL) AS party_null,
SUM(votes IS NULL) AS votes_null
FROM election_2026_clean;

# STEP 9 : Validate Vote Statistics
SELECT MIN(votes) AS minimum_votes,
MAX(votes) AS maximum_votes,
ROUND(AVG(votes),2) AS average_votes
FROM election_2026_clean;

# STEP 10 : Validate Dashboard Views
SELECT COUNT(*) AS dashboard_records
FROM vw_dashboard;

SELECT COUNT(*) AS party_summary
FROM vw_dashboard_party_summary;

SELECT COUNT(*) AS region_summary
FROM vw_dashboard_region_summary;

SELECT COUNT(*) AS reserved_summary
FROM vw_dashboard_reserved_summary;

SELECT COUNT(*) AS vote_share_summary
FROM vw_dashboard_vote_share;

SELECT COUNT(*) AS margin_summary
FROM vw_dashboard_margin;

SELECT COUNT(*) AS constituency_summary
FROM vw_dashboard_constituency;

# STEP 11 : Validate Analytics Layer
SELECT * FROM vw_party_summary
ORDER BY total_votes DESC;

SELECT * FROM vw_vote_share_summary
ORDER BY vote_share_percentage DESC;

SELECT * FROM vw_margin_summary
ORDER BY winning_margin DESC
LIMIT 10;

# STEP 12 : Validate Indexes
SHOW INDEX
FROM constituency_master_clean;

SHOW INDEX
FROM election_2021_clean;

SHOW INDEX
FROM election_2026_clean;

# STEP 13 : Review Database Statistics
SELECT TABLE_NAME,TABLE_ROWS,DATA_LENGTH,INDEX_LENGTH
FROM information_schema.TABLES
WHERE TABLE_SCHEMA='election_intelligence_analytics';

# STEP 14 : Final Project Health Report

SELECT
(SELECT COUNT(*) FROM constituency_master_clean) AS constituency_master_records,
(SELECT COUNT(*) FROM election_2021_clean) AS election_2021_records,
(SELECT COUNT(*) FROM election_2026_clean) AS election_2026_records,
(SELECT COUNT(*) FROM vw_winner_2021) AS winner_view_2021,
(SELECT COUNT(*) FROM vw_winner_2026) AS winner_view_2026,
(SELECT COUNT(*) FROM vw_dashboard) AS dashboard_records,
(SELECT COUNT(DISTINCT party)
FROM election_2026_clean) AS political_parties;

# STEP 15 : Project Completion Status
SELECT 'SQL Analytics Pipeline Completed Successfully'
AS project_status,
DATABASE() AS database_name,
CURDATE() AS completion_date;

/*=====================================================================
PART 17 COMPLETED

FINAL PROJECT VALIDATION COMPLETED

✓ Database Validated
✓ Tables Verified
✓ Row Counts Verified
✓ Analytics Layer Verified
✓ Dashboard Views Verified
✓ Winner & Runner-up Views Verified
✓ Referential Integrity Verified
✓ NULL Value Validation Completed
✓ Vote Statistics Verified
✓ Indexes Verified
✓ Database Statistics Reviewed
✓ Project Health Report Generated

-----------------------------------------------------------------------
FINAL DELIVERABLES

✓ Relational Database
✓ Clean Election Datasets
✓ SQL Validation Layer
✓ Analytics Layer
✓ Advanced SQL Analytics
✓ Research Question Analytics
✓ Dashboard Views
✓ Performance Optimization
✓ Final Project Validation
✓ Power BI Ready Database

-----------------------------------------------------------------------
PROJECT STATUS
SQL PROJECT COMPLETED SUCCESSFULLY

Database Status
READY FOR POWER BI DASHBOARD DEVELOPMENT
=====================================================================*/

