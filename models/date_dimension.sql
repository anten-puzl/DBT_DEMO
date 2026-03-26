WITH CTE as (
    select
to_timestamp(STARTED_AT) AS STARTED_AT,
DATE(to_timestamp(STARTED_AT)) AS DATE_STARTED_AT,
HOUR(to_timestamp(STARTED_AT)) AS HOUR_STARTED_AT,
DAYNAME(to_timestamp(STARTED_AT)),
CASE
WHEN DAYNAME(to_timestamp(STARTED_AT)) in ('Sat','Sun')
THEN 'WEEKEND'
ELSE 'BUISNESSDAY'
END AS DAY_TYPE,
CASE WHEN MONTH(to_timestamp(STARTED_AT)) in (12,1,2)
    THEN 'WINTER'
    WHEN MONTH(to_timestamp(STARTED_AT)) in (3,4,5)
    THEN 'SPRING'
    WHEN MONTH(to_timestamp(STARTED_AT)) in (6,7,8)
    THEN 'SUMMER'
    ELSE 'AUTUMN' END AS STATION_OF_YEAR


from {{ source('demo', 'bike') }}
where STARTED_AT != 'started_at'
)

select
*
from CTE