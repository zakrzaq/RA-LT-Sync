import os

from scripts.rtd_reports.archive_reports import archive_reports
from scripts.rtd_reports.convert_reports import convert_reports
from scripts.rtd_reports.filter_reports import filter_reports
from scripts.lt_sync.split_loadfile import split_loadfile
from scripts.lt_sync.process_ltsync import process_ltsync
from scripts.rtd_reports.aio import run_plasue_aio
import scripts.summary as summary
import scripts.exclusion as excl
import scripts.extension as extn
import scripts.utility as util

from utils.helpers import clear

clear()


def get_menu_choice():
    def print_menu():  # Your menu design here
        print(23 * "-", "LT Sync & Planning Plause UTILS", 22 * "-")
        print("1)    RTD: Filter and gather reports")
        print("2)    RTD: Convert and format reports")
        print("3)    RTD: Cleanup and archive reports")
        print("4)    RTD: AIO reports")
        print(78 * "-")
        print("5)    LT SYNC: Process")
        print("6)    LT SYNC: Split loadfile")
        print("7)    LT SYNC: AIO LT Sync")
        print(78 * "-")
        print("8)    SUMMARY: Prepare summary file")
        print(78 * "-")
        print("9)    EXCLUSION LIST: add new parts")
        print("10)   PDT EXTENSION: add new parts")
        print(78 * "-")
        print("11)   UTILITY: archive old RTD reports")

        print(78 * "-")
        print("U)    Update program")
        print("X)    Close program")
        print(78 * "=")

    loop = True
    int_choice = -1

    while loop:  # While loop which will keep going until loop = False
        print_menu()  # Displays menu
        choice = input("Choose procedure to run: ")
        print("\n")

        if choice == "1":
            filter_reports()
            clear()
        elif choice == "2":
            convert_reports()
            clear()
        elif choice == "3":
            archive_reports()
            clear()
        elif choice == "4":
            run_plasue_aio()
            clear()
        elif choice == "5":
            process_ltsync()
            clear()
        elif choice == "6":
            split_loadfile()
            clear()
        elif choice == "8":
            summary.prepare()
            clear()
        elif choice == "9":
            excl.add()
            clear()
        elif choice == "10":
            extn.add()
            clear()
        elif choice == "11":
            util.archive_old_in_rtd()
            clear()
        elif choice == "u" or choice == "U":
            os.system("git pull && pip install -r requirements.txt")
            clear()
        elif choice == "x" or choice == "X":
            print("Exiting...")
            loop = False
        else:
            # Any inputs other than values 1-4 we print an error message
            input("Wrong menu selection. Enter any key to try again...")
            clear()
    # return [int_choice, choice]


print(get_menu_choice())
