import keyboard
import win32api
import os
import shutil
import dotenv
import platform
import warnings
import utils.prompts as pr
from state.output import output
from typing import Tuple


def use_dotenv():
    dotenv_file = dotenv.find_dotenv()
    dotenv.load_dotenv(dotenv_file)


def ignore_warnings():
    warnings.filterwarnings("ignore")


def await_char(char="y", msg="", func="", param=""):
    if msg == "":
        msg_out = f"{pr.info}Press {char.upper()} to continue"
    else:
        msg_out = msg
    print(msg_out)
    while True:
        if keyboard.is_pressed("c"):
            break
        if keyboard.is_pressed("C"):
            break
        if keyboard.is_pressed(char):
            if func != "":
                if param != "":
                    func(param)
                else:
                    func()
            break


def list_win_drives():
    drives = win32api.GetLogicalDriveStrings()
    drives = drives.split("\000")[:-1]
    return drives[1:]


def find_directory(dir: str):
    drive_list = list_win_drives()
    for drv in drive_list:
        for root, dirs, files in os.walk(drv):
            for name in dirs:
                if dir in name:
                    return os.path.join(root, name)


def move_file(file, dir):
    shutil.move(file, dir)
    return f"{pr.file}{file}"


def output_msg(msg: str, *args: Tuple[str]):
    print(msg)
    classes = "code-line "
    for a in args:
        classes += a + " "
    return f'<p class="{classes}">{msg}</p>\n'


def check_dir(dir):
    if not os.path.exists(dir):
        os.mkdir(dir)


def end_script(server=False, title=""):
    if server:
        return output.get_markup(), title
    else:
        await_char("y", "Script completed.")
        return "No Title", "No Output"


def clear():
    if platform.system() == "Windows":
        return os.system("cls")
    else:
        return os.system("clear")
