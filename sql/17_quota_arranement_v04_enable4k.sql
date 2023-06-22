SELECT
  a.matnr AS "Material",
  a.werks AS "Plant",
  a.ekgrp AS "P-group",
  y.eknam AS "Buyer",
  a.dispo AS "MRP Controller",
  z.dsnam AS "Planner",
  a.beskz AS "Proc Type",
  a.sobsl AS "SPK",
  a.usequ AS "Quota Usage"
FROM
  sapecc_librarian.marc a,
  sapecc_librarian.equk b,
  sapecc_librarian.t024 y,
  sapecc_librarian.t024d z,
  sapecc_librarian.mara c
WHERE
  -- joins
  a.matnr = b.matnr(+)
  AND a.werks = b.werks(+)
  AND a.mandt = '400'
  AND a.mandt = y.mandt
  AND a.mandt = z.mandt
  AND a.mandt = c.mandt
  AND a.matnr = c.matnr
  AND a.ekgrp = y.ekgrp
  AND a.dispo = z.dispo
  AND a.werks = z.werks --filters
  AND c.mtart <> 'ZCFG'
  AND a.lvorm <> 'X'
  AND c.lvorm <> 'X'
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
    'ZJ'
  )
  AND a.usequ > '0'
  AND a.werks NOT IN ('1010', '1030', '1110', '1060')
  AND a.werks NOT BETWEEN '3500'
  AND '3650' -- errors
  AND b.matnr IS NULL