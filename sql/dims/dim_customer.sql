-- S02 - Dimension client
-- Une ligne = un client NexaMart.

CREATE OR REPLACE TABLE dim_customer AS
SELECT
    ROW_NUMBER() OVER (ORDER BY customer_id) AS customer_key,
    customer_id,
    first_name,
    last_name,
    first_name || ' ' || last_name AS full_name,
    email_domain,
    city,
    province,
    loyalty_segment,
    CAST(join_date AS DATE) AS join_date
FROM raw_dim_customer
WHERE customer_id IS NOT NULL;
