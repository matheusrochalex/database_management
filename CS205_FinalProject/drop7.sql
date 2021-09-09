--Matheus Alexandre; CS205-01, Fall 2017

--drop7.sql 

--Script to drop tables for Term Project 01: Room House


--Spool results to a file in the current directory
\o spoolDrop7.txt


--Echo the date and time the script is run
\qecho -n 'Script run on '
\qecho -n `date /t`
\qecho -n 'at '
\qecho -n `time /t`
\qecho -n ' by '
\qecho :USER
\qecho ' '

DROP TABLE IF EXISTS Customer_t CASCADE;
\qecho 'Customer_t'
DROP TABLE IF EXISTS Reservation_t CASCADE;
\qecho 'Reservation_t'
DROP TABLE IF EXISTS Room_t CASCADE;
\qecho 'Room_t'
DROP TABLE IF EXISTS Type_t CASCADE;
\qecho 'Type_t'
DROP VIEW Popularity_v;
\qecho 'Popularity_v'
DROP VIEW DaysIn_v;
\qecho 'DaysIn_v'
DROP VIEW BillAmt_v;
\qecho 'BillAmt_v'

\qecho ----------------------------
\qecho End of script

--Turn off spooling
\o