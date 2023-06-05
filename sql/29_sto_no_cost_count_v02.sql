SELECT
  Plant,
  COUNT (Material)
FROM
  (
    SELECT
      DISTINCT MARA.MATNR AS Material,
      MARC1.WERKS AS Plant
    FROM
      sapecc_librarian.marc MARC1,
      sapecc_librarian.T460A T460A,
      sapecc_librarian.mbew MBEW,
      sapecc_librarian.marc MARC2,
      sapecc_librarian.mbew MBEW2,
      sapecc_librarian.mara MARA,
      sapecc_librarian.T024 T024,
      sapecc_librarian.T024D T024D1,
      sapecc_librarian.T024D T024D2,
      sapecc_librarian.mvke MVKE
    WHERE
      -- joins
      MARC1.werks = T460A.werks
      AND MARC1.werks = MBEW2.bwkey
      AND MARC1.matnr = MBEW2.matnr
      AND MARC1.matnr = MARA.matnr
      AND MARC1.matnr = MVKE.matnr
      AND MARC1.SOBSL = T460A.SOBSL
      AND MARC2.mandt = T024.mandt
      AND MARC2.mandt = T024D1.mandt
      AND MARC2.ekgrp = T024.ekgrp
      AND MARC2.dispo = T024D1.dispo
      AND MARC2.werks = T024D1.werks
      AND MARC1.mandt = T024D2.mandt
      AND MARC1.dispo = T024D2.dispo
      AND MARC1.werks = T024D2.werks
      AND MARC1.mandt = '400'
      AND MARC1.mandt = MARC2.mandt
      AND MARC1.mandt = MBEW2.mandt
      AND MARC1.mandt = T460A.mandt
      AND MARC1.mandt = MARA.mandt
      AND MARC1.matnr = MBEW.matnr(+)
      AND MARC1.matnr = MARC2.matnr(+)
      AND MBEW.bwkey = MARC2.werks
      AND T460A.wrk02 = MARC2.werks -- filters
      AND MARC1.lvorm <> 'X'
      AND MARA.lvorm <> 'X'
      AND MARC1.beskz = 'F'
      AND SUBSTR(MARC1.SOBSL, 1, 1) IN ('E', 'F')
      AND MARC1.mmsta NOT IN (
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
      AND MARA.mtart NOT IN ('ZSPL', 'ZNV', 'ZNFG', 'ZCFG', 'ZREP')
      AND MARC1.werks NOT BETWEEN '3500'
      AND '3900'
      AND NOT (
        MARC1.werks = '4000'
        AND MARC2.werks = '1210'
      )
      AND MARC2.werks <> '1030'
      AND MARC1.dispo != 'RET'
  )
GROUP BY
  Plant
ORDER BY
  Plant