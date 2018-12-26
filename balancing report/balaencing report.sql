/* Formatted on 12/26/2018 12:32:11 PM (QP5 v5.287) */
SELECT *
  FROM (SELECT *
          FROM (SELECT COUNT (customer_id) customer_no,
                       SUM (single_burner) single_burner,
                       SUM (double_burner) double_burner,
                       SUM (others_burner) others_burner,
                       'Cb3D' flag
                  FROM bill_non_metered
                 WHERE bill_id IN
                          (SELECT 201806 || AA.CUSTOMER_ID bill_id
                             FROM (  SELECT customer_id
                                       FROM bill_non_metered
                                      WHERE     SUBSTR (bill_id, 1, 10) BETWEEN '2017070101'
                                                                            AND '2018060101'
                                            AND status = 1
                                            and CUSTOMER_CATEGORY = 01
                                            and area_id = 01
                                   GROUP BY customer_id
                                     HAVING COUNT (customer_id) <= 3) aa,
                                  customer_connection cc
                            WHERE     AA.CUSTOMER_ID = CC.CUSTOMER_ID
                                  AND CC.STATUS = 1)
                UNION
                SELECT COUNT (customer_id),
                       SUM (single_burner),
                       SUM (double_burner),
                       SUM (others_burner),
                       'Ca3D' flag
                  FROM bill_non_metered
                 WHERE bill_id IN
                          (SELECT 201806 || AA.CUSTOMER_ID bill_id
                             FROM (  SELECT customer_id
                                       FROM bill_non_metered
                                      WHERE     SUBSTR (bill_id, 1, 10) BETWEEN '2017070101'
                                                                            AND '2018060101'
                                            AND status = 1
                                            and CUSTOMER_CATEGORY = 01
                                            and area_id = 01
                                   GROUP BY customer_id
                                     HAVING COUNT (customer_id) > 3) aa,
                                  customer_connection cc
                            WHERE     AA.CUSTOMER_ID = CC.CUSTOMER_ID
                                  AND CC.STATUS = 1)
                UNION
                SELECT COUNT (customer_id),
                       SUM (single_burner),
                       SUM (double_burner),
                       SUM (others_burner),
                       'Cb3G' flag
                  FROM bill_non_metered
                 WHERE bill_id IN
                          (SELECT 201806 || AA.CUSTOMER_ID bill_id
                             FROM (  SELECT customer_id
                                       FROM bill_non_metered
                                      WHERE     SUBSTR (bill_id, 1, 10) BETWEEN '2017070109'
                                                                            AND '2018060109'
                                            AND status = 1
                                            and CUSTOMER_CATEGORY = 09
                                            and area_id = 01
                                   GROUP BY customer_id
                                     HAVING COUNT (customer_id) <= 3) aa,
                                  customer_connection cc
                            WHERE     AA.CUSTOMER_ID = CC.CUSTOMER_ID
                                  AND CC.STATUS = 1)
                UNION
                SELECT COUNT (customer_id),
                       SUM (single_burner),
                       SUM (double_burner),
                       SUM (others_burner),
                       'Ca3G' flag
                  FROM bill_non_metered
                 WHERE bill_id IN
                          (SELECT 201806 || AA.CUSTOMER_ID bill_id
                             FROM (  SELECT customer_id
                                       FROM bill_non_metered
                                      WHERE     SUBSTR (bill_id, 1, 10) BETWEEN '2017070109'
                                                                            AND '2018060109'
                                            AND status = 1
                                            and CUSTOMER_CATEGORY = 09
                                            and area_id = 01
                                   GROUP BY customer_id
                                     HAVING COUNT (customer_id) > 3) aa,
                                  customer_connection cc
                            WHERE     AA.CUSTOMER_ID = CC.CUSTOMER_ID
                                  AND CC.STATUS = 1))) tm1,
       ((SELECT SUM (ADVANCED_AMOUNT) ADVANCE_TOTAL, 'Cb3D' flag
           FROM bill_coll_advanced
          WHERE     customer_id IN
                       (SELECT AA.CUSTOMER_ID customer_id
                          FROM (  SELECT customer_id
                                    FROM bill_non_metered
                                   WHERE     SUBSTR (bill_id, 1, 10) BETWEEN '2017070101'
                                                                         AND '2018060101'
                                         AND status = 1
                                         and CUSTOMER_CATEGORY = 01
                                         and area_id = 01
                                GROUP BY customer_id
                                  HAVING COUNT (customer_id) <= 3) aa,
                               customer_connection cc
                         WHERE     AA.CUSTOMER_ID = CC.CUSTOMER_ID
                               AND CC.STATUS = 1)
                AND status = 1
         UNION
         SELECT SUM (ADVANCED_AMOUNT) ADVANCE_TOTAL, 'Ca3D' flag
           FROM bill_coll_advanced
          WHERE     customer_id IN
                       (SELECT AA.CUSTOMER_ID customer_id
                          FROM (  SELECT customer_id
                                    FROM bill_non_metered
                                   WHERE     SUBSTR (bill_id, 1, 10) BETWEEN '2017070101'
                                                                         AND '2018060101'
                                         AND status = 1
                                         and CUSTOMER_CATEGORY = 01
                                         and area_id = 01
                                GROUP BY customer_id
                                  HAVING COUNT (customer_id) > 3) aa,
                               customer_connection cc
                         WHERE     AA.CUSTOMER_ID = CC.CUSTOMER_ID
                               AND CC.STATUS = 1)
                AND status = 1
         UNION
         SELECT SUM (ADVANCED_AMOUNT) ADVANCE_TOTAL, 'Cb3G' flag
           FROM bill_coll_advanced
          WHERE     customer_id IN
                       (SELECT AA.CUSTOMER_ID customer_id
                          FROM (  SELECT customer_id
                                    FROM bill_non_metered
                                   WHERE     SUBSTR (bill_id, 1, 10) BETWEEN '2017070109'
                                                                         AND '2018060109'
                                         AND status = 1
                                         and CUSTOMER_CATEGORY = 09
                                         and area_id = 01
                                GROUP BY customer_id
                                  HAVING COUNT (customer_id) <= 3) aa,
                               customer_connection cc
                         WHERE     AA.CUSTOMER_ID = CC.CUSTOMER_ID
                               AND CC.STATUS = 1)
                AND status = 1
         UNION
         SELECT SUM (ADVANCED_AMOUNT) ADVANCE_TOTAL, 'Ca3G' flag
           FROM bill_coll_advanced
          WHERE     customer_id IN
                       (SELECT AA.CUSTOMER_ID customer_id
                          FROM (  SELECT customer_id
                                    FROM bill_non_metered
                                   WHERE     SUBSTR (bill_id, 1, 10) BETWEEN '2017070109'
                                                                         AND '2018060109'
                                         AND status = 1
                                         and CUSTOMER_CATEGORY = 09
                                         and area_id = 01
                                GROUP BY customer_id
                                  HAVING COUNT (customer_id) > 3) aa,
                               customer_connection cc
                         WHERE     AA.CUSTOMER_ID = CC.CUSTOMER_ID
                               AND CC.STATUS = 1)
                AND status = 1)) tm2,
       (SELECT SUM (CASH), SUM (BG), 'Cb3D' flag
          FROM (SELECT md.CUSTOMER_ID, 0 CASH, TOTAL_DEPOSIT BG
                  FROM mst_deposit md,
                       (SELECT AA.CUSTOMER_ID CUSTOMER_ID
                          FROM (  SELECT customer_id
                                    FROM bill_non_metered
                                   WHERE     SUBSTR (bill_id, 1, 10) BETWEEN '2017070101'
                                                                         AND '2018060101'
                                         AND status = 1
                                         and CUSTOMER_CATEGORY = 01
                                         and area_id = 01
                                GROUP BY customer_id
                                  HAVING COUNT (customer_id) <= 3) aa,
                               customer_connection cc
                         WHERE     AA.CUSTOMER_ID = CC.CUSTOMER_ID
                               AND CC.STATUS = 1) bb
                 WHERE     MD.CUSTOMER_ID = BB.CUSTOMER_ID
                       AND DEPOSIT_PURPOSE = 1
                       AND DEPOSIT_TYPE = 1
                       AND MD.CUSTOMER_ID LIKE '0101%'
                UNION ALL
                SELECT md.CUSTOMER_ID, TOTAL_DEPOSIT CASH, 0 BG
                  FROM mst_deposit md,
                       (SELECT AA.CUSTOMER_ID CUSTOMER_ID
                          FROM (  SELECT customer_id
                                    FROM bill_non_metered
                                   WHERE     SUBSTR (bill_id, 1, 10) BETWEEN '2017070101'
                                                                         AND '2018060101'
                                         AND status = 1
                                         and CUSTOMER_CATEGORY = 01
                                         and area_id = 01
                                GROUP BY customer_id
                                  HAVING COUNT (customer_id) <= 3) aa,
                               customer_connection cc
                         WHERE     AA.CUSTOMER_ID = CC.CUSTOMER_ID
                               AND CC.STATUS = 1) bb
                 WHERE     MD.CUSTOMER_ID = BB.CUSTOMER_ID
                       AND DEPOSIT_PURPOSE = 1
                       AND DEPOSIT_TYPE = 0
                       AND MD.CUSTOMER_ID LIKE '0101%')
        UNION
        SELECT SUM (CASH), SUM (BG), 'Ca3D' flag
          FROM (SELECT md.CUSTOMER_ID, 0 CASH, TOTAL_DEPOSIT BG
                  FROM mst_deposit md,
                       (SELECT AA.CUSTOMER_ID CUSTOMER_ID
                          FROM (  SELECT customer_id
                                    FROM bill_non_metered
                                   WHERE     SUBSTR (bill_id, 1, 10) BETWEEN '2017070101'
                                                                         AND '2018060101'
                                         AND status = 1
                                         and CUSTOMER_CATEGORY = 01
                                         and area_id = 01
                                GROUP BY customer_id
                                  HAVING COUNT (customer_id) > 3) aa,
                               customer_connection cc
                         WHERE     AA.CUSTOMER_ID = CC.CUSTOMER_ID
                               AND CC.STATUS = 1) bb
                 WHERE     MD.CUSTOMER_ID = BB.CUSTOMER_ID
                       AND DEPOSIT_PURPOSE = 1
                       AND DEPOSIT_TYPE = 1
                       AND MD.CUSTOMER_ID LIKE '0101%'
                UNION ALL
                SELECT md.CUSTOMER_ID, TOTAL_DEPOSIT CASH, 0 BG
                  FROM mst_deposit md,
                       (SELECT AA.CUSTOMER_ID CUSTOMER_ID
                          FROM (  SELECT customer_id
                                    FROM bill_non_metered
                                   WHERE     SUBSTR (bill_id, 1, 10) BETWEEN '2017070101'
                                                                         AND '2018060101'
                                         AND status = 1
                                         and CUSTOMER_CATEGORY = 01
                                         and area_id = 01
                                GROUP BY customer_id
                                  HAVING COUNT (customer_id) > 3) aa,
                               customer_connection cc
                         WHERE     AA.CUSTOMER_ID = CC.CUSTOMER_ID
                               AND CC.STATUS = 1) bb
                 WHERE     MD.CUSTOMER_ID = BB.CUSTOMER_ID
                       AND DEPOSIT_PURPOSE = 1
                       AND DEPOSIT_TYPE = 0
                       AND MD.CUSTOMER_ID LIKE '0101%')
        UNION
        SELECT SUM (CASH), SUM (BG), 'Cb3G' flag
          FROM (SELECT md.CUSTOMER_ID, 0 CASH, TOTAL_DEPOSIT BG
                  FROM mst_deposit md,
                       (SELECT AA.CUSTOMER_ID CUSTOMER_ID
                          FROM (  SELECT customer_id
                                    FROM bill_non_metered
                                   WHERE     SUBSTR (bill_id, 1, 10) BETWEEN '2017070109'
                                                                         AND '2018060109'
                                         AND status = 1
                                         and CUSTOMER_CATEGORY = 09
                                         and area_id = 01
                                GROUP BY customer_id
                                  HAVING COUNT (customer_id) <= 3) aa,
                               customer_connection cc
                         WHERE     AA.CUSTOMER_ID = CC.CUSTOMER_ID
                               AND CC.STATUS = 1) bb
                 WHERE     MD.CUSTOMER_ID = BB.CUSTOMER_ID
                       AND DEPOSIT_PURPOSE = 1
                       AND DEPOSIT_TYPE = 1
                       AND MD.CUSTOMER_ID LIKE '0109%'
                UNION ALL
                SELECT md.CUSTOMER_ID, TOTAL_DEPOSIT CASH, 0 BG
                  FROM mst_deposit md,
                       (SELECT AA.CUSTOMER_ID CUSTOMER_ID
                          FROM (  SELECT customer_id
                                    FROM bill_non_metered
                                   WHERE     SUBSTR (bill_id, 1, 10) BETWEEN '2017070109'
                                                                         AND '2018060109'
                                         AND status = 1
                                         and CUSTOMER_CATEGORY = 09
                                         and area_id = 01
                                GROUP BY customer_id
                                  HAVING COUNT (customer_id) <= 3) aa,
                               customer_connection cc
                         WHERE     AA.CUSTOMER_ID = CC.CUSTOMER_ID
                               AND CC.STATUS = 1) bb
                 WHERE     MD.CUSTOMER_ID = BB.CUSTOMER_ID
                       AND DEPOSIT_PURPOSE = 1
                       AND DEPOSIT_TYPE = 0
                       AND MD.CUSTOMER_ID LIKE '0109%')
        UNION
        SELECT SUM (CASH), SUM (BG), 'Ca3G' flag
          FROM (SELECT md.CUSTOMER_ID, 0 CASH, TOTAL_DEPOSIT BG
                  FROM mst_deposit md,
                       (SELECT AA.CUSTOMER_ID CUSTOMER_ID
                          FROM (  SELECT customer_id
                                    FROM bill_non_metered
                                   WHERE     SUBSTR (bill_id, 1, 10) BETWEEN '2017070109'
                                                                         AND '2018060109'
                                         AND status = 1
                                         and CUSTOMER_CATEGORY = 09
                                         and area_id = 01
                                GROUP BY customer_id
                                  HAVING COUNT (customer_id) > 3) aa,
                               customer_connection cc
                         WHERE     AA.CUSTOMER_ID = CC.CUSTOMER_ID
                               AND CC.STATUS = 1) bb
                 WHERE     MD.CUSTOMER_ID = BB.CUSTOMER_ID
                       AND DEPOSIT_PURPOSE = 1
                       AND DEPOSIT_TYPE = 1
                       AND MD.CUSTOMER_ID LIKE '0109%'
                UNION ALL
                SELECT md.CUSTOMER_ID, TOTAL_DEPOSIT CASH, 0 BG
                  FROM mst_deposit md,
                       (SELECT AA.CUSTOMER_ID CUSTOMER_ID
                          FROM (  SELECT customer_id
                                    FROM bill_non_metered
                                   WHERE     SUBSTR (bill_id, 1, 10) BETWEEN '2017070109'
                                                                         AND '2018060109'
                                         AND status = 1
                                         and CUSTOMER_CATEGORY = 09
                                         and area_id = 01
                                GROUP BY customer_id
                                  HAVING COUNT (customer_id) > 3) aa,
                               customer_connection cc
                         WHERE     AA.CUSTOMER_ID = CC.CUSTOMER_ID
                               AND CC.STATUS = 1) bb
                 WHERE     MD.CUSTOMER_ID = BB.CUSTOMER_ID
                       AND DEPOSIT_PURPOSE = 1
                       AND DEPOSIT_TYPE = 0
                       AND MD.CUSTOMER_ID LIKE '0109%')) tm3
 WHERE tm1.flag = tm2.flag AND tm1.flag = tm3.flag