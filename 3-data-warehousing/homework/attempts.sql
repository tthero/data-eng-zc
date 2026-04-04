-- Create external table
CREATE OR REPLACE EXTERNAL TABLE zoomcamp.yellow_tripdata_2024_ext
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://tcyk-kestra-bucket1/yellow_tripdata_2024-*.parquet']
);

-- Get the count
SELECT COUNT(*) FROM zoomcamp.yellow_tripdata_2024_ext;

-- Create regular table
CREATE OR REPLACE TABLE zoomcamp.yellow_tripdata_2024_regular AS (
  SELECT * FROM zoomcamp.yellow_tripdata_2024_ext
);

-- Create materialized view of regular view?
CREATE OR REPLACE MATERIALIZED VIEW zoomcamp.yellow_tripdata_2024_material AS (
  SELECT * FROM zoomcamp.yellow_tripdata_2024_regular
);

-- Get the counter of distinct number of PULocationID
SELECT COUNT(DISTINCT(PULocationID)) FROM zoomcamp.yellow_tripdata_2024_ext;
SELECT COUNT(DISTINCT(PULocationID)) FROM zoomcamp.yellow_tripdata_2024_material;

SELECT PULocationID FROM zoomcamp.yellow_tripdata_2024_regular;
SELECT PULocationID, DOLocationID FROM zoomcamp.yellow_tripdata_2024_regular;

SELECT COUNT(fare_amount) FROM zoomcamp.yellow_tripdata_2024_material WHERE fare_amount = 0;

CREATE OR REPLACE TABLE zoomcamp.yellow_tripdata_2024_custom1
PARTITION BY DATE(tpep_dropoff_datetime)
CLUSTER BY VendorID AS
SELECT * FROM zoomcamp.yellow_tripdata_2024_regular;


-- Materialized view: around 310.24MB
SELECT DISTINCT(VendorID) FROM zoomcamp.yellow_tripdata_2024_material
WHERE tpep_dropoff_datetime BETWEEN '2024-03-01' AND '2024-03-15';

-- Partitioned and clustered: around 26.84MB
SELECT DISTINCT(VendorID) FROM zoomcamp.yellow_tripdata_2024_custom1
WHERE tpep_dropoff_datetime BETWEEN '2024-03-01' AND '2024-03-15';


SELECT COUNT(*) FROM zoomcamp.yellow_tripdata_2024_regular;
SELECT COUNT(*) FROM zoomcamp.yellow_tripdata_2024_material;
