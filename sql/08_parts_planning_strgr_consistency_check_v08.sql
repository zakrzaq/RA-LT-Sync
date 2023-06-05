SELECT
  DISTINCT a.matnr AS "Matnr",
  a.werks AS "Werks",
  a.strgr AS "Strgr",
  a.dispo AS "MRP Controller",
  z.dsnam AS "Planner",
  a.dismm AS "MRP Type",
  a.beskz AS "Proc Type",
  a.sobsl AS "SPK",
  a.mmsta AS "Plant Block",
  b.mtart AS "Material Type"
FROM
  sapecc_dly_librarian.marc a,
  sapecc_librarian.T024D z,
  sapecc_dly_librarian.mara b
WHERE
  -- joins
  a.dispo = z.dispo
  AND a.mandt = 400
  AND a.mandt = b.mandt
  AND a.mandt = z.mandt
  AND a.matnr = b.matnr
  AND a.werks = z.werks -- filter
  AND b.mtart NOT IN ('ZCFG', 'ZSPL', 'ZNFG')
  AND a.lvorm <> 'X'
  AND b.lvorm <> 'X'
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
  AND a.beskz = 'F'
  AND a.dismm <> 'ND'
  AND a.werks NOT IN ('1010', '1030', '1110', '1060')
  AND a.werks NOT BETWEEN '3500'
  AND '3900'
  AND a.matnr NOT LIKE '%MASTER%'
  AND a.dispo != 'RET' -- errors
  AND a.STRGR = 'Z0'