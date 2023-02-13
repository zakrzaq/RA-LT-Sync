import os
import pandas as pd
from openpyxl import load_workbook
import warnings

from utils.score_card import handle_scorecard
from utils.helpers import use_dotenv, await_char, output_msg
import utils.prompts as pr

use_dotenv()

scorcard_reports = [
    "EDM_04_tot_rep_LT_vs_IPT_",
    "EDM_07_STO_ND_",
    "EDM_09_not_extended_to_SPK_plant_",
    "EDM_15_STO_parts_wo_released_std_cost_",
    "Total Rep Lead Time",
    "NO Planning_ND_Count",
    "SPK Plant Count",
    "No Cost Count",
]


class ScorecardState(object):
    scorecard = {}

    def __init__(self):
        self.scorecard = {}

    def get(self):
        return self.scorecard

    def add(self, key, value):
        self.scorecard[key] = value


def convert_reports(server=False):
    warnings.simplefilter("ignore")

    report_date = input(f"{pr.prmt}Please provide report date in MM-DD-YYYY format: \n")

    output = ""
    scorecard = ScorecardState()

    data_directory = os.path.join(os.environ["EDM_DRV"], "rtd_data")
    output_directory = os.path.join(os.environ["DIR_OUT"], report_date)

    if os.path.exists(output_directory) == False:
        os.mkdir(output_directory)

    output += output_msg(f"{pr.info}Converting and formatting RTD reports:")

    def handle_input_file(
        file,
        new_file,
        pivot=["Plant", "Material", "count", "true"],
        df_sheet: str = "DATA",
        pvt_sheet: str = "summary",
    ):
        df = pd.read_csv(file, sep="\t")

        if not "_COUNT_" in file:
            pivot = df.pivot_table(
                index=[pivot[0]],
                values=[pivot[1]],
                aggfunc=[pivot[2]],
                margins=pivot[3],
            )

        with pd.ExcelWriter(os.path.join(output_directory, new_name)) as writer:
            if not "_COUNT_" in file:
                pivot.to_excel(writer, sheet_name=pvt_sheet)
            df.to_excel(writer, sheet_name=df_sheet, index=False)

        # GATHER SCORECARD DATA
        if [ele for ele in scorcard_reports if (ele in f)]:
            if scorcard_reports[0] in f:
                scorecard.add("rep_lt_isu", df.shape[0])
            if scorcard_reports[1] in f:
                scorecard.add("plant_nd_isu", df.shape[0])
            if scorcard_reports[2] in f:
                scorecard.add("spk_plant_isu", df.shape[0])
            if scorcard_reports[3] in f:
                scorecard.add("std_cost_isu", df.shape[0])

        return output_msg(f"[➡ FILE] {new_file}")

    for filename in os.listdir(data_directory):
        f = os.path.join(data_directory, filename)
        if os.path.isfile(f):
            if "EDM_02_Make_wo_LT_" in f:
                new_name = os.path.join(
                    output_directory, f"{report_date} Make wo LT.xlsx"
                )
                output += handle_input_file(f, new_name)
            if "EDM_03_sto_wo_lt_" in f:
                new_name = os.path.join(
                    output_directory, f"{report_date} STO_wo_LT.xlsx"
                )
                output += handle_input_file(f, new_name)
            if "EDM_04_tot_rep_LT_vs_IPT_" in f:
                new_name = os.path.join(
                    output_directory, f"{report_date} Tot Rep LT vs IPT.xlsx"
                )
                output += handle_input_file(f, new_name)
            if "EDM_06_dist_center_make_parts_" in f:
                new_name = os.path.join(
                    output_directory, f"{report_date} Distribution Make parts.xlsx"
                )
                output += handle_input_file(f, new_name)
            if "EDM_07_STO_ND_" in f:
                new_name = os.path.join(output_directory, f"{report_date} STO ND.xlsx")
                output += handle_input_file(
                    f,
                    new_name,
                    ["SupPlnt", "Material", "count", "true"],
                )
            if "EDM_08_dist_center_make_parts_" in f:
                new_name = os.path.join(
                    output_directory, f"{report_date} Distribution Make parts.xlsx"
                )
                output += handle_input_file(f, new_name)
            if "EDM_08_Parts_planning_strgr_consistency_check_" in f:
                new_name = os.path.join(
                    output_directory,
                    f"{report_date} Parts_Planning_Strategy_Consistency_Check.xlsx",
                )
                output += handle_input_file(
                    f, new_name, ["Werks", "Matnr", "count", "true"]
                )
            if "EDM_09_not_extended_to_SPK_plant_" in f:
                new_name = os.path.join(
                    output_directory, f"{report_date} SPK not extended to plant.xlsx"
                )
                output += handle_input_file(
                    f, new_name, ["RECV_PLANT", "Material", "count", "true"]
                )
            if "EDM_11_Strat_group_check_" "EDM_11_Strat_group_check_" in f:
                new_name = os.path.join(
                    output_directory, f"{report_date} Strategy_Grp_Check.xlsx"
                )
                output += handle_input_file(
                    f, new_name, ["Werks", "Matnr", "count", "true"]
                )
            if "EDM_12_Matl_Proc_to_Spec_Proc_" in f:
                new_name = os.path.join(
                    output_directory, f"{report_date} Matl Proc to Spec Proc.xlsx"
                )
                output += handle_input_file(f, new_name)
            if "EDM_13_min_max_lots_equal_" in f:
                new_name = os.path.join(
                    output_directory, f"{report_date} Min Max Lots equal.xlsx"
                )
                output += handle_input_file(f, new_name)
            if "EDM_13_min_max_lots_equal_" in f:
                new_name = os.path.join(
                    output_directory, f"{report_date} Min Max Lots equal.xlsx"
                )
                output += handle_input_file(f, new_name)
            if "EDM_14_Purch_no_EP_sloc_" in f:
                new_name = os.path.join(
                    output_directory, f"{report_date} Purch no EP sloc.xlsx"
                )
                output += handle_input_file(
                    f, new_name, ["Werks", "Matnr", "count", "true"]
                )
            if "EDM_15_STO_parts_wo_released_std_cost_" in f:
                new_name = os.path.join(
                    output_directory,
                    f"{report_date} STO_Parts_wo_Released_Std_Cost.xlsx",
                )
                output += handle_input_file(
                    f, new_name, ["RcvPlnt", "Material", "count", "true"]
                )
            if "EDM_17_Quota_Arranement_" in f:
                new_name = os.path.join(
                    output_directory, f"{report_date} Quota_arrangement.xlsx"
                )
                output += handle_input_file(f, new_name)
            if "EDM_24_SPK_VS_DEL_PLANT_CHECK_" in f:
                new_name = os.path.join(
                    output_directory, f"{report_date} del_plant_validation.xlsx"
                )
                output += handle_input_file(
                    f, new_name, ["PLANTID", "MATERIALID", "count", "true"]
                )

            if "EDM_27_NOT_EXT_SPK_PLANT_COUNT_" in f:
                new_name = os.path.join(
                    output_directory,
                    f"{report_date} Not Extended to SPK Plant Count.xlsx",
                )
                output += handle_input_file(f, new_name, [], "Sheet1")
            if "EDM_28_STO_FROM_PLANT_WITH_ND_COUNT_" in f:
                new_name = os.path.join(
                    output_directory,
                    f"{report_date} STO From Plant with NO Planning_ND_Count.xlsx",
                )
                output += handle_input_file(f, new_name, [], "Sheet1")
            if "EDM_29_STO_NO_COST_COUNT_" in f:
                new_name = os.path.join(
                    output_directory,
                    f"{report_date} Total Rep Lead Time vs In House Prod Time Count.xlsx",
                )
                output += handle_input_file(f, new_name, [], "Sheet1")
            if "EDM_30_TRLT_VS_IPT_COUNT_" in f:
                new_name = os.path.join(
                    output_directory, f"{report_date} STO No Cost Count.xlsx"
                )
                output += handle_input_file(f, new_name, [], "Sheet1")
    output += output_msg(f"{pr.info}RTD reports formatted and edited\n")

    # SUM VALUES FOR COUNT REPORTS V.2
    output += output_msg("{pr.info}Edit COUNT reports")
    for filename in os.listdir(output_directory):
        f = os.path.join(output_directory, filename)
        if os.path.isfile(f):
            if "Count" in f:
                df = pd.read_excel(f, sheet_name="Sheet1")
                total = df["QTY"].sum()
                if scorcard_reports[4] in f:
                    scorecard.add("rep_lt_pop", df.shape[0])
                if scorcard_reports[5] in f:
                    scorecard.add("plant_nd_pop", df.shape[0])
                if scorcard_reports[6] in f:
                    scorecard.add("spk_plant_pop", df.shape[0])
                if scorcard_reports[7] in f:
                    scorecard.add("std_cost_pop", df.shape[0])

                wb = load_workbook(filename=f)
                sht = wb.active
                sht["D2"] = total
                wb.save(filename=f)
                output += output_msg(f"{pr.file}{filename}: {total}")
    output += output_msg(f"{pr.done}Complete")

    # SCORECARD DATA
    output += output_msg(f"{pr.info}Handle SCORECARD data")
    handle_scorecard(scorecard.get())
    output += output_msg(f"{pr.done}Complete")

    if server == True:
        return output, "Convert & format RTD reports"
    else:
        await_char(
            "y",
            f"\n{pr.prmt}Finished! Please find reports in {report_date} directory. \nPress Y to close.",
        )
