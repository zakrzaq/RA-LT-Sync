# RA - Planning Plause & LT Sync UTILS

Developed for Rockwell Automation by `@zakrzaq`

## SETUP

1. Install `python 3.10` or up `git`
2. `git clone` repository to `C:\RA-Apps`
3. Run `python setup.py` from app directory

## UPDATE PROGRAM

Simply run program and choose `U` from the menu. Then close the application selecting `R` and run it again. Hurray, you are at the newest version.

## RTD REPORTS

Run `Filter & gather report to collect` reports in `INPUTS/rtd_data` directory

Run `Convert and format` to format reports. Outputs will be in `OUTPUTS/<date-provided>`

Run `Cleanup and archive` after process is completed

## LT Sync

### PROCEDURE

Copy `NEW`, `ORIGNAL`, `O15` into `INPUT` folder

ALL FORMATTED AS `xlsx`

## Exclusion list

### PROCEDURE

Copy current **exclusion list** with filename `LT sync exclusion list` into `INPUT` folder

Copy current **new additions file** in with filename `new_exclusions` into `INPUT` folder.

BOTH FORMATTED AS `xlsx`

## Extension list

### PROCEDURE

Copy current **exclusion list** with filename `LT Sync PDT Extension List` into `INPUT` folder

Copy current **new additions file** in with filename `new_extensions` into `INPUT` folder.

BOTH FORMATTED AS `xlsx`

## TODO

- [ ] scorecard: extend table [here](https://stackoverflow.com/questions/48657867/manipulate-existing-excel-table-using-openpyxl)
