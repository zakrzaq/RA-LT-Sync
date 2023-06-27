SELECT
  DISTINCT a.matnr AS "Material",
  a.werks AS "Plant",
  a.dispo AS "MRP cont",
  z.dsnam AS "Planner",
  a.mmsta AS "block",
  a.beskz AS "Purch type",
  a.sobsl AS "SPK",
  a.plifz AS "PDT",
  a.dzeit AS "IPT",
  a.wzeit AS "tot repl lt"
FROM
  sapecc_librarian.mara b,
  sapecc_librarian.marc a,
  sapecc_librarian.T024D z
WHERE
  -- joins
  a.mandt = '400'
  AND a.mandt = b.mandt
  AND a.mandt = z.mandt
  AND a.werks = z.werks
  AND a.matnr = b.matnr
  AND a.dispo = z.dispo -- filters
  AND a.lvorm <> 'X'
  AND b.lvorm <> 'X'
  AND a.beskz = 'E'
  AND b.mtart NOT IN ('ZCFG', 'ZREP')
  AND a.werks NOT IN ('1010', '1030', '1110', '1060')
  AND a.werks NOT BETWEEN '3500'
  AND '3900'
  AND a.dispo <> 'RET'
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
  AND a.wzeit != '0' -- errors
  AND cast(a.wzeit AS int) < a.dzeit