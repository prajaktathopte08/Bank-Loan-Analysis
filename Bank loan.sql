create database Bank_loan;
use Bank_loan;
drop database Bank_loan;
CREATE TABLE Bank_loan (
    id VARCHAR(50),
    address_state VARCHAR(50),
    application_type VARCHAR(50),
    emp_length VARCHAR(50),
    emp_title VARCHAR(100),
    grade VARCHAR(10),
    home_ownership VARCHAR(50),
    issue_date VARCHAR(50),
    last_credit_pull_date VARCHAR(50),
    last_payment_date VARCHAR(50),
    loan_status VARCHAR(50),
    next_payment_date VARCHAR(50),
    member_id VARCHAR(50),
    purpose VARCHAR(100),
    sub_grade VARCHAR(10),
    term VARCHAR(50),
    verification_status VARCHAR(50),
    annual_income VARCHAR(50),
    dti VARCHAR(50),
    installment VARCHAR(50),
    int_rate VARCHAR(50),
    loan_amount VARCHAR(50),
    total_acc VARCHAR(50),
    total_payment VARCHAR(50)
);

DROP table bank_loan;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Bank_loan.csv'
INTO TABLE Bank_loan
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Total Loan Applications
 
SELECT COUNT(id) AS Total_Applications FROM Bank_loan;

-- MTD Loan Applications
 
SELECT COUNT(id) AS Total_Applications FROM Bank_loan
WHERE MONTH(issue_date) = 12;

-- PMTD Loan Applications 
SELECT COUNT(id) AS Total_Applications FROM bank_loan
WHERE MONTH(issue_date) = 11;

-- 
-- Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM Bank_loan;

-- MTD Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM Bank_loan
WHERE MONTH(issue_date) = 12;

-- PMTD Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM Bank_loan
WHERE MONTH(issue_date) = 11;

-- Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected FROM Bank_loan;

-- MTD Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected FROM Bank_loan
WHERE MONTH(issue_date) = 12;

-- PMTD Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected FROM Bank_loan
WHERE MONTH(issue_date) = 11;

-- Average Interest Rate
SELECT AVG(int_rate)*100 AS Avg_Int_Rate FROM Bank_loan;

-- MTD Average Interest
SELECT AVG(int_rate)*100 AS MTD_Avg_Int_Rate FROM Bank_loan
WHERE MONTH(issue_date) = 12;

-- PMTD Average Interest
SELECT AVG(int_rate)*100 AS PMTD_Avg_Int_Rate FROM Bank_loan
WHERE MONTH(issue_date) = 11;

-- Avg DTI
SELECT AVG(dti)*100 AS Avg_DTI FROM Bank_loan;

-- MTD Avg DTI
SELECT AVG(dti)*100 AS MTD_Avg_DTI FROM Bank_loan
WHERE MONTH(issue_date) = 12;

-- PMTD Avg DTI
SELECT AVG(dti)*100 AS PMTD_Avg_DTI FROM Bank_loan
WHERE MONTH(issue_date) = 11;

-- GOOD LOAN ISSUED
-- Good Loan Percentage
SELECT 
    SUM(loan_status IN ('Fully Paid','Current')) * 100.0 / COUNT(*) AS Good_Loan_Percentage
FROM Bank_loan;


-- Good Loan Applications
SELECT COUNT(id) AS Good_Loan_Applications FROM Bank_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

-- Good Loan Funded Amount
SELECT SUM(loan_amount) AS Good_Loan_Funded_amount FROM Bank_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

-- Good Loan Amount Received
SELECT SUM(total_payment) AS Good_Loan_amount_received FROM Bank_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

-- BAD LOAN ISSUED
-- Bad Loan Percentage
SELECT 
    SUM(loan_status = 'Charged Off') * 100.0 / COUNT(*) AS Bad_Loan_Percentage
FROM Bank_loan;

-- Bad Loan Applications
SELECT COUNT(id) AS Bad_Loan_Applications FROM Bank_loan
WHERE loan_status = 'Charged Off';

-- Bad Loan Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded_amount FROM Bank_loan
WHERE loan_status = 'Charged Off';

-- Bad Loan Amount Received
SELECT SUM(total_payment) AS Bad_Loan_amount_received FROM Bank_loan
WHERE loan_status = 'Charged Off';

-- LOAN STATUS
	SELECT
        loan_status,
        COUNT(id) AS LoanCount,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100) AS Interest_Rate,
        AVG(dti * 100) AS DTI
    FROM
        Bank_loan
	GROUP BY
        loan_status;

SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM Bank_loan
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status;

-- BANK LOAN REPORT | OVERVIEW
-- MONTH 
SELECT 
    MONTH(issue_date) AS Month_Number,
    MONTHNAME(issue_date) AS Month_name,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM Bank_loan
GROUP BY MONTH(issue_date), MONTHNAME(issue_date)
ORDER BY MONTH(issue_date);


-- STATE
SELECT 
	address_state AS State, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM Bank_loan
GROUP BY address_state
ORDER BY address_state;

-- TERM
SELECT 
	term AS Term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM Bank_loan
GROUP BY term
ORDER BY term;


-- EMPLOYEE LENGTH
SELECT 
	emp_length AS Employee_Length, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM Bank_loan
GROUP BY emp_length
ORDER BY COUNT(id) DESC;

-- PURPOSE
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM Bank_loan
GROUP BY purpose
ORDER BY COUNT(id) DESC;


-- HOME OWNERSHIP
SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM Bank_loan
GROUP BY home_ownership
ORDER BY COUNT(id) DESC;


-- Note: We have applied multiple Filters on all the dashboards. You can check the results for the filters as well by modifying the query and comparing the results.
-- For e.g
-- See the results when we hit the Grade A in the filters for dashboards.
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM Bank_loan
WHERE grade = 'A'
GROUP BY purpose
ORDER BY purpose;
