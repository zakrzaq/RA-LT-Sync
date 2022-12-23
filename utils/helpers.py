import keyboard
import win32api
import os
import shutil


def await_char(char="y", msg="", func="", param=""):
    if msg == "":
        msg_out = 'Press {} to continue'.format(char.upper())
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
    drives = drives.split('\000')[:-1]
    return drives[1:]


def find_rtd_directory():
    drive_list = list_win_drives()
    for drv in drive_list:
        for root, dirs, files in os.walk(drv):
            for name in dirs:
                if 'rtd_reports' in name:
                    return os.path.join(root, name)


def move_file(file, dir):
    print("\t" + file)
    shutil.move(file, dir)
