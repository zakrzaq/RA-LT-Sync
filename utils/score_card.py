def handle_scorecard(scorecard):
    import openpyxl
    from datetime import date

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
    print(
        f"Scorecard issues {scorecard_total_isu}\nScorecard populations: {scorecard_total_pop}\nScorecard percent: {scorecard_percent}"
    )

    f_scorecard = r"C:\Users\JZakrzewski\Rockwell Automation, Inc\EDM_Brazil - SCORECARD\SCORECARD - Metrics Goal Attainment Tracking.xlsx"
    f_scorecard_out = r"C:\RA-Apps\LT-Sync\OUTPUTS\scorecard_out.xlsx"
    wb_scorecard = openpyxl.load_workbook(f_scorecard)
    ws_ops_plan = wb_scorecard["Operations and Planning"]

    new_row = len(list(ws_ops_plan.rows)) + 1

    today = date.today().strftime("%d/%m/%y")
    date_my = date.today().strftime("%b-%y")
    fy = "FY" + date_my[-2:]

    ws_ops_plan[f"A{new_row}"] = date_my
    ws_ops_plan[f"B{new_row}"] = fy
    ws_ops_plan[f"P{new_row}"] = today

    ws_ops_plan[f"D{new_row}"] = scorecard["rep_lt_isu"]
    ws_ops_plan[f"E{new_row}"] = scorecard["rep_lt_pop"]
    ws_ops_plan[f"G{new_row}"] = scorecard["plant_nd_isu"]
    ws_ops_plan[f"H{new_row}"] = scorecard["plant_nd_pop"]
    ws_ops_plan[f"J{new_row}"] = scorecard["spk_plant_isu"]
    ws_ops_plan[f"K{new_row}"] = scorecard["spk_plant_pop"]
    ws_ops_plan[f"M{new_row}"] = scorecard["std_cost_isu"]
    ws_ops_plan[f"N{new_row}"] = scorecard["std_cost_pop"]

    # print(ws_ops_plan.tables)
    # last_row = ""
    tbl_ops_plan = ws_ops_plan.tables["Operations_and_Planning"]
    # for cell in ws_ops_plan["A"]:
    #     if cell.value != None:
    #         # print(cell.address)
    #         last_row = cell.row
    print(tbl_ops_plan.ref)
    tbl_ops_plan.ref = f"A1:P{new_row}"
    print(tbl_ops_plan.ref)

    wb_scorecard.save(f_scorecard_out)
