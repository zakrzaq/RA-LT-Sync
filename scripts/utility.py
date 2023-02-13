import os
import time
import shutil
import fnmatch
from progressbar import progressbar


import utils.prompts as pr
from utils.helpers import await_char, use_dotenv, output_msg

use_dotenv()


def archive_old_in_rtd(server=False):
    now = time.time()
    old = now - 61 * 24 * 60 * 60
    report_dir = os.environ["EDM_DRV"]
    archive_dir = os.path.join(report_dir, "RTD_ARCHIVE")

    output = f"{pr.info}Archiving rtd reports older than 60 days..."
    total = len(fnmatch.filter(os.listdir(report_dir), "*.*"))
    i = 0
    count = 0
    for f in os.listdir(report_dir):
        for i in progressbar(range(total)):
            i += 1
            path = os.path.join(report_dir, f)
            if os.path.isfile(path):
                stat = os.stat(path)
                if stat.st_ctime < old:
                    count += 1
                    # print(f"{pr.cncl}{count}/{total} - {f}")
                    shutil.move(path, archive_dir)
                # else:
                # print(f"{pr.ok}{count}/{total} - {f}")

    if server == True:
        output += output_msg(f"{pr.done}Archived {count} files. Press Y to continue.")
        return output, "Archive old rtd reports"
    else:
        await_char("y", f"{pr.done}Archived {count} files. Press Y to continue.")
