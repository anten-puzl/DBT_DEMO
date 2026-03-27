with TRIPS as (
    select
    RIDE_ID,
    RIDEABLE_TYPE,
    to_timestamp(started_at) as trip_date,
    start_statio_id as START_STATION_ID,
    END_STATION_ID,
    MEMBER_CSUAL AS MEMBER_CASUAL,
    TIMESTAMPDIFF(SECOND,to_timestamp(STARTED_AT),to_timestamp(ENDED_AT)) AS TRIP_DURATION_SECONDS
    from {{ source('demo', 'bike') }}
    where ride_id <> 'ride_id'
    limit 10
)
select * from TRIPS