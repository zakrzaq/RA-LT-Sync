import os

from utils.helpers import move_file, use_dotenv, await_char

use_dotenv()


def filter_reports():
    report_directory = os.environ["EDM_DRV"]

    sub_dir = "rtd_data"
    output_directory = os.path.join(os.environ["DIR_IN"], sub_dir)

    if os.path.exists(os.path.join(report_directory, sub_dir)) == False:
        os.mkdir(os.path.join(report_directory, sub_dir))

    for filename in os.listdir(report_directory):
        # define filename
        f = os.path.join(report_directory, filename)
        # print(f)
        # check if file exists
        # include_files = ['EDM_02_', 'EDM_03_', 'EDM_04_', 'EDM_06_', 'EDM_07_', 'EDM_08_', 'EDM_09_', 'EDM_11_',
        #                  'EDM_12_', 'EDM_13_', 'EDM_14_', 'EDM_15_', 'EDM_17_', 'EDM_24_', 'EDM_27_', 'EDM_28_', 'EDM_29_', 'EDM_30_']
        if os.path.isfile(f):
            if "EDM_02_" in f:
                move_file(f, output_directory)
            if "EDM_03_" in f:
                move_file(f, output_directory)
            if "EDM_04_" in f:
                move_file(f, output_directory)
            if "EDM_06_" in f:
                move_file(f, output_directory)
            if "EDM_07_" in f:
                move_file(f, output_directory)
            if "EDM_08_" in f:
                move_file(f, output_directory)
            if "EDM_09_" in f:
                move_file(f, output_directory)
            if "EDM_11_" in f:
                move_file(f, output_directory)
            if "EDM_12_" in f:
                move_file(f, output_directory)
            if "EDM_13_" in f:
                move_file(f, output_directory)
            if "EDM_14_" in f:
                move_file(f, output_directory)
            if "EDM_15_" in f:
                move_file(f, output_directory)
            if "EDM_17_" in f:
                move_file(f, output_directory)
            if "EDM_24_" in f:
                move_file(f, output_directory)
            if "EDM_27_" in f:
                move_file(f, output_directory)
            if "EDM_28_" in f:
                move_file(f, output_directory)
            if "EDM_29_" in f:
                move_file(f, output_directory)
            if "EDM_30_" in f:
                move_file(f, output_directory)

    num_files = len(
        [
            f
            for f in os.listdir(output_directory)
            if os.path.isfile(os.path.join(output_directory, f))
        ]
    )

    await_char(
        "y,"
        "Reports moved to DATA directory:  %s. \nPress Y key to finish. " % (num_files)
    )
