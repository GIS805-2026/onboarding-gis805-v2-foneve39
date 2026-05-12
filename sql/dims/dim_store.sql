-- S02 - Dimension magasin
-- Une ligne = un magasin NexaMart.

SELECT
    ROW_NUMBER() OVER (ORDER BY store_id) AS store_key,
    store_id,
    store_name,
    city,
    region,
    province,
    store_type
FROM raw_dim_store
WHERE store_id IS NOT NULL;

