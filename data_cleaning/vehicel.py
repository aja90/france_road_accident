import pandas as pd 

df_car = pd.read_csv('vehicles.csv', encoding= 'latin-1')

print(df_car.head())

print(df_car.info())


df_car = df_car.dropna()
df_car = df_car.drop('occutc', axis= 1)
print(df_car.info())

df_car.to_csv('/Users/alijamal/Desktop/road_accidents/vehicel_edit.csv', index=False)


