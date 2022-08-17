create table visit (
  visitDate datetime not null default now(),
  visitCount			int  not null default 1
);

drop table visit;

select now();
select date(now());

insert into visit values (date(now()),default);
insert into visit values ('2022-08-03',78);
insert into visit values ('2022-08-02',55);
insert into visit values ('2022-08-01',40);
insert into visit values ('2022-07-31',62);
insert into visit values ('2022-07-30',35);
insert into visit values ('2022-07-29',43);
insert into visit values ('2022-07-28',52);

select * from visit;
select substring(visitDate,1,10) as visitDate, visitCount from visit order by visitDate desc limit 7;
