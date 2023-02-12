import os
import re
import shutil

from utils.helpers import use_dotenv, await_char

use_dotenv()


def archive_reports():
    report_directory = os.environ["EDM_DRV"]

    data_directory = os.path.join(report_directory, "rtd_data")
    archive_directory = os.path.join(report_directory, "ARCHIVE-PLANNING_PLAUSE")

    # print(data_directory)
    # print(archive_directory)

    # archive data folder with rtd reports
    for filename in os.listdir(data_directory):
        f = os.path.join(data_directory, filename)
        if os.path.isfile(f):
            shutil.move(f, archive_directory)

    # remove tmp dirs: data, input
    if os.path.isdir(report_directory):
        shutil.rmtree(data_directory)

    # find and remove output dire
    for filename in os.listdir(report_directory):
        match = re.search(r"^\d{2}\-\d{2}\-\d{4}", filename)
        if match:
            if os.path.isdir(os.path.join(report_directory, filename)):
                shutil.rmtree(os.path.join(report_directory, filename))

    await_char("y", "Completed. Press Y to continue.")
