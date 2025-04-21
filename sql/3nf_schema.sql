ROAD.PUBLIC.INTERNAL_STAGEcreate schema star_schema;

CREATE or replace TABLE Time (
    hrmn int,
    an INT,
    mois INT,
    jour INT,
    time_ID INT autoincrement,
    primary key (time_id)
);

use warehouse load;

insert into 
    time(hrmn, an,mois,jour)
select
    distinct hrmn,
    an,
    mois,
    jour,
from accident;



CREATE TABLE Lighting (
    lum INT PRIMARY KEY,
    light VARCHAR(255)
);

INSERT INTO Lighting (lum, light) VALUES
(1, 'Full day'),
(2, 'Twilight or dawn'),
(3, 'Night without public lighting'),
(4, 'Night with public lighting not lit'),
(5, 'Night with public lighting on');


CREATE TABLE Intersection (
    int INT PRIMARY KEY,
    type VARCHAR(255)
);

INSERT INTO Intersection (int, type) VALUES
(1, 'Out of intersection'),
(2, 'Intersection in X'),
(3, 'Intersection in T'),
(4, 'Intersection in Y'),
(5, 'Intersection with more than 4 branches'),
(6, 'Giratory'),
(7, 'Place'),
(8, 'Level crossing'),
(9, 'Other intersection');


CREATE TABLE Atmospheric (
    atm INT PRIMARY KEY,
    condition VARCHAR(255)
);

INSERT INTO Atmospheric (atm, condition) VALUES
(1, 'Normal'),
(2, 'Light rain'),
(3, 'Heavy rain'),
(4, 'Snow - hail'),
(5, 'Fog - smoke'),
(6, 'Strong wind - storm'),
(7, 'Dazzling weather'),
(8, 'Cloudy weather');


CREATE TABLE Collision (
    col INT PRIMARY KEY,
    type VARCHAR(255)
);

INSERT INTO Collision (col, type) VALUES
(1, 'Two vehicles - frontal'),
(2, 'Two vehicles - from the rear'),
(3, 'Two vehicles - by the side'),
(4, 'Three vehicles and more - in chain'),
(5, 'Three or more vehicles - multiple collisions'),
(6, 'Other collision'),
(7, 'Without collision');




create table address (
  address_id int autoincrement ,
  adr varchar ,
  gps varchar ,
  lat int ,
  long int ,
  primary key (address_id)
) ;


insert into address(adr,gps,lat,long)
select
distinct adr,
gps,
lat,
long
from  accident ;




---- facts table accident 

CREATE or replace TABLE  fact_accident (
    Num_Acc INT PRIMARY KEY,
    time_id int ,
    lum INT,
    int INT,
    atm INT,
    col INT,
    address_id int,
    foreign key (time_id) references time(time_id),
    FOREIGN KEY (lum) REFERENCES Lighting(lum),
    FOREIGN KEY (int) REFERENCES Intersection(int),
    FOREIGN KEY (atm) REFERENCES Atmospheric(atm),
    FOREIGN KEY (col) REFERENCES Collision(col),
    foreign key (address_id) references address(address_id)
);

insert into 
fact_accident(num_acc,time_id,lum,int,atm,col,address_id)
select 
    num_acc,t.time_id,lum, int ,atm , col , a.address_id
from accident as acc
join time  as t on  acc.hrmn = t.hrmn
and acc.an = t.an
and acc.mois = t.mois
and acc.an = t.an
join address as a on acc.adr = a.adr
and acc.gps = a.gps
and acc.lat = a.lat 
and acc.long = a.long;

    
--- now for places table 

CREATE TABLE Road_Category (
    catr INT PRIMARY KEY,
    road VARCHAR(255)
);

INSERT INTO Road_Category (catr, road) VALUES
(1, 'Highway'),
(2, 'National Road'),
(3, 'Departmental Road'),
(4, 'Communal Way'),
(5, 'Off public network'),
(6, 'Parking lot open to public traffic'),
(9, 'Other');

CREATE TABLE Surface_Condition (
    surf INT PRIMARY KEY,
    condition VARCHAR(255)
);

INSERT INTO Surface_Condition (surf, condition) VALUES
(1, 'Normal'),
(2, 'Wet'),
(3, 'Puddles'),
(4, 'Flooded'),
(5, 'Snow'),
(6, 'Mud'),
(7, 'Icy'),
(8, 'Fat - oil'),
(9, 'Other');

CREATE TABLE Infrastructure (
    infra INT PRIMARY KEY,
    type VARCHAR(255)
);

INSERT INTO Infrastructure (infra, type) VALUES
(1, 'Underground - tunnel'),
(2, 'Bridge - autopont'),
(3, 'Exchanger or connection brace'),
(4, 'Railway'),
(5, 'Carrefour arranged'),
(6, 'Pedestrian area');

INSERT INTO Infrastructure (infra, type) VALUES
(7, 'Toll Zone');

CREATE TABLE Accident_Situation (
    situ INT PRIMARY KEY,
    situation VARCHAR(255)
);

INSERT INTO Accident_Situation (situ, situation) VALUES
(1, 'On the road'),
(2, 'On emergency stop band'),
(3, 'On the verge'),
(4, 'On the sidewalk');


CREATE TABLE Traffic_System (
    circ INT PRIMARY KEY,
    system VARCHAR(255)
);

INSERT INTO Traffic_System (circ, system) VALUES
(1, 'One way'),
(2, 'Bidirectional'),
(3, 'Separated carriageways'),
(4, 'With variable assignment channels');

CREATE TABLE gradient_road(
    prof INT PRIMARY KEY,
    description VARCHAR(255)
);

INSERT INTO gradient_road (prof, description) VALUES
(1, 'Dish'),
(2, 'Slope'),
(3, 'Hilltop'),
(4, 'Hill bottom');


-- create fact_place table 

CREATE TABLE fact_Place (
    Place_ID INT PRIMARY KEY,
    Num_Acc INT,
    catr INT,
    circ INT,
    nbv INT,
    prof INT,
    surf INT,
    infra INT,
    situ INT,
    env1 BOOLEAN,
    FOREIGN key(Num_Acc) REFERENCES fact_accident(Num_Acc),
    FOREIGN KEY (catr) REFERENCES Road_Category(catr),
    FOREIGN KEY (circ) REFERENCES traffic_system(circ),
    FOREIGN KEY (prof) REFERENCES gradient_road(prof),
    FOREIGN KEY (surf) REFERENCES Surface_Condition(surf),
    FOREIGN KEY (infra) REFERENCES Infrastructure(infra),
    FOREIGN KEY (situ) REFERENCES Accident_Situation(situ)
);

insert into 
    fact_Place (place_id ,num_acc,catr,circ,nbv,prof,surf,infra,situ,env1)
select place_id ,num_acc , catr,circ,nbv,prof,surf,infra,situ,env1
from places;





---> now create lookup tables for " users "

CREATE TABLE User_Category (
    catu INT PRIMARY KEY,
    category VARCHAR(255)
);

INSERT INTO User_Category (catu, category) VALUES
(1, 'Driver'),
(2, 'Passenger'),
(3, 'Pedestrian'),
(4, 'Pedestrian in rollerblade or scooter');


CREATE TABLE Severity (
    grav INT PRIMARY KEY,
    severity VARCHAR(255)
);


INSERT INTO Severity (grav, severity) VALUES
(1, 'Unscathed'),
(2, 'Killed'),
(3, 'Hospitalized wounded'),
(4, 'Light injury');


CREATE or replace TABLE Sex (
    sexe INT PRIMARY KEY,
    gender VARCHAR(255)
);

INSERT INTO Sex (sexe, gender) VALUES
(1, 'Male'),
(2, 'Female');


CREATE or replace TABLE Trip_Reason (
    trajet INT PRIMARY KEY,
    reason VARCHAR(255)
);

INSERT INTO Trip_Reason (trajet, reason) VALUES
(1, 'Home - work'),
(2, 'Home - school'),
(3, 'Shopping - Shopping'),
(4, 'Professional use'),
(5, 'Promenade - leisure'),
(9, 'Other');




CREATE TABLE Pedestrian_Location (
    locp INT PRIMARY KEY,
    location_description VARCHAR(255)
);

INSERT INTO Pedestrian_Location (locp, location_description) VALUES
(1, 'A + 50 m from the pedestrian crossing'),
(2, 'A - 50 m from the pedestrian crossing'),
(3, 'On pedestrian crossing without light signaling'),
(4, 'On pedestrian crossing with light signaling'),
(5, 'On the sidewalk'),
(6, 'On the verge'),
(7, 'On refuge or BAU'),
(8, 'On against aisle');



CREATE TABLE Pedestrian_Action (
    actp INT PRIMARY KEY,
    action_description VARCHAR(255)
);

INSERT INTO Pedestrian_Action (actp, action_description) VALUES
(0, 'Not specified or not applicable'),
(1, 'Moving - Meaning bumping vehicle'),
(2, 'Moving - Opposite direction of the vehicle'),
(3, 'Crossing'),
(4, 'Masked'),
(5, 'Playing - running'),
(6, 'With animal'),
(9, 'Other');

CREATE TABLE fact_user (
    user_id INT,
    num_acc INT,
    num_veh VARCHAR(255),
    catu INT,
    grav INT,
    sexe INT,
    an_nais int,
    trajet int,
    secu int,
    locp INT,
    actp INT,
    primary key (user_id),
    FOREIGN KEY (num_acc) REFERENCES fact_accident(num_acc),
    FOREIGN KEY (num_veh) REFERENCES fact_vehicle (num_veh),
    FOREIGN KEY (catu) REFERENCES User_Category(catu),
    FOREIGN KEY (grav) REFERENCES Severity(grav),
    FOREIGN KEY (sexe) REFERENCES Sex(sexe),
    FOREIGN KEY (trajet) REFERENCES Trip_reason(trajet),
    FOREIGN KEY (locp) REFERENCES Pedestrian_Location(locp),
    FOREIGN KEY (actp) REFERENCES Pedestrian_Action(actp)
);



insert into 
fact_user(  user_id , num_acc, num_veh , catu ,grav ,sexe ,an_nais, trajet ,secu , locp ,actp )
select user_id , num_acc, num_veh , catu ,grav ,sexe ,an_nais, trajet ,secu , locp ,actp
from users;

---- now for vehicles 

CREATE TABLE Vehicle_Category (
    catv INT PRIMARY KEY,
    category VARCHAR(255)
);

INSERT INTO Vehicle_Category (catv, category) VALUES
(01, 'Bicycle'),
(02, 'Moped <50cm3'),
(03, 'Cart (Quadricycle with bodied motor)'),
(04, 'Not used since 2006 (registered scooter)'),
(05, 'Not used since 2006 (motorcycle)'),
(06, 'Not used since 2006 (side-car)'),
(07, 'VL only'),
(08, 'Not used category (VL + caravan)'),
(09, 'Not used category (VL + trailer)'),
(10, 'VU only 1,5T <= GVW <= 3,5T with or without trailer'),
(11, 'Most used since 2006 (VU (10) + caravan)'),
(12, 'Most used since 2006 (VU (10) + trailer)');



CREATE TABLE fact_vehicle (
    Num_Veh VARCHAR(255) PRIMARY KEY,
    Num_Acc INT,
    catv INT,
    FOREIGN KEY (Num_Acc) REFERENCES fact_accident(Num_Acc),
    FOREIGN KEY (catv) REFERENCES Vehicle_Category(catv)
    
);


insert into 
    fact_vehicle(num_veh,num_acc,catv)
select num_veh , num_acc , catv
from vehicles;
   







    