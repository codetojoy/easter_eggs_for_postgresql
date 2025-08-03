
* setup: `setup.sql`
    * creates `book` table
    * installs extensions
* populate: `./run-populate-groovy.sh`
    * requires `../setvars.sh` to be reified and executed
    * populates `book` with data
* pre-observe: `./info.sql`
    * can be used to view size and tuples
* delete: `./delete.sql` 
    * delete some rows
* type 1: maintenance vacuum: 
    * `./vacuum.sql`
* type 2: run pg_repack
* post-observe: `./info.sql`
    * can be used to view size and tuples
