SELECT
  DISTINCT a.matnr AS "Material",
  a.werks AS "Plant",
  b.mtart AS "Mtl Type",
  a.mmsta AS "Plant-sp. Matl Status",
  a.beskz AS "Proc Type",
  a.sobsl AS "SPK or vendor plant",
  a.dismm AS "MRP Type",
  a.ekgrp AS "P-group",
  y.eknam AS "Buyer",
  a.dispo AS "MRP Controller",
  z.dsnam AS "Planner",
  a.dzeit AS "In House Production",
  a.plifz AS "Plnd Delivery Time"
FROM
  sapecc_librarian.marc a,
  sapecc_librarian.mara b,
  sapecc_librarian.t024 y,
  sapecc_librarian.t024d z,
  sapecc_librarian.mvke v
WHERE
  -- joins
  a.matnr = b.matnr
  AND a.matnr = v.matnr
  AND a.mandt = b.mandt
  AND a.mandt = y.mandt
  AND a.mandt = z.mandt
  AND a.mandt = v.mandt
  AND a.ekgrp = y.ekgrp
  AND a.dispo = z.dispo
  AND a.werks = z.werks -- Filters 
  AND a.mandt = '400'
  AND b.mtart <> 'ZCFG'
  AND a.lvorm <> 'X'
  AND b.lvorm <> 'X'
  AND a.beskz = 'F'
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
  )
  AND SUBSTR(A.SOBSL, 1, 1) IN ('E', 'F')
  AND a.dismm <> 'ND'
  AND a.dispo <> 'RET'
  AND a.werks NOT IN ('1010', '1030', '1110', '1060', '4010')
  AND a.werks NOT BETWEEN '3500'
  AND '3900' -- Errors
  AND nvl(a.plifz, '0') = '0'