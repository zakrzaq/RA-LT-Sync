import os
import fnmatch
from progressbar import progressbar

import utils.prompts as pr
from utils.helpers import use_dotenv, await_char, output_msg, move_file

use_dotenv()


def filter_reports(server=False):
    output = ""

    output += output_msg(f"{pr.info}Filtering current reports")
    report_directory = os.environ["EDM_DRV"]

    sub_dir = "rtd_data"
    output_directory = os.path.join(os.environ["DIR_IN"], sub_dir)

    if os.path.exists(os.path.join(report_directory, sub_dir)) == False:
        os.mkdir(os.path.join(report_directory, sub_dir))

    total = len(fnmatch.filter(os.listdir(report_directory), "*.*"))
    i = 0
    for filename in os.listdir(report_directory):
        for i in progressbar(range(total)):
            i += 1
            # define filename
            f = os.path.join(report_directory, filename)
            # print(f)
            # check if file exists
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
                    output += move_file(f, output_directory)

    if server:
        output += output_msg(
            f"Reports moved to DATA directory:  {total}. \nPress Y key to finish."
        )
        return output, "Filter RTD reports"
    else:
        await_char(
            "y," f"Reports moved to DATA directory:  {tatal}. \nPress Y key to finish."
        )
