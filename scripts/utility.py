import os
import time
import shutil
import fnmatch
from tqdm import tqdm


import utils.prompts as pr
from utils.helpers import await_char, use_dotenv, output_msg

use_dotenv()


def archive_old_in_rtd(server=False):
    now = time.time()
    keep_age = 31
    old = now - keep_age * 24 * 60 * 60
    report_dir = os.environ["EDM_DRV"]
    archive_dir = os.path.join(report_dir, "RTD_ARCHIVE")

    output = f"{pr.info}Archiving rtd reports older than {keep_age} days..."

    count = 0
    for f in tqdm(os.listdir(report_dir)):
        path = os.path.join(report_dir, f)
        if os.path.isfile(path):
            stat = os.stat(path)
            if stat.st_ctime < old:
                count += 1
                # print(f"{pr.cncl}{count} - {f}")
                shutil.move(path, archive_dir)
            # else:
            # print(f"{pr.ok}{count}/{total} - {f}")

    if server == True:
        output += output_msg(f"{pr.done}Archived {count} files. Press Y to continue.")
        return output, "Archive old rtd reports"
    else:
        await_char("y", f"{pr.done}Archived {count} files. Press Y to continue.")
