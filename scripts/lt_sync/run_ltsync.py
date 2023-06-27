import os

from api.rtd.rtd_connector import connect_rtd, close_rtd


def get_original():
    # view_script = os.path.join('sql', 'lt_sync', '00_lt_sync_daily_v46_org.sql')
    view_script = os.path.join('sql', 'lt_sync', 'test_lt_org.sql')
    with open(view_script, 'r') as file:
        view_query = file.read()

    query = '''
    SELECT
      'STATUS_ORIG_CODE' AS S_Status,
      Aa.mat AS "Material",
      Aa.rplt AS "Rcv Plt",
      aa.clt AS "CORRECT_LT(PLIFZ)",
      aa.rpdt AS "Rcv PDT(PLIFZ)",
      aa.splt AS "Sup Plt",
      aa.lt_delta AS "LT delta",
      Aa.mattype AS "Mat Type",
      aa.rcont AS "Rcv MRP cont",
      aa.rplanner AS "Rcv Planner",
      aa.rblock AS "rcv block",
      aa.rspk AS "rcv SPK",
      aa.rtrlt AS "Rcv tot repl lt",
      aa.sblock AS "sup block",
      aa.spdt AS "Sup PDT",
      aa.sipt AS "Sup IPT",
      aa.sgrt AS "Sup GRT",
      aa.strlt AS "Sup tot repl lt",
      aa.route,
      aa.ttime AS "transit time",
      aa.sproc AS "Sup proc type",
      aa.strat AS "Strat grp",
      aa.calc AS "LT Calc",
      aa.calc_type AS "calc type",
      aa.rcvadd
    FROM
      lt_sync_original
    WHERE
      AA.calc_type != 'ok';
    '''

    con, cur = connect_rtd()
    cur.execute(view_query)
    cur.execute(query)

    results = cur.fetchall()

    for r in results:
        print(r)

    

