with raw_data as (
    select 
        to_timestamp(trim(STARTED_AT, '"'), 'YYYY-MM-DD HH24:MI:SS.FF') as cleaned_started_at
    from {{ source('demo', 'bike') }}
    where trim(lower(STARTED_AT), '"') not in ('started_at', 'starttime')
),

CTE as (
    select
        cleaned_started_at as STARTED_AT,
        date(cleaned_started_at) as DATE_STARTED_AT,
        hour(cleaned_started_at) as HOUR_STARTED_AT,
        dayname(cleaned_started_at) as DAY_NAME,
        {{ daytype('cleaned_started_at') }} as DAY_TYPE,
        {{ get_season('cleaned_started_at') }} as SEASON_OF_YEAR
    from raw_data
)

select * from CTE