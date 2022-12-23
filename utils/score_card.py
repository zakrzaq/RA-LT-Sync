import openpyxl
from openpyxl import Workbook, load_workbook
from openpyxl.worksheet.table import Table, TableStyleInfo
from scipy.stats import norm
from utils.helpers import await_char


def handle_scorecard(scorecard):
    print(f"SCORCARD DATA: {scorecard}")
    scorecard_total_pop = (
        scorecard["rep_lt_pop"]
        + scorecard["plant_nd_pop"]
        + scorecard["spk_plant_pop"]
        + scorecard["std_cost_pop"]
    )
    scorecard_total_isu = (
        scorecard["rep_lt_isu"]
        + scorecard["plant_nd_isu"]
        + scorecard["spk_plant_isu"]
        + scorecard["std_cost_isu"]
    )
    scorecard_percent = (scorecard_total_isu / scorecard_total_pop) * 100
    scorecard_percent = round(scorecard_percent, 2)
    scorecard_sigma = norm.cdf(1 - scorecard_percent) + 1.5
    print(
        f"Scorecard issues {scorecard_total_isu}\nScorecard populations: {scorecard_total_pop}\nScorecard percent: {scorecard_percent}\nScorecard Sigma: {scorecard_sigma}"
    )

    # score_wb = Workbook()
    # ws = score_wb.active
    # ws.title = "Operations & Planning"
    # ws["A1"] = "Total Rep LT < IPT Issues"
    # ws["B1"] = "Total Rep LT < IPT Population"
    # ws["C1"] = "STO's where Send plant ND Issues"
    # ws["D1"] = "STO's where Send plant ND Population"
    # ws["E1"] = "Not extended to SPK plant Issues"
    # ws["F1"] = "Not extended to SPK plant Population"
    # ws["G1"] = "STO Parts wo Released Std Cost Issues"
    # ws["H1"] = "STO Parts wo Released Std Cost Population"

    # ws["A2"] = scorecard["rep_lt_isu"]
    # ws["B2"] = scorecard["rep_lt_pop"]
    # ws["C2"] = scorecard["rep_lt_isu"]
    # ws["D2"] = scorecard["plant_nd_pop"]
    # ws["E2"] = scorecard["plant_nd_isu"]
    # ws["F2"] = scorecard["spk_plant_pop"]
    # ws["G2"] = scorecard["spk_plant_isu"]
    # ws["H2"] = scorecard["std_cost_pop"]

    # score_wb.save(filename="scorecard.xlsx")

    f_scorecard = r'C:\Users\JZakrzewski\Rockwell Automation, Inc\EDM_Brazil - SCORECARD\SCORECARD - Metrics Goal Attainment Tracking.xlsx'
    wb_scorecard = openpyxl.load_workbook(f_scorecard)
    ws_ops_plan = wb_scorecard['Operations and Planning']

    new_row = len(list(ws_ops_plan.rows)) + 1

    ws_ops_plan[f"D{new_row}"] = scorecard["rep_lt_isu"]
    ws_ops_plan[f"E{new_row}"] = scorecard["rep_lt_pop"]
    ws_ops_plan[f"G{new_row}"] = scorecard["rep_lt_isu"]
    ws_ops_plan[f"H{new_row}"] = scorecard["plant_nd_pop"]
    ws_ops_plan[f"J{new_row}"] = scorecard["plant_nd_isu"]
    ws_ops_plan[f"K{new_row}"] = scorecard["spk_plant_pop"]
    ws_ops_plan[f"M{new_row}"] = scorecard["spk_plant_isu"]
    ws_ops_plan[f"N{new_row}"] = scorecard["std_cost_pop"]

    wb_scorecard.save(f_scorecard)

    await_char()
