[ duplicate data show]

SELECT *
  FROM BG_DELETED
 WHERE TOTAL_DEPOSIT IN
          (  SELECT TOTAL_DEPOSIT
               FROM BG_DELETED
           GROUP BY TOTAL_DEPOSIT
             HAVING COUNT (*) > 1)

[ 2nd highest value ]

SELECT MAX (TOTAL_DEPOSIT)
  FROM BG_DELETED
 WHERE total_deposit NOT IN (SELECT MAX (TOTAL_DEPOSIT)
                               FROM BG_DELETED)

[ Delete demand note bill ]

delete from BILL_NON_METERED where bill_id in ((SELECT 201801||customer_id bill_id
   FROM bill_non_metered
  WHERE bill_id LIKE '2018010301%')
 minus
 (
 SELECT 201801||customer_id bill_id
   FROM bill_non_metered
  WHERE bill_id LIKE '2017120301%'
 ) );
 
delete from BILL_NM_DTL where bill_id in ((SELECT 201801||customer_id bill_id
   FROM bill_non_metered
  WHERE bill_id LIKE '2018010301%')
 minus
 (
 SELECT 201801||customer_id bill_id
   FROM bill_non_metered
  WHERE bill_id LIKE '2017120301%'
 ) );
 
delete from SALES_REPORT where bill_id in ((SELECT 201801||customer_id bill_id
   FROM bill_non_metered
  WHERE bill_id LIKE '2018010301%')
 minus
 (
 SELECT 201801||customer_id bill_id
   FROM bill_non_metered
  WHERE bill_id LIKE '2017120301%'
 ) );