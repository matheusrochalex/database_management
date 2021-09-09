--Matheus Alexandre; CS205-01, Fall 2017

--drop6.sql 

--Script to drop tables for Term Project 01: Room House


--Spool results to a file in the current directory
\o spoolDrop6.txt


--Echo the date and time the script is run
\qecho -n 'Script run on '
\qecho -n `date /t`
\qecho -n 'at '
\qecho -n `time /t`
\qecho -n ' by '
\qecho :USER
\qecho ' '

DROP TABLE IF EXISTS Customer CASCADE;
\qecho Customer
DROP TABLE IF EXISTS CustName CASCADE;
\qecho CustName
DROP TABLE IF EXISTS Room CASCADE;
\qecho Room
DROP TABLE IF EXISTS Reservation CASCADE;
\qecho Reservation
DROP TABLE IF EXISTS ResDate CASCADE;
\qecho ResDate

\qecho ----------------------------
\qecho End of script

--Turn off spooling
\o