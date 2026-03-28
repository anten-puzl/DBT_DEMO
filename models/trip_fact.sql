with TRIPS as (
    select
        RIDE_ID,
        -- 1. Убираем кавычки через TRIM
        -- 2. Преобразуем в timestamp с учетом миллисекунд (.FF)
        -- 3. Отрезаем время через ::date
        to_timestamp(trim(STARTED_AT, '"'), 'YYYY-MM-DD HH24:MI:SS.FF')::date as TRIP_DATE,
        
        START_STATIO_ID as START_STATION_ID,
        END_STATION_ID,
        MEMBER_CSUAL as MEMBER_CASUAL,
        
        -- Повторяем очистку для расчета секунд
        timestampdiff(
            second, 
            to_timestamp(trim(STARTED_AT, '"'), 'YYYY-MM-DD HH24:MI:SS.FF'), 
            to_timestamp(trim(ENDED_AT, '"'), 'YYYY-MM-DD HH24:MI:SS.FF')
        ) as TRIP_DURATION_SECONDS
        
    from {{ source('demo', 'bike') }}
    
    where RIDE_ID <> 'ride_id'
    limit 10
)

select * from TRIPS