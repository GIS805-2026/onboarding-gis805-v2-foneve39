-- S02 - Dimension date
-- Une ligne = une date du calendrier analytique.

CREATE OR REPLACE TABLE dim_date AS
SELECT
    CAST(date_key AS DATE) AS date_key,
    year,
    quarter,
    month,
    month_name,
    week_iso,
    day_of_week,
    day_name,
    is_weekend
FROM raw_dim_date
WHERE date_key IS NOT NULL;
