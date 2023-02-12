import pandas as pd
import os

import utils.date_time as dt
from utils.helpers import use_dotenv, await_char, output_msg

use_dotenv()
output = ""


def add(server=False):
    dir_inputs = os.environ["DIR_IN"]
    dir_outputs = os.environ["DIR_OUT"]

    output += output_msg("Loading data...")

    for filename in os.listdir(dir_inputs):
        if "LT sync exclusion list" in filename:
            current_file = os.path.join(dir_inputs, filename)
        if "new_exclusions" in filename:
            addition_file = os.path.join(dir_inputs, filename)

    # current list & new request
    output += output_msg("Processing data")

    old = pd.read_excel(current_file, sheet_name="LT Exclusion list")
    new = pd.read_excel(addition_file)

    # outer join
    outer = pd.merge(old, new, on="Material", how="outer")

    # indetify new additions
    additions = outer[(outer["Requestor_x"].isnull()) & outer["Requestor_y"].notnull()]
    additions_clean = additions.drop(columns=["Requestor_x", "Date Added_x"])
    additions_clean.rename(
        columns={"Requestor_y": "Requestor", "Date Added_y": "Date Added"}, inplace=True
    )

    # full list of duplicates
    duplicates = outer[
        (outer["Requestor_x"].notnull()) & (outer["Requestor_y"].notnull())
    ]

    # duplicates changing owner
    new_owner = duplicates[duplicates["Requestor_x"] != duplicates["Requestor_y"]]
    new_owner_clean = new_owner.drop(columns=["Requestor_x", "Date Added_x"])
    new_owner_clean.rename(
        columns={"Requestor_y": "Requestor", "Date Added_y": "Date Added"}, inplace=True
    )

    # requests with same owner - disrearded
    same_owner = duplicates[duplicates["Requestor_x"] == duplicates["Requestor_y"]]

    # old list minus - duplicates
    keeps = outer[
        (outer["Requestor_y"].isnull()) | (outer["Requestor_x"] == outer["Requestor_y"])
    ]
    keeps_clean = keeps.drop(columns=["Requestor_y", "Date Added_y"])
    keeps_clean.rename(
        columns={"Requestor_x": "Requestor", "Date Added_x": "Date Added"}, inplace=True
    )

    # new list = (old list - duplicates) + parts with new owner + new additions
    new_list = pd.concat([keeps_clean, new_owner_clean, additions_clean])
    new_list["Date Added"] = new_list["Date Added"].apply(pd.to_datetime, utc=True)
    new_list["Date Added"] = pd.to_datetime(new_list["Date Added"]).dt.date
    # new_list['Date Added'] = pd.to_datetime(new_list['Date Added'].astype(str), format='%d/%m/%Y')

    # DUPLICATED REMOVED
    duplic_list = duplicates[duplicates["Requestor_x"] != duplicates["Requestor_y"]]
    duplic_list["Requestor_y"] = "moved to " + duplic_list["Requestor_y"] + " list"
    duplic_list_clean = duplic_list.iloc[:, [4, 0, 1, 2, 3]]
    duplic_list_clean.rename(
        columns={
            "Date Added_y": "Date Removed",
            "Requestor_x": "Requestor",
            "Date Added_x": "Date Added",
            "Requestor_y": "Comments",
        },
        inplace=True,
    )
    duplic_list_clean["Date Removed"] = pd.to_datetime(
        duplic_list_clean["Date Removed"]
    ).dt.date
    duplic_list_clean["Date Added"] = pd.to_datetime(
        duplic_list_clean["Date Added"]
    ).dt.date
    # duplic_list_clean['Date Added'] = pd.to_datetime(duplic_list_clean['Date Added'].astype(str), format='%d/%m/%Y')

    # SAVE RESULTS to OUTPUT.XLSX
    output += output_msg("Saving results...")

    today = dt.today_us()
    output_name = os.path.join(
        dir_outputs, ("NEW_LT sync exclusion list" + today + ".xlsx")
    )

    writer = pd.ExcelWriter(output_name, engine="xlsxwriter")
    new_list.to_excel(writer, sheet_name="Exclusion List", index=False)
    duplic_list_clean.to_excel(writer, sheet_name="Duplicates removed", index=False)
    writer.save()
    output += output_msg("Complete")

    # .to_excel('pdt_ext_new.xlsx', index=False)
    # print(new.head())

    # KEEPS CORRECT RECIPE
    # outer[(outer['Requestor_y'].isnull()) | (outer['Requestor_x'] == outer['Requestor_y'])]

    if server:
        return output
    else:
        await_char("y", "Completed. Press Y to continue.")
