use warehouse load;

create stage internal_stage;

CREATE OR REPLACE FILE FORMAT csv_format
TYPE = CSV
FIELD_DELIMITER = ','
SKIP_HEADER = 1 -- If your CSV files have headers
NULL_IF = ('NULL', 'null','nan') -- Treat 'NULL' or 'null' as NULL values
ERROR_ON_COLUMN_COUNT_MISMATCH = FALSE
ENCODING = 'ISO-8859-1';


create or replace file format classic_csv 
COMPRESSION = 'AUTO' 
RECORD_DELIMITER = '\n'
FIELD_DELIMITER = ',' 
SKIP_HEADER = 1 
DATE_FORMAT = 'AUTO' 
TIMESTAMP_FORMAT = 'AUTO'
FIELD_OPTIONALLY_ENCLOSED_BY = '"'
TRIM_SPACE = FALSE
ERROR_ON_COLUMN_COUNT_MISMATCH = True 
ESCAPE = 'NONE' 
ESCAPE_UNENCLOSED_FIELD = '\134' 
NULL_IF = ('\\N');


copy into accident(num_acc,an , mois,jour,hrmn,lum,agg,int,atm,col,com,adr,gps,lat,long,dep)
from '@"ROAD"."PUBLIC"."INTERNAL_STAGE"/accident.csv'
FILE_FORMAT = (FORMAT_NAME = classic_csv);

copy into users(user_id,num_acc,catu,grav,sexe,trajet,secu,locp,actp,etatp,an_nais,num_veh)
from '@"ROAD"."PUBLIC"."INTERNAL_STAGE"/user_edit.csv'
FILE_FORMAT = (FORMAT_NAME = classic_csv);

copy into places(num_acc, catr,circ,nbv,vosp,prof,plan,lartpc,larrout,surf,infra,situ,env1)
from '@"ROAD"."PUBLIC"."INTERNAL_STAGE"/place_edit.csv'
FILE_FORMAT = (FORMAT_NAME = classic_csv);

copy into VEHICLES(num_acc, senc,catv,obs,obsm,choc,manv,num_veh)
from '@"ROAD"."PUBLIC"."INTERNAL_STAGE"/car_edit.csv'
FILE_FORMAT = (FORMAT_NAME = classic_csv);
