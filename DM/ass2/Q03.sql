SELECT Name, area, round(area * 100 / (select sum(area) FROM districts),2) AS relativSum
FROM districts;

--check with round, otherwise user 
--https://stackoverflow.com/questions/10380197/rounding-off-to-two-decimal-places-in-sql