--Matheus Alexandre; CS205-01, Fall 2017

--create9.sql

--Script to create tables for Term Project 01: Room House


--Spool results to a file in the current directory
\o spoolCreate9.txt


--Echo the date and time the script is run
\qecho -n 'Script run on '
\qecho -n `date /t`
\qecho -n 'at '
\qecho -n `time /t`
\qecho -n ' by '
\qecho :USER
\qecho ' '

CREATE TABLE IF NOT EXISTS Customer_t
(
	CID 			SERIAL NOT NULL PRIMARY KEY, 
	CName			VARCHAR(30) NOT NULL,
	Street			VARCHAR(50) NOT NULL, 
	ZIP			VARCHAR(10) NOT NULL,
	City			VARCHAR(20) NOT NULL,
	State			CHAR(2) NOT NULL 
);
\qecho 'Customer_t'

CREATE TABLE IF NOT EXISTS Room_t
(
	RoomNum			INTEGER NOT NULL PRIMARY KEY,
	RoomType		VARCHAR(10) NOT NULL
);
\qecho 'Room_t'

CREATE TABLE IF NOT EXISTS Type_t
(
	TName			VARCHAR(10) NOT NULL PRIMARY KEY,
	TPrice			NUMERIC(6, 2) NOT NULL 
);

\qecho 'Type_t'

CREATE TABLE IF NOT EXISTS Reservation_t
(
	ResID			SERIAL NOT NULL PRIMARY KEY, 
	CID			INTEGER NOT NULL REFERENCES Customer_t(CID), 
	RID			INTEGER NOT NULL REFERENCES Room_t(RoomNum),
	CheckInDate		DATE DEFAULT CURRENT_DATE NOT NULL, 
	CheckOutDate		DATE DEFAULT CURRENT_DATE NOT NULL
);
\qecho 'Reservation_t'



-- Views created for reports and derived attributes --
--
--
--
-- Report for how often a room is rented, 
-- showing most popular first (Popularity derived attribute)

CREATE VIEW Popularity_v AS
(
	SELECT DISTINCT RE.RID, R.RoomType
	FROM Reservation_t RE 
	JOIN Room_t R ON RE.RID = R.RoomNum
);
\qecho 'Popularity_v'

-- View to be used in bill generation (DaysIn derived attribute)

CREATE VIEW DaysIn_v AS
(
	SELECT ResID, date_part('days', age(CheckOutDate, CheckInDate)) AS Days
	FROM Reservation_t
);
\qecho 'DaysIn_v'


-- Report that shows a customer's bill (BillAmt derived attribute)

CREATE VIEW BillAmt_v AS
(
	SELECT C.CName, C.Street, C.ZIP, C.City, C.State, RES.CheckInDate, 
		CAST((T.TPrice * D.Days) AS NUMERIC(5,2)) AS BILL
	FROM Reservation_t RES 
	JOIN DaysIn_v D ON RES.ResID = D.ResID
	JOIN Room_t R ON R.RoomNum = RES.RID
	JOIN Type_t T ON T.TName = R.RoomType
	JOIN Customer_t C ON C.CName = RES.CID
	ORDER BY RES.ResID
);
\qecho 'BillAmt_v'


\qecho ----------------------------
\qecho End of script

--Turn off spooling
\o


	