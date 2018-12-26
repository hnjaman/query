(SELECT sum(ADVANCED_AMOUNT), 1 flag
  FROM bill_coll_advanced
 WHERE customer_id IN
          (SELECT AA.CUSTOMER_ID customer_id
             FROM (  SELECT customer_id
                       FROM bill_non_metered
                      WHERE     SUBSTR (bill_id, 1, 10) BETWEEN '2017070101'
                                                            AND '2018060101'
                            AND status = 1
                   GROUP BY customer_id
                     HAVING COUNT (customer_id) <= 3) aa,
                  customer_connection cc
            WHERE AA.CUSTOMER_ID = CC.CUSTOMER_ID AND CC.STATUS = 1)
            and status=1
union 

SELECT sum(ADVANCED_AMOUNT), 2 flag
  FROM bill_coll_advanced
 WHERE customer_id IN
          (SELECT AA.CUSTOMER_ID customer_id
             FROM (  SELECT customer_id
                       FROM bill_non_metered
                      WHERE     SUBSTR (bill_id, 1, 10) BETWEEN '2017070101'
                                                            AND '2018060101'
                            AND status = 1
                   GROUP BY customer_id
                     HAVING COUNT (customer_id) > 3) aa,
                  customer_connection cc
            WHERE AA.CUSTOMER_ID = CC.CUSTOMER_ID AND CC.STATUS = 1)
            and status=1  

union ----

SELECT sum(ADVANCED_AMOUNT), 3 flag
  FROM bill_coll_advanced
 WHERE customer_id IN
          (SELECT AA.CUSTOMER_ID customer_id
             FROM (  SELECT customer_id
                       FROM bill_non_metered
                      WHERE     SUBSTR (bill_id, 1, 10) BETWEEN '2017070109'
                                                            AND '2018060109'
                            AND status = 1
                   GROUP BY customer_id
                     HAVING COUNT (customer_id) <= 3) aa,
                  customer_connection cc
            WHERE AA.CUSTOMER_ID = CC.CUSTOMER_ID AND CC.STATUS = 1)
            and status=1
union 

SELECT sum(ADVANCED_AMOUNT), 4 flag
  FROM bill_coll_advanced
 WHERE customer_id IN
          (SELECT AA.CUSTOMER_ID customer_id
             FROM (  SELECT customer_id
                       FROM bill_non_metered
                      WHERE     SUBSTR (bill_id, 1, 10) BETWEEN '2017070109'
                                                            AND '2018060109'
                            AND status = 1
                   GROUP BY customer_id
                     HAVING COUNT (customer_id) > 3) aa,
                  customer_connection cc
            WHERE AA.CUSTOMER_ID = CC.CUSTOMER_ID AND CC.STATUS = 1)
            and status=1  )
order by flag