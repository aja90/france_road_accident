import pandas as pd
import numpy as np 
df =pd.read_csv('places.csv', encoding='latin-1')


print(df[['voie','v1','v2']].isnull().sum())


print(df.info())





df_accident = pd.read_csv('caracteristics.csv' , encoding='latin-1')

print(df_accident.dtypes)
#print(df_accident['lat'].unique())


#df_accident['lat'].astype(int)

print(df_accident['lat'].isna().sum())

df_accident = df_accident.dropna()


print(df_accident.info())

df_accident['long'] = df_accident['long'].replace('-',0)
df_accident['long'] = df_accident['long'].astype(float)

print(df_accident.info())

#df_accident.to_csv('/Users/alijamal/Desktop/road_accidents/accident.csv',index = False)


