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

