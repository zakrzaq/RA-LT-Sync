SELECT
  DISTINCT A.MATNR AS "Material",
  A.WERKS AS "Plant",
  B.MTART AS "Mtl Type",
  A.MMSTA AS "Plant-sp. Matl Status",
  A.BESKZ AS "Proc Type",
  a.sobsl AS "SPK",
  a.dismm AS "MRP Type",
  a.DISLS AS "Lot size",
  a.BSTMI AS "Min Lot size",
  a.BSTMA AS "Max lot size",
  a.ekgrp AS "P-group",
  y.eknam AS "Buyer",
  a.dispo AS "MRP Controller",
  z.DSNAM AS "Planner"
FROM
  SAPECC_LIBRARIAN.MARC A,
  SAPECC_LIBRARIAN.MARA B,
  sapecc_librarian.T024 y,
  sapecc_librarian.T024D z
WHERE
  -- join
  A.MATNR = B.MATNR
  AND a.mandt = '400'
  AND a.mandt = b.mandt
  AND a.mandt = y.mandt
  AND a.mandt = z.mandt
  AND a.ekgrp = y.ekgrp
  AND a.dispo = z.dispo
  AND a.werks = z.werks -- filters
  AND b.mtart <> 'ZCFG'
  AND A.LVORM <> 'X'
  AND B.LVORM <> 'X'
  AND A.DISLS = 'EX'
  AND a.bstmi NOT IN ('0', '1')
  AND a.werks NOT IN ('1010', '1030', '1110', '1060')
  AND a.werks NOT BETWEEN '3500'
  AND '3900'
  AND a.mmsta NOT IN (
    '07',
    '08',
    '09',
    '01',
    'NA',
    'FC',
    'ZP',
    'Z8',
    'ZG',
    'ZQ',
    'ZJ',
    'ZL'
  ) -- errors 
  AND a.BSTMA = a.BSTMI