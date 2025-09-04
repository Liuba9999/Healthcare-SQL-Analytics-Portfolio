========================================================                                                 
--alter table encounters                          
--add constraint encounters_pkey  primary key(id);
========================================================
----Count total encounters

select count(*) as total_encounters
from encounters 
--total_encounters=5924
========================================================

----Find average, max and min encounters per pateints

select round(avg(total_encounters),0) as avg_encounters_per_p,
max(total_encounters) as p_most_encounters,
min(total_encounters)as p_min_encounters
from
(select patient,count(id) as total_encounters
from encounters
group by patient
order by total_encounters desc)
================================================================

----Count encounters by ENCOUNTERCLASS

select encounterclass,count(*) from encounters
group by encounterclass
order by count(*) desc
==============================================================

----Find average encounter length(START-STOP)

select round(avg((stop-start)*24),1) as avg_length_encouner 
from encounters
where stop is not null and start is not null
----average length encounter is 4.7 hrs
================================================================

----Find numbers of encounters per year

select extract(year from start) as year_encounter,count(*) as number_per_year
from encounters
group by year_encounter
order by year_encounter desc
=========================================================================================

----Top 5 most common encounter descriptions

select description,count(*)  from encounters
group by description
order by count(*) desc
limit 5
===============================================


