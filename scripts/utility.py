import os
import time
import shutil
import fnmatch

from utils.helpers import await_char


def archive_old_in_rtd():
    now = time.time()
    old = now - 61 * 24 * 60 * 60
    report_dir = r"Z:\rtd_reports"
    archive_dir = os.path.join(report_dir, "RTD_ARCHIVE")

    total = len(fnmatch.filter(os.listdir(report_dir), "*.*"))
    count = 0

    for f in os.listdir(report_dir):
        path = os.path.join(report_dir, f)
        if os.path.isfile(path):
            count += 1
            stat = os.stat(path)
            if stat.st_ctime < old:
                print(f"[{count}/{total}]: ARCHIVE {f}")
                shutil.move(path, archive_dir)
            else:
                print(f"[{count}/{total}]: CURRENT {f}")

    await_char("y", "Completed. Press Y to continue.")
