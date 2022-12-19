import os
import time
import shutil

import utils.helpers as helpers

now = time.time()
old = now - 61 * 24 * 60 * 60
report_dir = r'Z:\rtd_reports'
archive_dir = os.path.join(report_dir, 'RTD_ARCHIVE')


def archive_old_in_rtd():
    for f in os.listdir(report_dir):
        path = os.path.join(report_dir, f)
        if os.path.isfile(path):
            stat = os.stat(path)
            if stat.st_ctime < old:
                print("archiving: " + f)
                shutil.move(path, archive_dir)
            else:
                print('current: ' + f)

    helpers.await_char()
