CREATE or replace TABLE accident(
    Num_Acc int primary key ,
    an int ,
    mois int,
    jour int ,
    hrmn int ,
    lum  int ,
    agg int ,
    int int ,
    atm  int ,
    col int ,
    com int ,
    adr varchar,
    gps varchar,
    lat int,
    long int,
    dep  int 
);

CREATE or replace table vehicles (
    Num_Acc int ,
    senc int ,
    catv int ,
    obs int ,
    obsm int ,
    choc int ,
    manv int ,
    num_veh varchar primary key,
    FOREIGN key (Num_Acc) REFERENCES accident(Num_Acc) 

);



CREATE or replace TABLE users (
    user_id int IDENTITY(1,1) primary key,
    Num_Acc int ,
    catu int ,
    grav int ,
    sexe int ,
    trajet int ,
    secu int ,
    locp int ,
    actp int ,
    etatp int ,
    an_nais int ,
    num_veh varchar,
    FOREIGN key  (Num_Acc) REFERENCES accident(Num_Acc),
    FOREIGN key (num_veh) REFERENCES  vehicles(num_veh)

);


CREATE or replace  TABLE places (
    Place_id int IDENTITY(1,1) PRIMARY KEY,
    Num_Acc int ,
    catr INT,
    circ INT,
    nbv INT,
    vosp INT,
    prof INT,
    plan INT,
    lartpc INT,
    larrout INT,
    surf INT,
    infra INT,
    situ INT,
    env1 INT,
    FOREIGN key(Num_Acc) REFERENCES accident(Num_Acc)

);

