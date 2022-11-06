import pandas as pd

l1_charging_events = pd.read_excel('data/level1_cleaned_AB.xlsx')
l2_charging_events = pd.read_excel('data/level2_cleaned_AB.xlsx')

l1_durations = l1_charging_events['durations'].apply(lambda x: int(x.minute + (x.hour * 60)))
l1_durations.to_csv('data/l1_durations_xformed.csv')
l2_durations = l2_charging_events['durations'].apply(lambda x: int(x.minute + (x.hour * 60)))
l2_durations.to_csv('data/l2_durations_xformed.csv')

