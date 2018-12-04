--[I activation key]
--slashed
--BT20030411bt

--[delete bill meter]

Delete BILLING_READING_MAP Where Bill_Id like '201801011000070%';
Delete BILL_METERED Where Bill_Id like '201801011000070%';             
Delete DTL_MARGIN_GOVT Where Bill_Id like '201801011000070%';
Delete DTL_MARGIN_PB Where Bill_Id like '201801011000070%';
Delete SUMMARY_MARGIN_GOVT Where Bill_Id like '201801011000070%';
Delete SUMMARY_MARGIN_PB Where Bill_Id like '201801011000070%';
Delete SALES_REPORT Where Bill_Id like '201801011000070%';

--[ delete bill non meter ]

delete from BILL_NON_METERED where bill_id like '201808110105305%';
delete from BILL_NM_DTL where bill_id like '201805040102655%';
delete from SALES_REPORT where bill_id like '201805040102655%';

--[ total consumption 2016,2017]

SELECT sum(BILLED_CONSUMPTION)
  FROM bill_metered
 WHERE     BILL_YEAR BETWEEN 2016 AND 2017
      and  SUBSTR (customer_id, 1, 4) in ('0303','0310');
	  
--[ bill id using concat]

(SELECT 201804||customer_id bill_id
   FROM bill_non_metered
  WHERE BILL_ID LIKE '20180424%'
 UNION ALL
 SELECT 201804||customer_id bill_id
   FROM bill_metered
  WHERE BILL_ID LIKE '20180424%')
MINUS
(SELECT 201804||customer_id bill_id
   FROM bill_non_metered
  WHERE BILL_ID LIKE '20171224%'
 UNION ALL
 SELECT 201804||customer_id bill_id
   FROM bill_metered
  WHERE BILL_ID LIKE '20171224%');
  
--[ BG update bank_account_ledger ]

update bank_account_ledger set BANK_ID='101314', BRANCH_ID='10131410', ACCOUNT_NO='10131410'
where TRANS_ID in(
select * from bank_account_ledger where REF_ID in (
select to_char(DEPOSIT_ID) from mst_deposit where CUSTOMER_ID like '10%'
and DEPOSIT_PURPOSE = 1
--AND BRANCH_ID ='10121510'
AND DEPOSIT_TYPE = 1
--and BANK_ID = 0
)
and TRANS_TYPE=0
);

--[ BG delete trigger ]

CREATE OR REPLACE TRIGGER DELETED_BG
BEFORE DELETE
ON MST_DEPOSIT
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
WHEN (OLD.DEPOSIT_TYPE=1)
DECLARE
      V_DELETED_BY       VARCHAR2(25 BYTE);
      V_DELETED_ON       VARCHAR2(25 BYTE);
BEGIN

      V_DELETED_BY :=sys_context( 'userenv', 'os_user' );
      V_DELETED_ON :=SYSDATE;
      
      INSERT INTO BG_DELETED VALUES (:OLD.DEPOSIT_ID,:OLD.CUSTOMER_ID,:OLD.TOTAL_DEPOSIT,:OLD.BANK_ID,:OLD.BRANCH_ID,:OLD.ACCOUNT_NO,
      :OLD.DEPOSIT_DATE,:OLD.DEPOSIT_PURPOSE,:OLD.DEPOSIT_TYPE,:OLD.VALID_FROM,:OLD.VALID_TO,:OLD.INSERTED_ON,:OLD.INSERTED_BY,:OLD.STATUS,
      :OLD.REMARKS,V_DELETED_BY,V_DELETED_ON,'null');

END;
/