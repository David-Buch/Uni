-- when not every thing is always up to date

select name, a.popcount from countries, (select t.ckey , t.popcount from (
	select * from popbycitizenship order by popdate asc) as t
	where (select dkey from districts where name = 'Jakomini') = dkey and popdate <= '2022-01-01') as a
	Where countries.ckey = a.ckey and eustatus = 'N-EU';

-- otherwise

select name, a.popcount from countries, (select ckey , popcount from popbycitizenship
	where (select dkey from districts where name = 'Jakomini') = dkey and popdate = '2022-01-01') as a
	Where countries.ckey = a.ckey and eustatus = 'N-EU';
