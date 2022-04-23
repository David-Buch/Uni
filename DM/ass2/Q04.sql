Select name, area, (select count(test.stkey) from (
	select dkey, streetdistricts.stkey from streetdistricts  join (select stkey from streetdistricts group by stkey having count(stkey) < 2) as t
	on streetdistricts.stkey = t.stkey )as test
					where test.dkey = districts.dkey) as streetcount
					from districts order by streetcount desc;


