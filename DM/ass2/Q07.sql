/*
select ckey, popdate, Max(sCount) from (select ckey, popdate, sum(popcount) as sCount from popbycitizenship 
group by ckey, popdate) as a group by ckey,popdate


select ckey, popdate, popcount
from popbycitizenship
where popcount = (select max(popcount) from popbycitizenship)
union all
select ckey, popdate,popcount
from popbycitizenship
where popcount = (select min(popcount) from popbycitizenship);

-- gets the max of all the ckey's per ckey
SELECT a.ckey, a.popdate, a.sCount 
from (select ckey, popdate, sum(popcount) as sCount from popbycitizenship 
group by ckey, popdate) as a 
INNER JOIN
    (SELECT ckey,MAX(b.sCount) AS MaxPopCount
    from (select ckey, popdate, sum(popcount) as sCount from popbycitizenship 
	group by ckey,popdate) as b
    group by ckey) as c
ON a.ckey = c.ckey 
AND a.sCount = c.MaxPopCount
order by ckey, popdate desc

-- min and max in one table
select maxValues.ckey, maxValues.popdate, maxValues.MaxCount, minValues.popdate, minValues.MinCount
from (
SELECT a.ckey, a.popdate, a.MaxCount 
from (select ckey, popdate, sum(popcount) as MaxCount from popbycitizenship 
group by ckey, popdate) as a 
INNER JOIN
    (SELECT ckey,MAX(b.MaxCount) AS MaxPopCount
    from (select ckey, popdate, sum(popcount) as MaxCount from popbycitizenship 
	group by ckey,popdate) as b
    group by ckey) as c
ON a.ckey = c.ckey 
AND a.MaxCount = c.MaxPopCount) as maxValues
Join (
select ckey, popdate, MinCount
from (
SELECT a.ckey, a.popdate, a.MinCount 
from (select ckey, popdate, sum(popcount) as MinCount from popbycitizenship 
group by ckey, popdate) as a 
INNER JOIN
    (SELECT ckey,MIN(b.MinCount) AS MinPopCount
    from (select ckey, popdate, sum(popcount) as MinCount from popbycitizenship 
	group by ckey,popdate) as b
    group by ckey) as c
ON a.ckey = c.ckey 
AND a.MinCount = c.MinPopCount) as minV) as minValues
ON maxValues.ckey = minValues.ckey

*/
-- comblied i guess
select name, maxValues.popdate, maxValues.MaxCount, minValues.popdate, minValues.MinCount, 
(maxValues.MaxCount - minValues.MinCount) as diff
from countries, 
(SELECT a.ckey, a.popdate, a.MaxCount 
from (select ckey, popdate, sum(popcount) as MaxCount from popbycitizenship 
group by ckey, popdate) as a 
INNER JOIN
    (SELECT ckey,MAX(b.MaxCount) AS MaxPopCount
    from (select ckey, popdate, sum(popcount) as MaxCount from popbycitizenship 
	group by ckey,popdate) as b
    group by ckey) as c
ON a.ckey = c.ckey 
AND a.MaxCount = c.MaxPopCount) as maxValues
Join (
select ckey, popdate, MinCount
from (
SELECT a.ckey, a.popdate, a.MinCount 
from (select ckey, popdate, sum(popcount) as MinCount from popbycitizenship 
group by ckey, popdate) as a 
INNER JOIN
    (SELECT ckey,MIN(b.MinCount) AS MinPopCount
    from (select ckey, popdate, sum(popcount) as MinCount from popbycitizenship 
	group by ckey,popdate) as b
    group by ckey) as c
ON a.ckey = c.ckey 
AND a.MinCount = c.MinPopCount) as minV) as minValues
ON maxValues.ckey = minValues.ckey
where countries.ckey = maxValues.ckey and maxValues.MaxCount - minValues.MinCount > 0
order by diff desc limit 10