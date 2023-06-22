import os
import fnmatch
import shutil
from tqdm import tqdm

import utils.prompts as pr
from utils.helpers import (
    use_dotenv,
    await_char,
    output_msg,
    move_file,
    check_dir,
    end_script,
)
import utils.prompts as pr
from state.output import output

use_dotenv()


def filter_reports(server=False):
    output.reset
    reports_found = 0

    output.add(f"{pr.info}Filtering current reports")
    report_directory = os.environ["EDM_DRV"]

    sub_dir = "rtd_data"
    output_directory = os.path.join(report_directory, sub_dir)

    check_dir(output_directory)

    for filename in tqdm(os.listdir(report_directory)):
        f = os.path.join(report_directory, filename)
        include_files = [
            "EDM_02_",
            "EDM_03_",
            "EDM_04_",
            "EDM_06_",
            "EDM_07_",
            "EDM_08_",
            "EDM_09_",
            "EDM_11_",
            "EDM_12_",
            "EDM_13_",
            "EDM_14_",
            "EDM_15_",
            "EDM_17_",
            "EDM_24_",
            "EDM_27_",
            "EDM_28_",
            "EDM_29_",
            "EDM_30_",
        ]

        if os.path.isfile(f):
            if [ele for ele in include_files if (ele in f)]:
                shutil.move(f, output_directory)
                output.add(f"{pr.file}{f}")
                reports_found += 1

    output.add(f"Reports moved to DATA directory:  {reports_found}.")
    end_script(title="Filter RTD reports")
