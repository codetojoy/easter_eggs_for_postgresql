
### Setup Summary (Python3)

* pgxn client
    * https://pgxn.github.io/pgxnclient/install.html
* pg_repack
    * https://reorg.github.io/pg_repack/

```
python3 -m venv path/to/venv
source path/to/venv/bin/activate
python3 -m pip install pgxnclient
sudo pgxn install pg_repack
    - won't compile... can't find "stdio.h" etc
```
