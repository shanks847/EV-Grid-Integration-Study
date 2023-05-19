import pandas as pd
import numpy as np
import os

directory = '../data/scenarios/balanced_load/modified_loads/'
dest = '../data/scenarios/balanced_load/modified_loads_emtp_fmt/'
for dirpath, dirnames, filenames in os.walk(directory):
    for filename in filenames:
        if filename.endswith('.csv'):
            df = pd.read_csv(os.path.join(dirpath, filename))
            df.set_index(['Time'],inplace=True)
            df = df.transpose()
            df.to_csv(os.path.join(dest, filename))