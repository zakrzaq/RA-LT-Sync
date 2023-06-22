SELECT
  Plant,
  COUNT (Material)
FROM
  (
    SELECT
      DISTINCT MARA.MATNR AS Material,
      MARC.WERKS AS Plant
    FROM
      SAPECC_LIBRARIAN.MARA MARA,
      SAPECC_LIBRARIAN.MARC MARC,
      SAPECC_LIBRARIAN.T460A T460A,
      SAPECC_LIBRARIAN.T024D T024D
    WHERE
      MARA.MANDT = '400'
      AND MARC.MANDT = MARA.MANDT
      AND T460A.MANDT = MARA.MANDT
      AND MARC.MATNR = MARA.MATNR
      AND MARC.WERKS = T460A.WERKS
      AND MARC.SOBSL = T460A.SOBSL
      AND MARC.WERKS = T024D.WERKS
      AND MARA.LVORM <> 'X'
      AND MARC.LVORM <> 'X'
      AND MARC.WERKS NOT IN ('1010', '1030', '1110', '1060')
      AND MARC.WERKS NOT BETWEEN '3500'
      AND '3900'
      AND MARC.MMSTA NOT IN (
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
      AND MARC.DISPO <> 'RET'
      AND MARA.MTART <> 'ZCFG'
      AND MARC.DISPO = T024D.DISPO
      AND SUBSTR(MARC.SOBSL, 1, 1) IN ('E', 'F', 'D')
  )
GROUP BY
  Plant
ORDER BY
  Plant