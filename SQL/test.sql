create database mybase;
use mybase;
create table mytable1(name char(10),id int,age int);
create unique index ids on mytable1 (id);
insert into mytable1 values("asdx",2016063203,22);
insert into mytable1 values("ssdd",20123401,1);
select name,id,age from mytable1;