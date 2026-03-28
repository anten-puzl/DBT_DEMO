with CTE as (
    select 
        t.*, 
        w.* from {{ ref('trip_fact') }} t
    left join {{ ref('daily_weather') }} w
        on t.trip_date = w.daily_date
  --  where t.trip_date >= '2018-01-01' and t.trip_date <= '2018-12-31'
)

select *
from CTE
