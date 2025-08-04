
### Resources

* good notes [here](https://aws.amazon.com/blogs/database/remove-bloat-from-amazon-aurora-and-rds-for-postgresql-with-pg_repack/)
* highly validating [video here](https://www.youtube.com/watch?v=PR4yjtve0DU)
* including: how to get version of `pg_repack` from AWS RDS

### Setup

* uses `./setvars.sh` from `..`
* pre-requisite: `docker pull cherts/pg-repack:1.5.1`
* see Python.Notes.md for attempt that didn't work 

### Full cycle

* setup table: `./run-file-psql.sh setup.sql`
* populate table: `./run-populate-groovy.sh`
* observe info: `./run-file-psql.sh info.sql`
* create dead-tuples and/or free space (if auto-vacuum running):
    * delete: `./run-file-psql.sh delete-rows.sql`
    * update: `./run-file-psql.sh update-rows.sql`
* run pg-repack: `./run-docker-pg-repack.sh`
* observe info: `./run-file-psql.sh info.sql`
