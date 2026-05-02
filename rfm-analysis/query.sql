-- Step 1: Append all monthly sales tables together

CREATE OR REPLACE TABLE `rfm-analysis-495110.sales.sales_2025` AS
SELECT * FROM `rfm-analysis-495110.sales.sales202501` 
UNION ALL SELECT * FROM `rfm-analysis-495110.sales.sales202502`
UNION ALL SELECT * FROM `rfm-analysis-495110.sales.sales202503`
UNION ALL SELECT * FROM `rfm-analysis-495110.sales.sales202504`
UNION ALL SELECT * FROM `rfm-analysis-495110.sales.sales202505`
UNION ALL SELECT * FROM `rfm-analysis-495110.sales.sales202506`
UNION ALL SELECT * FROM `rfm-analysis-495110.sales.sales202507`
UNION ALL SELECT * FROM `rfm-analysis-495110.sales.sales202508`
UNION ALL SELECT * FROM `rfm-analysis-495110.sales.sales202509`
UNION ALL SELECT * FROM `rfm-analysis-495110.sales.sales202510`
UNION ALL SELECT * FROM `rfm-analysis-495110.sales.sales202511`
UNION ALL SELECT * FROM `rfm-analysis-495110.sales.sales202512_new` ;

-- step 2: Calculate recency,frequency and monetary r,f,m ranks
-- Combine views with CTE's
CREATE OR REPLACE VIEW `rfm-analysis-495110.sales.rfm_metrics` AS

WITH current_date AS (
    SELECT DATE('2026-05-02') AS analysis_date
),

rfm AS (
    SELECT 
        CustomerID,
        MAX(OrderDate) AS last_order_date,
        
        DATE_DIFF(
            (SELECT analysis_date FROM current_date),
            MAX(OrderDate),
            DAY
        ) AS recency,
        
        COUNT(*) AS frequency,
        SUM(OrderValue) AS monetary
        
    FROM `rfm-analysis-495110.sales.sales_2025`
    GROUP BY CustomerID
)

SELECT 
    CustomerID,
    last_order_date,
    recency,
    frequency,
    monetary,

    ROW_NUMBER() OVER (ORDER BY recency ASC) AS r_rank,
    ROW_NUMBER() OVER (ORDER BY frequency DESC) AS f_rank,
    ROW_NUMBER() OVER (ORDER BY monetary DESC) AS m_rank

FROM rfm;

-- step 3 : Assign deciles (best = 10 , worst = 1)

create or replace view `rfm-analysis-495110.sales.rfm_scores`
as 
select 
*,
ntile(10) over(order by r_rank desc) as r_score,
ntile(10) over(order by f_rank desc) as f_score,
ntile(10) over(order by m_rank desc) as m_score

from `rfm-analysis-495110.sales.rfm_metrics`;


-- step 4 : Total Scores 

create or replace view `rfm-analysis-495110.sales.rfm_total_score` 
as 
select 
    CustomerID,
    recency,
    frequency,
    monetary,
    r_score,f_score,m_score,
    (r_score+ f_score + m_score) rfm_total_score 
from `rfm-analysis-495110.sales.rfm_scores`
order by rfm_total_score desc;


-- step 5 : BI ready rfm segement table

create or replace table `rfm-analysis-495110.sales.rfm_final_segement_table`
as 
select 
    CustomerID,
    recency,
    frequency,
    monetary,
    r_score,f_score,m_score,
    rfm_total_score,
    CASE 
    when rfm_total_score >= 28 then "VIP Campions Customers"
    when rfm_total_score >= 24 then "Loyal Customers"
    when rfm_total_score >= 20 then "Potential Loyalists"
    when rfm_total_score >= 16 then "Promising"
    when rfm_total_score >= 12 then "Engaged"
    when rfm_total_score >= 8 then "Need Attention"
    when rfm_total_score >= 4 then "At Risk"
    else "Lost/In-active" 
    end as rfm_segement
  from `rfm-analysis-495110.sales.rfm_total_score`
  order by rfm_total_score desc;
 















 