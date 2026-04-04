"""
VendorID                          int32
lpep_pickup_datetime     datetime64[us]
lpep_dropoff_datetime    datetime64[us]
store_and_fwd_flag                  str
RatecodeID                      float64
PULocationID                      int32
DOLocationID                      int32
passenger_count                 float64
trip_distance                   float64
fare_amount                     float64
extra                           float64
mta_tax                         float64
tip_amount                      float64
tolls_amount                    float64
ehail_fee                       float64
improvement_surcharge           float64
total_amount                    float64
payment_type                    float64
trip_type                       float64
congestion_surcharge            float64
cbd_congestion_fee              float64
"""

import pandas as pd
from sqlalchemy import create_engine
from tqdm.auto import tqdm
import click

DEFAULT_DATASET = 'green_tripdata_2025-11.parquet'
DEFAULT_LOOKUP_FILE = 'taxi_zone_lookup.csv'

@click.command()
@click.option('--user', default='postgres', help="PostgreSQL User")
@click.option('--password', default='postgres', help="PostgreSQL Password")
@click.option('--host', default='localhost', help="PostgreSQL Host")
@click.option('--port', default='5433', help="PostgreSQL Port")
@click.option('--db', default='ny_taxi_green', help="Green Taxi TLC Trips")
@click.option('--dataset', default=DEFAULT_DATASET, help="Default dataset")
@click.option('--target_table', default='ny_taxi_green', help="PostgreSQL User")
@click.option('--lookup_file', default=DEFAULT_LOOKUP_FILE, help="Default lookup file")
def run(user, password, host, port, db, dataset, target_table, lookup_file):
    engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')

    print(f"Reading {dataset}")
    read_data = pd.read_parquet(dataset)
    read_data.to_sql(
        name=target_table,
        con=engine,
        if_exists='replace'
    )

    print(f"Reading taxi zone lookup file")
    read_data = pd.read_csv(lookup_file)
    read_data.to_sql(
        name="lookup",
        con=engine,
        if_exists='replace'
    )


if __name__ == "__main__":
    run()





