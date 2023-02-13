import os
import pandas as pd
import warnings

import utils.prompts as pr
from utils.helpers import await_char, use_dotenv, output_msg

use_dotenv()
output = ""


def process_ltsync(server=False):
    warnings.simplefilter("ignore")

    dir_inputs = os.environ["DIR_IN"]
    dir_outputs = os.environ["DIR_OUT"]

    report_date = input(f"{pr.prmt}Please provide report date in MM-DD-YYYY format: ")

    # omit_plants = [6160] - 6160 removed as per Vanessa Tonelo [2022-04-04]
    # omit_plants = [4040] - 4040 removed as per Linda Jager [2022-07-21]
    omit_plants = [6160, 4040]

    new_report = os.path.join(dir_inputs, "NEW.xlsx")
    original_report = os.path.join(dir_inputs, "ORIGINAL.xlsx")
    o15_report = os.path.join(dir_inputs, "O15.xlsx")

    # NEW
    output += output_msg(f"{pr.info}Loading NEW QUERY data...")
    df_new = pd.read_excel(new_report)
    df_new_clean = df_new.drop(
        [
            "Mat Type",
            "Rcv MRP cont",
            "Rcv Planner",
            "rcv block",
            "rcv SPK",
            "Rcv tot repl lt",
            "sup block",
            "Sup PDT",
            "Sup IPT",
            "Sup GRT",
            "Sup tot repl lt",
            "ROUTE",
            "transit time",
            "Sup proc type",
            "Strat grp",
            "LT Calc",
            "calc type",
            "RCVADD",
        ],
        axis=1,
    )

    # ORIGINAL
    output += output_msg(f"{pr.info}Loading ORIGINAL QUERY data...")
    df_org = pd.read_excel(original_report)
    df_org_clean = df_org.drop(
        [
            "Mat Type",
            "Rcv MRP cont",
            "Rcv Planner",
            "rcv block",
            "rcv SPK",
            "Rcv tot repl lt",
            "sup block",
            "Sup PDT",
            "Sup IPT",
            "Sup GRT",
            "Sup tot repl lt",
            "ROUTE",
            "transit time",
            "Sup proc type",
            "Strat grp",
            "LT Calc",
            "calc type",
            "RCVADD",
        ],
        axis=1,
    )

    # OCEAN 1170 5130
    output += output_msg(f"{pr.info}Loading 3 QUERY data...")

    df_o15 = pd.read_excel(o15_report)

    # COMBINE
    output += output_msg(f"{pr.info}Processing...")

    frames = [df_new_clean, df_org_clean, df_o15]
    df_combined = pd.concat(frames)

    # REMOVE OMIT PLANTS
    result = df_combined[(~df_combined["Rcv Plt"].isin(omit_plants))]
    omitted = df_combined[(df_combined["Rcv Plt"].isin(omit_plants))]
    output += output_msg(
        f"{pr.file}LT Sync Daily after exclusion has total of: {result.shape[0]} records."
    )
    output += output_msg(
        f"{pr.file}Total of changes were excluded from the process: {omitted.shape[0]} records."
    )

    # WS LOAD DATA
    load_data = result.drop(
        [
            "Rcv PDT(PLIFZ)",
            "Sup Plt",
            "LT delta",
        ],
        axis=1,
    )

    # CREATE PIVOT
    pivot = result.pivot_table(
        index=["Rcv Plt"], values=["Material"], aggfunc=["count"], margins="true"
    )

    # OUTPUTS
    # if os.path.exists(os.path.join(os.getcwd(), 'output')) == False:
    #     os.mkdir(os.path.join(os.getcwd(), 'output'))

    output += output_msg(f"{pr.info}Saving results to LT SYnc daily & Loadfile")
    with pd.ExcelWriter(
        os.path.join(dir_outputs, f"{report_date} LT Sync_Daily after excludes.xlsx")
    ) as writer:
        pivot.to_excel(writer, sheet_name="summary")
        result.to_excel(writer, sheet_name="DATA", index=False)

    with pd.ExcelWriter(
        os.path.join(dir_outputs, f"00_lt_loadfile_{report_date}.xlsx")
    ) as writer:
        load_data.to_excel(writer, sheet_name="LOAD", index=False)
    output += output_msg(f"{pr.done}Complete")

    # END PROPMPT
    if server:
        return output, "Process LT Sync data"
    else:
        await_char(
            "y",
            f"{pr.prmt}Please find your processed file in OUTPUT folder. Press Y to continue.",
        )
