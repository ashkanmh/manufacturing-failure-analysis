
-- Manufacturing Failure Analysis
-- Dataset: AI4I 2020 Predictive Maintenance
-- Author: Ashkan Mirzahoseini

-- QUERY 1: Failure count, rate and cost by failure type
SELECT 
    'HDF' AS failure_type,
    SUM(HDF) AS failure_count,
    ROUND(SUM(HDF) * 100.0 / COUNT(*), 2) AS failure_rate_pct,
    SUM(HDF) * 1000 AS estimated_cost_gbp
FROM machine_data
UNION ALL
SELECT 'OSF', SUM(OSF), ROUND(SUM(OSF) * 100.0 / COUNT(*), 2), SUM(OSF) * 1000 FROM machine_data
UNION ALL
SELECT 'PWF', SUM(PWF), ROUND(SUM(PWF) * 100.0 / COUNT(*), 2), SUM(PWF) * 1000 FROM machine_data
UNION ALL
SELECT 'TWF', SUM(TWF), ROUND(SUM(TWF) * 100.0 / COUNT(*), 2), SUM(TWF) * 1000 FROM machine_data
UNION ALL
SELECT 'RNF', SUM(RNF), ROUND(SUM(RNF) * 100.0 / COUNT(*), 2), SUM(RNF) * 1000 FROM machine_data
ORDER BY failure_count DESC;


-- QUERY 2: Failure rate by tool wear band
SELECT
    CASE
        WHEN "Tool wear [min]" BETWEEN 0 AND 49 THEN '1. 0-50 mins'
        WHEN "Tool wear [min]" BETWEEN 50 AND 99 THEN '2. 50-100 mins'
        WHEN "Tool wear [min]" BETWEEN 100 AND 149 THEN '3. 100-150 mins'
        WHEN "Tool wear [min]" BETWEEN 150 AND 199 THEN '4. 150-200 mins'
        ELSE '5. 200+ mins'
    END AS tool_wear_band,
    COUNT(*) AS total_runs,
    SUM("Machine failure") AS failures,
    ROUND(SUM("Machine failure") * 100.0 / COUNT(*), 2) AS failure_rate_pct
FROM machine_data
GROUP BY tool_wear_band
ORDER BY tool_wear_band;


-- QUERY 3: Failure rate by torque band
SELECT
    CASE
        WHEN "Torque [Nm]" BETWEEN 0 AND 19.99 THEN '1. 0-20 Nm'
        WHEN "Torque [Nm]" BETWEEN 20 AND 29.99 THEN '2. 20-30 Nm'
        WHEN "Torque [Nm]" BETWEEN 30 AND 39.99 THEN '3. 30-40 Nm'
        WHEN "Torque [Nm]" BETWEEN 40 AND 49.99 THEN '4. 40-50 Nm'
        WHEN "Torque [Nm]" BETWEEN 50 AND 59.99 THEN '5. 50-60 Nm'
        ELSE '6. 60+ Nm'
    END AS torque_band,
    COUNT(*) AS total_runs,
    SUM("Machine failure") AS failures,
    ROUND(SUM("Machine failure") * 100.0 / COUNT(*), 2) AS failure_rate_pct
FROM machine_data
GROUP BY torque_band
ORDER BY torque_band;


-- QUERY 4: Failure rate and cost by product type
SELECT
    Type AS product_type,
    COUNT(*) AS total_runs,
    SUM("Machine failure") AS failures,
    ROUND(SUM("Machine failure") * 100.0 / COUNT(*), 2) AS failure_rate_pct,
    SUM("Machine failure") * 1000 AS estimated_cost_gbp
FROM machine_data
GROUP BY Type
ORDER BY failure_rate_pct DESC;


-- QUERY 5: Top 10 highest risk runs (high tool wear AND high torque)
SELECT
    UDI AS run_id,
    "Product ID" AS product_id,
    Type AS product_type,
    "Tool wear [min]" AS tool_wear_mins,
    "Torque [Nm]" AS torque_nm,
    "Rotational speed [rpm]" AS speed_rpm,
    "Machine failure" AS failed,
    CASE
        WHEN TWF = 1 THEN 'Tool Wear'
        WHEN HDF = 1 THEN 'Heat Dissipation'
        WHEN PWF = 1 THEN 'Power'
        WHEN OSF = 1 THEN 'Overstrain'
        WHEN RNF = 1 THEN 'Random'
        ELSE 'No failure'
    END AS failure_cause
FROM machine_data
WHERE "Machine failure" = 1
    AND "Tool wear [min]" > 200
    AND "Torque [Nm]" > 50
ORDER BY "Tool wear [min]" DESC, "Torque [Nm]" DESC
LIMIT 10;
