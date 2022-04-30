# ERAlchemy - ER Diagram from Database

Create a postgresql database by docker-compose-testpg.yml with tables in samples/sample-ddl.sql and make a ER diagram.
![img/er.png]

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

Create a container 'eralchemy:latest'

```
$ ./build.sh
```

## Usage: ./eralchemy.sh

### Options

* Data source
  * --protocol: database protocol
  * -s, --server: database server name
  * -P, --port: database server port number
  * -d, --database: database name
  * -u, --user: database user name
  * -p, --password: database user password
* Container network
  * -n, --network: container network to connect database server
* Output
  * -D, --dir: output directory (mkdir if it doesn't exist and share to container)
  * o, --output: output file name (extension: pdf, png, er, etc.)
