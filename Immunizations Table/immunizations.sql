----Count total immunizations given
select count(*)  as total_immunization from immunizations
--It is 1549
==========================================================

----Top 5 most common vaccines

select description as vac_name,count(*) as most_common from immunizations
group by description
order by most_common desc
limit 5
===========================================================================

----Patients who received an influenza vaccine

select distinct patient,description from immunizations
where description ilike '%influenza%'
=========================================================

----Patients who received more than 3 different vaccines
select patient,total_various_vac from(

select patient,count(distinct description)as total_various_vac from immunizations
group by patient
) sub
where total_various_vac >3
order by total_various_vac desc
======================================================================================

----Compute age at immunization

select p.id as patient_id,
extract(year from(age(i.immunization_date,p.birthdate)))as age_at_imm,gender
from patients p
left join immunizations i
on p.id=i.patient
order by age_at_imm

----Age group distribution

select p.id as patient_id,gender,
case
   when extract(year from(age(i.immunization_date,p.birthdate)))<5 then '0-4'
   when extract(year from(age(i.immunization_date,p.birthdate)))between 5 and 17 then '5-17'
   else '18+'
end as age_group
from patients p
left join immunizations i
on p.id=i.patient
order by age_group

----Gender breakdown by age group

select gender,
case
   when extract(year from(age(i.immunization_date,p.birthdate)))<5 then '0-4'
   when extract(year from(age(i.immunization_date,p.birthdate)))between 5 and 17 then '5-17'
   else '18+'
end as age_group,
count(distinct p.id)
from patients p
left join immunizations i
on p.id=i.patient
group by gender,age_group
order by age_group,gender

----For each patient, show their first vaccination date and latest vaccination date

select distinct patient, 
       min(immunization_date) as first_vac,
	   max(immunization_date)as latest_vac 
from immunizations
group by patient
order by first_vac 

----Average age by vaccine

select round(avg(extract(year from (age(i.immunization_date,p.birthdate)))),0) as avg_age_pervac,
       description as vac_name
from patients p
left join immunizations i
on p.id=i.patient
group by description
order by avg_age_pervac; 
=========================================================================================================       









