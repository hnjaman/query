SELECT *
    FROM (SELECT COUNT (customer_id) customer_no,   -- <=3 + conn + pvt
                 SUM (single_burner) single_burner,
                 SUM (double_burner) double_burner,
                 SUM (others_burner) others_burner,
                 1 flag
            FROM bill_non_metered
           WHERE bill_id IN
                    (SELECT 201806 || AA.CUSTOMER_ID bill_id
                       FROM (  SELECT customer_id
                                 FROM bill_non_metered
                                WHERE     SUBSTR (bill_id, 1, 10) BETWEEN '2017070101'
                                                                      AND '2018060101'
                                      AND status = 1
                             GROUP BY customer_id
                               HAVING COUNT (customer_id) <= 3) aa,
                            customer_connection cc
                      WHERE AA.CUSTOMER_ID = CC.CUSTOMER_ID AND CC.STATUS = 1)
          UNION 
          SELECT COUNT (customer_id),      -- >3 + conn + pvt
                 SUM (single_burner),
                 SUM (double_burner),
                 SUM (others_burner),
                 2 flag
            FROM bill_non_metered
           WHERE bill_id IN
                    (SELECT 201806 || AA.CUSTOMER_ID bill_id
                       FROM (  SELECT customer_id
                                 FROM bill_non_metered
                                WHERE     SUBSTR (bill_id, 1, 10) BETWEEN '2017070101'
                                                                      AND '2018060101'
                                      AND status = 1
                             GROUP BY customer_id
                               HAVING COUNT (customer_id) > 3) aa,
                            customer_connection cc
                      WHERE AA.CUSTOMER_ID = CC.CUSTOMER_ID AND CC.STATUS = 1)
          UNION
          SELECT COUNT (customer_id), -- <=3 + conn + govt
                 SUM (single_burner),
                 SUM (double_burner),
                 SUM (others_burner),
                 3 flag
            FROM bill_non_metered
           WHERE bill_id IN
                    (SELECT 201806 || AA.CUSTOMER_ID bill_id
                       FROM (  SELECT customer_id
                                 FROM bill_non_metered
                                WHERE     SUBSTR (bill_id, 1, 10) BETWEEN '2017070109'
                                                                      AND '2018060109'
                                      AND status = 1
                             GROUP BY customer_id
                               HAVING COUNT (customer_id) <= 3) aa,
                            customer_connection cc
                      WHERE AA.CUSTOMER_ID = CC.CUSTOMER_ID AND CC.STATUS = 1)
          UNION
          SELECT COUNT (customer_id), -- >3 + conn + govt
                 SUM (single_burner),
                 SUM (double_burner),
                 SUM (others_burner),
                 4 flag
            FROM bill_non_metered
           WHERE bill_id IN
                    (SELECT 201806 || AA.CUSTOMER_ID bill_id
                       FROM (  SELECT customer_id
                                 FROM bill_non_metered
                                WHERE     SUBSTR (bill_id, 1, 10) BETWEEN '2017070109'
                                                                      AND '2018060109'
                                      AND status = 1
                             GROUP BY customer_id
                               HAVING COUNT (customer_id) > 3) aa,
                            customer_connection cc
                      WHERE AA.CUSTOMER_ID = CC.CUSTOMER_ID AND CC.STATUS = 1))
ORDER BY flag