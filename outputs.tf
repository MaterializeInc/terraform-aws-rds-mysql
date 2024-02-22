output "rds_instance" {
  value     = aws_db_instance.mz_rds_demo_db
  sensitive = true
}

output "vpc" {
  value = module.vpc
}

output "mz_rds_mysql_details" {
  sensitive = true
  value     = <<EOF
    -- On the RDS instance side:
    -- 1. Connect to the RDS instance
    mysql -h ${aws_db_instance.mz_rds_demo_db.address} -u ${aws_db_instance.mz_rds_demo_db.username} -p${aws_db_instance.mz_rds_demo_db.password} ${aws_db_instance.mz_rds_demo_db.db_name}

    -- 2. Create a new schema and table
    CREATE DATABASE IF NOT EXISTS dummyschema;
    USE dummyschema;
    CREATE TABLE dummy (f1 INTEGER);

    -- 3. Insert some data
    INSERT INTO dummy VALUES (1), (2);

    -- 4. Verify the data
    SELECT * FROM dummy;

    -- On the Materialize side:
    -- 1. Ensure MySQL sources are enabled in Materialize

    -- 2. Create a secret for the RDS password
    CREATE SECRET mysqlpass AS '${aws_db_instance.mz_rds_demo_db.password}';

    -- 3. Create a connection to the RDS instance with an optional SSH tunnel
    CREATE CONNECTION mysql TO MYSQL (
        HOST '${aws_db_instance.mz_rds_demo_db.address}',
        USER '${aws_db_instance.mz_rds_demo_db.username}',
        PASSWORD SECRET mysqlpass
        -- The module expects the RDS instance to be publicly accessible for testing purposes.
    );

    -- 4. Create a source for all tables in the MySQL RDS instance
    CREATE SOURCE mysql_source FROM MYSQL CONNECTION mysql FOR ALL TABLES;

    -- 5. Query the source to verify data ingestion
    SELECT * FROM dummy;
    EOF
}
