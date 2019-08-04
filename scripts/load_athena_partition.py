import os

import boto3
import digdag
from botocore.client import Config

athena_client = boto3.client(
    'athena',
    region_name='ap-northeast-1',
    aws_access_key_id=os.getenv('AWS_ACCESS_KEY'),
    aws_secret_access_key=os.getenv('AWS_SECRET_KEY'),
    config=Config(connect_timeout=5, read_timeout=5)
)

def load_partition(database, table):
    return athena_client.start_query_execution(
        QueryString='MSCK REPAIR TABLE {database}.{table}'.format(
            database=database,
            table=table,
        ),
        ResultConfiguration={
            'OutputLocation': os.getenv('ATHENA_OUTPUT_LOCATION')
        }
    )

def run():
    database = digdag.env.params['database']
    table = digadag.env.params['table']
    load_partition(database, table)

