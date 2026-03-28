with BIKE as (
    select
    distinct 
    START_STATIO_ID as station_id,
    START_STATION_NAME as station_name, 
    start_lat as staion_lat,
    start_lng as staion_lng
    from {{ source('demo', 'bike') }}
    where ride_id <> 'ride_id'
)

select 
  * 
from BIKE