SELECT
  DISTINCT f.mtart AS "Mtlr type",
  a.matnr AS "Material",
  a.werks AS "RcvPlnt",
  a.dispo AS "RcvPlnt MRP Controller",
  x.dsnam AS "RcvPlnt Planner",
  a.mmsta AS "RcvPlnt block",
  a.beskz AS "RcvPlnt ProcType",
  a.sobsl AS "RcvPlnt SPK",
  e.lplpr AS "RcvPlnt StdCost",
  c.bwkey AS "SupPlnt",
  d.ekgrp AS "SupPlnt P-grp",
  y.eknam AS "SupPlnt Buyer",
  d.dispo AS "SupPlnt MRP controller",
  z.dsnam AS "SupPlnt Planner",
  d.mmsta AS "SupPlnt block",
  c.lplpr AS "SupPlnt StdCost",
  d.beskz AS "SupPlnt Proc Type",
  d.sobsl AS "SupPlnt SPK"
FROM
  sapecc_librarian.marc a,
  sapecc_librarian.T460A b,
  sapecc_librarian.mbew c,
  sapecc_librarian.marc d,
  sapecc_librarian.mbew e,
  sapecc_librarian.mara f,
  sapecc_librarian.T024 y,
  sapecc_librarian.T024D z,
  sapecc_librarian.T024D x,
  sapecc_librarian.mvke v
WHERE
  -- joins
  a.werks = b.werks
  AND a.werks = e.bwkey
  AND a.matnr = e.matnr
  AND a.matnr = f.matnr
  AND a.matnr = v.matnr
  AND a.SOBSL = b.SOBSL
  AND d.mandt = y.mandt
  AND d.mandt = z.mandt
  AND d.ekgrp = y.ekgrp
  AND d.dispo = z.dispo
  AND d.werks = z.werks
  AND a.mandt = x.mandt
  AND a.dispo = x.dispo
  AND a.werks = x.werks
  AND a.mandt = '400'
  AND a.mandt = d.mandt
  AND a.mandt = e.mandt
  AND a.mandt = b.mandt
  AND a.mandt = f.mandt
  AND a.matnr = c.matnr(+)
  AND a.matnr = d.matnr(+)
  AND c.bwkey = d.werks
  AND b.wrk02 = d.werks -- filters
  AND a.lvorm <> 'X'
  AND f.lvorm <> 'X'
  AND a.beskz = 'F'
  AND SUBSTR(A.SOBSL, 1, 1) IN ('E', 'F')
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
  AND f.mtart NOT IN ('ZSPL', 'ZNV', 'ZNFG', 'ZCFG', 'ZREP')
  AND a.werks NOT IN ('1010', '1030', '1110', '1060')
  AND a.werks NOT BETWEEN '3500'
  AND '3900'
  AND NOT (
    a.werks = '4000'
    AND d.werks = '1210'
  )
  AND d.werks <> '1030'
  AND a.dispo != 'RET' -- errors
  AND c.lplpr = '0'