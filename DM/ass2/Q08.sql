select b1.name, b2.name, c.popdate ,c.popcount, c.gender from (
	select * from districts) as b1, (
	select * from districts) as b2, (select a1.dkey as key1, a2.dkey as key2, a1.popdate ,a1.popcount, a1.gender from 
	popbygender as a1 Join popbygender as a2 
	ON a1.dkey < a2.dkey and a1.popdate = a2.popdate and a1.popcount = a2.popcount and a1.gender = a2.gender) as c
	where b1.dkey = c.key1 and b2.dkey = c.key2;