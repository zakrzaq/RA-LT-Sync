SELECT
  DISTINCT aa.matnr AS "Material",
  aa.recv_plant,
  aa.ship_plant,
  aa.dispo AS recv_mrp_ctlr,
  aa.dsnam AS "Planner"
FROM
  sapecc_librarian.marc bb,
  (
    SELECT
      a.matnr,
      a.werks AS recv_plant,
      b.wrk02 AS ship_plant,
      a.dispo,
      c.dsnam
    FROM
      sapecc_librarian.marc a,
      sapecc_librarian.t460A b,
      sapecc_librarian.t024d c,
      sapecc_librarian.mara d
    WHERE
      a.mandt = '400'
      AND a.mandt = d.mandt
      AND a.werks = b.werks
      AND a.matnr = d.matnr
      AND a.sobsl = b.sobsl
      AND a.dispo <> 'RET'
      AND d.mtart <> 'ZCFG'
      AND d.lvorm <> 'X'
      AND a.lvorm <> 'X'
      AND a.werks = c.werks
      AND a.dispo = c.dispo
      AND a.werks NOT IN ('1010', '1030', '1110', '1060', '5080')
      AND a.werks NOT BETWEEN '3500'
      AND '3900'
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
        'ZJ'
      )
  ) aa
WHERE
  -- join
  aa.matnr = bb.matnr(+) -- errors
  AND aa.ship_plant = bb.werks(+)
  AND bb.matnr IS NULL