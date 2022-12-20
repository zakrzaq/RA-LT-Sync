import os
import platform
import scripts.rtd_reports as rtd
import scripts.lt_sync as lt
import scripts.summary as summary
import scripts.exclusion as excl
import scripts.extension as extn
import scripts.utility as util


def clear():
    if platform.system() == 'Windows':
        return os.system('cls')
    else:
        return os.system('clear')


clear()


def get_menu_choice():
    def print_menu():       # Your menu design here
        print(28 * "-", "LT Sync & Planning Plause UTILS", 28 * "-")
        print("1)    RTD: Filter and gather reports")
        print("2)    RTD: Convert and format reports")
        print("3)    RTD: Cleanup and archive reports")
        print(85 * "-")
        print("4)    LT SYNC: Process")
        print("5)    LT SYNC: Split loadfile")
        print("6)    SUMMARY: Prepare summary file")
        print(85 * "-")
        print("7)    EXCLUSION LIST: add new parts")
        print("8)    PDT EXTENSION: add new parts")
        print(85 * "-")
        print("9)    UTILITY: archive old RTD reports - careful!!!")

        print(85 * "-")
        print("U)    Update program")
        print("X)    Close program")
        print(85 * "=")

    loop = True
    int_choice = -1

    while loop:          # While loop which will keep going until loop = False
        print_menu()    # Displays menu
        choice = input("Choose procedure to run: ")
        print("\n")

        if choice == '1':
            rtd.filter_reports()
            clear()
        elif choice == '2':
            rtd.convert_reports()
            clear()
        elif choice == '3':
            rtd.archive_reports()
            clear()
        elif choice == '4':
            lt.process_ltsync()
            clear()
        elif choice == '5':
            lt.split_loadfile()
            clear()
        elif choice == '6':
            summary.prepare()
            clear()
        elif choice == '7':
            excl.add()
            clear()
        elif choice == '8':
            extn.add()
            clear()
        elif choice == '9':
            util.archive_old_in_rtd()
            clear()
        elif (choice == 'u' or choice == 'U'):
            os.system("git pull")
            clear()
        elif (choice == 'x' or choice == 'X'):
            int_choice = -1
            print("Exiting...")
            loop = False
        else:
            # Any inputs other than values 1-4 we print an error message
            input("Wrong menu selection. Enter any key to try again...")
            clear()
    # return [int_choice, choice]


print(get_menu_choice())
