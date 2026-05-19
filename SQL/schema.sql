-- 1. Create the Assignments table
CREATE TABLE assignments (
    assignment_id INT PRIMARY KEY,
    assignment_name VARCHAR(255),
    start_date DATE,
    end_date DATE,
    budget DECIMAL,
    region VARCHAR(100),
    impact_score DECIMAL
);

-- 2. Create the Donors table
CREATE TABLE donors (
    donor_id INT PRIMARY KEY,
    donor_name VARCHAR(255),
    donor_type VARCHAR(50)
);

-- 3. Create the Donations table (linking the two)
CREATE TABLE donations (
    donation_id INT PRIMARY KEY,
    donor_id INT,
    amount DECIMAL(12,2),
    donation_date DATE,
    assignment_id INT,

    CONSTRAINT fk_donor
        FOREIGN KEY (donor_id)
        REFERENCES donors(donor_id),

    CONSTRAINT fk_assignment
        FOREIGN KEY (assignment_id)
        REFERENCES assignments(assignment_id)
);

select *
FROM assignments


