select name, t.count from districts, (
			  select dkey, count(distinct ckey) as count
			  from popbycitizenship where popdate 
			  between '2010-01-01' and '2014-12-31' group by dkey) as t 
		where t.dkey = districts.dkey order by t.count desc;