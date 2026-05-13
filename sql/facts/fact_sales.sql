-- S02 - Table de faits ventes
-- GRAIN : une ligne = une ligne de commande (order_number + sale_line_id).

CREATE OR REPLACE TABLE fact_sales AS
SELECT
    -- Dimension degeneree : identifiant de commande conserve dans le fait.
    f.order_number,
    f.sale_line_id,

    -- Cles etrangeres vers les dimensions conformes.
    d.date_key,
    c.customer_key,
    p.product_key,
    s.store_key,
    ch.channel_key,

    -- Mesures.
    f.quantity,
    CAST(f.unit_price AS DECIMAL(10,2)) AS unit_price,
    CAST(f.discount_pct AS DECIMAL(10,4)) AS discount_pct,
    CAST(f.net_price AS DECIMAL(10,2)) AS net_price,
    CAST(f.line_total AS DECIMAL(12,2)) AS line_total,
    CAST(f.quantity * f.unit_price AS DECIMAL(12,2)) AS gross_amount
FROM raw_fact_sales f
JOIN dim_date d
    ON f.order_date = d.date_key
JOIN dim_customer c
    ON f.customer_id = c.customer_id
JOIN dim_product p
    ON f.product_id = p.product_id
JOIN dim_store s
    ON f.store_id = s.store_id
JOIN dim_channel ch
    ON f.channel_id = ch.channel_id
WHERE f.order_number IS NOT NULL
  AND f.sale_line_id IS NOT NULL;
