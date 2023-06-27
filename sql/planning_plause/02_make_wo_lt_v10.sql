SELECT
  DISTINCT A.MATNR AS "Material",
  A.WERKS AS "Plant",
  B.MTART AS "Mtl Type",
  A.MMSTA AS "Plant-sp. Matl Status",
  A.BESKZ AS "Proc Type",
  a.sobsl AS "SPK",
  a.ekgrp AS "P-group",
  y.eknam AS "Buyer",
  a.dispo AS "MRP Controller",
  z.DSNAM AS "Planner",
  A.DZEIT AS "In House Production",
  A.PLIFZ AS "Plnd Delivery Time"
FROM
  sapecc_librarian.MARC A,
  sapecc_librarian.MARA B,
  sapecc_librarian.T024 y,
  sapecc_librarian.T024D z
WHERE
  -- joins
  a.matnr = b.matnr
  AND a.mandt = y.mandt
  AND a.mandt = z.mandt
  AND a.ekgrp = y.ekgrp
  AND a.dispo = z.dispo
  AND a.werks = z.werks -- filters
  AND a.mandt = '400'
  AND A.BESKZ = 'E'
  AND b.mtart <> 'ZCFG'
  AND b.mtart <> 'ZNFG'
  AND b.mtart <> 'ZSPL'
  AND b.matnr NOT LIKE '%COPY%'
  AND A.LVORM <> 'X'
  AND B.LVORM <> 'X'
  AND A.MMSTA NOT IN (
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
  )
  AND a.sobsl <> '50'
  AND a.dispo != 'RET'
  AND b.matkl NOT IN ('711900')
  AND b.matnr NOT LIKE 'IDD%'
  AND a.werks NOT IN ('1010', '1030', '1110', '1060', '2000', '2010')
  AND a.werks NOT BETWEEN '3500'
  AND '3900' -- errors
  AND NVL(A.DZEIT, '0') = '0'