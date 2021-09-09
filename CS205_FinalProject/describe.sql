--Matheus Alexandre; CS205-01, Fall 2017

--describe.sql 

--Script contains statements needed to describe each table for Term Project 01: Room House


--Spool results to a file in the current directory
\o spoolDescribe.txt


--Echo the date and time the script is run
\qecho -n 'Script run on '
\qecho -n `date /t`
\qecho -n 'at '
\qecho -n `time /t`
\qecho -n ' by '
\qecho :USER
\qecho ' '

\d Customer_t
\d Reservation_t
\d Room_t
\d Type_t
\d Popularity_v
\d DaysIn_v
\d BillAmt_v

\qecho ----------------------------
\qecho End of script

--Turn off spooling
\o