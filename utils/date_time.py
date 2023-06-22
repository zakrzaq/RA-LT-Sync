import pandas as pd


def today_us():
    today = pd.to_datetime("today")
    return today.strftime("%Y-%m-%d")
