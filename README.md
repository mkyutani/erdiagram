# erdiagram - print ER diagram from database

`erdiagram` prints ER diagram from postgresql database.

## Overview

`erdiagram` prints ER diagram from existing postgresql database in any formats. (pdf, png, ...)

![Architecture](img/function.png)

### Sample output

This repository includes a sample postgresql container [`docker-compose-testpg.yml`](docker-compose-testpg.yml) and a sample ddl [`samples/sample-ddl.sql`](samples/sample-ddl.sql).

![Sample diagram](img/sample.png)

You can docker-run this container and print the sample output.

```
# Run a sample postgresql container
$ docker compose -f docker-compose-testpg.yml up -d

# Print ER diagram from `postgresql://testuser:testpw@testpg/testdb' in the docker network `testnw'
$ erdiagram -n testnw -s testpg -d testdb -u testuser -p testpw

# See the ER diagram output in `tmp/er.png'

# Remove the postgresql container
$ docker compose -f docker-compose-testpg.yml down
```

## Install

`./install.sh` builds an docker image (`eralchemy:latest`) and copies the command to `/usr/local/bin`.

```
$ sudo ./install.sh
```

## Detail in `erdiagram`

### Typical command line

* To print ER diagram from data source `postgresql://user:password@myserver:15432/mydatabase` in the network `mydockernetwork`, call `erdiagram` with some optional arguments.

```
$ erdiagram -u user -p password -s myserver -d mydatabase -P 15432 -n mydockernetwork
```

* If the database exists and exports port in host network, don't assign host and network arguments.

```
$ erdiagram -u user -p password -d mydatabase -P 15432 # means `localhost' in `host' network
```

* Some arguments are not necessary.
  * port
  * password
* Use -o option to specify output file format like pdf or png.
* -D or --dir optional argument specifies the docker volume directory.

### Command line options

| Category | Option | default value | description |
| ---- | ---- | ---- | ---- |
| Container network | -n, --network | host | container network to connect database server |
| Data source | --protocol | postgresql | database protocol |
|| -s, --server | localhost | database server name |
|| -P, --port | (none) | database server port number |
|| -d, --database | postgres | database name |
|| -u, --user | (current user) | database user name |
|| -p, --password | (none) | database user password |
| Output | -D, --dir | ./tmp | output directory (mkdir if it doesn't exist and share to container) |
|| o, --output | er.png | output file name (extension: pdf, png, er, etc.) |

### Technology in docker image

* Python3
  * [ERAlchemy](https://pypi.org/project/ERAlchemy/)
  * [SQLAlchemy](https://www.sqlalchemy.org/) version <1.4
  * [psycopg2](https://www.psycopg.org/)
* [graphviz](https://graphviz.org/) and [pygraphvizx](https://pygraphviz.github.io/)

### License

[MIT License](LICENSE)
