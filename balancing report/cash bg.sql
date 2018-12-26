SELECT SUM (CASH), SUM (BG), 1 flag
    FROM (SELECT md.CUSTOMER_ID, 0 CASH, TOTAL_DEPOSIT BG
            FROM mst_deposit md,
                 (SELECT AA.CUSTOMER_ID CUSTOMER_ID
                    FROM (  SELECT customer_id
                              FROM bill_metered
                             WHERE     SUBSTR (bill_id, 1, 10) BETWEEN '2017070101'
                                                                   AND '2018060101'
                                   AND status = 1
                          GROUP BY customer_id
                            HAVING COUNT (customer_id) <= 3) aa,
                         customer_connection cc
                   WHERE AA.CUSTOMER_ID = CC.CUSTOMER_ID AND CC.STATUS = 1) bb
           WHERE     MD.CUSTOMER_ID = BB.CUSTOMER_ID
                 AND DEPOSIT_PURPOSE = 1
                 AND DEPOSIT_TYPE = 1
                 AND MD.CUSTOMER_ID LIKE '0107%'
          UNION ALL
          SELECT md.CUSTOMER_ID, TOTAL_DEPOSIT CASH, 0 BG
            FROM mst_deposit md,
                 (SELECT AA.CUSTOMER_ID CUSTOMER_ID
                    FROM (  SELECT customer_id
                              FROM bill_metered
                             WHERE     SUBSTR (bill_id, 1, 10) BETWEEN '2017070101'
                                                                   AND '2018060101'
                                   AND status = 1
                          GROUP BY customer_id
                            HAVING COUNT (customer_id) <= 3) aa,
                         customer_connection cc
                   WHERE AA.CUSTOMER_ID = CC.CUSTOMER_ID AND CC.STATUS = 1) bb
           WHERE     MD.CUSTOMER_ID = BB.CUSTOMER_ID
                 AND DEPOSIT_PURPOSE = 1
                 AND DEPOSIT_TYPE = 0
                 AND MD.CUSTOMER_ID LIKE '0107%') temp
GROUP BY temp.CUSTOMER_ID

union

SELECT SUM (nvl(CASH,0)), SUM (nvl(BG,0)), 2 flag
    FROM (SELECT md.CUSTOMER_ID, 0 CASH, TOTAL_DEPOSIT BG
            FROM mst_deposit md,
                 (SELECT AA.CUSTOMER_ID CUSTOMER_ID
                    FROM (  SELECT customer_id
                              FROM bill_metered
                             WHERE     SUBSTR (bill_id, 1, 10) BETWEEN '2017070101'
                                                                   AND '2018060101'
                                   AND status = 1
                          GROUP BY customer_id
                            HAVING COUNT (customer_id) > 3) aa,
                         customer_connection cc
                   WHERE AA.CUSTOMER_ID = CC.CUSTOMER_ID AND CC.STATUS = 1) bb
           WHERE     MD.CUSTOMER_ID = BB.CUSTOMER_ID
                 AND DEPOSIT_PURPOSE = 1
                 AND DEPOSIT_TYPE = 1
                 AND MD.CUSTOMER_ID LIKE '0107%'
          UNION ALL
          SELECT md.CUSTOMER_ID, TOTAL_DEPOSIT CASH, 0 BG
            FROM mst_deposit md,
                 (SELECT AA.CUSTOMER_ID CUSTOMER_ID
                    FROM (  SELECT customer_id
                              FROM bill_metered
                             WHERE     SUBSTR (bill_id, 1, 10) BETWEEN '2017070101'
                                                                   AND '2018060101'
                                   AND status = 1
                          GROUP BY customer_id
                            HAVING COUNT (customer_id) > 3) aa,
                         customer_connection cc
                   WHERE AA.CUSTOMER_ID = CC.CUSTOMER_ID AND CC.STATUS = 1) bb
           WHERE     MD.CUSTOMER_ID = BB.CUSTOMER_ID
                 AND DEPOSIT_PURPOSE = 1
                 AND DEPOSIT_TYPE = 0
                 AND MD.CUSTOMER_ID LIKE '0107%') temp
GROUP BY temp.CUSTOMER_ID

union 

SELECT SUM (CASH), SUM (BG), 1 flag
    FROM (SELECT md.CUSTOMER_ID, 0 CASH, TOTAL_DEPOSIT BG
            FROM mst_deposit md,
                 (SELECT AA.CUSTOMER_ID CUSTOMER_ID
                    FROM (  SELECT customer_id
                              FROM bill_metered
                             WHERE     SUBSTR (bill_id, 1, 10) BETWEEN '2017070109'
                                                                   AND '2018060109'
                                   AND status = 1
                          GROUP BY customer_id
                            HAVING COUNT (customer_id) <= 3) aa,
                         customer_connection cc
                   WHERE AA.CUSTOMER_ID = CC.CUSTOMER_ID AND CC.STATUS = 1) bb
           WHERE     MD.CUSTOMER_ID = BB.CUSTOMER_ID
                 AND DEPOSIT_PURPOSE = 1
                 AND DEPOSIT_TYPE = 1
                 AND MD.CUSTOMER_ID LIKE '0107%'
          UNION ALL
          SELECT md.CUSTOMER_ID, TOTAL_DEPOSIT CASH, 0 BG
            FROM mst_deposit md,
                 (SELECT AA.CUSTOMER_ID CUSTOMER_ID
                    FROM (  SELECT customer_id
                              FROM bill_metered
                             WHERE     SUBSTR (bill_id, 1, 10) BETWEEN '2017070109'
                                                                   AND '2018060109'
                                   AND status = 1
                          GROUP BY customer_id
                            HAVING COUNT (customer_id) <= 3) aa,
                         customer_connection cc
                   WHERE AA.CUSTOMER_ID = CC.CUSTOMER_ID AND CC.STATUS = 1) bb
           WHERE     MD.CUSTOMER_ID = BB.CUSTOMER_ID
                 AND DEPOSIT_PURPOSE = 1
                 AND DEPOSIT_TYPE = 0
                 AND MD.CUSTOMER_ID LIKE '0107%') temp
GROUP BY temp.CUSTOMER_ID
union
SELECT SUM (CASH), SUM (BG), 2 flag
    FROM (SELECT md.CUSTOMER_ID, 0 CASH, TOTAL_DEPOSIT BG
            FROM mst_deposit md,
                 (SELECT AA.CUSTOMER_ID CUSTOMER_ID
                    FROM (  SELECT customer_id
                              FROM bill_metered
                             WHERE     SUBSTR (bill_id, 1, 10) BETWEEN '2017070109'
                                                                   AND '2018060109'
                                   AND status = 1
                          GROUP BY customer_id
                            HAVING COUNT (customer_id) > 3) aa,
                         customer_connection cc
                   WHERE AA.CUSTOMER_ID = CC.CUSTOMER_ID AND CC.STATUS = 1) bb
           WHERE     MD.CUSTOMER_ID = BB.CUSTOMER_ID
                 AND DEPOSIT_PURPOSE = 1
                 AND DEPOSIT_TYPE = 1
                 AND MD.CUSTOMER_ID LIKE '0107%'
          UNION ALL
          SELECT md.CUSTOMER_ID, TOTAL_DEPOSIT CASH, 0 BG
            FROM mst_deposit md,
                 (SELECT AA.CUSTOMER_ID CUSTOMER_ID
                    FROM (  SELECT customer_id
                              FROM bill_metered
                             WHERE     SUBSTR (bill_id, 1, 10) BETWEEN '2017070109'
                                                                   AND '2018060109'
                                   AND status = 1
                          GROUP BY customer_id
                            HAVING COUNT (customer_id) > 3) aa,
                         customer_connection cc
                   WHERE AA.CUSTOMER_ID = CC.CUSTOMER_ID AND CC.STATUS = 1) bb
           WHERE     MD.CUSTOMER_ID = BB.CUSTOMER_ID
                 AND DEPOSIT_PURPOSE = 1
                 AND DEPOSIT_TYPE = 0
                 AND MD.CUSTOMER_ID LIKE '0107%') temp
GROUP BY temp.CUSTOMER_ID