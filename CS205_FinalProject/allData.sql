--Matheus Alexandre; CS205-01, Fall 2017

--allData.sql 

--Script that shows all data in Term Project 01: Room House


--Spool results to a file in the current directory
\o spoolAllData.txt

--Echo the date and time the script is run
\qecho -n 'Script run on '
\qecho -n `date /t`
\qecho -n 'at '
\qecho -n `time /t`
\qecho -n ' by '
\qecho :USER
\qecho ' '

\qecho 'Customer_t:'
SELECT * FROM Customer_t;
\qecho 'Reservation_t:'
SELECT * FROM Reservation_t;
\qecho 'Room_t:'
SELECT * FROM Room_t;
\qecho 'Type_t:'
SELECT * FROM Type_t;
\qecho 'Popularity_v:'
SELECT * FROM Popularity_v;
\qecho 'DaysIn_v:'
SELECT * FROM DaysIn_v;
\qecho 'BillAmt_v:'
SELECT * FROM BillAmt_v; 

\qecho ----------------------------
\qecho End of script

--Turn off spooling
\o