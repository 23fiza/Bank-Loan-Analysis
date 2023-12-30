SELECT * FROM bank_analysis.finance;


 ####-----KPI-1---Year-wise Loan Amount Stats------------####
select year(issue_d) as loan_year ,
count(*) as loan_count, sum(loan_amnt) as Total_loan
 from bank_analysis.finance Group by loan_year;
 
####-----KPI-2---Grade and Sub-Grade-wise Revolving Balance------------####
select grade, sub_grade , avg(revol_bal) as Avg_Revolving_Bal 
from bank_analysis.finance group by grade, sub_grade;

####-----KPI-3---Total Payment for Verified Status vs. Total Payment for Non-Verified Status------------####
select verification_status, Sum(total_pymnt) as Total_Payment
from bank_analysis.finance group by verification_status;

####-----KPI-4---State-wise and Month-wise Loan Status------------####
select addr_state, date_format(issue_d, '%y-%m')  as month_year , loan_status,
count(*) as loan_count from bank_analysis.finance
 group by addr_state, month_year, loan_status;
 
 ####-----KPI-5---Home Ownership vs. Last Payment Date Stats------------####
 
SELECT home_ownership, 
       AVG(DATEDIFF(last_pymnt_d, issue_d)) AS avg_days_to_last_payment,
       MIN(DATEDIFF(last_pymnt_d, issue_d)) AS min_days_to_last_payment,
       MAX(DATEDIFF(last_pymnt_d, issue_d)) AS max_days_to_last_payment
FROM bank_analysis.finance
WHERE last_pymnt_d IS NOT NULL
GROUP BY home_ownership;

####--------KPI-6-----Purpose-wise Loan Amount----####
Select purpose, count(*) as loan_count, avg(loan_amnt) as Avg_loan_amt
from bank_analysis.finance group by purpose;

####--------KPI-7-----Average Loan Amount by Purpose----####
SELECT purpose,
       AVG(loan_amnt) AS avg_loan_amount
FROM bank_analysis.finance
GROUP BY purpose;

####--------KPI-8-----Annual Income vs. Loan Amoun----####
SELECT FLOOR(annual_inc/10000) * 10000 AS income_range,
       AVG(loan_amnt) AS avg_loan_amount
FROM bank_analysis.finance
GROUP BY income_range
ORDER BY income_range;

####--------KPI-9-----Late Loan Payment Rate----####
SELECT COUNT(*) AS late_payments,
       (sum(delinq_2yrs) / (SELECT count(loan_amnt) FROM bank_analysis.finance)) * 100 AS late_payment_rate
FROM bank_analysis.finance;

####--------KPI-10-----Funded Amount vs. Loan Status----####
Select loan_status,
       AVG(funded_amnt) AS avg_funded_amount,
       AVG(loan_amnt) AS avg_loan_amount
From bank_analysis.finance
group by loan_status;

