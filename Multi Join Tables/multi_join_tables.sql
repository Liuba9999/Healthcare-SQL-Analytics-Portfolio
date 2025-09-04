----Calculate the average number of encounters per patient

select  round(avg(sub.total_encounters),0) as avg_encounter_per_patient
from(

select p.id as patient,count(e.id) as total_encounters from patients p
left join encounters e
on p.id=e.patient
group by p.id) sub;
=============================================================================

----Find the age of patients at their first diabetes diagnosis

select sub.patient,
extract(year from (age(sub.first_patient_diagnosis,p.birthdate)))as patient_age

from
(select patient,min(start)as first_patient_diagnosis
from conditions
where description ilike'%diabetes%'
group by patient) sub 
inner join patients p
on sub.patient=p.id
order by patient_age
================================================================================

----For each encounter with a diabetes diagnosis, list all immunizations the patient got during the same
-- encounter

select distinct c.patient,c.encounter,i.immunization_date,i.description as vac_name
from conditions c
inner join immunizations i
on c.encounter=i.encounter
where c.description ilike'%diabetes%' 
group by c.patient,c.encounter,i.immunization_date,i.description

======================================================================================

----Find patients who had an encounter within 7 days after receiving an immunization

select distinct e.patient,
       i.immunization_date,
	   i.immunization_date+7 as week_after_vac,
	   e.start,
	   e.description
from immunizations i
inner join encounters e
on i.patient=e.patient
and e.start between i.immunization_date and  i.immunization_date+7
order by e.start
=======================================================================================

----Find the top 5 most frequent condition descriptions recorded during encounters where an
-- immunization was also given

select  c.description as diagnose,count(*) from conditions c
inner join immunizations i
on c.encounter=i.encounter
group by c.description
order by count(*) desc
limit 5
==============================================================================================

