--Matheus Alexandre; CS205-01, Fall 2017

--create8.sql

--Script to create tables for Term Project 01: Room House


--Spool results to a file in the current directory
\o spoolCreate8.txt


--Echo the date and time the script is run
\qecho -n 'Script run on '
\qecho -n `date /t`
\qecho -n 'at '
\qecho -n `time /t`
\qecho -n ' by '
\qecho :USER
\qecho ' '

CREATE TABLE IF NOT EXISTS Customer
(
	CID 			NUMERIC(6, 0) NOT NULL PRIMARY KEY, 
	Street			VARCHAR(50) NOT NULL, 
	ZIP			VARCHAR(10) NOT NULL,
	City			VARCHAR(20) NOT NULL,
	State			CHAR(2) NOT NULL 
);

CREATE TABLE IF NOT EXISTS CustName
(
	CustID 			NUMERIC(6, 0) NOT NULL PRIMARY KEY REFERENCES Customer(CID),
	CName			VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS Room
(
	RoomNum			NUMERIC(2, 0) NOT NULL PRIMARY KEY,
	RType			VARCHAR(10) NOT NULL,
	TypePrice		NUMERIC(6, 2) NOT NULL
);

CREATE TABLE IF NOT EXISTS Reservation
(
	ResID			NUMERIC(5, 0) NOT NULL PRIMARY KEY, 
	CID			NUMERIC(6, 0) NOT NULL REFERENCES Customer(CID), 
	RID			NUMERIC(2, 0) NOT NULL REFERENCES Room(RoomNum)
);

CREATE TABLE IF NOT EXISTS ResDate
(
	ResID			NUMERIC(5, 0) NOT NULL PRIMARY KEY REFERENCES Reservation(ResID), 
	CheckInDate		DATE DEFAULT CURRENT_DATE NOT NULL, 
	CheckOutDate		DATE DEFAULT CURRENT_DATE NOT NULL
);


\qecho ----------------------------
\qecho End of script

--Turn off spooling
\o


	