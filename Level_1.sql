select staff_name, pod_group, weight_kg
from crew 
where status != 'deceased';

select staff_name,
pod_group,
	case 
		when weight_kg > 10 then weight_kg
		when weight_kg < 10 then weight_kg * 10
end as fixed_weight
from filtered_crew;

SELECT 
  pod_group, 
  SUM(fixed_weight) AS total_weight
FROM fixed_crew
GROUP BY pod_group;

select pod_group, total_weight
from grouped_crew
where total_weight > 1000
order by total_weight desc;

--=========================

With
  filtered_crew as (
    select
      staff_name,
      pod_group,
      weight_kg
    from
      crew
    where
      status != 'deceased'
  )
,
  fixed_crew as (
    select
      staff_name,
      pod_group,
      case
        when weight_kg > 10 then weight_kg
        when weight_kg < 10 then weight_kg * 10
      end as fixed_weight
    from
      filtered_crew
    )
  ,
  grouped_crew as (
    SELECT
      pod_group,
      SUM(fixed_weight) AS total_weight
    FROM
      fixed_crew
    GROUP BY
      pod_group
  )
 
select
  pod_group,
  total_weight
from
  grouped_crew
where
  total_weight > 1000
order by
  total_weight desc;

select crew.staff_name, evacuation_groups.party_status
from crew
join evacuation_groups on crew.pod_group = evacuation_groups.pod_group 
where evacuation_groups.party_status != 'boarded';

select *
from original_crew
left join crew on original_crew.staff_id = crew.staff_id
where original_crew.staff_name is not null;

select *
from joined_crew
where last_location is null;

--===============================
With
  joined_crew as (
    select
      *
    from
      original_crew
      left join crew on original_crew.staff_id = crew.staff_id
    where
      original_crew.staff_name is not null
     
  )
  
select
  *
from
  joined_crew
where
  last_location is null

SELECT 
  staff_name, 
  GROUP_CONCAT(role, ', ') AS combined_roles
FROM staffing_changes
GROUP BY staff_name;
