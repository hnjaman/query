[ update from deferent table]

MERGE INTO customer_personal_info cpi
     USING CUSTOMER_PHONE cp
        ON (CPI.CUSTOMER_ID = CP.CUSTOMER_ID)
WHEN MATCHED
THEN
   UPDATE SET cpi.MOBILE = cp.MOBILE_NEW

[ Remove characters from a mobile number]

update CUSTOMER_PHONE set mobile=REGEXP_REPLACE(mobile,'[^[:alnum:]'' '']', NULL) where  length(mobile)>=12
update CUSTOMER_PHONE set mobile=REGEXP_REPLACE(mobile, '[^0-9]+', '') where  length(mobile)>11

[ fraction value ]

select customer_id,double_burner,floor(double_burner) int1,trunc(double_burner) int2,
double_burner - floor(double_burner) fr1,double_burner - trunc(double_burner) fr2--,mod(wt,sign(wt)) fr3,remainder(wt,sign(wt)) fr4
FROM bill_non_metered
 WHERE bill_id LIKE '201806%'

[ duplicate meter delete]

delete from customer_meter where (customer_id, meter_id) in(
select customer_id, min(meter_id)  from customer_meter  where customer_id like '0410%'
group by customer_id having count(*)>1)

[ Delete duplicate data]

DELETE sales_report
WHERE rowid in
(SELECT min(rowid)
          FROM SALES_REPORT sr
         WHERE     SUBSTR (sr.customer_id, 1, 2) = '05'
               AND SUBSTR (sr.customer_id, 3, 2) = '01'
               AND sr.BILLING_MONTH = 8
               AND sr.BILLING_YEAR = 2018
               group by BILL_ID
               having count(BILL_ID)>1);

			   
[ duplicate data show]

SELECT *
  FROM BG_DELETED
 WHERE TOTAL_DEPOSIT IN
          (  SELECT TOTAL_DEPOSIT
               FROM BG_DELETED
           GROUP BY TOTAL_DEPOSIT
             HAVING COUNT (*) > 1)

[ 2nd highest value ]

SELECT *
  FROM (SELECT pid2.pid, ROWNUM rnum
          FROM (  SELECT *
                    FROM BURNER_QNT_CHANGE
                   WHERE APPLIANCE_TYPE_CODE NOT IN ('01', '02')
                ORDER BY pid DESC) pid2
         WHERE ROWNUM <= 2)
 WHERE rnum >= 2;
---------------------------------------
SELECT MAX (pid)
  FROM BURNER_QNT_CHANGE
 WHERE     APPLIANCE_TYPE_CODE NOT IN ('01', '02')
       AND pid <> (SELECT MAX (pid)
                     FROM BURNER_QNT_CHANGE
                    WHERE APPLIANCE_TYPE_CODE NOT IN ('01', '02'))
---------------------------------------
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