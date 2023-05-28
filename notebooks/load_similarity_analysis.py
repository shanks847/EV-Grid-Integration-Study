#importing relev. libs
import pandas as pd
import numpy as np
import matplotlib as mpl
import matplotlib.pyplot as plt   # data visualization

#importing data
df = pd.read_csv('EV-Grid-Integration-Study/data/arganguez_feeder_data.csv',parse_dates=[0])
df.set_index('Timestamp',inplace=True)
df.drop(['Times'],inplace=True,axis=1)
df_proc = df.resample('15T').asfreq().sort_index(ascending=False)

#cleaning data
missing_segments = df_proc[df_proc.isna().any(axis=1)]

# Print the missing segments, if any
if len(missing_segments) > 0:
    df_proc = df_proc.interpolate('linear')
    print("\n{} segments corrected:".format(len(missing_segments)))
else:
    print("No missing segments.")

#Splitting load into subsequences

#setting up containers to store data
jan_wk1,jan_wk2,jan_wk3,jan_wk4 = [],[],[],[]
jan = [jan_wk1,jan_wk2,jan_wk3,jan_wk4]

feb_wk1,feb_wk2,feb_wk3,feb_wk4 = [],[],[],[]
feb = [feb_wk1,feb_wk2,feb_wk3,feb_wk4]


