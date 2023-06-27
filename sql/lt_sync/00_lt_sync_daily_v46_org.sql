SELECT
  CASE
    WHEN (
      a.werks = '4000'
      AND d.werks IN (
        '1140',
        '1090',
        '1180',
        '4020',
        '4050',
        '4070',
        '5120',
        '5160',
        '5190',
        '5200',
        '5040',
        '5050',
        '5100',
        '5110',
        '5140',
        '5070',
        '6060',
        '6030',
        '6050',
        '6070',
        '6080',
        '6110',
        '6120',
        '6140',
        '6190',
        '6040',
        '6200'
      
      AND d.strgr = '40'
      AND decode(a.plifz, ' ', 0, a.plifz) != round(
        (
          (
            TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            ) / 5
          ) * 7
        ) + 2 + rcvadd
      )
      AND a.plifz - round(
        (
          (
            TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            ) / 5
          ) * 7
        ) + 2 + rcvadd
      ) != '0'
    ) THEN round(
      (
        (
          TO_NUMBER(
            nvl(
              decode(
                substr(t.route, 5),
                'TB',
                1,
                substr(t.route, 5)
              ),
              0
            )
          ) / 5
        ) * 7
      ) + 2 + rcvadd
    )
    WHEN (
      a.werks = '4010'
      AND d.werks = '4000'
      AND d.strgr = '40'
      AND decode(a.plifz, ' ', 0, a.plifz) != 0
    ) THEN 0
    WHEN (
      a.werks = '4010'
      AND d.werks = '4000'
      AND d.strgr != '40'
      AND decode(a.plifz, ' ', 0, a.plifz) != round(d.plifz +((d.webaz) * 7 / 5))
    ) THEN round(d.plifz +((d.webaz) * 7 / 5))
    WHEN (
      a.werks = '1250'
      AND d.werks = '1140'
      AND d.strgr = '40'
      AND decode(a.plifz, ' ', 0, a.plifz) != 0
    ) THEN 0
    WHEN (
      a.werks = '1250'
      AND d.werks = '1140'
      AND d.strgr != '40'
      AND decode(a.plifz, ' ', 0, a.plifz) != round(d.plifz +((d.webaz) * 7 / 5))
    ) THEN round(d.plifz +((d.webaz) * 7 / 5))
    WHEN (
      a.beskz = 'F'
      AND substr(a.sobsl, 1, 1) IN ('E', 'F', 'D')
      AND d.werks IN (
        '1140',
        '1090',
        '1180',
        '4000',
        '4020',
        '4050',
        '4070',
        '5120',
        '5160',
        '5190',
        '5040',
        '5050',
        '5100',
        '5110',
        '5140',
        '5070',
        '6060',
        '6030',
        '6050',
        '6070',
        '6080',
        '6110',
        '6120',
        '6140',
        '6190',
        '6040',
        '6200'
      )
      AND d.strgr = '40'
      AND decode(a.plifz, ' ', 0, a.plifz) != round(
        (
          (
            TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            ) / 5
          ) * 7
        ) + 2 + rcvadd
      )
      AND a.plifz - round(
        (
          (
            TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            ) / 5
          ) * 7
        ) + 2 + rcvadd
      ) != '0'
    ) THEN round(
      (
        (
          TO_NUMBER(
            nvl(
              decode(
                substr(t.route, 5),
                'TB',
                1,
                substr(t.route, 5)
              ),
              0
            )
          ) / 5
        ) * 7
      ) + 2 + rcvadd
    )
    WHEN (
      a.beskz = 'F'
      AND substr(a.sobsl, 1, 1) IN ('E', 'F', 'D')
      AND d.werks IN ('5200')
      AND d.strgr = '40'
      AND decode(a.plifz, ' ', 0, a.plifz) != round(
        (
          (
            TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            ) / 5
          ) * 7
        ) + 4 + rcvadd
      )
      AND a.plifz - round(
        (
          (
            TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            ) / 5
          ) * 7
        ) + 4 + rcvadd
      ) != '0'
    ) THEN round(
      (
        (
          TO_NUMBER(
            nvl(
              decode(
                substr(t.route, 5),
                'TB',
                1,
                substr(t.route, 5)
              ),
              0
            )
          ) / 5
        ) * 7
      ) + 4 + rcvadd
    )
    WHEN (
      a.beskz = 'F'
      AND substr(a.sobsl, 1, 1) IN ('E', 'F', 'D')
      AND d.werks IN (
        '1140',
        '1090',
        '1180',
        '4000',
        '4020',
        '4050',
        '4070',
        '5120',
        '5160',
        '5190',
        '5040',
        '5050',
        '5100',
        '5110',
        '5140',
        '5070',
        '6060',
        '6030',
        '6050',
        '6070',
        '6080',
        '6110',
        '6120',
        '6140',
        '6190',
        '6040',
        '6200'
      )
      AND d.strgr != '40'
      AND decode(a.plifz, ' ', 0, a.plifz) != round(
        d.plifz +(
          (
            d.webaz + TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            )
          ) *(7 / 5)
        ) + 2 + rcvadd
      )
      AND a.plifz - round(
        d.plifz +(
          (
            d.webaz + TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            )
          ) *(7 / 5)
        ) + 2 + rcvadd
      ) != '0'
    ) THEN round(
      d.plifz +(
        (
          d.webaz + TO_NUMBER(
            nvl(
              decode(
                substr(t.route, 5),
                'TB',
                1,
                substr(t.route, 5)
              ),
              0
            )
          )
        ) *(7 / 5)
      ) + 2 + rcvadd
    )
    WHEN (
      a.beskz = 'F'
      AND substr(a.sobsl, 1, 1) IN ('E', 'F', 'D')
      AND d.werks IN ('5200')
      AND d.strgr != '40'
      AND decode(a.plifz, ' ', 0, a.plifz) != round(
        d.plifz +(
          (
            d.webaz + TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            )
          ) *(7 / 5)
        ) + 4 + rcvadd
      )
      AND a.plifz - round(
        d.plifz +(
          (
            d.webaz + TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            )
          ) *(7 / 5)
        ) + 4 + rcvadd
      ) != '0'
    ) THEN round(
      d.plifz +(
        (
          d.webaz + TO_NUMBER(
            nvl(
              decode(
                substr(t.route, 5),
                'TB',
                1,
                substr(t.route, 5)
              ),
              0
            )
          )
        ) *(7 / 5)
      ) + 4 + rcvadd
    )
    WHEN (
      a.beskz = 'F'
      AND substr(a.sobsl, 1, 1) IN ('E', 'F', 'D')
      AND d.werks NOT IN (
        '1140',
        '1090',
        '1180',
        '4000',
        '4020',
        '4050',
        '4070',
        '5120',
        '5160',
        '5190',
        '5200',
        '5040',
        '5050',
        '5100',
        '5110',
        '5140',
        '5070',
        '6060',
        '6030',
        '6050',
        '6070',
        '6080',
        '6110',
        '6120',
        '6140',
        '6190',
        '6040',
        '6200'
      )
      AND d.beskz = 'F'
      AND decode(a.plifz, ' ', 0, a.plifz) != round(
        2 + rcvadd + d.plifz +(
          (
            d.webaz + TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(
                    t.route,
                    5
                  )
                ),
                0
              )
            )
          ) *(7 / 5)
        )
      )
      AND a.plifz - round(
        d.plifz +(
          (
            d.webaz + TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            )
          ) *(7 / 5)
        ) + 2 + rcvadd
      ) != '0'
    ) THEN round(
      d.plifz +(
        (
          d.webaz + TO_NUMBER(
            nvl(
              decode(
                substr(t.route, 5),
                'TB',
                1,
                substr(t.route, 5)
              ),
              0
            )
          )
        ) *(7 / 5)
      ) + 2 + rcvadd
    )
    WHEN (
      a.beskz = 'F'
      AND substr(a.sobsl, 1, 1) IN ('E', 'F', 'D')
      AND d.werks NOT IN (
        '1140',
        '1090',
        '1180',
        '4000',
        '4020',
        '4050',
        '4070',
        '5120',
        '5160',
        '5190',
        '5200',
        '5040',
        '5050',
        '5100',
        '5110',
        '5140',
        '5070',
        '6060',
        '6030',
        '6050',
        '6070',
        '6080',
        '6110',
        '6120',
        '6140',
        '6190',
        '6040',
        '6200'
      )
      AND d.beskz = 'E'
      AND d.wzeit = 0
      AND decode(a.plifz, ' ', 0, a.plifz) != round(
        (
          (
            d.dzeit + d.webaz + TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            )
          ) *(7 / 5)
        ) + 1 + rcvadd
      )
      AND a.plifz - round(
        (
          (
            d.dzeit + d.webaz + TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            )
          ) *(7 / 5)
        ) + 1 + rcvadd
      ) != '0'
    ) THEN round(
      (
        (
          d.dzeit + d.webaz + TO_NUMBER(
            nvl(
              decode(
                substr(t.route, 5),
                'TB',
                1,
                substr(t.route, 5)
              ),
              0
            )
          )
        ) *(7 / 5)
      ) + 1 + rcvadd
    )
    WHEN (
      a.beskz = 'F'
      AND substr(a.sobsl, 1, 1) IN ('E', 'F', 'D')
      AND d.werks NOT IN (
        '1140',
        '1090',
        '1180',
        '4000',
        '4020',
        '4050',
        '4070',
        '5120',
        '5160',
        '5190',
        '5200',
        '5040',
        '5050',
        '5100',
        '5110',
        '5140',
        '5070',
        '6060',
        '6030',
        '6050',
        '6070',
        '6080',
        '6110',
        '6120',
        '6140',
        '6190',
        '6040',
        '6200'
      )
      AND d.beskz = 'E'
      AND d.wzeit != 0
      AND decode(a.plifz, ' ', 0, a.plifz) != round(
        (
          (
            d.wzeit + d.webaz + TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            )
          ) *(7 / 5)
        ) + 1 + rcvadd
      )
      AND a.plifz - round(
        (
          (
            d.wzeit + d.webaz + TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            )
          ) *(7 / 5)
        ) + 1 + rcvadd
      ) != '0'
    ) THEN round(
      (
        (
          d.wzeit + d.webaz + TO_NUMBER(
            nvl(
              decode(
                substr(t.route, 5),
                'TB',
                1,
                substr(t.route, 5)
              ),
              0
            )
          )
        ) *(7 / 5)
      ) + 1 + rcvadd
    )
    ELSE 0
  END AS clt,
  CASE
    WHEN (
      a.werks = '4000'
      AND d.werks IN (
        '1140',
        '1090',
        '1180',
        '4020',
        '4050',
        '4070',
        '5120',
        '5160',
        '5190',
        '5200',
        '5040',
        '5050',
        '5100',
        '5110',
        '5140',
        '5070',
        '6060',
        '6030',
        '6050',
        '6070',
        '6080',
        '6110',
        '6120',
        '6140',
        '6190',
        '6040',
        '6200'
      )
      AND d.strgr = '40'
      AND decode(a.plifz, ' ', 0, a.plifz) != round(
        (
          (
            TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            ) / 5
          ) * 7
        ) + 2 + rcvadd
      )
      AND a.plifz - round(
        (
          (
            TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            ) / 5
          ) * 7
        ) + 2 + rcvadd
      ) != '0'
    ) THEN a.plifz - round(
      (
        (
          TO_NUMBER(
            nvl(
              decode(
                substr(t.route, 5),
                'TB',
                1,
                substr(t.route, 5)
              ),
              0
            )
          ) / 5
        ) * 7
      ) + 2 + rcvadd
    )
    WHEN (
      a.werks = '4010'
      AND d.werks = '4000'
      AND d.strgr = '40'
      AND decode(a.plifz, ' ', 0, a.plifz) != 0
    ) THEN a.plifz
    WHEN (
      a.werks = '4010'
      AND d.werks = '4000'
      AND d.strgr != '40'
      AND decode(a.plifz, ' ', 0, a.plifz) != round(d.plifz +((d.webaz) * 7 / 5))
    ) THEN a.plifz - round(d.plifz +((d.webaz) * 7 / 5))
    WHEN (
      a.werks = '1250'
      AND d.werks = '1140'
      AND d.strgr = '40'
      AND decode(a.plifz, ' ', 0, a.plifz) != 0
    ) THEN a.plifz
    WHEN (
      a.werks = '1250'
      AND d.werks = '1140'
      AND d.strgr != '40'
      AND decode(a.plifz, ' ', 0, a.plifz) != round(d.plifz +((d.webaz) * 7 / 5))
    ) THEN a.plifz - round(d.plifz +((d.webaz) * 7 / 5))
    WHEN (
      a.beskz = 'F'
      AND substr(a.sobsl, 1, 1) IN ('E', 'F', 'D')
      AND d.werks IN (
        '1140',
        '1090',
        '1180',
        '4000',
        '4020',
        '4050',
        '4070',
        '5120',
        '5160',
        '5190',
        '5040',
        '5050',
        '5100',
        '5110',
        '5140',
        '5070',
        '6060',
        '6030',
        '6050',
        '6070',
        '6080',
        '6110',
        '6120',
        '6140',
        '6190',
        '6040',
        '6200'
      )
      AND d.strgr = '40'
      AND decode(a.plifz, ' ', 0, a.plifz) != round(
        (
          (
            TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            ) / 5
          ) * 7
        ) + 2 + rcvadd
      )
      AND a.plifz - round(
        (
          (
            TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            ) / 5
          ) * 7
        ) + 2 + rcvadd
      ) != '0'
    ) THEN a.plifz - round(
      (
        (
          TO_NUMBER(
            nvl(
              decode(
                substr(t.route, 5),
                'TB',
                1,
                substr(t.route, 5)
              ),
              0
            )
          ) / 5
        ) * 7
      ) + 2 + rcvadd
    )
    WHEN (
      a.beskz = 'F'
      AND substr(a.sobsl, 1, 1) IN ('E', 'F', 'D')
      AND d.werks IN ('5200')
      AND d.strgr = '40'
      AND decode(a.plifz, ' ', 0, a.plifz) != round(
        (
          (
            TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            ) / 5
          ) * 7
        ) + 4 + rcvadd
      )
      AND a.plifz - round(
        (
          (
            TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            ) / 5
          ) * 7
        ) + 4 + rcvadd
      ) != '0'
    ) THEN a.plifz - round(
      (
        (
          TO_NUMBER(
            nvl(
              decode(
                substr(t.route, 5),
                'TB',
                1,
                substr(t.route, 5)
              ),
              0
            )
          ) / 5
        ) * 7
      ) + 4 + rcvadd
    )
    WHEN (
      a.beskz = 'F'
      AND substr(a.sobsl, 1, 1) IN ('E', 'F', 'D')
      AND d.werks IN (
        '1140',
        '1090',
        '1180',
        '4000',
        '4020',
        '4050',
        '4070',
        '5120',
        '5160',
        '5190',
        '5040',
        '5050',
        '5100',
        '5110',
        '5140',
        '5070',
        '6060',
        '6030',
        '6050',
        '6070',
        '6080',
        '6110',
        '6120',
        '6140',
        '6190',
        '6040',
        '6200'
      )
      AND d.strgr != '40'
      AND decode(a.plifz, ' ', 0, a.plifz) != round(
        d.plifz +(
          (
            d.webaz + TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            )
          ) *(7 / 5)
        ) + 2 + rcvadd
      )
      AND a.plifz - round(
        d.plifz +(
          (
            d.webaz + TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            )
          ) *(7 / 5)
        ) + 2 + rcvadd
      ) != '0'
    ) THEN a.plifz - round(
      d.plifz +(
        (
          d.webaz + TO_NUMBER(
            nvl(
              decode(
                substr(t.route, 5),
                'TB',
                1,
                substr(t.route, 5)
              ),
              0
            )
          )
        ) *(7 / 5)
      ) + 2 + rcvadd
    )
    WHEN (
      a.beskz = 'F'
      AND substr(a.sobsl, 1, 1) IN ('E', 'F', 'D')
      AND d.werks IN ('5200')
      AND d.strgr != '40'
      AND decode(a.plifz, ' ', 0, a.plifz) != round(
        d.plifz +(
          (
            d.webaz + TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            )
          ) *(7 / 5)
        ) + 4 + rcvadd
      )
      AND a.plifz - round(
        d.plifz +(
          (
            d.webaz + TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            )
          ) *(7 / 5)
        ) + 4 + rcvadd
      ) != '0'
    ) THEN a.plifz - round(
      d.plifz +(
        (
          d.webaz + TO_NUMBER(
            nvl(
              decode(
                substr(t.route, 5),
                'TB',
                1,
                substr(t.route, 5)
              ),
              0
            )
          )
        ) *(7 / 5)
      ) + 4 + rcvadd
    )
    WHEN (
      a.beskz = 'F'
      AND substr(a.sobsl, 1, 1) IN ('E', 'F', 'D')
      AND d.werks NOT IN (
        '1140',
        '1090',
        '1180',
        '4000',
        '4020',
        '4050',
        '4070',
        '5120',
        '5160',
        '5190',
        '5200',
        '5040',
        '5050',
        '5100',
        '5110',
        '5140',
        '5070',
        '6060',
        '6030',
        '6050',
        '6070',
        '6080',
        '6110',
        '6120',
        '6140',
        '6190',
        '6040',
        '6200'
      )
      AND d.beskz = 'F'
      AND decode(a.plifz, ' ', 0, a.plifz) != round(
        2 + rcvadd + d.plifz +(
          (
            d.webaz + TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(
                    t.route,
                    5
                  )
                ),
                0
              )
            )
          ) *(7 / 5)
        )
      )
      AND a.plifz - round(
        d.plifz +(
          (
            d.webaz + TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            )
          ) *(7 / 5)
        ) + 2 + rcvadd
      ) != '0'
    ) THEN a.plifz - round(
      d.plifz +(
        (
          d.webaz + TO_NUMBER(
            nvl(
              decode(
                substr(t.route, 5),
                'TB',
                1,
                substr(t.route, 5)
              ),
              0
            )
          )
        ) *(7 / 5)
      ) + 2 + rcvadd
    )
    WHEN (
      a.beskz = 'F'
      AND substr(a.sobsl, 1, 1) IN ('E', 'F', 'D')
      AND d.werks NOT IN (
        '1140',
        '1090',
        '1180',
        '4000',
        '4020',
        '4050',
        '4070',
        '5120',
        '5160',
        '5190',
        '5200',
        '5040',
        '5050',
        '5100',
        '5110',
        '5140',
        '5070',
        '6060',
        '6030',
        '6050',
        '6070',
        '6080',
        '6110',
        '6120',
        '6140',
        '6190',
        '6040',
        '6200'
      )
      AND d.beskz = 'E'
      AND d.wzeit = 0
      AND decode(a.plifz, ' ', 0, a.plifz) != round(
        (
          (
            d.dzeit + d.webaz + TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            )
          ) *(7 / 5)
        ) + 1 + rcvadd
      )
      AND a.plifz - round(
        (
          (
            d.dzeit + d.webaz + TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            )
          ) *(7 / 5)
        ) + 1 + rcvadd
      ) != '0'
    ) THEN a.plifz - round(
      (
        (
          d.dzeit + d.webaz + TO_NUMBER(
            nvl(
              decode(
                substr(t.route, 5),
                'TB',
                1,
                substr(t.route, 5)
              ),
              0
            )
          )
        ) *(7 / 5)
      ) + 1 + rcvadd
    )
    WHEN (
      a.beskz = 'F'
      AND substr(a.sobsl, 1, 1) IN ('E', 'F', 'D')
      AND d.werks NOT IN (
        '1140',
        '1090',
        '1180',
        '4000',
        '4020',
        '4050',
        '4070',
        '5120',
        '5160',
        '5190',
        '5200',
        '5040',
        '5050',
        '5100',
        '5110',
        '5140',
        '5070',
        '6060',
        '6030',
        '6050',
        '6070',
        '6080',
        '6110',
        '6120',
        '6140',
        '6190',
        '6040',
        '6200'
      )
      AND d.beskz = 'E'
      AND d.wzeit != 0
      AND decode(a.plifz, ' ', 0, a.plifz) != round(
        (
          (
            d.wzeit + d.webaz + TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            )
          ) *(7 / 5)
        ) + 1 + rcvadd
      )
      AND a.plifz - round(
        (
          (
            d.wzeit + d.webaz + TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            )
          ) *(7 / 5)
        ) + 1 + rcvadd
      ) != '0'
    ) THEN a.plifz - round(
      (
        (
          d.wzeit + d.webaz + TO_NUMBER(
            nvl(
              decode(
                substr(t.route, 5),
                'TB',
                1,
                substr(t.route, 5)
              ),
              0
            )
          )
        ) *(7 / 5)
      ) + 1 + rcvadd
    )
    ELSE 0
  END AS lt_delta,
  a.matnr AS mat,
  a.werks AS rplt,
  a.dispo AS rcont,
  z.dsnam AS rplanner,
  a.mmsta AS rblock,
  a.sobsl AS rspk,
  a.plifz AS rpdt,
  a.wzeit AS rtrlt,
  d.werks AS splt,
  m.mtart AS mattype,
  d.mmsta AS sblock,
  d.plifz AS spdt,
  d.dzeit AS sipt,
  d.webaz AS sgrt,
  d.wzeit AS strlt,
  t.route,
  TO_NUMBER(
    nvl(
      decode(
        substr(t.route, 5),
        'TB',
        1,
        substr(t.route, 5)
      ),
      0
    )
  ) AS ttime,
  d.beskz AS sproc,
  d.strgr AS strat,
  v.prat1 AS dirshp,
  v.dwerk AS delplnt,
  a.rcvadd,
  CASE
    WHEN (
      a.werks = '4000'
      AND d.werks IN (
        '1140',
        '1090',
        '1180',
        '4020',
        '4050',
        '4070',
        '5120',
        '5160',
        '5190',
        '5200',
        '5040',
        '5050',
        '5100',
        '5110',
        '5140',
        '5070',
        '6060',
        '6030',
        '6050',
        '6070',
        '6080',
        '6110',
        '6120',
        '6140',
        '6190',
        '6040',
        '6200'
      )
      AND d.strgr = '40'
      AND decode(a.plifz, ' ', 0, a.plifz) != round(
        (
          (
            TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            ) / 5
          ) * 7
        ) + 2 + rcvadd
      )
      AND a.plifz - round(
        (
          (
            TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            ) / 5
          ) * 7
        ) + 2 + rcvadd
      ) != '0'
    ) THEN 'CEDC rule (2 + Xfer *7/5+rcvadd)'
    WHEN (
      a.werks = '4010'
      AND d.werks = '4000'
      AND d.strgr = '40'
      AND decode(a.plifz, ' ', 0, a.plifz) != 0
    ) THEN 'BCC rule set to 0'
    WHEN (
      a.werks = '4010'
      AND d.werks = '4000'
      AND d.strgr != '40'
      AND decode(a.plifz, ' ', 0, a.plifz) != round(d.plifz +((d.webaz) * 7 / 5))
    ) THEN 'BCC rule PDT+(GR*7/5)'
    WHEN (
      a.werks = '1250'
      AND d.werks = '1140'
      AND d.strgr = '40'
      AND decode(a.plifz, ' ', 0, a.plifz) != 0
    ) THEN '1250 rule set to 0'
    WHEN (
      a.werks = '1250'
      AND d.werks = '1140'
      AND d.strgr != '40'
      AND decode(a.plifz, ' ', 0, a.plifz) != round(d.plifz +((d.webaz) * 7 / 5))
    ) THEN '1250 rule PDT+(GR*7/5)'
    WHEN (
      a.beskz = 'F'
      AND substr(a.sobsl, 1, 1) IN ('E', 'F', 'D')
      AND d.werks IN (
        '1140',
        '1090',
        '1180',
        '4000',
        '4020',
        '4050',
        '4070',
        '5120',
        '5160',
        '5190',
        '5040',
        '5050',
        '5100',
        '5110',
        '5140',
        '5070',
        '6060',
        '6030',
        '6050',
        '6070',
        '6080',
        '6110',
        '6120',
        '6140',
        '6190',
        '6040',
        '6200'
      )
      AND d.strgr = '40'
      AND decode(a.plifz, ' ', 0, a.plifz) != round(
        (
          (
            TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            ) / 5
          ) * 7
        ) + 2 + rcvadd
      )
      AND a.plifz - round(
        (
          (
            TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            ) / 5
          ) * 7
        ) + 2 + rcvadd
      ) != '0'
    ) THEN '2+ (Xfer * 7/5)+rcvadd'
    WHEN (
      a.beskz = 'F'
      AND substr(a.sobsl, 1, 1) IN ('E', 'F', 'D')
      AND d.werks IN ('5200')
      AND d.strgr = '40'
      AND decode(a.plifz, ' ', 0, a.plifz) != round(
        (
          (
            TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            ) / 5
          ) * 7
        ) + 4 + rcvadd
      )
      AND a.plifz - round(
        (
          (
            TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            ) / 5
          ) * 7
        ) + 4 + rcvadd
      ) != '0'
    ) THEN '4+ (Xfer * 7/5)+rcvadd'
    WHEN (
      a.beskz = 'F'
      AND substr(a.sobsl, 1, 1) IN ('E', 'F', 'D')
      AND d.werks IN (
        '1140',
        '1090',
        '1180',
        '4000',
        '4020',
        '4050',
        '4070',
        '5120',
        '5160',
        '5190',
        '5040',
        '5050',
        '5100',
        '5110',
        '5140',
        '5070',
        '6060',
        '6030',
        '6050',
        '6070',
        '6080',
        '6110',
        '6120',
        '6140',
        '6190',
        '6040',
        '6200'
      )
      AND d.strgr != '40'
      AND decode(a.plifz, ' ', 0, a.plifz) != round(
        d.plifz +(
          (
            d.webaz + TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            )
          ) *(7 / 5)
        ) + 2 + rcvadd
      )
      AND a.plifz - round(
        d.plifz +(
          (
            d.webaz + TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            )
          ) *(7 / 5)
        ) + 2 + rcvadd
      ) != '0'
    ) THEN '2+rcvadd + PDT + ((GR + Xfer) * 7/5)'
    WHEN (
      a.beskz = 'F'
      AND substr(a.sobsl, 1, 1) IN ('E', 'F', 'D')
      AND d.werks IN ('5200')
      AND d.strgr != '40'
      AND decode(a.plifz, ' ', 0, a.plifz) != round(
        d.plifz +(
          (
            d.webaz + TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            )
          ) *(7 / 5)
        ) + 4 + rcvadd
      )
      AND a.plifz - round(
        d.plifz +(
          (
            d.webaz + TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            )
          ) *(7 / 5)
        ) + 4 + rcvadd
      ) != '0'
    ) THEN '4+rcvadd + PDT + ((GR + Xfer) * 7/5)'
    WHEN (
      a.beskz = 'F'
      AND substr(a.sobsl, 1, 1) IN ('E', 'F', 'D')
      AND d.werks NOT IN (
        '1140',
        '1090',
        '1180',
        '4000',
        '4020',
        '4050',
        '4070',
        '5120',
        '5160',
        '5190',
        '5200',
        '5040',
        '5050',
        '5100',
        '5110',
        '5140',
        '5070',
        '6060',
        '6030',
        '6050',
        '6070',
        '6080',
        '6110',
        '6120',
        '6140',
        '6190',
        '6040',
        '6200'
      )
      AND d.beskz = 'F'
      AND decode(a.plifz, ' ', 0, a.plifz) != round(
        2 + rcvadd + d.plifz +(
          (
            d.webaz + TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(
                    t.route,
                    5
                  )
                ),
                0
              )
            )
          ) *(7 / 5)
        )
      )
      AND a.plifz - round(
        d.plifz +(
          (
            d.webaz + TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            )
          ) *(7 / 5)
        ) + 2 + rcvadd
      ) != '0'
    ) THEN '2 +rcvadd + PDT + ((GR + Xfer) * 7/5)'
    WHEN (
      a.beskz = 'F'
      AND substr(a.sobsl, 1, 1) IN ('E', 'F', 'D')
      AND d.werks NOT IN (
        '1140',
        '1090',
        '1180',
        '4000',
        '4020',
        '4050',
        '4070',
        '5120',
        '5160',
        '5190',
        '5200',
        '5040',
        '5050',
        '5100',
        '5110',
        '5140',
        '5070',
        '6060',
        '6030',
        '6050',
        '6070',
        '6080',
        '6110',
        '6120',
        '6140',
        '6190',
        '6040',
        '6200'
      )
      AND d.beskz = 'E'
      AND d.wzeit = 0
      AND decode(a.plifz, ' ', 0, a.plifz) != round(
        (
          (
            d.dzeit + d.webaz + TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            )
          ) *(7 / 5)
        ) + 1 + rcvadd
      )
      AND a.plifz - round(
        (
          (
            d.dzeit + d.webaz + TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            )
          ) *(7 / 5)
        ) + 1 + rcvadd
      ) != '0'
    ) THEN '1 +rcvadd + ((IPT + GR + Xfer) * 7/5)'
    WHEN (
      a.beskz = 'F'
      AND substr(a.sobsl, 1, 1) IN ('E', 'F', 'D')
      AND d.werks NOT IN (
        '1140',
        '1090',
        '1180',
        '4000',
        '4020',
        '4050',
        '4070',
        '5120',
        '5160',
        '5190',
        '5200',
        '5040',
        '5050',
        '5100',
        '5110',
        '5140',
        '5070',
        '6060',
        '6030',
        '6050',
        '6070',
        '6080',
        '6110',
        '6120',
        '6140',
        '6190',
        '6040',
        '6200'
      )
      AND d.beskz = 'E'
      AND d.wzeit != 0
      AND decode(a.plifz, ' ', 0, a.plifz) != round(
        (
          (
            d.wzeit + d.webaz + TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            )
          ) *(7 / 5)
        ) + 1 + rcvadd
      )
      AND a.plifz - round(
        (
          (
            d.wzeit + d.webaz + TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            )
          ) *(7 / 5)
        ) + 1 + rcvadd
      ) != '0'
    ) THEN '1 +rcvadd + ((TRLT + GR + Xfer) * 7/5)'
    ELSE 'ok'
  END AS calc,
  CASE
    WHEN (
      a.werks = '4000'
      AND d.werks IN (
        '1140',
        '1090',
        '1180',
        '4020',
        '4050',
        '4070',
        '5120',
        '5160',
        '5190',
        '5200',
        '5040',
        '5050',
        '5100',
        '5110',
        '5140',
        '5070',
        '6060',
        '6030',
        '6050',
        '6070',
        '6080',
        '6110',
        '6120',
        '6140',
        '6190',
        '6040',
        '6200'
      )
      AND d.strgr = '40'
      AND decode(a.plifz, ' ', 0, a.plifz) != round(
        (
          (
            TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            ) / 5
          ) * 7
        ) + 2 + rcvadd
      )
      AND a.plifz - round(
        (
          (
            TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            ) / 5
          ) * 7
        ) + 2 + rcvadd
      ) != '0'
    ) THEN 'CEDC rule - Stocked in CDC'
    WHEN (
      a.werks = '4000'
      AND d.werks IN (
        '1140',
        '1090',
        '1180',
        '4020',
        '4050',
        '4070',
        '5120',
        '5160',
        '5190',
        '5200',
        '5040',
        '5050',
        '5100',
        '5110',
        '5140',
        '5070',
        '6060',
        '6030',
        '6050',
        '6070',
        '6080',
        '6110',
        '6120',
        '6140',
        '6190',
        '6040',
        '6200'
      )
      AND d.strgr = '40'
      AND (
        decode(a.plifz, ' ', 0, a.plifz) = round(
          (
            (
              TO_NUMBER(
                nvl(
                  decode(
                    substr(t.route, 5),
                    'TB',
                    1,
                    substr(t.route, 5)
                  ),
                  0
                )
              ) / 5
            ) * 7
          ) + 2 + rcvadd
        )
        OR a.plifz - round(
          (
            (
              TO_NUMBER(
                nvl(
                  decode(
                    substr(t.route, 5),
                    'TB',
                    1,
                    substr(t.route, 5)
                  ),
                  0
                )
              ) / 5
            ) * 7
          ) + 2 + rcvadd
        ) = '0'
      )
    ) THEN 'ok'
    WHEN (
      a.werks = '4010'
      AND d.werks = '4000'
      AND d.strgr = '40'
      AND decode(a.plifz, ' ', 0, a.plifz) != 0
    ) THEN 'BCC rule stocked in 4000'
    WHEN (
      a.werks = '4010'
      AND d.werks = '4000'
      AND d.strgr != '40'
      AND decode(a.plifz, ' ', 0, a.plifz) != round(d.plifz +((d.webaz) * 7 / 5))
    ) THEN 'BCC rule nonstocked in 4000'
    WHEN (
      a.werks = '4010'
      AND d.werks = '4000'
      AND d.strgr = '40'
      AND decode(a.plifz, ' ', 0, a.plifz) = 0
    ) THEN 'ok'
    WHEN (
      a.werks = '4010'
      AND d.werks = '4000'
      AND d.strgr != '40'
      AND decode(a.plifz, ' ', 0, a.plifz) = round(d.plifz +((d.webaz) * 7 / 5))
    ) THEN 'ok'
    WHEN (
      a.werks = '1250'
      AND d.werks = '1140'
      AND d.strgr = '40'
      AND decode(a.plifz, ' ', 0, a.plifz) != 0
    ) THEN '1250 rule stocked in 1140'
    WHEN (
      a.werks = '1250'
      AND d.werks = '1140'
      AND d.strgr != '40'
      AND decode(a.plifz, ' ', 0, a.plifz) != round(d.plifz +((d.webaz) * 7 / 5))
    ) THEN '1250 rule nonstocked in 1140'
    WHEN (
      a.werks = '1250'
      AND d.werks = '1140'
      AND d.strgr = '40'
      AND decode(a.plifz, ' ', 0, a.plifz) = 0
    ) THEN 'ok'
    WHEN (
      a.werks = '1250'
      AND d.werks = '1140'
      AND d.strgr != '40'
      AND decode(a.plifz, ' ', 0, a.plifz) = round(d.plifz +((d.webaz) * 7 / 5))
    ) THEN 'ok'
    WHEN (
      a.beskz = 'F'
      AND substr(a.sobsl, 1, 1) IN ('E', 'F', 'D')
      AND d.werks IN (
        '1140',
        '1090',
        '1180',
        '4000',
        '4020',
        '4050',
        '4070',
        '5120',
        '5160',
        '5190',
        '5040',
        '5050',
        '5100',
        '5110',
        '5140',
        '5070',
        '6060',
        '6030',
        '6050',
        '6070',
        '6080',
        '6110',
        '6120',
        '6140',
        '6190',
        '6040',
        '6200'
      )
      AND d.strgr = '40'
      AND decode(a.plifz, ' ', 0, a.plifz) != round(
        (
          (
            TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            ) / 5
          ) * 7
        ) + 2 + rcvadd
      )
      AND a.plifz - round(
        (
          (
            TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            ) / 5
          ) * 7
        ) + 2 + rcvadd
      ) != '0'
    ) THEN 'Stocked in CDC'
    WHEN (
      a.beskz = 'F'
      AND substr(a.sobsl, 1, 1) IN ('E', 'F', 'D')
      AND d.werks IN ('5200')
      AND d.strgr = '40'
      AND decode(a.plifz, ' ', 0, a.plifz) != round(
        (
          (
            TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            ) / 5
          ) * 7
        ) + 4 + rcvadd
      )
      AND a.plifz - round(
        (
          (
            TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            ) / 5
          ) * 7
        ) + 4 + rcvadd
      ) != '0'
    ) THEN 'Stocked in SGP DC'
    WHEN (
      a.beskz = 'F'
      AND substr(a.sobsl, 1, 1) IN ('E', 'F', 'D')
      AND d.werks IN (
        '1140',
        '1090',
        '1180',
        '4000',
        '4020',
        '4050',
        '4070',
        '5120',
        '5160',
        '5190',
        '5040',
        '5050',
        '5100',
        '5110',
        '5140',
        '5070',
        '6060',
        '6030',
        '6050',
        '6070',
        '6080',
        '6110',
        '6120',
        '6140',
        '6190',
        '6040',
        '6200'
      )
      AND d.strgr != '40'
      AND decode(a.plifz, ' ', 0, a.plifz) != round(
        d.plifz +(
          (
            d.webaz + TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            )
          ) *(7 / 5)
        ) + 2 + rcvadd
      )
      AND a.plifz - round(
        d.plifz +(
          (
            d.webaz + TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            )
          ) *(7 / 5)
        ) + 2 + rcvadd
      ) != '0'
    ) THEN 'Non-stock in CDC'
    WHEN (
      a.beskz = 'F'
      AND substr(a.sobsl, 1, 1) IN ('E', 'F', 'D')
      AND d.werks IN ('5200')
      AND d.strgr != '40'
      AND decode(a.plifz, ' ', 0, a.plifz) != round(
        d.plifz +(
          (
            d.webaz + TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            )
          ) *(7 / 5)
        ) + 4 + rcvadd
      )
      AND a.plifz - round(
        d.plifz +(
          (
            d.webaz + TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            )
          ) *(7 / 5)
        ) + 4 + rcvadd
      ) != '0'
    ) THEN 'Non-stock in SGP DC'
    WHEN (
      a.beskz = 'F'
      AND substr(a.sobsl, 1, 1) IN ('E', 'F', 'D')
      AND d.werks NOT IN (
        '1140',
        '1090',
        '1180',
        '4000',
        '4020',
        '4050',
        '4070',
        '5120',
        '5160',
        '5190',
        '5200',
        '5040',
        '5050',
        '5100',
        '5110',
        '5140',
        '5070',
        '6060',
        '6030',
        '6050',
        '6070',
        '6080',
        '6110',
        '6120',
        '6140',
        '6190',
        '6040',
        '6200'
      )
      AND d.beskz = 'F'
      AND decode(a.plifz, ' ', 0, a.plifz) != round(
        2 + rcvadd + d.plifz +(
          (
            d.webaz + TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(
                    t.route,
                    5
                  )
                ),
                0
              )
            )
          ) *(7 / 5)
        )
      )
      AND a.plifz - round(
        d.plifz +(
          (
            d.webaz + TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            )
          ) *(7 / 5)
        ) + 2 + rcvadd
      ) != '0'
    ) THEN 'Non-CDC purch'
    WHEN (
      a.beskz = 'F'
      AND substr(a.sobsl, 1, 1) IN ('E', 'F', 'D')
      AND d.werks NOT IN (
        '1140',
        '1090',
        '1180',
        '4000',
        '4020',
        '4050',
        '4070',
        '5120',
        '5160',
        '5190',
        '5200',
        '5040',
        '5050',
        '5100',
        '5110',
        '5140',
        '5070',
        '6060',
        '6030',
        '6050',
        '6070',
        '6080',
        '6110',
        '6120',
        '6140',
        '6190',
        '6040',
        '6200'
      )
      AND d.beskz = 'E'
      AND d.wzeit = 0
      AND decode(a.plifz, ' ', 0, a.plifz) != round(
        (
          (
            d.dzeit + d.webaz + TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            )
          ) *(7 / 5)
        ) + 1 + rcvadd
      )
      AND a.plifz - round(
        (
          (
            d.dzeit + d.webaz + TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            )
          ) *(7 / 5)
        ) + 1 + rcvadd
      ) != '0'
    ) THEN 'Non-CDC make no TRLT'
    WHEN (
      a.beskz = 'F'
      AND substr(a.sobsl, 1, 1) IN ('E', 'F', 'D')
      AND d.werks NOT IN (
        '1140',
        '1090',
        '1180',
        '4000',
        '4020',
        '4050',
        '4070',
        '5120',
        '5160',
        '5190',
        '5200',
        '5040',
        '5050',
        '5100',
        '5110',
        '5140',
        '5070',
        '6060',
        '6030',
        '6050',
        '6070',
        '6080',
        '6110',
        '6120',
        '6140',
        '6190',
        '6040',
        '6200'
      )
      AND d.beskz = 'E'
      AND d.wzeit != 0
      AND decode(a.plifz, ' ', 0, a.plifz) != round(
        (
          (
            d.wzeit + d.webaz + TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            )
          ) *(7 / 5)
        ) + 1 + rcvadd
      )
      AND a.plifz - round(
        (
          (
            d.wzeit + d.webaz + TO_NUMBER(
              nvl(
                decode(
                  substr(t.route, 5),
                  'TB',
                  1,
                  substr(t.route, 5)
                ),
                0
              )
            )
          ) *(7 / 5)
        ) + 1 + rcvadd
      ) != '0'
    ) THEN 'Non-CDC make with TRLT'
    ELSE 'ok'
  END AS calc_type
FROM
  (
    SELECT
      marc.*,
      CASE
        WHEN (
          marc.werks = '6120'
          AND marc.dispo = '003'
        ) THEN 60
        WHEN (
          (marc.werks IN ('6120', '6160'))
          AND (marc.sobsl = 'F8')
        ) THEN TO_NUMBER('-2.0')
        ELSE 0
      END AS rcvadd
    FROM
      sapecc_dly_librarian.marc
    WHERE
      marc.mandt = '400'
  ) a,
  sapecc_dly_librarian.t460a b,
  sapecc_dly_librarian.marc d,
  sapecc_librarian.trolz t,
  sapecc_librarian.t024d z,
  sapecc_dly_librarian.mvke v,
  sapecc_dly_librarian.mara m
WHERE
  a.mandt = '400'
  AND a.mandt = b.mandt
  AND a.mandt = d.mandt
  AND a.mandt = t.mandt
  AND a.mandt = z.mandt
  AND a.mandt = v.mandt
  AND a.mandt = m.mandt
  AND a.werks = b.werks
  AND a.sobsl = b.sobsl
  AND a.matnr = d.matnr
  AND a.matnr NOT IN (
    SELECT
      decode(
        translate(t1.matnr, '-0123456789', '-'),
        '',
        lpad(t1.matnr, 18, '0'),
        t1.matnr
      )
    FROM
      winshuttle_admin.lt_sync_pdt_ext_list t1
  )
  AND a.matnr NOT IN (
    SELECT
      decode(
        translate(t1.matnr, '-0123456789', '-'),
        '',
        lpad(t1.matnr, 18, '0'),
        t1.matnr
      )
    FROM
      winshuttle_admin.lt_sync_excl_list t1
  )
  AND a.matnr = v.matnr
  AND b.wrk02 = d.werks
  AND a.werks = z.werks
  AND a.dispo = z.dispo
  AND v.vkorg <> '1006'
  AND v.vkorg = CASE
    WHEN (d.werks = '4030') THEN '4128'
    WHEN (d.werks = '3020') THEN '4128' --                  when (d.werks = '1170')     
    --                  then '4122'
    ELSE (
      SELECT
        bukrs
      FROM
        sapecc_librarian.t001k
      WHERE
        bwkey = d.werks
    )
  END
  AND a.mmsta NOT IN (
    '01',
    '07',
    '08',
    '09',
    'NA',
    'ZL',
    'ZP',
    'Z8',
    'ZG',
    'ZQ',
    'ZJ'
  )
  AND m.mtart != 'ZREP'
  AND a.dispo != 'RET'
  AND (
    (a.dismm != 'ND')
    OR (
      a.werks IN (
        '1130',
        '3500',
        '3540',
        '3560',
        '3580',
        '3581',
        '3600',
        '3610',
        '3620',
        '3630',
        '3640',
        '3641',
        '3650',
        '3651',
        '3660',
        '3670',
        '3680',
        '3690',
        '3700',
        '3710',
        '3720',
        '3730',
        '3740',
        '3750',
        '3760',
        '3770',
        '3780',
        '3790',
        '3800',
        '3810',
        '3820',
        '3830',
        '3840',
        '3850',
        '3860',
        '3870',
        '7001',
        '7002',
        '7003',
        '7004',
        '7005',
        '7006',
        '7007',
        '7008',
        '7009',
        '7010',
        '7011',
        '7012'
      )
    )
  )
  AND NOT (
    d.werks IN ('5170')
    AND d.beskz = 'F'
  ) --Ignore when plant 5170 is supply plant and are purchased 05-02-2013
  AND NOT (
    d.werks = '4010'
    AND a.werks = '4000'
  ) -- per Maurits Lems 3-22-13 ignore updates of leadtimes when delivery plant is 4010 and recevie plant is 4000
  AND t.vsbed = 'Z1'
  AND t.grulg = ' '
  AND t.lzone = CASE
    WHEN (a.werks = '3000') THEN '1020'
    WHEN (a.werks = '4010') THEN '4000'
    WHEN (a.werks = '4100') THEN '4020'
    ELSE a.werks
  END
  AND substr(t.azone, 1, 3) = substr(d.werks, 1, 3)
  AND substr(t.azone, 4) = 'A'
  AND t.tragr = 'Z001'
  AND m.tragr != 'Z003'
  AND a.matnr = m.matnr
  AND d.ladgr != 'Z003' -- added to properly exclude ocean materials.  At the same time, removed the 27 current ocean materials from the exclude list.
  AND NOT (
    a.werks IN ('1140', '1090', '1180')
    AND v.prat1 = 'X'
    AND v.dwerk IN ('1120', '1160', '3000')
  )
)

