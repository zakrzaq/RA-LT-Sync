import os

os.system("python -m pip install --upgrade pip")
os.system("pip install virtualenv")
os.system("pip install python_dotenv")
os.system("pip install keyboard")
os.system("pip install pywin32")

import dotenv

from utils.helpers import find_directory

# FIND AND LOAD DOT ENV
dotenv_file = dotenv.find_dotenv()
dotenv.load_dotenv(dotenv_file)

# LOCAL SYSTEM
os.system("python -m venv env")
os.system("env/Scripts/activate.bat")
os.system("env/Scripts/Activate.ps1")
os.system("pip install -r requirements.txt")
os.system("echo call env/Scripts/activate.bat >> lt_sync.bat")
os.system("echo call env/Scripts/Activate.ps1 >> lt_sync.bat")
os.system("echo python app.py >> lt_sync.bat")

# FIND DESKTOP FOLDER

userdir = rf"C:\Users\{os.getlogin()}"
ra_app = r"C:\RA-Apps"
scorecard = rf"{find_directory('EDM_Brazil - SCORECARD')}\SCORECARD - Metrics Goal Attainment Tracking.xlsx"


# # print(homedir)
# for root, dirs, files in os.walk(homedir):
#     for folder in dirs:
#       # path = os.path.join(homedir, dirs, folder)
#         if (folder == "Desktop"):
#             path = os.path.join(root, folder)
#             if 'OneDrive - Rockwell Automation, Inc' in path:
#                 # print(path)
#                 os.environ["HOME_DIR"] = path
#                 dotenv.set_key(dotenv_file, "HOME_DIR", os.environ["HOME_DIR"])

os.environ["EDM_DRV"] = find_directory("rtd_reports")
dotenv.set_key(dotenv_file, "EDM_DRV", os.environ["EDM_DRV"])

os.environ["APP_DIR"] = os.path.join(ra_app, "LT-Sync")
dotenv.set_key(dotenv_file, "APP_DIR", os.environ["APP_DIR"])

os.environ["DIR_IN"] = os.path.join(ra_app, "LT-Sync", "INPUTS")
dotenv.set_key(dotenv_file, "DIR_IN", os.environ["DIR_IN"])

os.environ["DIR_OUT"] = os.path.join(ra_app, "LT-Sync", "OUTPUTS")
dotenv.set_key(dotenv_file, "DIR_OUT", os.environ["DIR_OUT"])

os.environ["SCORECARD"] = scorecard
dotenv.set_key(dotenv_file, "SCORECARD", os.environ["SCORECARD"])


# download_dir = os.path.join(homedir, downloads_folder)
# os.environ["DWN_DIR"] = download_dir
# dotenv.set_key(dotenv_file, "DWN_DIR", os.environ["DWN_DIR"])

# tmp_out_dir = os.path.join(devdir, tmp_output_folder)
# os.environ["TMP_OUT_DIR"] = tmp_out_dir
# dotenv.set_key(dotenv_file, "TMP_OUT_DIR",
#                os.environ["TMP_OUT_DIR"])

# for root, dirs, files in os.walk(homedir):
#     for folder in dirs:
#       # path = os.path.join(homedir, dirs, folder)
#         if (folder == "EDM - AP MM Service Request Process"):
#             sp_path = os.path.join(root, folder)
#             print(sp_path)
#             os.environ["AP_SHAREPOINT"] = sp_path
#             dotenv.set_key(dotenv_file, "AP_SHAREPOINT",
#                            os.environ["AP_SHAREPOINT"])

#             log_name = 'AP MM Service Request Log.xlsm'
#             lg_path = os.path.join(sp_path, log_name)
#             os.environ["AP_LOG"] = lg_path
#             dotenv.set_key(dotenv_file, "AP_LOG",
#                            os.environ["AP_LOG"])


# # print(os.environ["HOME_DIR"])  # outputs "value"
# # os.environ["key"] = "newvalue" # create kay, assign value
# # print(os.environ['key'])  # outputs new key

# # Write changes to .env file.
# # dotenv.set_key(dotenv_file, "key", os.environ["key"])
