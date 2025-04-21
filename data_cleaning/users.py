import pandas as pd


df_user = pd.read_csv('users.csv',encoding='latin-1')



print(df_user.isnull().sum())

df_user.drop('place', axis=1,inplace=True)



df_user = df_user.dropna()

print(df_user.isnull().sum())
print(df_user.info())
df_user['secu'] = df_user['secu'].astype(int)


df_user.to_csv('/Users/alijamal/Desktop/road_accidents/user_edit.csv')



#df_user.to_csv('/Users/alijamal/Desktop/road_accidents/user_edit.csv')