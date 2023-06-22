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
      SAPECC_LIBRARIAN.T024D T024D
    WHERE
      MARA.MANDT = '400'
      AND MARC.MANDT = MARA.MANDT
      AND MARA.MATNR = MARC.MATNR
      AND MARC.WERKS = T024D.WERKS
      AND MARA.LVORM <> 'X'
      AND MARC.LVORM <> 'X'
      AND MARA.MTART NOT IN ('ZCFG', 'ZREP')
      AND MARC.WERKS NOT IN ('1010', '1030', '1110', '1060')
      AND MARC.WERKS NOT BETWEEN '3500'
      AND '3900'
      AND MARC.DISPO <> 'RET'
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
      AND MARC.DISPO = T024D.DISPO
      AND MARC.BESKZ = 'E'
      AND MARC.WZEIT != '0'
  )
GROUP BY
  Plant
ORDER BY
  Plant