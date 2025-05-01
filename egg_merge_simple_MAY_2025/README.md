
### Summary

From [this blog post](https://www.crunchydata.com/blog/a-look-at-postgres-15-merge-command-with-examples).

### Usage

* requires `psql`
    * one option is to install via Home Brew. [see here](https://stackoverflow.com/a/49689589/12704)
* at terminal: 
    * `cp setvars.sh my_setvars.sh`
    * edit `my_setvars.sh` with values
    * `chmod 744 my_setvars.sh`
    * `. ./my_setvars.sh`
* see `go.sh` for full flow
    * incoming-v1: new records with    ids: 1, 2, 3, 4, 5
    * incoming-v2: update records with ids: 1, 2, 3, 4
    * incoming-v3: update records with ids: 1, 2, 3
    * the incoming records are MERGEd into `station_data`

### Example Output

```
 station_id | version | a  | b  |     created_on      |     updated_on      
------------+---------+----+----+---------------------+---------------------
          1 |       3 | 66 | 63 | 2025-05-01 06:30:08 | 2025-05-01 06:30:08
          2 |       3 | 44 |  6 | 2025-05-01 06:30:08 | 2025-05-01 06:30:08
          3 |       3 |  4 | 85 | 2025-05-01 06:30:08 | 2025-05-01 06:30:08
          4 |       2 | 53 | 13 | 2025-05-01 06:30:08 | 2025-05-01 06:30:08
          5 |       1 | 13 | 43 | 2025-05-01 06:30:08 | 2025-05-01 06:30:08
```
