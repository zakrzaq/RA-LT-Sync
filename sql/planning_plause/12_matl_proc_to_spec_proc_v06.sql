SELECT
  DISTINCT a.matnr AS "Material",
  a.werks AS "Plant",
  a.ekgrp AS "P-group",
  y.eknam AS "Buyer",
  a.dispo AS "MRP Controller",
  z.dsnam AS "Planner",
  a.beskz AS "Proc Type",
  a.sobsl AS "SPK",
  a.strgr AS "Strategy Group"
FROM
  sapecc_librarian.marc a,
  sapecc_librarian.mara b,
  sapecc_librarian.T024 y,
  sapecc_librarian.T024D z
WHERE
  -- joins
  a.mandt = '400'
  AND a.mandt = y.mandt
  AND a.mandt = z.mandt
  AND a.mandt = b.mandt
  AND a.matnr = b.matnr
  AND a.ekgrp = y.ekgrp
  AND a.dispo = z.dispo
  AND a.werks = z.werks -- filters
  AND a.werks NOT IN ('1010', '1030', '1110', '1060')
  AND a.werks NOT BETWEEN '3500'
  AND '3900'
  AND b.mtart <> 'ZCFG'
  AND a.lvorm = ' '
  AND b.lvorm = ' '
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
  ) -- errors
  AND A.sobsl IN (
    '20',
    '40',
    '50',
    '52',
    '60',
    '70',
    '80',
    'CC',
    'CD'
  )
UNION
SELECT
  a.matnr AS "Material",
  a.werks AS "Plant",
  a.ekgrp AS "P-group",
  y.eknam AS "Buyer",
  a.dispo AS "MRP Controller",
  z.dsnam AS "Planner",
  a.beskz AS "Proc Type",
  a.sobsl AS "SPK",
  a.strgr AS "Strategy Group"
FROM
  sapecc_librarian.marc a,
  sapecc_librarian.mara b,
  sapecc_librarian.T024 y,
  sapecc_librarian.T024D z
WHERE
  -- joins
  a.mandt = '400'
  AND a.mandt = y.mandt
  AND a.mandt = z.mandt
  AND a.mandt = b.mandt
  AND a.matnr = b.matnr
  AND a.ekgrp = y.ekgrp
  AND a.dispo = z.dispo
  AND a.werks = z.werks -- filters
  AND a.werks NOT IN ('1010', '1030', '1110', '1060')
  AND a.werks NOT BETWEEN '3500'
  AND '3900'
  AND b.mtart <> 'ZCFG'
  AND a.lvorm = ' '
  AND b.lvorm = ' '
  AND a.beskz = 'E'
  AND a.mmsta NOT IN (
    '07',
    '99',
    '08',
    '09',
    '01',
    'NA',
    'FC',
    'ZP',
    'Z8',
    'ZG',
    'ZQ',
    'ZL'
  ) -- errors
  AND (
    a.sobsl IN (
      '10',
      '20',
      '30',
      '40',
      '45',
      '70',
      '80',
      'CC',
      'CD'
    )
    OR a.sobsl LIKE 'E%'
  )