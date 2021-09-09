--Matheus Alexandre; CS205-01, Fall 2017

--userOps1.sql

--Script to create tables for Term Project 01: Room House

--Spool results to a file in the current directory
\o spoolUserOps1.txt


--Echo the date and time the script is run
\qecho -n 'Script ruin on '
\qecho -n `date /t`
\qecho -n 'at '
\qecho -n `time /t`
\qecho -n ' by '
\qecho :USER
\qecho ' '


--Clear all existing data
DELETE FROM Customer CASCADE;
DELETE FROM CustName CASCADE;
DELETE FROM Room CASCADE;
DELETE FROM Reservation CASCADE;
DELETE FROM ResDate CASCADE;


-- not inserted by users, already preset for reservation purposes
INSERT INTO ROOM (RoomNum, RType, TypePrice)
VALUES (1, 'Suite', 7.00);
INSERT INTO ROOM (RoomNum, RType, TypePrice)
VALUES (2, 'Double', 3.00);
INSERT INTO ROOM (RoomNum, RType, TypePrice)
VALUES (3, 'Single', 5.00);


-- user operations
INSERT INTO CUSTOMER (CID, Street, ZIP, City, State)
VALUES (1, '151 White Street', '06811', 'Danbury', 'CT');

INSERT INTO CUSTNAME (CustID, CName)
VALUES (1, 'Mathes Alexandre');

UPDATE CUSTNAME SET CName = 'Matheus Alexandre' WHERE CustID = 1;

INSERT INTO CUSTOMER (CID, Street, ZIP, City, State)
VALUES (2, '122 Tower Rd', '06804', 'Brookfield', 'CT');

INSERT INTO CUSTNAME (CustID, CName)
VALUES (2, 'Lil Git');

INSERT INTO RESERVATION (ResID, CID, RID)
VALUES (2, 2, 1);

INSERT INTO RESDATE (ResID, CheckInDate, CheckOutDate)
VALUES (2, '2017-01-02', '2017-02-01');

INSERT INTO RESERVATION (ResID, CID, RID)
VALUES (1, 1, 1);

INSERT INTO RESDATE (ResID, CheckInDate, CheckOutDate)
VALUES (1, '2017-10-28', '2017-11-12');

UPDATE RESERVATION SET RID = 2 WHERE ResID = 2;

INSERT INTO CUSTOMER (CID, Street, ZIP, City, State)
VALUES (3, '103 Eagle St', '06607', 'Bridgeport', 'CT');

INSERT INTO CUSTNAME (CustID, CName)
VALUES (3, 'Chutzpah Roc');

INSERT INTO RESERVATION (ResID, CID, RID)
VALUES (3, 3, 3);

INSERT INTO RESDATE (ResID, CheckInDate, CheckOutDate)
VALUES (3, '2017-11-28', '2017-12-23');

UPDATE RESDATE SET CheckInDate = '2017-11-29' WHERE ResID = 3;

INSERT INTO CUSTOMER (CID, Street, ZIP, City, State)
VALUES (4, '1800 Acapulco Dr', '94806', 'San Pablo', 'CA');

INSERT INTO CUSTNAME (CustID, CName)
VALUES (4, 'Sean Murthy');

INSERT INTO RESERVATION (ResID, CID, RID)
VALUES (4, 4, 2);

INSERT INTO RESDATE (ResID, CheckInDate, CheckOutDate)
VALUES (4, '2017-03-21', '2017-03-30');

DELETE FROM RESDATE WHERE ResID = 4;
DELETE FROM RESERVATION WHERE CID = 4;

INSERT INTO CUSTOMER (CID, Street, ZIP, City, State)
VALUES (5, '7 Padanaram Rd', '06811', 'Danbury', 'CT');

INSERT INTO CUSTNAME (CustID, CName)
VALUES (5, 'Water Bottle');

INSERT INTO RESERVATION (ResID, CID, RID)
VALUES (5, 5, 1);

INSERT INTO RESDATE (ResID, CheckInDate, CheckOutDate)
VALUES (5, '2017-07-13', '2017-08-11');

INSERT INTO CUSTOMER (CID, Street, ZIP, City, State)
VALUES (6, '51 Area Ave', '00000', 'Somewhere', 'AR');

INSERT INTO CUSTNAME (CustID, CName)
VALUES (6, 'Rick Morty');

INSERT INTO RESERVATION (ResID, CID, RID)
VALUES (6, 6, 3);

INSERT INTO RESDATE (ResID, CheckInDate, CheckOutDate)
VALUES (6, '2017-07-10', '2017-07-25');

UPDATE CUSTOMER SET City = 'Nowhere' WHERE CID = 6;

DELETE FROM RESDATE WHERE RESID = 3;
DELETE FROM Reservation WHERE CID = 3;

INSERT INTO CUSTOMER (CID, Street, ZIP, City, State)
VALUES (7, '1 Two Three Rd', '12345', 'Numbers', 'OH');

INSERT INTO CUSTNAME (CustID, CName)
VALUES (7, 'Naruto Uzumaki');

INSERT INTO CUSTOMER (CID, Street, ZIP, City, State)
VALUES (8, '350 5th Ave', '10118', 'New York', 'NY');

INSERT INTO RESERVATION (ResID, CID, RID)
VALUES (7, 7, 3);

INSERT INTO CUSTNAME (CustID, CName)
VALUES (8, 'Beyonce Knowles');

INSERT INTO RESERVATION (ResID, CID, RID)
VALUES (8, 8, 2);

INSERT INTO RESDATE (ResID, CheckInDate, CheckOutDate)
VALUES (8, '2018-01-01', '2018-01-31');

INSERT INTO RESDATE (ResID, CheckInDate, CheckOutDate)
VALUES (7, '2017-11-10', '2017-12-09');

INSERT INTO CUSTOMER (CID, Street, ZIP, City, State)
VALUES (9, '14 Valerie Ln', '06810', 'Danbury', 'CT');

INSERT INTO CUSTNAME (CustID, CName)
VALUES (9, 'Edgar F. Codd');

INSERT INTO CUSTOMER (CID, Street, ZIP, City, State)
VALUES (10, '100 Passing St', '94765', 'Oakland', 'CA');

INSERT INTO CUSTNAME (CustID, CName)
VALUES (10, 'Barack Obama');

INSERT INTO RESERVATION (ResID, CID, RID)
VALUES (9, 9, 3);
INSERT INTO RESERVATION (ResID, CID, RID)
VALUES (10, 10, 1);

INSERT INTO RESDATE (ResID, CheckInDate, CheckOutDate)
VALUES (9, '2017-12-15', '2018-01-02');
INSERT INTO RESDATE (ResID, CheckInDate, CheckOutDate)
VALUES (10, '2017-06-06', '2017-07-04');

-- Report for how often a room is rented, showing most popular first
CREATE VIEW Popularity AS
(
	SELECT DISTINCT RE.rid, R.RType
	FROM Reservation RE JOIN Room R ON RE.rid = R.roomnum
	ORDER BY RE.rid DESC
);

-- View to be used in bill generation
CREATE VIEW DaysIn AS
(
	SELECT RES.ResID, date_part('days', age(RD.CheckOutDate, RD.CheckInDate)) AS Days
	FROM Reservation RES JOIN ResDate RD ON RES.ResID = RD.ResID
);


-- Report that shows a customer's bill
CREATE VIEW BillAmt AS
(
	SELECT RES.ResID, R.RType, R.TypePrice, 
		D.Days, CAST((R.TypePrice * D.Days) AS NUMERIC(5,2)) AS BILL
	FROM Reservation RES 
	JOIN DaysIn D ON RES.ResID = D.ResID
	JOIN Room R ON R.RoomNum = RES.RID
	ORDER BY RES.ResID
);




\qecho -------------------------------
\qecho End of script

--turn off spooling
\o