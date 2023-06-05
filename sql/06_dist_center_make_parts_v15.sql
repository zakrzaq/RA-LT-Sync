SELECT
  DISTINCT a.matnr AS "Material",
  a.werks AS "Plant",
  b.mtart AS "Mtl Type",
  a.mmsta AS "Plant-sp. Matl Status",
  a.beskz AS "Proc Type",
  a.sobsl AS "SPK",
  a.dismm AS "MRP Type",
  a.ekgrp AS "P-group",
  y.eknam AS "Buyer",
  a.dispo AS "MRP Controller",
  z.dsnam AS "Planner"
FROM
  sapecc_librarian.marc a,
  sapecc_librarian.mara b,
  sapecc_librarian.t024 y,
  sapecc_librarian.t024d z
WHERE
  -- joins
  a.matnr = b.matnr
  AND a.mandt = '400'
  AND b.mandt = '400'
  AND a.mandt = b.mandt
  AND a.mandt = y.mandt
  AND a.mandt = z.mandt
  AND a.ekgrp = y.ekgrp
  AND a.dispo = z.dispo
  AND a.werks = z.werks --filters
  AND a.lvorm <> 'X'
  AND b.lvorm <> 'X'
  AND a.werks IN (
    '1140',
    '1180',
    '4000',
    '4020',
    '5070',
    '5120',
    '5140',
    '5160',
    '5190',
    '5200',
    '5040',
    '5050',
    '5100',
    '5110',
    '6060',
    '6030',
    '6050',
    '6070',
    '6080',
    '6120',
    '6140',
    '6110',
    '6190',
    '6040',
    '6200'
  )
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
  AND dismm <> 'ND'
  AND b.mtart NOT IN ('ZCFG', 'ZNFG', 'ZSPL') -- errors
  AND a.beskz = 'E'