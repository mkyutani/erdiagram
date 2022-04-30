create table account (
       id integer primary key not null unique,
       name varchar(256) not null,
       email varchar(256) not null,
       enabled boolean
);

create table resource (
       id integer primary key not null unique,
       name varchar(256) not null,
       type varchar(32) not null,
       owner integer references account
);
