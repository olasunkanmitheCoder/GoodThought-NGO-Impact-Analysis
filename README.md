# GoodThought NGO Impact Intelligence Dashboard: Funding, Operational Performance & Strategic Grant Readiness Analysis (2020–2022)

## Executive Summary
GoodThought NGO is an international humanitarian organization focused on improving lives through education, healthcare, environmental sustainability, food relief, youth empowerment, and community development initiatives.
As GoodThought NGO seeks to strengthen its eligibility for future international grant opportunities, the organization requires a comprehensive data-driven evaluation of its historical funding performance, donor behavior, operational efficiency, and regional impact outcomes.
Using PostgreSQL, SQL analytics, and Power BI, this project analyzes donation activities, donor engagement, initiative performance, and regional funding distribution between 2020 and 2022.

The goal of this analysis is to provide strategic insights that help GoodThought NGO:
- Demonstrate measurable social impact
- Improve operational decision-making
- Optimize donor engagement strategies
- Identify underfunded high-impact regions
- Prioritize initiatives for future international grant proposals
- Improve transparency and accountability through data storytelling

This project simulates a real-world NGO analytics consulting engagement where data is used to support strategic planning, operational effectiveness, and grant-readiness evaluation.


## Business Problem Statement

GoodThought NGO has experienced increasing operational complexity across multiple humanitarian initiatives and geographical regions. While the organization has successfully attracted donor funding over the years, leadership requires deeper insight into how financial resources are allocated, how effectively initiatives generate measurable social impact, and which operational areas should be prioritized for future funding.

The management team is particularly interested in understanding:
- Which initiatives attract the highest donor investment
- Which donor segments contribute most toward high-impact initiatives
- Whether donor funds are equitably distributed across operational regions
- Which regions demonstrate strong impact potential 
- How efficiently the organization converts financial resources into measurable impact
- Which initiatives should be prioritized in future international grant proposals

As a Data Analyst, my responsibility is to transform operational and donation data into actionable business intelligence to support strategic decision-making and strengthen GoodThought NGO’s grant-application capabilities.


## Project Objectives
The primary objective of this project is to evaluate GoodThought NGO’s funding performance, donor engagement, and initiative effectiveness between 2020 and 2022 using SQL analytics and Power BI visualization.

Specific objectives include:
- Analyze donor contribution patterns across donor categories
- Evaluate initiative-level funding and impact performance
- Assess regional funding distribution and operational efficiency
- Identify high-impact regions
- Measure organizational impact efficiency
- Develop strategic recommendations for future grant prioritization
- Build an executive-level interactive dashboard for stakeholders


## Dataset Overview
The dataset contains operational and donation records from 2020 to 2022 across three relational PostgreSQL tables with 5000 rows each.

1. Assignments Table - Contains information about humanitarian initiatives.
   - Key Fields - assignment_id, assignment_name, start_date, end_date, budget, region, impact_score
   - Business Meaning - Represents NGO programs, interventions, and operational initiatives(assignment) executed across various regions.

2. Donations Table - Contains records of financial contributions.
   - Key Fields - donation_id, donor_id, amount, donation_date, assignment_id
   - Business Meaning - Represents donor funding transactions allocated toward initiatives(assignment).

3. Donors Table - Contains donor information.
   - Key Fields - donor_id, donor_name, donor_type
   - Business Meaning - Represents funding partners, including individuals, organizations, and corporate entities.

## Entity Relationship Overview
The database follows a relational structure:
   - One donor can make multiple donations
   - One initiative can receive multiple donations
   - Donations serve as the transactional bridge between donors and initiatives

![erd_iamge](https://github.com/olasunkanmitheCoder/GoodThought-NGO-Impact-Analysis/blob/main/img/ERD_diagram.jpeg)
> > ERD Diagram

## Data Preparation & Validation
### Validation Activities Performed
   - Missing Value Checks - Validated critical fields across all tables to identify null or incomplete records.
   - Duplicate Record Detection - Checked for duplicate donation transactions and repeated donor records.
   - Foreign Key Integrity Validation - Validated relationships between donations, donors, and initiatives.
   - Invalid Budget Detection - Identified assignments containing negative budget values.
   - Invalid Date Range Validation - Detected initiatives where end dates occurred before start dates.

## Analytical Business Questions
### Funding & Donor Analysis
1. Which humanitarian initiatives attracted the highest levels of donor investment across different donor categories?
2. How have donor contribution trends evolved from 2020 to 2022?
3. Which donor segments contribute most significantly toward high-impact initiatives?
4. Which donor categories demonstrate the strongest long-term funding behavior?
5. How equitably are donor funds distributed across GoodThought’s operational regions?
   
### Impact & Operational Performance
6. Which initiatives achieve the highest impact outcomes while maintaining budget efficiency?
7. Which initiatives generate the highest social impact relative to donated funds received?
8. Which regions appear underfunded despite demonstrating strong impact potential?

### Strategic Grant Readiness
9. Which initiatives should GoodThought prioritize in future international grant proposals?

## SQL Analysis Framework
The analysis was conducted using PostgreSQL and included:
   - Aggregate functions
   - Common Table Expressions (CTEs)
   - Joins
   - Window functions
   - KPI calculations
   - Funding efficiency metrics
   - Regional performance analysis
   - Donor segmentation analytics

## Power BI Dashboard Structure
The dashboard was designed as an executive-level NGO intelligence solution consisting of four analytical pages.
### Dashboard Page 1 — Executive Overview
   Key KPIs
   - Total Donations
   - Total Donor Transactions
   - Total Donors
   - Average Impact Score
   - Total Operational Regions
   - Total Initiatives
   Visualizations
   - Donation Trend Analysis
   - Funding Distribution by Donor Type
### Dashboard Page 2 — Funding & Donor Analysis
   Visualizations
   - 15 Top-Funded Initiatives
   - Funding Distribution Across Regions   
### Dashboard Page 3 — Impact & Operational Performance
   Visualizations
   - Top 15 Initiatives By Impact Efficiency
   - Regional Impact Score
### Dashboard Page 4 — Strategic Grant Readiness
   Visualizations
   - Region-Based Funds Level
   - Top 30 Low-Funded Initiatives
![dashboard_display](https://github.com/user-attachments/assets/18931d92-f2cb-4ff6-9478-adcaecc7ac12)

## Expected Business Impact
The insights generated from this analysis are expected to help GoodThought NGO:
- Improve grant proposal credibility
- Identify high-performing initiatives for expansion
- Strengthen donor engagement strategies
- Improve funding allocation efficiency
- Increase transparency and accountability
- Support evidence-based strategic planning
- Identify underserved operational regions

