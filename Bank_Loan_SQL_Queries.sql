CREATE DATABASE Bank_Loan;
USE Bank_Loan;

CREATE TABLE loans_data (
    id BIGINT,
    address_stat VARCHAR(5),
    application_type VARCHAR(20),
    emp_length VARCHAR(20),
    emp_title VARCHAR(100),
    grade CHAR(1),
    home_ownership VARCHAR(20),
    issue_date DATE,
    last_credit_pull DATE,
    last_payment_date DATE,
    loan_status VARCHAR(20),
    next_payment_date DATE,
    member_id BIGINT,
    purpose VARCHAR(50),
    sub_grade VARCHAR(5),
    term VARCHAR(20),
    verification_status VARCHAR(50),
    annual_income DECIMAL(12,2),
    dti DECIMAL(6,3),
    installment DECIMAL(12,2),
    int_rate DECIMAL(6,4),
    loan_amount DECIMAL(12,2),
    total_acc INT,
    total_payment DECIMAL(12,2)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/financial_loan.csv'
INTO TABLE loans_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM loans_data;
SELECT COUNT(*) FROM loans_data;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Ques.1 What is the total number of loan applications received in a specific period, and how does this change from month to month?
SELECT COUNT(id) AS Total_Loan_Applications FROM loans_data;
SELECT * FROM Total_Loan_Applications;
CREATE VIEW Total_Loan_Applications AS
SELECT MONTH(issue_date) AS Months, COUNT(id) AS Monthly_Loan_Applications FROM loans_data
WHERE issue_date BETWEEN '2021-01-01' AND '2021-12-31'
GROUP BY MONTH(issue_date)
ORDER BY MONTH(issue_date);

----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Ques.2 What is the total amount of funds disbursed as loans in the current period, and how does the Month-to-Date (MTD) funding compare with the previous month (MoM)?
SELECT ROUND(SUM(loan_amount)) AS Total_Amount_Distributed FROM loans_data;

CREATE VIEW Total_Funded_Amount AS
SELECT MONTH(issue_date) AS Months , ROUND(SUM(loan_amount)) AS Monthly_Amount_Distributed FROM loans_data
WHERE issue_date BETWEEN '2021-01-01' AND '2021-12-31'
GROUP BY MONTH(issue_date)
ORDER BY MONTH(issue_date);

----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Ques.3 How much total repayment has been received from borrowers so far, and what are the Month-to-Date (MTD) collections compared with the previous month (MoM change)?
SELECT SUM(total_payment) AS Total_Repayment_Received FROM loans_data;

CREATE VIEW Total_Amount_Received AS 
SELECT MONTH(issue_date) AS Months, SUM(total_payment) AS Montly_Repayment_Received
FROM loans_data
WHERE issue_date BETWEEN '2021-01-01' AND '2021-12-31'
GROUP BY MONTH(issue_date)
ORDER BY MONTH(issue_date);

----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Ques.4 What is the average interest rate across all loans, and how has the Month-over-Month (MoM) interest rate changed?
SELECT ROUND(AVG(int_rate)*100,2) AS Avg_Interest_Rate FROM loans_data;

CREATE VIEW Average_Interest_Rate AS
SELECT MONTH(issue_date) AS Months, ROUND(AVG(int_rate)*100,2) AS Monthly_Loan_Applications
FROM loans_data
WHERE issue_date BETWEEN '2021-01-01' AND '2021-12-31'
GROUP BY MONTH(issue_date)
ORDER BY MONTH(issue_date);

----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Ques.5 What is the average DTI ratio of all borrowers, and how has it fluctuated Month-to-Month (MoM)?=
SELECT ROUND(AVG(dti)*100,2) AS Avg_DTI FROM loans_data;

CREATE VIEW Average_DTI_Ratio AS
SELECT MONTH(issue_date) AS Months, ROUND(AVG(dti)*100,2) AS Avg_DTI
FROM loans_data
WHERE issue_date BETWEEN '2021-01-01' AND '2021-12-31'
GROUP BY MONTH(issue_date)
ORDER BY MONTH(issue_date);

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

-- GOOD LOAN
---------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
-- Good Loan Application Percentage?
CREATE VIEW Good_Loan_Application_Percentage AS
SELECT 
ROUND(COUNT(CASE WHEN loan_status IN ('Fully Paid', 'Current') THEN id END) /COUNT(id) * 100, 2) AS Good_Loan_Application_Percentage 
FROM loans_data; 
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Good Loan Applications?
CREATE VIEW Good_Loan_Applications AS
SELECT COUNT(id) AS Good_Loan_Applications FROM loans_data
WHERE loan_status IN ('Fully Paid', 'Current');
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Good Loan Funded Amount?
CREATE VIEW Good_Loan_Funded_Amount AS
SELECT SUM(loan_amount) AS Good_Loan_Funded_Amount FROM loans_data
WHERE loan_status IN ('Fully Paid', 'Current');
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Good Loan Total Received Amount?
CREATE VIEW Good_Loan_Total_Received_Amount AS
SELECT SUM(total_payment) AS Good_Loan_Total_Received_Amount FROM loans_data
WHERE loan_status IN ('Fully Paid', 'Current');
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
-- BAD LOAN
---------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
-- Bad Loan Application Percentage?
CREATE VIEW Bad_Loan_Application_Percentage AS
SELECT
ROUND(COUNT( CASE WHEN loan_status IN ('Charged Off') THEN id END) / COUNT(id) *100, 2) AS Bad_Loan_Application_Percentage
FROM loans_data;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Bad Loan Applications?
CREATE VIEW Bad_Loan_Applications AS
SELECT COUNT(id) AS Bad_Loan_Applications FROM loans_data
WHERE loan_status = 'Charged Off';
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Bad Loan Funded Amount?
CREATE VIEW Bad_Loan_Funded_Amount AS
SELECT SUM(loan_amount) AS Bad_Loan_Funded_Amount FROM loans_data
WHERE loan_status = 'Charged Off';
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Bad Loan Total Received Amount?
CREATE VIEW Bad_Loan_Total_Received_Amount AS
SELECT SUM(total_payment) AS Bad_Loan_Total_Received_Amount FROM loans_data
WHERE loan_status = 'Charged Off';
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Ques.8 elaborate on how metrics like Total Loan Applications, Total Funded Amount, Total Amount Received, Month-to-Date (MTD) Funded Amount, MTD Amount Received, 
-- Average Interest Rate, and Average Debt-to-Income Ratio (DTI) contribute to helping data analysts or decision-makers assess the health and performance of a loan portfolio.

CREATE VIEW Loan_Performance_Metrics_View AS
SELECT
loan_status AS Loans_Status,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Amount_Received,
AVG(int_rate)*100 AS Average_Interest_Rate,
AVG(dti)*100 AS Average_DTI
FROM loans_data
WHERE (issue_date) BETWEEN '2021-01-01' AND '2021-12-31'
GROUP BY loan_status;

CREATE VIEW Loan_Amount_By_Month_View AS
SELECT
  loan_status,
  SUM(CASE WHEN MONTH(issue_date) = 1 THEN loan_amount ELSE 0 END) AS 'January',
  SUM(CASE WHEN MONTH(issue_date) = 2 THEN loan_amount ELSE 0 END) AS 'February',
  SUM(CASE WHEN MONTH(issue_date) = 3 THEN loan_amount ELSE 0 END) AS 'March',
  SUM(CASE WHEN MONTH(issue_date) = 4 THEN loan_amount ELSE 0 END) AS 'April',
  SUM(CASE WHEN MONTH(issue_date) = 5 THEN loan_amount ELSE 0 END) AS 'May',
  SUM(CASE WHEN MONTH(issue_date) = 6 THEN loan_amount ELSE 0 END) AS 'June',
  SUM(CASE WHEN MONTH(issue_date) = 7 THEN loan_amount ELSE 0 END) AS 'July',
  SUM(CASE WHEN MONTH(issue_date) = 8 THEN loan_amount ELSE 0 END) AS 'August',
  SUM(CASE WHEN MONTH(issue_date) = 9 THEN loan_amount ELSE 0 END) AS 'September',
  SUM(CASE WHEN MONTH(issue_date) = 10 THEN loan_amount ELSE 0 END) AS 'October',
  SUM(CASE WHEN MONTH(issue_date) = 11 THEN loan_amount ELSE 0 END) AS 'November',
  SUM(CASE WHEN MONTH(issue_date) = 12 THEN loan_amount ELSE 0 END) AS 'December'
FROM
  loans_data
GROUP BY
  loan_status
ORDER BY
  loan_status;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- DASHBOARD-2: OVERVIEW
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Monthly Trends by Issue Date(Line Chart):

CREATE VIEW Monthly_Trends_by_Issue_Date AS
SELECT 
MONTH(issue_date) AS Month_Number,
MONTHNAME(issue_date) AS Month_Name,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Loan_Amount,
SUM(total_payment) AS Total_Amount_Received
FROM loans_data
GROUP BY MONTH(issue_date), MONTHNAME(issue_date)
ORDER BY MONTH(issue_date);
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Regional Analysis By State (Filled Map):

CREATE VIEW Regional_Analysis_By_State AS
SELECT 
address_stat,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Loan_Amount,
SUM(total_payment) AS Total_Amount_Received
FROM loans_data
GROUP BY address_stat
ORDER BY address_stat;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Loan Term Analysis (Donut Chart):

CREATE VIEW Loan_Term_Analysis AS
SELECT 
term as Loan_Term,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Loan_Amount,
SUM(total_payment) AS Total_Amount_Received
FROM loans_data
GROUP BY term
ORDER BY term;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Employee Length Analysis (Bar Chart):

CREATE VIEW Employee_Length_Analysis AS
SELECT 
emp_length AS Employment_Length,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Loan_Amount,
SUM(total_payment) AS Total_Amount_Received
FROM loans_data
GROUP BY emp_length
ORDER BY emp_length;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Loan Purpose Breakdown (Bar Chart):

CREATE VIEW Loan_Purpose_Breakdown AS
SELECT 
purpose AS Purposes_Of_Loans,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Loan_Amount,
SUM(total_payment) AS Total_Amount_Received
FROM loans_data
GROUP BY purpose
ORDER BY COUNT(id) DESC;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Home Ownership Analysis (Tree Map):

CREATE VIEW Home_Ownership_Analysis AS
SELECT 
home_ownership AS Home_Ownerships,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Loan_Amount,
SUM(total_payment) AS Total_Amount_Received
FROM loans_data
GROUP BY home_ownership
ORDER BY COUNT(id) DESC;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT table_name
FROM INFORMATION_SCHEMA.VIEWS
WHERE table_schema = 'bank_loan';
