-- Check for Missing Values
--- Assignments table
SELECT *
FROM assignments
WHERE
    assignment_name IS NULL
    OR region IS NULL
    OR impact_score IS NULL;

--- Donors table
SELECT *
FROM donors
WHERE
    donor_name IS NULL
    OR donor_type IS NULL;

--- Donations table
SELECT *
FROM donations
WHERE
    donor_id IS NULL
    OR assignment_id IS NULL
    OR amount IS NULL;

-- Check for Duplicate Records
--- Donors
SELECT
    donor_name,
    COUNT(*) AS duplicate_count
FROM donors
GROUP BY donor_name
HAVING COUNT(*) > 1;

--- Donations 
SELECT
    donation_id,
    COUNT(*)
FROM donations
GROUP BY donation_id
HAVING COUNT(*) > 1;

-- Validate Foreign Key Integrity
--- Donations with missing donors
SELECT d.*
FROM donations d
LEFT JOIN donors dn
    ON d.donor_id = dn.donor_id
WHERE dn.donor_id IS NULL;

--- Donations with missing assignments
SELECT d.*
FROM donations d
LEFT JOIN assignments a
    ON d.assignment_id = a.assignment_id
WHERE a.assignment_id IS NULL;

-- Validate Date Logic
--- Assignments ending before starting
SELECT *
FROM assignments
WHERE end_date < start_date;

--- Update Assignments ending before starting
UPDATE assignments
SET
    start_date = LEAST(start_date, end_date),
    end_date = GREATEST(start_date, end_date)
WHERE end_date < start_date;

--- Future donation dates
SELECT *
FROM donations
WHERE donation_date > CURRENT_DATE;

-- Check Invalid Donation Amounts
SELECT *
FROM donations
WHERE amount <= 0;

-- Check Budget Consistency
--- Investigate the Problem
SELECT *
FROM assignments
WHERE budget <= 0;

--- Quantify the Issue
SELECT
    COUNT(*) AS negative_budget_records,
    ROUND(MIN(budget),2) AS lowest_budget,
    ROUND(MAX(budget),2) AS highest_negative_budget
FROM assignments
WHERE budget < 0;

--- Convert to Negative Budget to Positive
UPDATE assignments
SET budget = ABS(budget)
WHERE budget < 0;