import os
import pandas as pd

import utils.date_time as dt
from utils.helpers import use_dotenv, await_char, output_msg

use_dotenv()


def add(server=False):
    dir_inputs = os.environ["DIR_IN"]
    dir_outputs = os.environ["DIR_OUT"]

    output += output_msg("Loading data")

    for filename in os.listdir(dir_inputs):
        if "LT Sync PDT Extension List" in filename:
            current_file = os.path.join(dir_inputs, filename)
        if "new_extensions" in filename:
            addition_file = os.path.join(dir_inputs, filename)

    output += output_msg("Processing...")

    pdt_list = pd.read_excel(current_file, sheet_name="Sheet1")
    new = pd.read_excel(addition_file)

    right_join = pd.merge(pdt_list, new, on="Material", how="right")
    not_in = right_join[right_join["Requestor"].isnull()]
    not_in.drop(["Requestor", "Date Added"], axis=1, inplace=True)
    print(not_in.head())

    output += output_msg("Saving results...")

    today = dt.today_us()
    output_name = os.path.join(
        dir_outputs, ("ADDITIONS_LT Sync PDT Extension List" + today + ".xlsx")
    )

    output += output_msg("Complete")

    not_in.to_excel(output_name, index=False)
    # print(new.head())

    if server:
        return output, "Extension list additions"
    else:
        await_char("y", "Completed. Press Y to continue.")
