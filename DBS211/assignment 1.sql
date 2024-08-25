-- CREATE airport TABLE
CREATE TABLE a1_airport
(
 airportID NUMBER(38) PRIMARY KEY,
 airportCode CHAR(3) UNIQUE,
 airportName VARCHAR(45),
 airportCity VARCHAR(25),
 airportState CHAR(2)
);
-- CREATE airline TABLE
CREATE TABLE a1_airline
(
 airlineID NUMBER(38) PRIMARY KEY,
 airLineName VARCHAR(25)
);
-- create flight TABLE
CREATE TABLE a1_flight
(
flightID NUMBER(38) PRIMARY KEY,
flightNumber CHAR(10),
airLineID NUMBER(38),
flightWeekdays CHAR(3),
FOREIGN KEY (AirLineID) REFERENCES a1_airline(airLineID)
);
-- create airplaneCompany TABLE
CREATE TABLE a1_airplaneCompany
(
 airplaneCompanyID NUMBER(38) PRIMARY KEY,
 airplaneCompanyName VARCHAR(25)
);
-- create airplaneType TABLE
CREATE TABLE a1_airplaneType
(
 airplaneTypeID NUMBER(38) PRIMARY KEY,
 airplaneTypeName VARCHAR(10),
 airplaneTypeMaxSeats NUMBER(4),
 airplaneCompanyID NUMBER(38),
 FOREIGN KEY (airplaneCompanyID) REFERENCES a1_airplaneCompany(airplaneCompanyID)
);
-- create table airplane
CREATE TABLE a1_airplane
(
 airplaneID NUMBER(38) PRIMARY KEY,
 airplaneSeats NUMBER(4),
 airplaneTypeID NUMBER(38),
 FOREIGN KEY (airplaneTypeID) REFERENCES a1_airplaneType(airplaneTypeID)
);
-- create canLand TABLE
CREATE TABLE a1_canLand
(
canLAndID NUMBER(38) PRIMARY KEY,
airplaneTypeID NUMBER(38),
airportID NUMBER(38),
FOREIGN KEY (airplaneTypeID) REFERENCES a1_airplaneType(airplaneTypeID),
FOREIGN KEY (airportID) REFERENCES a1_airport(airportID)
);
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

ASSIGNMENT
QUESTION 1
SELECT 
t.airplaneTypename AS "Plane Type",
t.airplaneTypeMaxSeats AS "Maximum Seats",
p.airplaneseats AS "Modified Seating",
(t.airplaneTypeMaxSeats - p.airplaneseats) AS "Difference"
FROM a1_airplaneType t INNER JOIN a1_airplane p
ON t.airplaneTypeID = p.airplaneTypeID
WHERE p.airplaneSeats < t.airplaneTypeMaxSeats
ORDER BY "Difference" DESC;

 QUESTION 2
SELECT
c.airplaneCompanyName AS "Company Name",
t.airplaneTypeName AS "Plane Type"
FROM a1_airplaneCompany c LEFT JOIN a1_airplaneType t
ON c.airplaneCompanyId = t.airplaneCompanyId
ORDER BY "Company Name" ASC, "Plane Type" ASC;

QUESTION 3
SELECT
p.airportCode AS "Code",
p.airportName AS "Name"
FROM a1_airport p LEFT JOIN a1_flightLeg f
ON p.airportId = f.airportId_departure
WHERE f.flightLegId IS NULL 
ORDER BY "Code" DESC;

QUESTION 4
SELECT
t.airplaneTypeName AS "Type of Plane"
FROM a1_airplaneType t LEFT JOIN a1_canLand l
ON t.airplaneTypeId = l.airplaneTypeId
WHERE l.canLandId IS NULL;

QUESTION 5
SELECT
f.flightNumber AS "Flight Number",
fl.flightLegNumber AS "Leg",
li.legInstanceDate AS "Date",
a.airplaneSeats AS "Full Seating",
li.legInstanceAvailableSeats AS "Occupied Seats",
ROUND(((a.airplaneSeats - li.legInstanceAvailableSeats) / a.airplaneSeats) * 100, 2) AS "Actual Flight Capacity %"
FROM a1_flight f
INNER JOIN a1_flightLeg fl 
ON f.flightID = fl.flightID
INNER JOIN a1_legInstance li 
ON f.flightID = li.flightID
INNER JOIN a1_airplane a 
ON li.airplaneID = a.airplaneID
INNER JOIN a1_airplaneType at 
ON a.airplaneTypeID = at.airplaneTypeID;

QUESTION 6
SELECT DISTINCT 
a.airlineName AS "Airline",
l.airplaneSeats AS "Modified Seating",
t.airplaneTypeName AS "Plane Type",
t.airplaneTypeMaxSeats AS "Maximum Seating"
FROM a1_airline a INNER JOIN a1_flight f 
ON a.airlineID = f.airLineID
INNER JOIN a1_legInstance s 
ON f.flightID = s.flightID
INNER JOIN a1_airplane l 
ON s.airplaneID = l.airplaneID
INNER JOIN a1_airplaneType t 
ON l.airplaneTypeID = t.airplaneTypeID
ORDER BY a.airLineName ASC;















