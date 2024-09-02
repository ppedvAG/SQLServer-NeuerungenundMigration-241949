DECLARE @date date = '2023-08-15',
		@origin date = '2023-02-05';
SELECT 
   DATE_BUCKET(day, 1, @date, @origin) AS "1 day",
   DATE_BUCKET(day, 2, @date, @origin) AS "2 days",
   DATE_BUCKET(day, 3, @date, @origin) AS "3 days",
   DATE_BUCKET(QUARTER, 2, @date, @origin) AS "Quartal";

SELECT value
FROM GENERATE_SERIES(1, 10);

SELECT value
FROM GENERATE_SERIES(1, 50, 5);

DECLARE @start decimal(2, 1) = 0.0;
DECLARE @stop decimal(2, 1) = 1.0;
DECLARE @step decimal(2, 1) = 0.1;

SELECT value
FROM GENERATE_SERIES(@start, @stop, @step);


SELECT *
FROM GENERATE_SERIES(10,1);


SELECT DATEADD(DAY,value,Getdate()) FROM GENERATE_SERIES(0,364,1);

--Geschäftquartale
SELECT DATEADD(QUARTER,value,'1.7.2023') FROM GENERATE_SERIES(0,3,1);


--DATETRUNC


DECLARE @d datetime2 = '2021-12-08 11:30:15.1234567';
SELECT 'Year', DATETRUNC(year, @d);
SELECT 'Quarter', DATETRUNC(quarter, @d);
SELECT 'Month', DATETRUNC(month, @d);
SELECT 'Week', DATETRUNC(week, @d); -- Using the default DATEFIRST setting value of 7 (U.S. English)
SELECT 'Iso_week', DATETRUNC(iso_week, @d);
SELECT 'DayOfYear', DATETRUNC(dayofyear, @d);
SELECT 'Day', DATETRUNC(day, @d);
SELECT 'Hour', DATETRUNC(hour, @d);
SELECT 'Minute', DATETRUNC(minute, @d);
SELECT 'Second', DATETRUNC(second, @d);
SELECT 'Millisecond', DATETRUNC(millisecond, @d);
SELECT 'Microsecond', DATETRUNC(microsecond, @d);