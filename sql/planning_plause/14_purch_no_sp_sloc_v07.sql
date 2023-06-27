SELECT
  DISTINCT a.matnr AS "Matnr",
  a.werks AS "Werks",
  a.lgpro AS "LGPRO",
  a.lgfsb AS "LGFSB",
  a.beskz AS "proc type",
  a.sobsl AS "SPK",
  a.mmsta AS "Plant block",
  a.dispo AS "SupPlnt MRP Controller",
  y.dsnam AS "SupPlnt Planner",
  b.mtart AS "Material Type",
  a.dismm AS "MRP Type"
FROM
  sapecc_dly_librarian.marc a,
  sapecc_librarian.t024d y,
  sapecc_dly_librarian.mara b
WHERE
  -- joins
  a.werks = y.werks
  AND a.mandt = y.mandt
  AND a.mandt = b.mandt
  AND a.matnr = b.matnr
  AND a.dispo = y.dispo -- filters
  AND a.werks NOT IN ('1010', '1030', '1110', '1060')
  AND a.werks NOT BETWEEN '3500'
  AND '3650'
  AND b.mtart <> 'ZCFG'
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
  AND a.lvorm <> 'X'
  AND b.lvorm <> 'X'
  AND a.beskz = 'F'
  AND SUBSTR(A.SOBSL, 1, 1) IN ('E', 'F')
  AND a.matnr NOT LIKE 'Z%'
  AND a.dispo != 'RET' -- errors
  AND a.lgfsb = ' '