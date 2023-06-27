SELECT
  DISTINCT A.MATNR AS "Material",
  A.WERKS AS "SupPlnt",
  A.DISMM AS "SupPlnt MRP Type",
  A.DZEIT AS "SupPlnt MFG LT",
  a.strgr AS "SupPlnt Strat Grp",
  A.DISPO AS "SupPlnt MRP Controller",
  y.DSNAM AS "SupPlnt Planner",
  a.mmsta AS "SupPlnt Block",
  C.WERKS AS "RcvPlnt",
  C.DISMM AS "RcvPlnt MRP Type",
  C.DISPO AS "RcvPlnt MRP Controller",
  z.dsnam AS "RcvPlnt Planner",
  C.PLIFZ AS "RcvPlnt LT",
  c.mmsta AS "RcvPlnt Block",
  c.strgr AS "RcvPlnt Strat Grp",
  c.sobsl AS "Rcv SPK",
  d.mtart AS "Material Type",
  a.ORG_SOURCE_VAL AS "send Original Source Val",
  c.ORG_SOURCE_VAL AS "rcv Original Source Val"
FROM
  sapecc_dly_librarian.MARC a,
  sapecc_dly_librarian.T460A b,
  sapecc_dly_librarian.MARC c,
  sapecc_librarian.T024D y,
  sapecc_librarian.T024D z,
  sapecc_dly_librarian.MARA D
WHERE
  -- joins
  a.mandt = '400'
  AND a.mandt = y.mandt
  AND a.mandt = d.mandt
  AND c.mandt = z.mandt
  AND a.matnr = c.matnr
  AND a.matnr = d.matnr
  AND c.sobsl = b.sobsl
  AND a.werks = b.Wrk02
  AND c.werks = b.werks
  AND a.werks = y.werks
  AND a.dispo = y.dispo
  AND c.werks = z.werks
  AND c.dispo = z.dispo -- filters
  AND d.mtart NOT IN ('ZCFG', 'ZREP', 'ZFG')
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
  AND c.mmsta NOT IN (
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
    'ZL',
    'ZA'
  )
  AND a.lvorm <> 'X'
  AND d.lvorm <> 'X'
  AND a.werks NOT IN ('1010', '1030', '1110', '1060')
  AND a.werks NOT BETWEEN '3500'
  AND '3900'
  AND c.werks NOT IN ('1010', '1030', '1110', '1060')
  AND c.werks NOT BETWEEN '3500'
  AND '3900'
  AND a.dispo <> 'RET'
  AND c.dispo <> 'RET'
  AND c.dismm <> 'ND' -- errors
  AND a.dismm = 'ND'