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