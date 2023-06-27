SELECT
  MERGED.MATERIALID,
  MERGED.PLANTID,
  MERGED.SALES_ORG,
  MERGED.SP_MATL_STAT_MMSTA,
  MERGED.D_CHAIN,
  MERGED.PROC_TYPE,
  MERGED.MRP_CONTROLLER,
  MERGED.MRP_NAME,
  MERGED.SPC,
  MERGED.SPC_KEY,
  MERGED.DEL_PLANT,
  MERGED.COMPARE,
  MERGED.SPC_PLANTID,
  MERGED.SPC_SP_MATL_STAT_MMSTA,
  MERGED.SPC_PROC_TYPE,
  MERGED.SPC_MRP_CONTROLLER,
  MERGED.SPC_MRP_NAME,
  MERGED.SPC_SPC
FROM
  (
    SELECT
      DISTINCT MARC.MATERIALID,
      MARC.PLANTID,
      MVKE.SALES_ORG,
      MARC.SP_MATL_STAT_MMSTA,
      MVKE.D_CHAIN,
      MARC.PROC_TYPE,
      MARC.MRP_CONTROLLER,
      MARC.MRP_NAME,
      MVKE.DEL_PLANT,
      MARC.SPC,
      MARC.SPC_KEY,
      CASE
        WHEN MVKE.SALES_ORG IS NULL THEN 'Non-SORG_1000'
        WHEN MARC.SPC_KEY = MVKE.DEL_PLANT THEN 'OK'
        WHEN MVKE.DEL_PLANT = '1140'
        AND MARC.SPC_KEY = '1070' THEN 'OK'
        WHEN MVKE.DEL_PLANT = '1140'
        AND MARC.SPC_KEY = '1140' THEN 'OK'
        WHEN trim(MVKE.DEL_PLANT) IS NULL THEN 'NO DEL_PLANT'
        WHEN trim(MARC_SPC.SPC_PLANTID) IS NULL THEN 'NOT EXTENDED TO SPC PLANT'
        ELSE 'NO MATCH'
      END COMPARE,
      MARC_SPC.SPC_PLANTID,
      MARC_SPC.SPC_SP_MATL_STAT_MMSTA,
      MARC_SPC.SPC_PROC_TYPE,
      MARC_SPC.SPC_MRP_CONTROLLER,
      MARC_SPC.SPC_MRP_NAME,
      MARC_SPC.SPC_SPC
    FROM
      (
        SELECT
          MATNR,
          CASE
            WHEN TRANSLATE (
              M1.matnr,
              'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ',
              '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
            ) LIKE '%!%' THEN TRIM (M1.MATNR)
            WHEN TRIM(M1.MATNR) LIKE '00000000000___ ___' THEN substr(TRIM(M1.MATNR), 12, 50)
            WHEN TRIM(M1.MATNR) LIKE '000000%' THEN TO_CHAR(TO_NUMBER(REPLACE(TRIM(M1.MATNR), ',', NULL)))
            ELSE TRIM(M1.MATNR)
          END MATERIALID,
          TRIM(M1.WERKS) PLANTID,
          M1.MMSTA SP_MATL_STAT_MMSTA,
          M1.BESKZ PROC_TYPE,
          M1.DISPO MRP_CONTROLLER,
          (
            SELECT
              trim(DSNAM)
            FROM
              SAPECC_LIBRARIAN.T024D MRP1
            WHERE
              MRP1.WERKS = trim(m1.werks)
              AND MRP1.DISPO = M1.DISPO
          ) MRP_NAME,
          M1.SOBSL SPC,
          (
            SELECT
              trim(WRK02)
            FROM
              SAPECC_LIBRARIAN.T460A TA
            WHERE
              trim(TA.WERKS) = trim(M1.WERKS)
              AND trim(M1.SOBSL) = trim(TA.SOBSL)
          ) SPC_KEY
        FROM
          SAPECC_LIBRARIAN.MARC M1
        WHERE
          m1.WERKS = '1140'
          AND trim(m1.MMSTA) IS NULL
          AND length(M1.SOBSL) > 1
      ) MARC
      LEFT OUTER JOIN (
        SELECT
          CASE
            WHEN TRANSLATE (
              matnr,
              'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ',
              '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
            ) LIKE '%!%' THEN TRIM (MATNR)
            WHEN TRIM(MATNR) LIKE '00000000000___ ___' THEN substr(TRIM(MATNR), 12, 50)
            WHEN TRIM(MATNR) LIKE '000000%' THEN TO_CHAR(TO_NUMBER(REPLACE(TRIM(MATNR), ',', NULL)))
            ELSE TRIM(MATNR)
          END MATERIALID,
          trim(DWERK) DEL_PLANT,
          VKORG SALES_ORG,
          trim(VMSTA) D_CHAIN
        FROM
          SAPECC_LIBRARIAN.MVKE M2
        WHERE
          vkorg = '1000'
      ) MVKE ON MARC.MATERIALID = MVKE.MATERIALID
      LEFT OUTER JOIN (
        SELECT
          MATNR,
          CASE
            WHEN TRANSLATE (
              matnr,
              'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ',
              '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
            ) LIKE '%!%' THEN TRIM (MATNR)
            WHEN TRIM(M2.MATNR) LIKE '00000000000___ ___' THEN substr(TRIM(M2.MATNR), 12, 50)
            WHEN TRIM(M2.MATNR) LIKE '000000%' THEN TO_CHAR(TO_NUMBER(REPLACE(TRIM(M2.MATNR), ',', NULL)))
            ELSE TRIM(M2.MATNR)
          END MATERIALID,
          TRIM(M2.WERKS) SPC_PLANTID,
          M2.MMSTA SPC_SP_MATL_STAT_MMSTA,
          M2.BESKZ SPC_PROC_TYPE,
          M2.DISPO SPC_MRP_CONTROLLER,
          (
            SELECT
              trim(DSNAM)
            FROM
              SAPECC_LIBRARIAN.T024D MRP1
            WHERE
              MRP1.WERKS = trim(m2.werks)
              AND MRP1.DISPO = M2.DISPO
          ) SPC_MRP_NAME,
          M2.SOBSL SPC_SPC,
          (
            SELECT
              trim(WRK02)
            FROM
              SAPECC_LIBRARIAN.T460A TA
            WHERE
              trim(TA.WERKS) = trim(M2.WERKS)
              AND trim(M2.SOBSL) = trim(TA.SOBSL)
          ) SPC_SPC_KEY
        FROM
          SAPECC_LIBRARIAN.MARC M2
      ) MARC_SPC ON MARC.MATERIALID = MARC_SPC.MATERIALID
      AND trim(MARC.SPC_KEY) = trim(MARC_SPC.SPC_PLANTID)
  ) MERGED
WHERE
  MERGED.COMPARE <> 'OK'
  AND nvl(MERGED.DEL_PLANT, 'X') <> '1180'
  AND MERGED.SPC_KEY IS NOT NULL
  AND MERGED.D_CHAIN IS NULL
  AND merged.spc_key <> '1170'
  AND merged.spc_key < '2000'
  AND merged.spc_key <> '1130'