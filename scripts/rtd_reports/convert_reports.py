import os
import pandas as pd
from openpyxl import load_workbook
import warnings

from utils.score_card import handle_scorecard
from utils.helpers import use_dotenv, await_char, output_msg

use_dotenv()


def convert_reports(server=False):
    warnings.simplefilter("ignore")

    report_date = input("Please provide report date in MM-DD-YYYY format: \n")

    output = ""
    scorecard = {}

    data_directory = os.path.join(os.environ["EDM_DRV"], "rtd_data")
    output_directory = os.path.join(os.environ["DIR_OUT"], report_date)

    if os.path.exists(output_directory) == False:
        os.mkdir(output_directory)

    output += output_msg("Converting and formatting RTD reports:")

    # file_list = [
    #     "EDM_02_Make_wo_LT_",
    #     "EDM_03_sto_wo_lt_",
    #     "EDM_04_tot_rep_LT_vs_IPT_",
    #     "EDM_06_dist_center_make_parts_",
    #     "EDM_07_STO_ND_",,
    #     "EDM_08_dist_center_make_parts_",
    #     "EDM_08_Parts_planning_strgr_consistency_check_",
    #     "EDM_09_not_extended_to_SPK_plant_",
    #     "EDM_11_Strat_group_check_",
    #     "EDM_12_Matl_Proc_to_Spec_Proc_",
    #     "EDM_13_min_max_lots_equal_",
    #     "EDM_14_Purch_no_EP_sloc_",
    #     "EDM_15_STO_parts_wo_released_std_cost_",
    #     "EDM_17_Quota_Arranement_",
    #     "EDM_24_SPK_VS_DEL_PLANT_CHECK_",
    #     "EDM_27_NOT_EXT_SPK_PLANT_COUNT_",
    #     "EDM_28_STO_FROM_PLANT_WITH_ND_COUNT_",
    #     "EDM_29_STO_NO_COST_COUNT_",
    #     "EDM_30_TRLT_VS_IPT_COUNT_",
    # ]

    for filename in os.listdir(data_directory):
        f = os.path.join(data_directory, filename)
        if os.path.isfile(f):
            df = pd.read_csv(f, sep="\t")
            if "EDM_02_Make_wo_LT_" in f:
                # TODO: add relevat inforamtion to scoracard DF
                new_name = os.path.join(
                    output_directory, f"{report_date} Make wo LT.xlsx"
                )
                # CREATE PIVOT
                pivot = df.pivot_table(
                    index=["Plant"],
                    values=["Material"],
                    aggfunc=["count"],
                    margins="true",
                )
                # output data farame without df index & Pivot
                with pd.ExcelWriter(os.path.join(output_directory, new_name)) as writer:
                    pivot.to_excel(writer, sheet_name="summary")
                    df.to_excel(writer, sheet_name="DATA", index=False)
                # log filename
                output += output_msg(new_name)
            if "EDM_03_sto_wo_lt_" in f:
                new_name = os.path.join(
                    output_directory, f"{report_date} STO_wo_LT.xlsx"
                )
                # CREATE PIVOT
                pivot = df.pivot_table(
                    index=["Plant"],
                    values=["Material"],
                    aggfunc=["count"],
                    margins="true",
                )
                # output data farame without df index & Pivot
                with pd.ExcelWriter(os.path.join(output_directory, new_name)) as writer:
                    pivot.to_excel(writer, sheet_name="summary")
                    df.to_excel(writer, sheet_name="DATA", index=False)
                # log filename
                output += output_msg(new_name)
            if "EDM_04_tot_rep_LT_vs_IPT_" in f:
                new_name = os.path.join(
                    output_directory, f"{report_date} Tot Rep LT vs IPT.xlsx"
                )
                scorecard["rep_lt_isu"] = df.shape[0]
                # CREATE PIVOT
                pivot = df.pivot_table(
                    index=["Plant"],
                    values=["Material"],
                    aggfunc=["count"],
                    margins="true",
                )
                # output data farame without df index & Pivot
                with pd.ExcelWriter(os.path.join(output_directory, new_name)) as writer:
                    pivot.to_excel(writer, sheet_name="summary")
                    df.to_excel(writer, sheet_name="DATA", index=False)
                # log filename
                output += output_msg(new_name)
            if "EDM_06_dist_center_make_parts_" in f:
                new_name = os.path.join(
                    output_directory, f"{report_date} Distribution Make parts.xlsx"
                )
                # CREATE PIVOT
                pivot = df.pivot_table(
                    index=["Plant"],
                    values=["Material"],
                    aggfunc=["count"],
                    margins="true",
                )
                # output data farame without df index & Pivot
                with pd.ExcelWriter(os.path.join(output_directory, new_name)) as writer:
                    pivot.to_excel(writer, sheet_name="summary")
                    df.to_excel(writer, sheet_name="DATA", index=False)
                # log filename
                output += output_msg(new_name)
            if "EDM_07_STO_ND_" in f:
                new_name = os.path.join(output_directory, f"{report_date} STO ND.xlsx")
                scorecard["plant_nd_isu"] = df.shape[0]
                # CREATE PIVOT
                pivot = df.pivot_table(
                    index=["SupPlnt"],
                    values=["Material"],
                    aggfunc=["count"],
                    margins="true",
                )
                # output data farame without df index & Pivot
                with pd.ExcelWriter(os.path.join(output_directory, new_name)) as writer:
                    pivot.to_excel(writer, sheet_name="summary")
                    df.to_excel(writer, sheet_name="DATA", index=False)
                # log filename
                output += output_msg(new_name)
            if "EDM_08_dist_center_make_parts_" in f:
                new_name = os.path.join(
                    output_directory, f"{report_date} Distribution Make parts.xlsx"
                )
                # CREATE PIVOT
                pivot = df.pivot_table(
                    index=["Plant"],
                    values=["Material"],
                    aggfunc=["count"],
                    margins="true",
                )
                # output data farame without df index & Pivot
                with pd.ExcelWriter(os.path.join(output_directory, new_name)) as writer:
                    pivot.to_excel(writer, sheet_name="summary")
                    df.to_excel(writer, sheet_name="DATA", index=False)
                # log filename
                output += output_msg(new_name)
            if "EDM_08_Parts_planning_strgr_consistency_check_" in f:
                new_name = os.path.join(
                    output_directory,
                    f"{report_date} Parts_Planning_Strategy_Consistency_Check.xlsx",
                )
                # CREATE PIVOT
                pivot = df.pivot_table(
                    index=["Werks"], values=["Matnr"], aggfunc=["count"], margins="true"
                )
                # output data farame without df index & Pivot
                with pd.ExcelWriter(os.path.join(output_directory, new_name)) as writer:
                    pivot.to_excel(writer, sheet_name="summary")
                    df.to_excel(writer, sheet_name="DATA", index=False)
                # log filename
                output += output_msg(new_name)
            if "EDM_09_not_extended_to_SPK_plant_" in f:
                scorecard["spk_plant_isu"] = df.shape[0]
                new_name = os.path.join(
                    output_directory, f"{report_date} SPK not extended to plant.xlsx"
                )
                # CREATE PIVOT
                pivot = df.pivot_table(
                    index=["RECV_PLANT"],
                    values=["Material"],
                    aggfunc=["count"],
                    margins="true",
                )
                # output data farame without df index & Pivot
                with pd.ExcelWriter(os.path.join(output_directory, new_name)) as writer:
                    pivot.to_excel(writer, sheet_name="summary")
                    df.to_excel(writer, sheet_name="DATA", index=False)
                # log filename
                output += output_msg(new_name)
            if "EDM_11_Strat_group_check_" "EDM_11_Strat_group_check_" in f:
                new_name = os.path.join(
                    output_directory, f"{report_date} Strategy_Grp_Check.xlsx"
                )
                # CREATE PIVOT
                pivot = df.pivot_table(
                    index=["Werks"], values=["Matnr"], aggfunc=["count"], margins="true"
                )
                # output data farame without df index & Pivot
                with pd.ExcelWriter(os.path.join(output_directory, new_name)) as writer:
                    pivot.to_excel(writer, sheet_name="summary")
                    df.to_excel(writer, sheet_name="DATA", index=False)
                # log filename
                output += output_msg(new_name)
            if "EDM_12_Matl_Proc_to_Spec_Proc_" in f:
                new_name = os.path.join(
                    output_directory, f"{report_date} Matl Proc to Spec Proc.xlsx"
                )
                # CREATE PIVOT
                pivot = df.pivot_table(
                    index=["Plant"],
                    values=["Material"],
                    aggfunc=["count"],
                    margins="true",
                )
                # output data farame without df index & Pivot
                with pd.ExcelWriter(os.path.join(output_directory, new_name)) as writer:
                    pivot.to_excel(writer, sheet_name="summary")
                    df.to_excel(writer, sheet_name="DATA", index=False)
                # log filename
                output += output_msg(new_name)
            if "EDM_13_min_max_lots_equal_" in f:
                new_name = os.path.join(
                    output_directory, f"{report_date} Min Max Lots equal.xlsx"
                )
                # CREATE PIVOT
                pivot = df.pivot_table(
                    index=["Plant"],
                    values=["Material"],
                    aggfunc=["count"],
                    margins="true",
                )
                # output data farame without df index & Pivot
                with pd.ExcelWriter(os.path.join(output_directory, new_name)) as writer:
                    pivot.to_excel(writer, sheet_name="summary")
                    df.to_excel(writer, sheet_name="DATA", index=False)
                # log filename
                output += output_msg(new_name)
            if "EDM_13_min_max_lots_equal_" in f:
                new_name = os.path.join(
                    output_directory, f"{report_date} Min Max Lots equal.xlsx"
                )
                # CREATE PIVOT
                pivot = df.pivot_table(
                    index=["Plant"],
                    values=["Material"],
                    aggfunc=["count"],
                    margins="true",
                )
                # output data farame without df index & Pivot
                with pd.ExcelWriter(os.path.join(output_directory, new_name)) as writer:
                    pivot.to_excel(writer, sheet_name="summary")
                    df.to_excel(writer, sheet_name="DATA", index=False)
                # log filename
                output += output_msg(new_name)
            if "EDM_14_Purch_no_EP_sloc_" in f:
                new_name = os.path.join(
                    output_directory, f"{report_date} Purch no EP sloc.xlsx"
                )
                # CREATE PIVOT
                pivot = df.pivot_table(
                    index=["Werks"], values=["Matnr"], aggfunc=["count"], margins="true"
                )
                # output data farame without df index & Pivot
                with pd.ExcelWriter(os.path.join(output_directory, new_name)) as writer:
                    pivot.to_excel(writer, sheet_name="summary")
                    df.to_excel(writer, sheet_name="DATA", index=False)
                # log filename
                output += output_msg(new_name)
            if "EDM_15_STO_parts_wo_released_std_cost_" in f:
                scorecard["std_cost_isu"] = df.shape[0]
                new_name = os.path.join(
                    output_directory,
                    f"{report_date} STO_Parts_wo_Released_Std_Cost.xlsx",
                )
                # CREATE PIVOT
                pivot = df.pivot_table(
                    index=["RcvPlnt"],
                    values=["Material"],
                    aggfunc=["count"],
                    margins="true",
                )
                # output data farame without df index & Pivot
                with pd.ExcelWriter(os.path.join(output_directory, new_name)) as writer:
                    pivot.to_excel(writer, sheet_name="summary")
                    df.to_excel(writer, sheet_name="DATA", index=False)
                # log filename
                output += output_msg(new_name)
            if "EDM_17_Quota_Arranement_" in f:
                new_name = os.path.join(
                    output_directory, f"{report_date} Quota_arrangement.xlsx"
                )
                # CREATE PIVOT
                pivot = df.pivot_table(
                    index=["Plant"],
                    values=["Material"],
                    aggfunc=["count"],
                    margins="true",
                )
                # output data farame without df index & Pivot
                with pd.ExcelWriter(os.path.join(output_directory, new_name)) as writer:
                    pivot.to_excel(writer, sheet_name="summary")
                    df.to_excel(writer, sheet_name="DATA", index=False)
                # log filename
                output += output_msg(new_name)
            if "EDM_24_SPK_VS_DEL_PLANT_CHECK_" in f:
                new_name = os.path.join(
                    output_directory, f"{report_date} del_plant_validation.xlsx"
                )
                # CREATE PIVOT
                pivot = df.pivot_table(
                    index=["PLANTID"],
                    values=["MATERIALID"],
                    aggfunc=["count"],
                    margins="true",
                )
                # output data farame without df index & Pivot
                with pd.ExcelWriter(os.path.join(output_directory, new_name)) as writer:
                    pivot.to_excel(writer, sheet_name="summary")
                    df.to_excel(writer, sheet_name="DATA", index=False)
                # log filename
                output += output_msg(new_name)

            if "EDM_27_NOT_EXT_SPK_PLANT_COUNT_" in f:
                new_name = os.path.join(
                    output_directory,
                    f"{report_date} Not Extended to SPK Plant Count.xlsx",
                )
                # output data farame without df index & Pivot
                with pd.ExcelWriter(os.path.join(output_directory, new_name)) as writer:
                    df.to_excel(writer, sheet_name="Sheet1", index=False)
                # log filename
                output += output_msg(new_name)
            if "EDM_28_STO_FROM_PLANT_WITH_ND_COUNT_" in f:
                new_name = os.path.join(
                    output_directory,
                    f"{report_date} STO From Plant with NO Planning_ND_Count.xlsx",
                )
                # output data farame without df index & Pivot
                with pd.ExcelWriter(os.path.join(output_directory, new_name)) as writer:
                    df.to_excel(writer, sheet_name="Sheet1", index=False)
                # log filename
                output += output_msg(new_name)
            if "EDM_29_STO_NO_COST_COUNT_" in f:
                new_name = os.path.join(
                    output_directory,
                    f"{report_date} Total Rep Lead Time vs In House Prod Time Count.xlsx",
                )
                # output data farame without df index & Pivot
                with pd.ExcelWriter(os.path.join(output_directory, new_name)) as writer:
                    df.to_excel(writer, sheet_name="Sheet1", index=False)
                # log filename
                output += output_msg(new_name)
            if "EDM_30_TRLT_VS_IPT_COUNT_" in f:
                new_name = os.path.join(
                    output_directory, f"{report_date} STO No Cost Count.xlsx"
                )
                # output data farame without df index & Pivot
                with pd.ExcelWriter(os.path.join(output_directory, new_name)) as writer:
                    df.to_excel(writer, sheet_name="Sheet1", index=False)
                # log filename
                output += output_msg(new_name)
    output += output_msg("RTD reports formatted and edited\n")

    # TODO: save Scorecard DF

    # SUM VALUES FOR COUNT REPORTS V.1
    # for filename in os.listdir(os.path.join(report_directory, report_date)):
    #   # define filename
    #   f = os.path.join(report_directory, report_date , filename)
    #   # chekc if file exists
    #   if os.path.isfile(f):
    #     if 'Count' in f:
    #       wb = load_workbook(filename=f)
    #       sht = wb.active
    #       sht['D2'] = '=sum(B2:B200)'
    #       wb.save(filename=f)
    #       print(f'{f} - file edited')

    # SUM VALUES FOR COUNT REPORTS V.2
    output += output_msg("Edit COUNT reports")
    for filename in os.listdir(output_directory):
        # define filename
        f = os.path.join(output_directory, filename)
        # chekc if file exists
        if os.path.isfile(f):
            if "Count" in f:
                df = pd.read_excel(f, sheet_name="Sheet1")
                total = df["QTY"].sum()
                output += output_msg(f"{filename}: {total}")
                if "Total Rep Lead Time" in filename:
                    scorecard["rep_lt_pop"] = total
                if "NO Planning_ND_Count" in filename:
                    scorecard["plant_nd_pop"] = total
                if "SPK Plant Count" in filename:
                    scorecard["spk_plant_pop"] = total
                if "No Cost Count" in filename:
                    scorecard["std_cost_pop"] = total

                wb = load_workbook(filename=f)
                sht = wb.active
                sht["D2"] = total
                wb.save(filename=f)
                output += output_msg(f"{f} - count file sum edited")
        output += output_msg("Complete")

    # SCORECARD DATA
    output += output_msg("Handle SCORECARD data")
    handle_scorecard(scorecard)
    output += output_msg("Complete")

    if server:
        return output, "Convert & format RTD reports"
    else:
        await_char(
            "y",
            f"\nFinished! Please find reports in {report_date} directory. \nPress Y to close.",
        )
