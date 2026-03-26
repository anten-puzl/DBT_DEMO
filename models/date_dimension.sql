WITH CTE as (
    select
to_timestamp(STARTED_AT) AS STARTED_AT,
DATE(to_timestamp(STARTED_AT)) AS DATE_STARTED_AT,
HOUR(to_timestamp(STARTED_AT)) AS HOUR_STARTED_AT,
DAYNAME(to_timestamp(STARTED_AT)),
{{daytype('STARTED_AT')}} as DAY_TYPE,
{{get_season('STARTED_AT')}} AS STATION_OF_YEAR


from {{ source('demo', 'bike') }}
where STARTED_AT != 'started_at'
)

select
*
from CTE