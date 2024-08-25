-- The relation _Airport_ contains basic information about an airport	
-- The relation _Flight_ contains basic information about a complete flight route
-- The relation _FlightLeg_ contains information about a flight segment within that route - this is the scheduled flight information - this may be different than the actual flight leg (a1_leginstance)
-- The relation _LegInstance_ contains information on a flight leg from a particular day - actual flight information for each leg - this can differe from the originally scheduled flight information for a leg - see (a1_flightleg)
-- The relation _AirplaneType_ has information about different airplane models
-- The relation _CanLand_ has information about whether a certain type of airplane can land at a particular airport
-- The relation _Airplane_ has information about an single airplane - the number of seats could be modified from the original manufactired plane (see a1_airplanetype)
-- The relation _AirPlaneCompany_ contains information about the manufacturer of each plane type

-- the following tables have been removed for DBS211
-- The relation _Fare_ contains information on a fare for a flight
-- The relation _Seat_reservation_ has information about a particular reservation for a flight
-- The relation _Customer _ has information about passangers who have pre-booked



-- set the session format - over riding the server setting
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY MM DD HH24:MI:SS';

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE a1_airport CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE a1_airline CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE a1_flight CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

/*
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE a1_fare CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/
*/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE a1_airplanecompany CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE a1_airplanetype CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE a1_airplane CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE a1_canland CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE a1_flightleg CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE a1_leginstance CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/


BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE a1_customer CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/



BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE a1_seatreservation CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/


-- CREATE airport TABLE
CREATE TABLE a1_airport
(
 airportID NUMBER(38) PRIMARY KEY,
 airportCode CHAR(3) UNIQUE,
 airportName VARCHAR(45),
 airportCity VARCHAR(25),
 airportState CHAR(2)
);

-- populate a1_airport
INSERT INTO a1_airport VALUES (1,'SFO','San-Francisco-International','San-Francisco','CA');
INSERT INTO a1_airport VALUES (2,'OAK', 'Oakland-International', 'Oakland', 'CA');
INSERT INTO a1_airport VALUES (3,'LAS', 'McCarren-International', 'Las-Vegas', 'NV');
INSERT INTO a1_airport VALUES (4,'HNL', 'Honolulu-International', 'Honolulu', 'HI');
INSERT INTO a1_airport VALUES (5,'JFK', 'John-F-Kennedy-International', 'New-York', 'NY');
INSERT INTO a1_airport VALUES (6,'FAT', 'Fresno-Yosemite-International', 'Fresno', 'CA');
INSERT INTO a1_airport VALUES (7,'MSY', 'Louis-Armstrong', 'New-Orleans', 'LA');
INSERT INTO a1_airport VALUES (8,'ORD', 'Chicago-OHare-International', 'Chicago', 'IL');
INSERT INTO a1_airport VALUES (9,'MDW', 'Midway', 'Chicago', 'IL');
INSERT INTO a1_airport VALUES (10,'SMF', 'Sacramento-International', 'Sacramento', 'CA');
INSERT INTO a1_airport VALUES (11,'SCK', 'Stockton-Metropolitan', 'Stockton', 'CA');
INSERT INTO a1_airport VALUES (12,'PHX', 'Phoenix-Sky-Harbor', 'Phoenix', 'AZ');
INSERT INTO a1_airport VALUES (13,'DEN', 'Denver-Interational', 'Denver', 'CO');
INSERT INTO a1_airport VALUES (14,'EWR', 'Newark-International', 'Newark', 'NJ');
INSERT INTO a1_airport VALUES (15,'IAH', 'Bush-Intercontinental', 'Houston', 'TX');
INSERT INTO a1_airport VALUES (16,'LAX', 'Los-Angeles-International', 'Los-Angeles', 'CA');
INSERT INTO a1_airport VALUES (17,'DCA', 'Ronald-Reagan-National', 'Arlington', 'VA');
INSERT INTO a1_airport VALUES (18,'IAD', 'Washington-Dulles-International', 'Dulles', 'VA');
INSERT INTO a1_airport VALUES (19,	'MSN', 'Dane-County-Regional', 'Madison', 'WI');
INSERT INTO a1_airport VALUES (20,	'MSP', 'Minneapolis-St-Paul', 'Minneapolis-St-Paul', 'MN');
INSERT INTO a1_airport VALUES (21,	'SLC', 'Salt-Lake-City-International', 'Salt-Lake-City', 'UT');
INSERT INTO a1_airport VALUES (22,	'DFW', 'Dallas-Fort-Worth', 'DFW', 'TX');
INSERT INTO a1_airport VALUES (23,	'SAN', 'San-Diego-International', 'San-Diego', 'CA');
INSERT INTO a1_airport VALUES (24,	'IWA', 'Phoenix-Mesa-Gateway', 'Phoenix', 'AZ');
INSERT INTO a1_airport VALUES (25,	'SJC', 'San-Jose-International', 'San-Jose', 'CA');
INSERT INTO a1_airport VALUES (26,	'ONT', 'Ontario-International', 'Ontario', 'CA');
COMMIT;


-- CREATE airline TABLE
CREATE TABLE a1_airline
(
 airlineID NUMBER(38) PRIMARY KEY,
 airLineName VARCHAR(25)
);

-- populate a1_airline
INSERT INTO a1_airline VALUES (1,'Jetblue');
INSERT INTO a1_airline VALUES (2,'Delta');
INSERT INTO a1_airline VALUES (3,'Allegiant');
INSERT INTO a1_airline VALUES (4,'Hawaiian');
INSERT INTO a1_airline VALUES (5,'American');
INSERT INTO a1_airline VALUES (6,'Southwest');
INSERT INTO a1_airline VALUES (7,'United');
COMMIT;


-- create flight TABLE
CREATE TABLE a1_flight
(
flightID NUMBER(38) PRIMARY KEY,
flightNumber CHAR(10),
airLineID NUMBER(38),
flightWeekdays CHAR(3),
FOREIGN KEY (AirLineID) REFERENCES a1_airline(airLineID)
);

-- populate a1_flight
INSERT INTO a1_flight VALUES (1, 'UA560',7,'Yes');
INSERT INTO a1_flight VALUES (2, 'B6624',1,'Yes');
INSERT INTO a1_flight VALUES (3, 'DL5841',2,'Yes');
INSERT INTO a1_flight VALUES (4, 'DL1149',2,'Yes');
INSERT INTO a1_flight VALUES (5, 'G4529',3,'No');
INSERT INTO a1_flight VALUES (6, 'G4154',3,'No');
INSERT INTO a1_flight VALUES (7, 'G4155',3,'No');
INSERT INTO a1_flight VALUES (8, 'HA48',4,'No');
INSERT INTO a1_flight VALUES (9, 'AA1522',5,'Yes');
INSERT INTO a1_flight VALUES (10, 'AA3472',5,'Yes');
INSERT INTO a1_flight VALUES (11, 'WN380',6,'Yes');
COMMIT;

/*
-- create fare TABLE
CREATE TABLE a1_fare
(
 fareID NUMBER(38) PRIMARY KEY,
 flightID NUMBER(38),
 fareCode CHAR(1),
 fareAmount NUMBER(6,2),
 fareRestrictions CHAR(3),
 FOREIGN KEY (flightID) REFERENCES a1_flight(flightID)
);


-- populate a1_fare
INSERT INTO a1_fare (fareID, flightID, fareCode, fareAmount, fareRestrictions) VALUES (1,1, 'L', 350, 'No');
INSERT INTO a1_fare (fareID, flightID, fareCode, fareAmount, fareRestrictions) VALUES (2,	6, 'Y', 106, 'No');
INSERT INTO a1_fare (fareID, flightID, fareCode, fareAmount, fareRestrictions) VALUES (3,	7, 'Y', 142, 'No');
INSERT INTO a1_fare (fareID, flightID, fareCode, fareAmount, fareRestrictions) VALUES (4,	3, 'Y', 100, 'Yes');
INSERT INTO a1_fare (fareID, flightID, fareCode, fareAmount, fareRestrictions) VALUES (5,	4, 'B', 500, 'Yes');
INSERT INTO a1_fare (fareID, flightID, fareCode, fareAmount, fareRestrictions) VALUES (6,	8, 'F', 1000, 'Yes');
INSERT INTO a1_fare (fareID, flightID, fareCode, fareAmount, fareRestrictions) VALUES (7,	9, 'Y', 250, 'No');
INSERT INTO a1_fare (fareID, flightID, fareCode, fareAmount, fareRestrictions) VALUES (8,	10, 'Y', 150, 'Yes');
INSERT INTO a1_fare (fareID, flightID, fareCode, fareAmount, fareRestrictions) VALUES (9,	11, 'Y', 256, 'No');
INSERT INTO a1_fare (fareID, flightID, fareCode, fareAmount, fareRestrictions) VALUES (10,	2, 'Y', 98, 'No');
COMMIT;
*/

-- create airplaneCompany TABLE
CREATE TABLE a1_airplaneCompany
(
 airplaneCompanyID NUMBER(38) PRIMARY KEY,
 airplaneCompanyName VARCHAR(25)
);

-- populate a1_airplaneCompany
INSERT INTO a1_airplanecompany (airplaneCompanyID, airplaneCompanyName) VALUES (1, 'Airbus');
INSERT INTO a1_airplanecompany (airplaneCompanyID, airplaneCompanyName) VALUES (2, 'Boeing');
INSERT INTO a1_airplanecompany (airplaneCompanyID, airplaneCompanyName) VALUES (3, 'Embraer');
INSERT INTO a1_airplanecompany (airplaneCompanyID, airplaneCompanyName) VALUES (4, 'Bombardier');
INSERT INTO a1_airplanecompany (airplaneCompanyID, airplaneCompanyName) VALUES (5, 'McDonnell-Douglas');
COMMIT;

-- create airplaneType TABLE
CREATE TABLE a1_airplaneType
(
 airplaneTypeID NUMBER(38) PRIMARY KEY,
 airplaneTypeName VARCHAR(10),
 airplaneTypeMaxSeats NUMBER(4),
 airplaneCompanyID NUMBER(38),
 FOREIGN KEY (airplaneCompanyID) REFERENCES a1_airplaneCompany(airplaneCompanyID)
);

--populate a1_airplanetype
INSERT INTO a1_airplanetype (airplaneTypeID, airplaneTypeName, airplaneTypeMaxSeats,airplaneCompanyID) VALUES (1,'A320',180,1);
INSERT INTO a1_airplanetype (airplaneTypeID, airplaneTypeName, airplaneTypeMaxSeats,airplaneCompanyID) VALUES (2,'A319',156,1);
INSERT INTO a1_airplanetype (airplaneTypeID, airplaneTypeName, airplaneTypeMaxSeats,airplaneCompanyID) VALUES (3,'A321',236,1);
INSERT INTO a1_airplanetype (airplaneTypeID, airplaneTypeName, airplaneTypeMaxSeats,airplaneCompanyID) VALUES (4,'A332',200,1);
INSERT INTO a1_airplanetype (airplaneTypeID, airplaneTypeName, airplaneTypeMaxSeats,airplaneCompanyID) VALUES (5,'707',189,2);
INSERT INTO a1_airplanetype (airplaneTypeID, airplaneTypeName, airplaneTypeMaxSeats,airplaneCompanyID) VALUES (6,'737',124,2);
INSERT INTO a1_airplanetype (airplaneTypeID, airplaneTypeName, airplaneTypeMaxSeats,airplaneCompanyID) VALUES (7,'747',550,2);
INSERT INTO a1_airplanetype (airplaneTypeID, airplaneTypeName, airplaneTypeMaxSeats,airplaneCompanyID) VALUES (8,'757',228,2);
INSERT INTO a1_airplanetype (airplaneTypeID, airplaneTypeName, airplaneTypeMaxSeats,airplaneCompanyID) VALUES (9,'727',189,2);
INSERT INTO a1_airplanetype (airplaneTypeID, airplaneTypeName, airplaneTypeMaxSeats,airplaneCompanyID) VALUES (10,'767',290,2);
INSERT INTO a1_airplanetype (airplaneTypeID, airplaneTypeName, airplaneTypeMaxSeats,airplaneCompanyID) VALUES (11,'777',440,2);
INSERT INTO a1_airplanetype (airplaneTypeID, airplaneTypeName, airplaneTypeMaxSeats,airplaneCompanyID) VALUES (12,'787',323,2);
INSERT INTO a1_airplanetype (airplaneTypeID, airplaneTypeName, airplaneTypeMaxSeats,airplaneCompanyID) VALUES (13,'ERJ145',50,3);
INSERT INTO a1_airplanetype (airplaneTypeID, airplaneTypeName, airplaneTypeMaxSeats,airplaneCompanyID) VALUES (14,'190',114,3);
INSERT INTO a1_airplanetype (airplaneTypeID, airplaneTypeName, airplaneTypeMaxSeats,airplaneCompanyID) VALUES (15,'170',80,3);
INSERT INTO a1_airplanetype (airplaneTypeID, airplaneTypeName, airplaneTypeMaxSeats,airplaneCompanyID) VALUES (16,'CRJ440',44,4);
INSERT INTO a1_airplanetype (airplaneTypeID, airplaneTypeName, airplaneTypeMaxSeats,airplaneCompanyID) VALUES (17,'CRJ100',50,4);
INSERT INTO a1_airplanetype (airplaneTypeID, airplaneTypeName, airplaneTypeMaxSeats,airplaneCompanyID) VALUES (18,'CRJ700',78,4);
INSERT INTO a1_airplanetype (airplaneTypeID, airplaneTypeName, airplaneTypeMaxSeats,airplaneCompanyID) VALUES (19,'MD80',166,5);
COMMIT;

-- create table airplane
CREATE TABLE a1_airplane
(
 airplaneID NUMBER(38) PRIMARY KEY,
 airplaneSeats NUMBER(4),
 airplaneTypeID NUMBER(38),
 FOREIGN KEY (airplaneTypeID) REFERENCES a1_airplaneType(airplaneTypeID)
);

-- populate a1_airplane
INSERT INTO a1_airplane (airplaneID, airplaneSeats, airplaneTypeID) VALUES (1,180,1);
INSERT INTO a1_airplane (airplaneID, airplaneSeats, airplaneTypeID) VALUES (2,175,1);
INSERT INTO a1_airplane (airplaneID, airplaneSeats, airplaneTypeID) VALUES (3,156,2);
INSERT INTO a1_airplane (airplaneID, airplaneSeats, airplaneTypeID) VALUES (4,150,2);
INSERT INTO a1_airplane (airplaneID, airplaneSeats, airplaneTypeID) VALUES (5,145,2);
INSERT INTO a1_airplane (airplaneID, airplaneSeats, airplaneTypeID) VALUES (6,188,5);
INSERT INTO a1_airplane (airplaneID, airplaneSeats, airplaneTypeID) VALUES (7,187,5);
INSERT INTO a1_airplane (airplaneID, airplaneSeats, airplaneTypeID) VALUES (8,124,9);
INSERT INTO a1_airplane (airplaneID, airplaneSeats, airplaneTypeID) VALUES (9,123,6);
INSERT INTO a1_airplane (airplaneID, airplaneSeats, airplaneTypeID) VALUES (10,120,6);
INSERT INTO a1_airplane (airplaneID, airplaneSeats, airplaneTypeID) VALUES (11,550,7);
INSERT INTO a1_airplane (airplaneID, airplaneSeats, airplaneTypeID) VALUES (12,500,7);
INSERT INTO a1_airplane (airplaneID, airplaneSeats, airplaneTypeID) VALUES (13,225,8);
INSERT INTO a1_airplane (airplaneID, airplaneSeats, airplaneTypeID) VALUES (14,290,10);
INSERT INTO a1_airplane (airplaneID, airplaneSeats, airplaneTypeID) VALUES (15,285,10);
INSERT INTO a1_airplane (airplaneID, airplaneSeats, airplaneTypeID) VALUES (16,440,11);
INSERT INTO a1_airplane (airplaneID, airplaneSeats, airplaneTypeID) VALUES (17,323,12);
INSERT INTO a1_airplane (airplaneID, airplaneSeats, airplaneTypeID) VALUES (18,50,13);
INSERT INTO a1_airplane (airplaneID, airplaneSeats, airplaneTypeID) VALUES (19,50,13);
INSERT INTO a1_airplane (airplaneID, airplaneSeats, airplaneTypeID) VALUES (20,110,14);
INSERT INTO a1_airplane (airplaneID, airplaneSeats, airplaneTypeID) VALUES (21,80,15);
INSERT INTO a1_airplane (airplaneID, airplaneSeats, airplaneTypeID) VALUES (22,44,16);
INSERT INTO a1_airplane (airplaneID, airplaneSeats, airplaneTypeID) VALUES (23,40,16);
INSERT INTO a1_airplane (airplaneID, airplaneSeats, airplaneTypeID) VALUES (24,50,17);
INSERT INTO a1_airplane (airplaneID, airplaneSeats, airplaneTypeID) VALUES (25,70,18);
INSERT INTO a1_airplane (airplaneID, airplaneSeats, airplaneTypeID) VALUES (26,75,18);
INSERT INTO a1_airplane (airplaneID, airplaneSeats, airplaneTypeID) VALUES (27,77,18);
INSERT INTO a1_airplane (airplaneID, airplaneSeats, airplaneTypeID) VALUES (28,166,19);
INSERT INTO a1_airplane (airplaneID, airplaneSeats, airplaneTypeID) VALUES (29,200,3);
INSERT INTO a1_airplane (airplaneID, airplaneSeats, airplaneTypeID) VALUES (30,180,4);
COMMIT;


-- create canLand TABLE
CREATE TABLE a1_canLand
(
canLAndID NUMBER(38) PRIMARY KEY,
airplaneTypeID NUMBER(38),
airportID NUMBER(38),
FOREIGN KEY (airplaneTypeID) REFERENCES a1_airplaneType(airplaneTypeID),
FOREIGN KEY (airportID) REFERENCES a1_airport(airportID)
);

-- populate a1_canland
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (1,19, 11);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (2,19, 23);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (3,19, 24);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (4,19, 3);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (5,13, 24);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (6,13, 6);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (7,13, 8);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (8,13, 19);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (9,16, 19);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (10,16, 20);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (11,17, 19);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (12,17, 20);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (13,18, 19);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (14,18, 21);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (15,18, 8);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (16,15, 2);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (17,15, 16);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (18,14, 21);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (19,14, 2);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (20,5, 4);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (21,5, 2);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (22,5, 9);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (23,5, 25);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (24,9, 10);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (25,9, 25);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (26,9, 16);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (27,6, 2);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (28,6, 1);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (29,6, 8);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (30,6, 9);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (31,6, 26);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (32,6, 10);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (33,6, 25);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (34,6, 23);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (35,6, 3);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (36,7, 1);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (37,7, 5);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (38,7, 8);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (39,7, 20);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (40,7, 13);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (41,8, 3);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (42,8, 12);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (43,8, 17);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (44,8, 16);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (45,8, 4);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (46,11, 8);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (47,11, 16);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (48,11, 18);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (49,12, 15);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (50,12, 5);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (51,12, 14);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (52,3, 22);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (53,3, 13);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (54,4, 2);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (55,4, 4);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (56,1, 5);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (57,1, 16);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (58,1, 15);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (59,2, 21);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (60,2, 12);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (61,2, 20);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (62,2, 1);
INSERT INTO a1_canland (canLandID, airplaneTypeID, airportID) VALUES (63,2, 9);
COMMIT;


-- create flightleg TABLE
CREATE TABLE a1_flightLeg
(
 flightLegID NUMBER(38) PRIMARY KEY,
 flightLegNumber NUMBER(1),
 flightLegDepartureTime INTERVAL day(0) to second,
 flightLegArrivalTime INTERVAL day(0) to second,
 flightID NUMBER(38),
 airportID_Departure NUMBER(38),
 airportID_Arrival NUMBER(38),
 FOREIGN KEY (flightID) REFERENCES a1_flight(flightID),
 FOREIGN KEY (airportID_Departure) REFERENCES a1_airport(airportID),
 FOREIGN KEY (airportID_Arrival) REFERENCES a1_airport(airportID)
);

-- populate a1_flightleg
INSERT INTO a1_flightleg (flightLegID, flightLegNumber, flightLegDepartureTime, flightLegArrivalTime, flightID, airportID_Departure, airportID_Arrival)
 VALUES (1, 1,INTERVAL '0 17:31:00' day(0) to second,INTERVAL '0 20:14:00' day(0) to second,7,11,24);
INSERT INTO a1_flightleg (flightLegID, flightLegNumber, flightLegDepartureTime, flightLegArrivalTime, flightID, airportID_Departure, airportID_Arrival)
 VALUES (2,1,INTERVAL '0 16:06:00' day(0) to second,INTERVAL '0 16:51:00' day(0) to second,6,24,11);
INSERT INTO a1_flightleg (flightLegID, flightLegNumber, flightLegDepartureTime, flightLegArrivalTime, flightID, airportID_Departure, airportID_Arrival)
 VALUES (3,1,INTERVAL '0 12:40:00' day(0) to second,INTERVAL '0 14:00:00' day(0) to second,3,2,16);
INSERT INTO a1_flightleg (flightLegID, flightLegNumber, flightLegDepartureTime, flightLegArrivalTime, flightID, airportID_Departure, airportID_Arrival)
 VALUES (4,1,INTERVAL '0 18:45:00' day(0) to second,INTERVAL '0 22:43:00' day(0) to second,4,16,4);
INSERT INTO a1_flightleg (flightLegID, flightLegNumber, flightLegDepartureTime, flightLegArrivalTime, flightID, airportID_Departure, airportID_Arrival)
 VALUES (5, 1,INTERVAL '0 14:15:00' day(0) to second,INTERVAL '0 21:30:00' day(0) to second,8,4,2);
INSERT INTO a1_flightleg (flightLegID, flightLegNumber, flightLegDepartureTime, flightLegArrivalTime, flightID, airportID_Departure, airportID_Arrival)
 VALUES (6,1,INTERVAL '0 23:59:00' day(0) to second,INTERVAL '0 06:04:00' day(0) to second,9,1,8);
INSERT INTO a1_flightleg (flightLegID, flightLegNumber, flightLegDepartureTime, flightLegArrivalTime, flightID, airportID_Departure, airportID_Arrival)
 VALUES (7,1,INTERVAL '0 07:19:00' day(0) to second,INTERVAL '0 08:19:00' day(0) to second,10,8,19);
INSERT INTO a1_flightleg (flightLegID, flightLegNumber, flightLegDepartureTime, flightLegArrivalTime, flightID, airportID_Departure, airportID_Arrival)
 VALUES (8,1,INTERVAL '0 07:55:00' day(0) to second,INTERVAL '0 10:10:00' day(0) to second,11,9,26);
INSERT INTO a1_flightleg (flightLegID, flightLegNumber, flightLegDepartureTime, flightLegArrivalTime, flightID, airportID_Departure, airportID_Arrival)
 VALUES (9,2,INTERVAL '0 10:45:00' day(0) to second,INTERVAL '0 11:45:00' day(0) to second,11,26,10);
INSERT INTO a1_flightleg (flightLegID, flightLegNumber, flightLegDepartureTime, flightLegArrivalTime, flightID, airportID_Departure, airportID_Arrival)
 VALUES (10,1,INTERVAL '0 21:15:00' day(0) to second,INTERVAL '0 05:22:00' day(0) to second,2,16,5);

-- create legInstance TABLE
CREATE TABLE a1_legInstance
(
 legInstanceID NUMBER(38) PRIMARY KEY,
 legInstanceLegNumber NUMBER(1),
 legInstanceDate DATE,
 legInstanceAvailableSeats NUMBER(4),
 legInstanceDepartureTime INTERVAL day(0) to second,
 legInstanceArrivalTime INTERVAL day(0) to second,
 flightID NUMBER(38),
 airplaneID NUMBER(38),
 airportID_Departure NUMBER(38),
 airportID_Arrival NUMBER(38),
 FOREIGN KEY (flightID) REFERENCES a1_flight(flightID),
 FOREIGN KEY (airplaneID) REFERENCES a1_airplane(airplaneID),
 FOREIGN KEY (airportID_Departure) REFERENCES a1_airport(airportID),
 FOREIGN KEY (airportID_Arrival) REFERENCES a1_airport(airportID)
);

-- populate a1_leginstance
INSERT INTO a1_legInstance (legInstanceID, LegInstanceLegNumber,legInstanceDate,legInstanceAvailableSeats, legInstanceDepartureTime, legInstanceArrivalTime, flightID, airplaneID,airportID_Departure, airportID_Arrival)
 VALUES (1,1,'20180128',3,INTERVAL '0 17:35:00' day(0) to second,INTERVAL '0 20:19:00' day(0) to second,7,28,11,24);
INSERT INTO a1_legInstance (legInstanceID, LegInstanceLegNumber,legInstanceDate,legInstanceAvailableSeats, legInstanceDepartureTime, legInstanceArrivalTime, flightID, airplaneID,airportID_Departure, airportID_Arrival)
 VALUES (2,1,'20180131',16,INTERVAL '0 17:31:00' day(0) to second,INTERVAL '0 20:13:00' day(0) to second,7,28,11,24);
INSERT INTO a1_legInstance (legInstanceID, LegInstanceLegNumber,legInstanceDate,legInstanceAvailableSeats, legInstanceDepartureTime, legInstanceArrivalTime, flightID, airplaneID,airportID_Departure, airportID_Arrival)
 VALUES (3,1,'20180203',19,INTERVAL '0 16:06:00' day(0) to second,INTERVAL '0 16:51:00' day(0) to second,6,28,11,24);
INSERT INTO a1_legInstance (legInstanceID, LegInstanceLegNumber,legInstanceDate,legInstanceAvailableSeats, legInstanceDepartureTime, legInstanceArrivalTime, flightID, airplaneID,airportID_Departure, airportID_Arrival)
 VALUES (4,1,'20180209',5,INTERVAL '0 12:45:00' day(0) to second,INTERVAL '0 14:05:00' day(0) to second,3,21,2,16);
INSERT INTO a1_legInstance (legInstanceID, LegInstanceLegNumber,legInstanceDate,legInstanceAvailableSeats, legInstanceDepartureTime, legInstanceArrivalTime, flightID, airplaneID,airportID_Departure, airportID_Arrival)
 VALUES (5,1,'20180209',20,INTERVAL '0 18:45:00' day(0) to second,INTERVAL '0 22:43:00' day(0) to second,4,13,16,4);
INSERT INTO a1_legInstance (legInstanceID, LegInstanceLegNumber,legInstanceDate,legInstanceAvailableSeats, legInstanceDepartureTime, legInstanceArrivalTime, flightID, airplaneID,airportID_Departure, airportID_Arrival)
 VALUES (6,1,'20180224',10,INTERVAL '0 14:15:00' day(0) to second,INTERVAL '0 21:10:00' day(0) to second,8,30,4,2);
INSERT INTO a1_legInstance (legInstanceID, LegInstanceLegNumber,legInstanceDate,legInstanceAvailableSeats, legInstanceDepartureTime, legInstanceArrivalTime, flightID, airplaneID,airportID_Departure, airportID_Arrival)
 VALUES (7,1,'20180805',70,INTERVAL '0 00:05:00' day(0) to second,INTERVAL '0 06:04:00' day(0) to second,9,9,1,8);
INSERT INTO a1_legInstance (legInstanceID, LegInstanceLegNumber,legInstanceDate,legInstanceAvailableSeats, legInstanceDepartureTime, legInstanceArrivalTime, flightID, airplaneID,airportID_Departure, airportID_Arrival)
 VALUES (8,1,'20180805',15,INTERVAL '0 07:19:00' day(0) to second,INTERVAL '0 08:19:00' day(0) to second,10,18,8,19);
INSERT INTO a1_legInstance (legInstanceID, LegInstanceLegNumber,legInstanceDate,legInstanceAvailableSeats, legInstanceDepartureTime, legInstanceArrivalTime, flightID, airplaneID,airportID_Departure, airportID_Arrival)
 VALUES (9,1,'20180805',110,INTERVAL '0 07:55:00' day(0) to second,INTERVAL '0 10:10:00' day(0) to second,11,10,9,26);
INSERT INTO a1_legInstance (legInstanceID, LegInstanceLegNumber,legInstanceDate,legInstanceAvailableSeats, legInstanceDepartureTime, legInstanceArrivalTime, flightID, airplaneID,airportID_Departure, airportID_Arrival)
 VALUES (10,2,'20180805',110,INTERVAL '0 10:45:00' day(0) to second,INTERVAL '0 11:45:00' day(0) to second,11,10,26,10);
INSERT INTO a1_legInstance (legInstanceID, LegInstanceLegNumber,legInstanceDate,legInstanceAvailableSeats, legInstanceDepartureTime, legInstanceArrivalTime, flightID, airplaneID,airportID_Departure, airportID_Arrival)
 VALUES (11,1,'20180209',100,INTERVAL '0 21:15:00' day(0) to second,INTERVAL '0 05:22:00' day(0) to second,2,1,16,5);


/*
-- create table customerID
CREATE TABLE a1_customer
(
 customerID NUMBER(38) PRIMARY KEY,
 customerFname VARCHAR(25),
 customerLname VARCHAR(25),
 customerPhone CHAR(14)
);

-- populate a1_customer
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (1,'Osvaldo',NULL,'555-55-5555');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (2,'Deana',NULL,'867-5309');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (3,'Mike',NULL,'555-5309');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (4,'Dan',NULL,'555-0000');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (5,'Ryan',NULL,'555-0001');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (6,'Mark',NULL,'555-0002');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (7,'Edgar',NULL,'555-0003');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (8,'Naomi',NULL,'555-0004');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (9,'Mitchell',NULL,'555-0005');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (10,'KC',NULL,'555-0006');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (11,'Jillian',NULL,'555-0007');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (12,'Carissa',NULL,'555-0008');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (13,'Clement',NULL,'555-0009');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (14,'John',NULL,'555-0010');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (15,'Sahib',NULL,'555-0011');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (16,'Alex',NULL,'555-0012');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (17,'KH',NULL,'555-0013');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (18,'Lisa',NULL,'555-0014');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (19,'Kyla',NULL,'555-0015');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (20,'Dorothy',NULL,'555-0016');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (21,'Max',NULL,'555-0017');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (22,'Jillian',NULL,'555-0018');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (23,'Michael',NULL,'555-0019');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (24,'Lisa',NULL,'555-0020');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (25,'Drew',NULL,'555-0021');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (26,'An',NULL,'555-0022');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (27,'Edgar',NULL,'555-0023');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (28,'Jeremy',NULL,'555-0024');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (29,'KH',NULL,'555-0025');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (30,'Katya',NULL,'555-0026');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (31,'Alicia',NULL,'555-0027');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (32,'Hillary',NULL,'555-0028');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (33,'Antonio',NULL,'555-0029');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (34,'Jaskaran',NULL,'555-0030');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (35,'Tom',NULL,'555-0031');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (36,'Norlan',NULL,'555-0032');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (37,'Ryan',NULL,'555-0033');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (38,'Naomi',NULL,'555-0034');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (39,'Mitchell',NULL,'555-0035');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (40,'Clement',NULL,'555-0036');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (41,'Danilo',NULL,'555-0037');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (42,'Sahib',NULL,'555-0038');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (43,'Alex',NULL,'555-0039');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (44,'KC',NULL,'555-0040');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (45,'Kyla',NULL,'555-0041');
INSERT INTO a1_customer (customerID, customerFName, customerLname, customerPhone) VALUES (46,'Drew',NULL,'555-0042');

*/

/*
-- create seatReservation TABLE
CREATE TABLE a1_seatReservation
(
 seatReservationID NUMBER(38) PRIMARY KEY,
 seatReservationLeg NUMBER(1),
 seatReservationDate DATE,
 seatReservationSeatNumber CHAR(5),
 flightID NUMBER(38),
 customerID NUMBER(38),
 FOREIGN KEY (flightID) REFERENCES a1_flight(flightID),
 FOREIGN KEY (customerID) REFERENCES a1_customer(customerID)
);

-- Populate a1_seatreservation

INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (1,1, '20180128','1A',7,1);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (2,1, '20180128','2A',7,2);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (3,1, '20180131','1A',6,3);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (4,1, '20180131','11A',6,4);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (5,1, '20180131','3A',6,5);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (6,1, '20180209','17A',4,6);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (7,1, '20180209','7A',3,7);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (8,1, '20180209','11B',4,8);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (9,1, '20180209','7F',3,9);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (10,1, '20180209','7D',3,10);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (11,1, '20180209','7C',3,11);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (12,1, '20180209','8A',4,12);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (13,1, '20180224','7E',8,13);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (14,1, '20180224','10A',8,14);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (15,1, '20180224','13A',8,15);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (16,1, '20180224','1E',8,16);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (17,1, '20180224','14A',8,17);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (18,1, '20180224','15E',8,18);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (19,1, '20180224','6A',8,19);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (20,1, '20180805','6A',9,20);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (21,1, '20180805','7E',9,21);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (22,1, '20180209','2A',2,22);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (23,1, '20180805','7F',9,23);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (24,1, '20180805','13A',9,24);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (25,1, '20180209','7D',2,25);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (26,1, '20180805','7F',9,26);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (27,1, '20180805','1A',10,27);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (28,1, '20180209','7B',2,28);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (29,1, '20180805','6A',10,29);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (30,1, '20180209','7C',2,30);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (31,1, '20180805','7A',10,31);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (32,1, '20180209','3D',2,32);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (33,1, '20180805','7E',10,33);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (34,1, '20180805','2B',10,34);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (35,1, '20180805','7C',11,35);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (36,1, '20180805','7A',11,36);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (37,1, '20180805','9B',11,37);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (38,1, '20180805','8A',11,38);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (39,1, '20180805','7F',11,39);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (40,1, '20180805','8F',11,40);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (41,2, '20180805','23D',11,41);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (42,2, '20180805','19A',11,42);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (43,2, '20180805','7E',11,43);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (44,2, '20180805','9A',11,44);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (45,2, '20180805','7B',11,45);
INSERT INTO a1_seatreservation (seatReservationID, seatReservationLeg, seatReservationDate, seatReservationSeatNumber, flightID,customerID) VALUES (46,2, '20180805','10C',11,46);
COMMIT;

*/





