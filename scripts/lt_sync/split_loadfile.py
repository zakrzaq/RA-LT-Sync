import os
import pandas as pd
import math
import numpy as np


import utils.helpers as helpers


def split_loadfile():
    report_date = input("Please provide report date in MM-DD-YYYY format: ")

    dir_inputs = os.path.join(os.getcwd(), "INPUTS")
    dir_outputs = os.path.join(os.getcwd(), "OUTPUTS")

    for filename in os.listdir(dir_inputs):
        if "00_lt_loadfile" in filename:
            loadfile = os.path.join(dir_inputs, filename)

    df = pd.read_excel(loadfile)

    print(f"Total parts to be processed: {len(df)}")

    parts = math.ceil(len(df) / 5000)

    print(f"Load file will split into {parts} parts")

    spilts = np.array_split(df, parts)

    x = 0
    for i in spilts:
        print(f"\tPart {i} has {len(i)} parts.")
        x = x + 1

        with pd.ExcelWriter(
            os.path.join(dir_outputs, f"00_lt_loadfile_{report_date} - p{x}.xlsx")
        ) as writer:
            i.to_excel(writer, index=False)

    helpers.await_char(
        "y", "Please find your processed files in OUTPUT folder. Press Y to continue."
    )
