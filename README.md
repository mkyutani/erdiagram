# ERAlchemy - ER Diagram from Database

![ER diagram](img/er.png)

Create a postgresql database by `docker-compose-testpg.yml` with tables in `samples/sample-ddl.sql` and make a ER diagram.

```
$ docker compose -f docker-compose-testpg.yml up -d
 ...
$ ./eralchemy.sh -n testnw -s testpg -d testdb -u testuser -p testpw
 ...
$ ls tmp
er.png
$ docker compose -f docker-compose-testpg.yml down
```

## Build container

Build an docker image 'eralchemy:latest'

```
$ ./build.sh
```

## Usage: `./eralchemy.sh`

`./eralchemy.sh` build a data source name and create ER diagram by eralchemy container.

### Options

| Category | Option | description |
| ---- | ---- | ---- |
| Container network | -n, --network | container network to connect database server |
| Data source | --protocol | database protocol |
|| -s, --server | database server name |
|| -P, --port | database server port number |
|| -d, --database | database name |
|| -u, --user | database user name |
|| -p, --password | database user password |
| Output | -D, --dir | output directory (mkdir if it doesn't exist and share to container) |
|| o, --output | output file name (extension: pdf, png, er, etc.) |
