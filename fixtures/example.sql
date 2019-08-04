CREATE EXTERNAL TABLE `users`(
  `id` int,
  `name` string,
  `email` string,
  `created_at` string,
  `updated_at` string
  )
ROW FORMAT SERDE
  'org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe'
STORED AS INPUTFORMAT
  'org.apache.hadoop.mapred.TextInputFormat'
OUTPUTFORMAT
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://<your bucket>/mysql/users'
TBLPROPERTIES (
  'has_encrypted_data'='false');

CREATE EXTERNAL TABLE `joined_users`(
  `id` int,
  `name` string,
  `email` string,
  `gender` string,
  `location` string,
  `created_at` string,
  `updated_at` string
  )
ROW FORMAT SERDE
  'org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe'
STORED AS INPUTFORMAT
  'org.apache.hadoop.mapred.TextInputFormat'
OUTPUTFORMAT
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://<your bucket>/mysql/joined_users'
TBLPROPERTIES (
  'has_encrypted_data'='false');

