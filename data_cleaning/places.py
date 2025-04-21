import pandas as pd

df_place = pd.read_csv('places.csv', encoding='latin-1')

print(df_place.head())


df_place = df_place.drop(columns=['v1','v2','pr','pr1'], axis = 1)

print(df_place.isna().sum())

print(df_place.info())

print(df_place['voie'].value_counts())

df_place = df_place.drop('voie', axis=1)

print(df_place.info())

df_place = df_place.dropna()
print(df_place.isna().sum())

df_place.to_csv('/Users/alijamal/Desktop/road_accidents/place_edit.csv', index= False)
