import os
import pandas as pd
from tqdm import tqdm
from openpyxl import load_workbook

from utils.helpers import use_dotenv, check_dir, ignore_warnings
from utils.plause import plause_files
from api.rtd.rtd_connector import connect_rtd, close_rtd


def run_plasue_aio():
    use_dotenv()
    ignore_warnings()

    files = plause_files
    report_date = input(f"Please provide report date in MM-DD-YYYY format: \n")
    output_directory = os.path.join(os.environ["DIR_OUT"], report_date)
    check_dir(output_directory)

    def handle_input(
        df,
        file,
        new_file,
        pivot=["Plant", "Material", "count", "true"],
        df_sheet: str = "DATA",
        pvt_sheet: str = "summary",
    ):
        print(file, "->", new_file)
        if not "_count" in file:
            pivot_df = df.pivot_table(
                index=[pivot[0]],
                values=[pivot[1]],
                aggfunc=[pivot[2]],
                margins=pivot[3],
            )
        out_path = os.path.join(output_directory, new_file)
        with pd.ExcelWriter(out_path) as writer:
            if not "_count" in file:
                pivot_df.to_excel(writer, sheet_name=pvt_sheet)
            df.to_excel(writer, sheet_name=df_sheet, index=False)

    def get_data(
        file,
    ):
        new_name = os.path.join(
            output_directory, f"{report_date} {file.split('.')[0]}.xlsx"
        )
        pivot = ["Plant", "Material", "count", "true"]
        df_sheet = "DATA"
        pvt_sheet = "summary"

        con = connect_rtd()[0]
        sql_command = open(os.path.join("sql", file), "r").read()
        chunks = pd.read_sql_query(sql_command, con, chunksize=100)
        df = pd.DataFrame()
        for chunk in tqdm(chunks):
            df = pd.concat([df, chunk])

        if "02_make_wo_lt" in file:
            new_name = os.path.join(output_directory, f"{report_date} Make wo LT.xlsx")
        if "03_sto_wo_lt" in file:
            new_name = os.path.join(output_directory, f"{report_date} STO_wo_LT.xlsx")
        if "04_tot_rep_lt_vs_ipt" in file:
            new_name = os.path.join(
                output_directory, f"{report_date} Tot Rep LT vs IPT.xlsx"
            )
        if "06_dist_center_make_parts" in file:
            new_name = os.path.join(
                output_directory, f"{report_date} Distribution Make parts.xlsx"
            )
        if "07_sto_nd" in file:
            new_name = os.path.join(output_directory, f"{report_date} STO ND.xlsx")
            pivot = ["SupPlnt", "Material", "count", "true"]
        if "08_parts_planning_strgr_consistency_check" in file:
            new_name = os.path.join(
                output_directory,
                f"{report_date} Parts_Planning_Strategy_Consistency_Check.xlsx",
            )
            pivot = ["Werks", "Matnr", "count", "true"]
        if "09_not_extended_to_spk_plant" in file:
            new_name = os.path.join(
                output_directory, f"{report_date} SPK not extended to plant.xlsx"
            )
            pivot = ["RECV_PLANT", "Material", "count", "true"]
        if "11_strat_group_check" in file:
            new_name = os.path.join(
                output_directory, f"{report_date} Strategy_Grp_Check.xlsx"
            )
            pivot = ["Werks", "Matnr", "count", "true"]
        if "12_matl_proc_to_spec_proc" in file:
            new_name = os.path.join(
                output_directory, f"{report_date} Matl Proc to Spec Proc.xlsx"
            )
        if "13_min_max_lots_equal" in file:
            new_name = os.path.join(
                output_directory, f"{report_date} Min Max Lots equal.xlsx"
            )
        if "14_purch_no_sp_sloc" in file:
            new_name = os.path.join(
                output_directory, f"{report_date} Purch no EP sloc.xlsx"
            )
            pivot = ["Werks", "Matnr", "count", "true"]
        if "15_sto_parts_wo_released_std_cost" in file:
            new_name = os.path.join(
                output_directory,
                f"{report_date} STO_Parts_wo_Released_Std_Cost.xlsx",
            )
            pivot = ["RcvPlnt", "Material", "count", "true"]
        if "17_quota_arranement" in file:
            new_name = os.path.join(
                output_directory, f"{report_date} Quota_arrangement.xlsx"
            )
            handle_input(df, file, new_name)
        if "24_spk_vs_del_plant_check" in file:
            new_name = os.path.join(
                output_directory, f"{report_date} del_plant_validation.xlsx"
            )
            pivot = ["PLANTID", "MATERIALID", "count", "true"]
        if "27_not_ext_spk_plant_count" in file:
            new_name = os.path.join(
                output_directory,
                f"{report_date} Not Extended to SPK Plant Count.xlsx",
            )
            df_sheet = "Sheet1"
        if "28_sto_from_plant_nith_nd_count" in file:
            new_name = os.path.join(
                output_directory,
                f"{report_date} STO From Plant with NO Planning_ND_Count.xlsx",
            )
            df_sheet = "Sheet1"
        if "29_sto_no_cost_count" in file:
            new_name = os.path.join(
                output_directory,
                f"{report_date} Total Rep Lead Time vs In House Prod Time Count.xlsx",
            )
            df_sheet = "Sheet1"
        if "30_trlt_vs_ipt_count" in file:
            new_name = os.path.join(
                output_directory, f"{report_date} STO No Cost Count.xlsx"
            )
            df_sheet = "Sheet1"

        handle_input(df, file, new_name, pivot, df_sheet, pvt_sheet)

    for f in files:
        get_data(f)

    for filename in os.listdir(output_directory):
        f = os.path.join(output_directory, filename)
        if os.path.isfile(f):
            if "Count" in f:
                df = pd.read_excel(f, sheet_name="Sheet1")
                df.columns = ["Plant", "QTY"]
                total = df["QTY"].sum()

                wb = load_workbook(filename=f)
                sht = wb.active
                sht["D2"] = total
                wb.save(filename=f)
