--[ separate bank branch update ]

-- # check bank branch 
SELECT *
  FROM mst_branch_info
 WHERE bank_id IN
          (SELECT BANK_ID
             FROM mst_bank_info
            WHERE     area_id IN (14, 15)
                  AND STATUS = 1
                  AND BANK_NAME NOT IN ('Grameenphone', 'ROBI'))
                  and STATUS = 1
-- # select 
select * from bank_account_ledger
where customer_id like '15%'
and branch_id = '10201110'
union 
select * from bank_account_ledger
where customer_id like '14%'
and branch_id = '10201110'

				  
--# bank_account_ledger
update bank_account_ledger set branch_id='10208715', ACCOUNT_NO='10208715'
where TRANS_ID in(
select TRANS_ID from bank_account_ledger
where customer_id like '15%'
and branch_id = '10208711'
union 
select TRANS_ID from bank_account_ledger
where customer_id like '14%'
and branch_id = '10201110'
)


--[ multiple like operation ]

UPDATE customer_connection
   SET PAY_WITHIN_WO_SC = 20, PAY_WITHIN_W_SC = 40
 WHERE customer_id IN (SELECT customer_id
                         FROM customer_connection
                        WHERE customer_id LIKE '1402%'
                       UNION
                       SELECT customer_id
                         FROM customer_connection
                        WHERE customer_id LIKE '1502%'
                       UNION
                       SELECT customer_id
                         FROM customer_connection
                        WHERE customer_id LIKE '1403%'
                       UNION
                       SELECT customer_id
                         FROM customer_connection
                        WHERE customer_id LIKE '1503%'
                       UNION
                       SELECT customer_id
                         FROM customer_connection
                        WHERE customer_id LIKE '1410%'
                       UNION
                       SELECT customer_id
                         FROM customer_connection
                        WHERE customer_id LIKE '1510%'
                       UNION
                       SELECT customer_id
                         FROM customer_connection
                        WHERE customer_id LIKE '1406%'
                       UNION
                       SELECT customer_id
                         FROM customer_connection
                        WHERE customer_id LIKE '1506%'
                       UNION
                       SELECT customer_id
                         FROM customer_connection
                        WHERE customer_id LIKE '1405%'
                       UNION
                       SELECT customer_id
                         FROM customer_connection
                        WHERE customer_id LIKE '1505%'
                       UNION
                       SELECT customer_id
                         FROM customer_connection
                        WHERE customer_id LIKE '1404%'
                       UNION
                       SELECT customer_id
                         FROM customer_connection
                        WHERE customer_id LIKE '1504%')