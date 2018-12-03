http://103.94.135.151:8080/JGTDSL_WEB/getiPgDetailInfo.action?customerId=020110002

[pubali bank]
update bank_account_ledger set branch_id ='10211431', account_no='10211431' where trans_id in (
select trans_id from bank_account_ledger where --BRANCH_ID = '10211431' -- 10211412
 TRANS_DATE between TO_DATE('08/2018', 'MM/YYYY') and TO_DATE('08/31/2018', 'MM/DD/YYYY')
and INSERTED_BY='Assistant Manager Shayestagonj'
and customer_id like '13%'
and bank_id ='102114'
)


[ merge from diff table]

MERGE INTO bill_non_metered bnm
     USING (SELECT *
              FROM bill_coll_advanced
             WHERE BILL_ID LIKE '2018100101%') bca
        ON (bnm.bill_id = bca.bill_id)
WHEN MATCHED
THEN
   UPDATE SET bnm.COLLECTION_DATE = bca.TRANS_DATE,
              bnm.BRANCH_ID = bca.BRANCH_ID,
              bnm.COLLECTED_BILLED_AMOUNT = bnm.BILLED_AMOUNT,
              COLLECTED_PAYABLE_AMOUNT = ACTUAL_PAYABLE_AMOUNT,
              status = 2,
              BILL_TYPE = 3
           WHERE bnm.status = 1

[update from deferent table]

UPDATE bill_non_metered bnm
   SET (COLLECTION_DATE) = (SELECT BCA.TRANS_DATE
                         FROM bill_coll_advanced bca
                        WHERE bnm.bill_id = BCA.BILL_ID
                        AND BCA.BILL_ID = '201810010119907'),
       COLLECTED_BILLED_AMOUNT = BILLED_AMOUNT,
       COLLECTED_PAYABLE_AMOUNT = ACTUAL_PAYABLE_AMOUNT,
       status = 2,
       BILL_TYPE = 3,
       BRANCH_ID = (SELECT BCA.BRANCH_ID
                         FROM bill_coll_advanced bca
                        WHERE bnm.bill_id = BCA.BILL_ID
                        AND BCA.BILL_ID = '201810010119907')
 WHERE EXISTS (
    SELECT 1
      FROM bill_coll_advanced bca
      WHERE bnm.bill_id = BCA.BILL_ID 
      AND BCA.BILL_ID = '201810010119907')

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