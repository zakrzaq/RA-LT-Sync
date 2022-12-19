import os
from turtle import right
import pandas as pd
import warnings


def add():
    pdt_list = pd.read_excel(
        "LT Sync PDT Extension List.xlsx", sheet_name='Sheet1')
    new = pd.read_excel("input.xlsx")

    right_join = pd.merge(pdt_list, new, on="Material", how='right')
    not_in = right_join[right_join["Requestor"].isnull()]
    not_in.drop(['Requestor', 'Date Added'], axis=1, inplace=True)
    print(not_in.head())

    not_in.to_excel('pdt_ext_new.xlsx', index=False)
    # print(new.head())
