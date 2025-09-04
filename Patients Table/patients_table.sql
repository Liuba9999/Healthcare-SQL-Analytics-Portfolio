--Count patients by race, gender, ethnicity

select 'race' as category, race as value,count(id) from patients
group by race 

union all

select 'gender',gender,count(id) from patients
group by gender 

union all

select 'ethnicity',ethnicity,count(id) from patients
group by ethnicity

===========================================================

----Calculate average age of patients

select round(avg(extract(year from(age(birthdate)))),0) as avg_patient_age
from patients
where deathdate is null

===================================================================

----Create age group distributions

select birthdate,
case 
    when extract(year from(age(birthdate)))<18 then 'Child'
	when extract(year from(age(birthdate)))between 19 and 39 then 'Young Adult'
	when extract(year from(age(birthdate)))between 40 and 60 then 'Adult'
	else 'Senior'
end as age_group
from patients

----Number patients per each age group
select 
(case 
    when extract(year from(age(birthdate)))between 0 and 18 then 'Child (0-18)'
	when extract(year from(age(birthdate)))between 19 and 39 then 'Young Adult (19-39)'
	when extract(year from(age(birthdate)))between 40 and 60 then 'Adult (40-60)'
	else 'Senior (60+)'
end ) as age_group,count(*) as patient_count
from patients
where deathdate is null
group by (case
    when extract(year from(age(birthdate)))between 0 and 18 then 'Child (0-18)'
	when extract(year from(age(birthdate)))between 19 and 39 then 'Young Adult (19-39)'
	when extract(year from(age(birthdate)))between 40 and 60 then 'Adult (40-60)'
	else 'Senior (60+)'
end )
order by patient_count desc

=========================================================================================

----Find patients who are deceased

select id,state,race,gender
from patients
where deathdate is not null
order by gender

========================================================================




