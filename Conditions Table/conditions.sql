----Count total conditions recorded
select count(*)as total_conditions from conditions

======================================================

----Find top 10 most the common conditions
select description,count(*) from conditions
group by description
order by count(*) desc
limit 10
=======================================================

----Count how many patients have diabetes

select count(description) as total_with_diabetes
from conditions
where description like '%diabetes%'
==========================================================

----Find patients who have both diabetes and hypertension
with diabetes as(
     select distinct patient from conditions 
	 where description ilike'%diabetes%')
select distinct d.patient
from diabetes d
join conditions c
on d.patient=c.patient
where c.description ilike'%hypertension%'

----The same patients with descriptions

with diabetes as(
    select patient,description as diabetes_desc
	from conditions
	where description ilike '%diabetes%'
),
hypertension as(
    select patient,description as hypertension_desc
	from conditions
	where description ilike '%hypertension%'
)
select distinct d.patient,d.diabetes_desc,h.hypertension_desc
from diabetes d
inner join hypertension h
on d.patient=h.patient;
======================================================================

----Average age of patients with asthma

select  round(avg(extract(year from (age(birthdate)))),0) as avg_asthma_age from (
select distinct p.id,p.birthdate from patients p
inner join conditions c
on  p.id=c.patient
where description ilike '%asthma%'
) sub;
======================================================================================

----Count conditions per patients

select patient,count(description ) as condition_count 
from conditions
group by patient
order by condition_count desc
===============================================================================

----Patients with more than 3 chronic conditions

select patient,total_chronic
from(
select patient,count(description) as total_chronic
from conditions
where description ilike '%chronic%'
group by patient
) sub
where total_chronic > 3
order by total_chronic desc
=================================================================================


