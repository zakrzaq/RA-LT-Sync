import os
import pandas as pd
import math
import numpy as np

import utils.prompts as pr
from utils.helpers import await_char, use_dotenv, output_msg

use_dotenv()


def split_loadfile(server=False):
    report_date = input(f"{pr.prmt}Please provide report date in MM-DD-YYYY format: ")

    dir_inputs = os.environ["DIR_IN"]
    dir_outputs = os.environ["DIR_OUT"]
    output = ""

    for filename in os.listdir(dir_inputs):
        if "00_lt_loadfile" in filename:
            loadfile = os.path.join(dir_inputs, filename)

    df = pd.read_excel(loadfile)

    output += output_msg(f"{pr.file}Total parts to be processed: {len(df)}")

    parts = math.ceil(len(df) / 5000)

    output += output_msg(f"{pr.file}Load file will split into {parts} parts")

    splits = np.array_split(df, parts)

    x = 0
    for i in splits:
        output += output_msg(f"{pr.file}Part {x+1} has {len(i)} parts.")
        x += 1

        with pd.ExcelWriter(
            os.path.join(dir_outputs, f"00_lt_loadfile_{report_date} - p{x}.xlsx")
        ) as writer:
            i.to_excel(writer, index=False)
    output += output_msg(f"{pr.done}Complete")

    if server:
        return output, "Split LT Sync loadfile"
    else:
        await_char(
            "y",
            "Please find your processed files in OUTPUT folder. Press Y to continue.",
        )
