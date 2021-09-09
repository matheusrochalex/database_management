--Matheus Alexandre; CS205-01, Fall 2017

--userOps2.sql

--Script to create tables for Term Project 01: Room House

--Spool results to a file in the current directory
\o spoolUserOps2.txt


--Echo the date and time the script is run
\qecho -n 'Script run on '
\qecho -n `date /t`
\qecho -n 'at '
\qecho -n `time /t`
\qecho -n ' by '
\qecho :USER
\qecho ' '


--Clear all existing data
DELETE FROM Customer_t CASCADE;
DELETE FROM Room_t CASCADE;
DELETE FROM Type_t CASCADE;
DELETE FROM Reservation_t CASCADE;


-- not inserted by users, already preset for reservation purposes
INSERT INTO Room_t (RoomNum, RoomType)
VALUES (1, 'Suite');
INSERT INTO Room_t (RoomNum, RoomType)
VALUES (2, 'Double');
INSERT INTO Room_t (RoomNum, RoomType)
VALUES (33, 'Sigle');

-- whoops, pretending a mistake was made
UPDATE Room_t SET RoomNum = 3 WHERE RoomNum = 033;
UPDATE Room_t SET RoomType = 'Single' WHERE RoomNum = 3;

INSERT INTO Room_t (RoomNum, RoomType)
VALUES (4, 'Single');
INSERT INTO Room_t (RoomNum, RoomType)
VALUES (5, 'Double');
INSERT INTO Room_t (RoomNum, RoomType)
VALUES (6, 'Suite');
INSERT INTO Room_t (RoomNum, RoomType)
VALUES (7, 'Double');

INSERT INTO Type_t (TName, TPrice)
VALUES ('Suite', 7.00);
INSERT INTO Type_t (TName, TPrice)
VALUES ('Double', 3.00);
INSERT INTO Type_t (TName, TPrice)
VALUES ('Single', 5.0);


-- user operations
INSERT INTO Customer_t (CName, Street, ZIP, City, State)
VALUES ('Mathes Alexandre', '151 White Street', '06811', 'Danbury', 'CT');

SELECT * FROM Customer_t;

--whoops
UPDATE Customer_t SET CName = 'Matheus Alexandre' WHERE CName = 'Mathes Alexandre';

SELECT * FROM Customer_t;

INSERT INTO Customer_t (CName, Street, ZIP, City, State)
VALUES ('Lil Git', '122 Tower Rd', '06804', 'Brookfield', 'CT');

INSERT INTO Reservation_t (CID, RID, CheckInDate, CheckOutDate)
VALUES (2, 2, '2017-01-02', '2017-02-01');

SELECT * FROM Reservation_t;

INSERT INTO Reservation_t (CID, RID, CheckInDate, CheckOutDate)
VALUES (1, 1, '2017-10-28', '2017-11-12');

SELECT * FROM Reservation_t
WHERE CID = 2;

--whoops
UPDATE Reservation_t SET RID = 2 WHERE CID = 2;

SELECT * FROM Reservation_t
WHERE CID = 2;

INSERT INTO Customer_t (CName, Street, ZIP, City, State)
VALUES ('Chutzpah Roc', '103 Eagle St', '06607', 'Bridgeport', 'CT');

INSERT INTO Reservation_t (CID, RID, CheckInDate, CheckOutDate)
VALUES (3, 3, '2017-11-28', '2017-12-23');

UPDATE Reservation_t SET CheckInDate = '2017-11-29' WHERE CID = 3;

INSERT INTO Customer_t (CName, Street, ZIP, City, State)
VALUES ('Sean Murthy', '1800 Acapulco Dr', '94806', 'San Pablo', 'CA');

INSERT INTO Reservation_t (CID, RID, CheckInDate, CheckOutDate)
VALUES (4, 4, '2017-03-21', '2017-03-30');

--cancelling reservation
DELETE FROM Reservation_t WHERE CID = 4;

--check if deleted
SELECT * FROM Reservation_t WHERE CID = 4;

INSERT INTO Customer_t (CName, Street, ZIP, City, State)
VALUES ('Water Bottle', '7 Padanaram Rd', '06811', 'Danbury', 'CT');

INSERT INTO Reservation_t (CID, RID, CheckInDate, CheckOutDate)
VALUES (5, 6, '2017-07-13', '2017-08-11');

INSERT INTO Customer_t (CName, Street, ZIP, City, State)
VALUES ('Rick Morty', '51 Area Ave', '00000', 'Somewhere', 'AR');

INSERT INTO Reservation_t (CID, RID, CheckInDate, CheckOutDate)
VALUES (6, 5, '2017-07-10', '2017-07-25');

--whoops
UPDATE Customer_t SET City = 'Nowhere' WHERE CID = 6;

--check if mistake was fixed
SELECT * FROM Customer_t WHERE CID = 6;

--cancelling reservation
DELETE FROM Reservation_t WHERE CID = 3;

--check if reservation was cancelled
SELECT * FROM Reservation_t WHERE CID = 3;

INSERT INTO Customer_t (CName, Street, ZIP, City, State)
VALUES ('Naruto Uzumaki', '1 Two Three Rd', '12345', 'Numbers', 'OH');

INSERT INTO Customer_t (CName, Street, ZIP, City, State)
VALUES ('Beyonce Knowles', '350 5th Ave', '10118', 'New York', 'NY');

INSERT INTO Reservation_t (CID, RID, CheckInDate, CheckOutDate)
VALUES (7, 5, '2017-11-10', '2017-12-09');

INSERT INTO Reservation_t (CID, RID, CheckInDate, CheckOutDate)
VALUES (8, 4, '2018-01-01', '2018-01-31');

INSERT INTO Customer_t (CName, Street, ZIP, City, State)
VALUES ('Edgar F. Codd', '14 Valerie Ln', '06810', 'Danbury', 'CT');

INSERT INTO Customer_t (CName, Street, ZIP, City, State)
VALUES ('Barack Obama', '100 Passing St', '94765', 'Oakland', 'CA');

INSERT INTO Reservation_t (CID, RID, CheckInDate, CheckOutDate)
VALUES (9, 7, '2017-12-15', '2018-01-02');
INSERT INTO Reservation_t (CID, RID, CheckInDate, CheckOutDate)
VALUES (10, 7, '2017-06-06', '2017-07-04');

--check if obama and edgar f. codd are in the same room
SELECT * FROM Reservation_t WHERE RID = 7; 


\qecho -------------------------------
\qecho End of script

--turn off spooling
\o