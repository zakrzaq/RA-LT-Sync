SELECT
  Plant,
  COUNT (Material)
FROM
  (
    SELECT
      DISTINCT MARA.MATNR AS Material,
      MARC1.WERKS AS Plant
    FROM
      SAPECC_LIBRARIAN.MARA MARA,
      SAPECC_LIBRARIAN.MARC MARC1,
      SAPECC_LIBRARIAN.MARC MARC2,
      SAPECC_LIBRARIAN.T460A T460A
    WHERE
      MARA.MANDT = '400'
      AND MARC1.MANDT = MARA.MANDT
      AND MARC2.MANDT = MARA.MANDT
      AND T460A.MANDT = MARA.MANDT
      AND MARC2.MATNR = MARA.MATNR
      AND MARC1.MATNR = MARA.MATNR
      AND MARC2.SOBSL = T460A.SOBSL
      AND MARC1.WERKS = T460A.WRK02
      AND MARC2.WERKS = T460A.WERKS
      AND MARA.LVORM <> 'X'
      AND MARC1.LVORM <> 'X'
      AND MARA.MTART NOT IN ('ZCFG', 'ZREP')
      AND MARC1.WERKS NOT IN ('1010', '1030', '1110', '1060')
      AND MARC2.WERKS NOT IN ('1010', '1030', '1110', '1060')
      AND MARC1.WERKS NOT BETWEEN '3500'
      AND '3900'
      AND MARC2.WERKS NOT BETWEEN '3500'
      AND '3900'
      AND MARC1.MMSTA NOT IN (
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
      AND MARC2.MMSTA NOT IN (
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
      AND MARC1.DISPO <> 'RET'
      AND MARC2.DISPO <> 'RET'
      AND MARC2.DISMM <> 'ND'
  )
GROUP BY
  Plant
ORDER BY
  Plant