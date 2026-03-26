WITH daily_weather AS (
    SELECT 
        DATE(time) AS daily_date,
        weather,
        temp,
        pressure,
        humidity,
        clouds
    FROM {{ source('demo', 'weather') }}
),

daily_weather_agg AS (
    SELECT 
        daily_date,
        weather,
        ROUND(AVG(temp), 2) AS avg_temp,
        ROUND(AVG(pressure), 2) AS avg_pressure,
        ROUND(AVG(humidity), 2) AS avg_humidity,
        ROUND(AVG(clouds), 2) AS avg_clouds,
        COUNT(weather) AS count_occurrence
    FROM daily_weather
    GROUP BY daily_date, weather
    -- Оставляем только ту погоду, которая была чаще всего в этот день
    QUALIFY ROW_NUMBER() OVER (PARTITION BY daily_date ORDER BY COUNT(weather) DESC) = 1
)

SELECT * FROM daily_weather_agg


