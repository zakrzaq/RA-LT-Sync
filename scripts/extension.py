import os
import pandas as pd

import utils.helpers as helpers
import utils.date_time as dt


def add():
    dir_inputs = os.path.join(os.getcwd(), "INPUTS")
    dir_outputs = os.path.join(os.getcwd(), "OUTPUTS")

    for filename in os.listdir(dir_inputs):
        if 'LT Sync PDT Extension List' in filename:
            current_file = os.path.join(dir_inputs, filename)
        if 'new_extensions' in filename:
            addition_file = os.path.join(dir_inputs, filename)

    pdt_list = pd.read_excel(
        current_file, sheet_name='Sheet1')
    new = pd.read_excel(addition_file)

    right_join = pd.merge(pdt_list, new, on="Material", how='right')
    not_in = right_join[right_join["Requestor"].isnull()]
    not_in.drop(['Requestor', 'Date Added'], axis=1, inplace=True)
    print(not_in.head())

    today = dt.today_us()
    output_name = os.path.join(
        dir_outputs, ('ADDITIONS_LT Sync PDT Extension List' + today + '.xlsx'))

    not_in.to_excel(output_name, index=False)
    # print(new.head())

    helpers.await_char()
