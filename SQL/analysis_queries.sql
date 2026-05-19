-- NEW
-- Funding & Donor Analysis
-- Which humanitarian initiatives attracted the highest levels of donor investment across different donor categories?
SELECT
    a.assignment_name AS initiative,
    dnr.donor_type,
    COUNT(d.donation_id) AS total_donations,
    ROUND(SUM(d.amount), 2) AS total_funding_received,
    ROUND(AVG(d.amount), 2) AS avg_donation_amount
FROM donations d
JOIN assignments a
    ON d.assignment_id = a.assignment_id
JOIN donors dnr
    ON d.donor_id = dnr.donor_id
GROUP BY
    a.assignment_name,
    dnr.donor_type
ORDER BY total_funding_received DESC
LIMIT 10;

-- How have donor contribution trends evolved from 2020 to 2022?
SELECT
    EXTRACT(YEAR FROM donation_date) AS donation_year,
    COUNT(donation_id) AS total_transactions,
    ROUND(SUM(amount), 2) AS total_contributions,
    ROUND(AVG(amount), 2) AS avg_contribution
FROM donations
GROUP BY donation_year
ORDER BY donation_year;

-- Which donor segments contribute most significantly toward high-impact initiatives?
SELECT
    dnr.donor_type,
    COUNT(DISTINCT a.assignment_id) AS supported_initiatives,
    ROUND(SUM(d.amount), 2) AS total_contributions,
    ROUND(AVG(a.impact_score), 2) AS avg_supported_impact_score
FROM donations d
JOIN donors dnr
    ON d.donor_id = dnr.donor_id
JOIN assignments a
    ON d.assignment_id = a.assignment_id
GROUP BY dnr.donor_type
ORDER BY avg_supported_impact_score DESC,
         total_contributions DESC;

-- Which donor categories demonstrate the strongest long-term funding behavior?
SELECT
    donor_type,
    COUNT(DISTINCT d.donor_id) AS unique_donors,
    COUNT(donation_id) AS total_transactions,
    ROUND(SUM(amount), 2) AS total_contributions,
    ROUND(AVG(amount), 2) AS avg_donation_amount
FROM donors dnr
JOIN donations d
    ON dnr.donor_id = d.donor_id
GROUP BY donor_type
ORDER BY total_contributions DESC,
         total_transactions DESC;

-- How equitably are donor funds distributed across GoodThought’s operational regions?
SELECT
    a.region,
    COUNT(DISTINCT a.assignment_id) AS total_initiatives,
    ROUND(SUM(d.amount), 2) AS total_regional_funding,
    ROUND(AVG(d.amount), 2) AS avg_donation_amount,
    ROUND(
        100.0 * SUM(d.amount)
        / SUM(SUM(d.amount)) OVER (),
        2
    ) AS percentage_of_total_funding
FROM donations d
JOIN assignments a
    ON d.assignment_id = a.assignment_id
GROUP BY a.region
ORDER BY total_regional_funding DESC;

-- Impact & Operational Performance
-- Which initiatives achieve the highest impact outcomes while maintaining budget efficiency?
SELECT
    assignment_name AS initiative,
    region,
    budget,
    impact_score,
    ROUND(
        impact_score / NULLIF(budget, 0),
        6
    ) AS impact_budget_efficiency
FROM assignments
WHERE budget > 0
ORDER BY impact_budget_efficiency DESC
LIMIT 10;

-- Which initiatives generate the highest social impact relative to donated funds received?
SELECT
    a.assignment_name AS initiative,
    a.region,
    ROUND(SUM(d.amount), 2) AS total_funding_received,
    a.impact_score,
    ROUND(
        a.impact_score / NULLIF(SUM(d.amount), 0),
        6
    ) AS impact_per_donation_dollar
FROM assignments a
JOIN donations d
    ON a.assignment_id = d.assignment_id
GROUP BY
    a.assignment_name,
    a.region,
    a.impact_score
ORDER BY impact_per_donation_dollar DESC
LIMIT 10;

-- Which regions appear underfunded despite demonstrating strong impact potential?
WITH regional_analysis AS (
    SELECT
        a.region,
        ROUND(SUM(d.amount), 2) AS total_funding,
        ROUND(AVG(a.impact_score), 2) AS avg_impact_score
    FROM assignments a
    JOIN donations d
        ON a.assignment_id = d.assignment_id
    GROUP BY a.region
)
SELECT
    region,
    total_funding,
    avg_impact_score
FROM regional_analysis
WHERE avg_impact_score > (
    SELECT AVG(impact_score)
    FROM assignments
)
ORDER BY total_funding;

-- Strategic Grant Readiness
-- Which initiatives should GoodThought prioritize in future international grant proposals?
WITH initiative_performance AS (
    SELECT
        a.assignment_name AS initiative,
        a.region,
        ROUND(SUM(d.amount), 2) AS total_funding,
        a.budget,
        a.impact_score,
        COUNT(d.donation_id) AS donor_transactions
    FROM assignments a
    JOIN donations d
        ON a.assignment_id = d.assignment_id
    GROUP BY
        a.assignment_name,
        a.region,
        a.budget,
        a.impact_score
)
SELECT
    initiative,
    region,
    total_funding,
    budget,
    impact_score,
    donor_transactions
FROM initiative_performance
ORDER BY
    impact_score DESC,
    donor_transactions DESC;





-- OLD
-- -- Top Donation Assignments by Donor Type
-- SELECT
--     a.assignment_name,
--     a.region,
--     ROUND(SUM(d.amount), 2) AS rounded_total_donation_amount,
--     dn.donor_type
-- FROM donations d
-- JOIN assignments a
--     ON d.assignment_id = a.assignment_id
-- JOIN donors dn
--     ON d.donor_id = dn.donor_id
-- GROUP BY
--     a.assignment_name,
--     a.region,
--     dn.donor_type
-- ORDER BY rounded_total_donation_amount DESC
-- LIMIT 5;

-- -- Highest Impact Assignment Per Region
-- WITH regional_rankings AS (
--     SELECT
--         a.assignment_name,
--         a.region,
--         a.impact_score,
--         COUNT(d.donation_id) AS num_total_donations,
--         ROW_NUMBER() OVER (
--             PARTITION BY a.region
--             ORDER BY a.impact_score DESC
--         ) AS rank_num
--     FROM assignments a
--     JOIN donations d
--         ON a.assignment_id = d.assignment_id
--     GROUP BY
--         a.assignment_name,
--         a.region,
--         a.impact_score
-- )
-- SELECT
--     assignment_name,
--     region,
--     impact_score,
--     num_total_donations
-- FROM regional_rankings
-- WHERE rank_num = 1
-- ORDER BY region ASC;

-- -- Yearly Donation Trend
-- SELECT
--     EXTRACT(YEAR FROM donation_date) AS donation_year,
--     ROUND(SUM(amount), 2) AS total_donations
-- FROM donations
-- GROUP BY donation_year
-- ORDER BY donation_year;

-- -- Top Performing Regions
-- SELECT
--     region,
--     ROUND(AVG(impact_score), 2) AS avg_impact_score,
--     ROUND(SUM(budget), 2) AS total_budget
-- FROM assignments
-- GROUP BY region
-- ORDER BY avg_impact_score DESC;

-- -- Donor Segmentation
-- SELECT
--     donor_type,
--     COUNT(DISTINCT dn.donor_id) AS total_donors,
--     ROUND(SUM(amount), 2) AS total_contributions
-- FROM donations d
-- JOIN donors dn
--     ON d.donor_id = dn.donor_id
-- GROUP BY donor_type
-- ORDER BY total_contributions DESC;

-- -- Regions total donations
-- SELECT
--     a.region,
--     ROUND(SUM(d.amount), 2) AS total_donations
-- FROM donations d
-- JOIN assignments a
--     ON d.assignment_id = a.assignment_id
-- GROUP BY a.region
-- ORDER BY total_donations DESC;
