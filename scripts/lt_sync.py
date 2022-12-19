import os
import pandas as pd
import math
import numpy as np
import warnings


def process_ltsync():
    warnings.simplefilter("ignore")

    report_date = input('Please provide report date in MM-DD-YYYY format: ')

    # omit_plants = [6160] - 6160 removed as per Vanessa Tonelo [2022-04-04]
    # omit_plants = [4040] - 4040 removed as per Linda Jager [2022-07-21]
    omit_plants = [6160, 4040]

    new_report = os.path.join(os.getcwd(), 'data', 'NEW.xlsx')
    original_report = os.path.join(os.getcwd(), 'data', 'ORIGINAL.xlsx')
    o15_report = os.path.join(os.getcwd(), 'data', 'O15.xlsx')

    # NEW
    df_new = pd.read_excel(new_report)
    df_new_clean = df_new.drop(['Mat Type', 'Rcv MRP cont', 'Rcv Planner', 'rcv block', 'rcv SPK', 'Rcv tot repl lt', 'sup block', 'Sup PDT',
                               'Sup IPT', 'Sup GRT', 'Sup tot repl lt', 'ROUTE', 'transit time', 'Sup proc type', 'Strat grp', 'LT Calc', 'calc type', 'RCVADD'], axis=1)

    # ORIGINAL
    df_org = pd.read_excel(original_report)
    df_org_clean = df_org.drop(['Mat Type', 'Rcv MRP cont', 'Rcv Planner', 'rcv block', 'rcv SPK', 'Rcv tot repl lt', 'sup block', 'Sup PDT',
                               'Sup IPT', 'Sup GRT', 'Sup tot repl lt', 'ROUTE', 'transit time', 'Sup proc type', 'Strat grp', 'LT Calc', 'calc type', 'RCVADD'], axis=1)

    # OCEAN 1170 5130
    df_o15 = pd.read_excel(o15_report)

    # COMBINE
    frames = [df_new_clean, df_org_clean, df_o15]
    df_combined = pd.concat(frames)

    # REMOVE OMIT PLANTS
    result = df_combined[(~df_combined['Rcv Plt'].isin(omit_plants))]
    omitted = df_combined[(df_combined['Rcv Plt'].isin(omit_plants))]
    print(
        f"LT Sync Daily after exclusion has total of: {result.shape[0]} records.")
    print(
        f"Total of changes were excluded from the process: {omitted.shape[0]} records.")

    # WS LOAD DATA
    load_data = result.drop(
        ['Rcv PDT(PLIFZ)', 'Sup Plt', 'LT delta', ], axis=1)

    # CREATE PIVOT
    pivot = result.pivot_table(index=['Rcv Plt'], values=[
                               'Material'], aggfunc=['count'], margins='true')

    # OUTPUTS
    if os.path.exists(os.path.join(os.getcwd(), 'output')) == False:
        os.mkdir(os.path.join(os.getcwd(), 'output'))

    with pd.ExcelWriter(os.path.join(os.getcwd(), 'output', f'{report_date} LT Sync_Daily after excludes.xlsx')) as writer:
        pivot.to_excel(writer, sheet_name="summary")
        result.to_excel(writer, sheet_name="DATA", index=False)

    with pd.ExcelWriter(os.path.join(os.getcwd(), 'output', f'00_ws_loadfile_lt_sync_{report_date}.xlsx')) as writer:
        load_data.to_excel(writer, sheet_name="LOAD", index=False)

    # END PROPMPT
    text = input(
        'Please find your processed file in OUTPUT folder. Press ENTER to close.')


def split_laodfile():
    report_date = input('Please provide report date in MM-DD-YYYY format: ')

    df = pd.read_excel('.//output//loadfile.xlsx')

    print('Total parts to be processed: ')
    print(len(df))

    parts = math.ceil(len(df)/5000)

    print('Load file will split into: ')
    print(parts)

    spilts = np.array_split(df, parts)

    x = 0
    for i in spilts:
        print(len(i))
        x = x + 1

        with pd.ExcelWriter(os.path.join(os.getcwd(), 'output', f'00_ws_loadfile_lt_sync_{report_date} - p{x}.xlsx')) as writer:
            i.to_excel(writer, index=False)

    text = input(
        'Please find your processed files in OUTPUT folder. Press ENTER to close.')
