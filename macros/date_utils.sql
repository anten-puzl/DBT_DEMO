{% macro get_season(STARTED_AT) %}
CASE WHEN MONTH(to_timestamp(STARTED_AT)) in (12,1,2)
    THEN 'WINTER'
    WHEN MONTH(to_timestamp(STARTED_AT)) in (3,4,5)
    THEN 'SPRING'
    WHEN MONTH(to_timestamp(STARTED_AT)) in (6,7,8)
    THEN 'SUMMER'
    ELSE 'AUTUMN' END 
{% endmacro %}

{%macro daytype(STARTED_AT)%}
CASE
WHEN DAYNAME(to_timestamp(STARTED_AT)) in ('Sat','Sun')
THEN 'WEEKEND'
ELSE 'BUISNESSDAY'
END
{%endmacro%}