-- �׽�Ʈ ���̺� ���� 
-- table a 
-- drop table a ;
create table a (
c1 int not null primary key, 
c2 char(1) not null, 
c3 varchar null,
c6 char(1) null 
);
-- table b 
--drop table b;
create table b (
c1 int not null, 
c2 char(1) not null, 
c3 varchar null,
c4 decimal(5,2) null,
c5 date default now(),
c6 char(1) null, 
constraint pk_b primary key(c1, c2)  
);
-- insert data to a 
insert into a 
values 
(1, 'a', '��', 'M'),
(2, 'b', '��', 'F'),
(3, 'c', '��', 'M'),
(4, 'd', '��', 'F'),
(5, 'e', '��', 'M'),
(6, 'f', '��', 'F');
-- insert data to b 
insert into b (c1, c2, c3, c4, c6 )
values 
(1, '1', 'a', 1.1, '��'),
(1, '2', 'a', 1.2, '��'),
(2, '1', 'b', 2.1, '��'),
(4, '1', 'd', 4.1, '��'),
(6, '1', 'f', 0.0, '��'),
(6, '2', 'f', 6.1, '��'),
(6, '3', 'f', 6.2, null),
(7, '1', null, 7.1, '��');

select * from a ;
select * from b ;

select a.*, b.* 
from a inner join b on (a.c1 = b.c1); 

select a.*, b.* 
from a join b on (a.c1 = b.c1);

select a.*, b.* 
from a left outer join b on (a.c1 = b.c1)
order by 1 ;

-- 10.1 

-- 10.1 ���� 1 covid19 ���̺�� pop_covid19 ���̺��� join�Ͽ� 
-- �Կ� �ѻ�� �� 100�� �̻��̸鼭 ������ ����� pat_sbst_no, ent_date, 
-- sex, age, adm_date�� ��ȸ�Ͻÿ�.   
select b.pat_sbst_no, b.ent_date, a.sex, a.age, a.adm_date 
from covid19 a join pop_covid19 b on (a.pat_sbst_no = b.pat_sbst_no)
where b.ward = 'I' and a.age >= 100 and a.sex = 'F';

-- 10.1 ���� 2 covid19 ���̺�� pop_covid19 ���̺��� join�Ͽ� 
-- ��Ȱġ�Ἶ�Ϳ� �Լ� ������ �ִ� 25�� ������ pat_sbst_no, ent_date, 
-- sex, age, adm_date�� ��ȸ�Ͻÿ�.
select b.pat_sbst_no, b.ent_date, a.sex, a.age, a.adm_date
from covid19 a join pop_covid19 b on (a.pat_sbst_no = b.pat_sbst_no and 
                    b.ward = 'L')
where a.age = 25 and a.sex = 'M';

select b.pat_sbst_no, b.ent_date, a.sex, a.age, a.adm_date
from covid19     a, 
     pop_covid19 b 
where a.pat_sbst_no = b.pat_sbst_no 
and   b.ward = 'L'
and   a.age = 25 and a.sex = 'M';

-- 10.1 ���� 3 �Կ��� ����� 19�� ȯ���� ��ü��ȣ�� ����, 
-- �Կ����ڸ� ��� ��ȸ�ϰ� ��Ȱġ�Ἶ���� �Լ��Ͽ��� �������� �̷��� ǥ���Ͻÿ�. 
select a.pat_sbst_no, a.age, a.adm_date, b.ent_date 
from covid19 a left outer join pop_covid19 b on 
              (a.pat_sbst_no = b.pat_sbst_no and b.ward = 'L')
where a.age = 19 ;

-- 10.1.2 

-- ������� ���̺� ���� 
--drop table covid19_death ;
create table COVID19_DEATH ( 
PAT_SBST_NO varchar(9) not null, 
DEATH_YN char(1) not null, 
DEATH_YMD date not null, 
constraint pk_covid_death primary key (PAT_SBST_NO)
); 

select * from covid19_death;

-- 10.1 ���� 4 COVID19�� �츮������ �Կ��� ����� ����� ����� ��ü��ȣ, 
-- ����, ����, ������ڸ� ��ȸ�Ͻÿ�. 
select a.pat_sbst_no, a.age, a.sex, b.death_ymd 
from covid19 a join covid19_death b on (a.pat_sbst_no = b.pat_sbst_no)
;
-- 10.1.2 p.260 
-- 3�� �̻� ���̺� ���� 
-- 10.1 ���� 5 COVID19�� �츮������ �Կ��ϰ� ����� ����� ��ü��ȣ, 
-- ����, ����, �������, ��ġ��������, �������� �� ��ȸ�Ͻÿ�. 
select a.pat_sbst_no, a.age, a.sex, b.death_ymd, c.ward, c.ent_date 
from covid19 a join covid19_death b on (a.pat_sbst_no = b.pat_sbst_no)
               join pop_covid19 c on (a.pat_sbst_no = c.pat_sbst_no)
;

-- 10.1.2 
-- 10.1 ����6 COVID19 �Կ��� ����� 65�� ���� 71�� �̸鼭 ������ ����� 
-- ��ȸ�ϰ� ������ڸ� ǥ���Ͻÿ�. 
select a.pat_sbst_no, a.age, a.sex, b.death_ymd 
from covid19 a left outer join covid19_death b 
                            on (a.pat_sbst_no = b.pat_sbst_no)
where a.age between 65 and 71 and a.sex = 'M' ;

-- 10.1 ����7 COVID19 �Կ��� ����� 65�� ���� 71�� �̸鼭 ������ ����� ��ȸ�ϰ� 
-- ������ڿ� ��Ȱġ�Ἶ�� ����(�Լ�)���ڸ� ǥ���Ͻÿ�.  
select a.pat_sbst_no, a.age, a.sex, b.death_ymd, c.ent_date  
from covid19 a left outer join covid19_death b 
               on (a.pat_sbst_no = b.pat_sbst_no)
               left outer join pop_covid19 c 
               on (a.pat_sbst_no = c.pat_sbst_no and c.ward = 'L')
where a.age between 65 and 71 and a.sex = 'M' ;

-- 10.2 ���� join : skip p.261 
select a.*, b.* 
from a cross join b  order by 1 ;

-- 10.3 natural join ������� ���� p.269 
-- �Ǽ��� ���� ���� Query Plan�� Ȯ���غ��ÿ�.  
select count(1) 
from covid19 a natural join pop_covid19 b ;

select count(1) 
from covid19 a join pop_covid19 b on (a.pat_sbst_no = b.pat_sbst_no);

-- 11 ���ǽ� 
-- 11.1
-- 11.2 case  
-- 11.2.1 
-- select �����ȿ� case �� 
-- ������� ��Ȱġ�Ἶ�� �Լ� ���� ���� 
select a.*,  
       case when exists (select 1 from pop_covid19 c 
                         where c.pat_sbst_no = a.pat_sbst_no 
                         and c.ward = 'L') then '��Ȱġ�Ἶ���Լ�'
            else '��Ȱġ�Ἶ���ԼҾ���' 
       end as ���� 
from covid19_death a 
;
-- 11.3.5 
-- null�� ��� ��� 'F'�� �� 
select a.c1, a.c6, b.c6  
from a join b on (a.c1 = b.c1) 
where a.c6 = (case when b.c6 = '��' then 'M'
                   else 'F' end);  
-- null�� ��� ����                    
select a.c1, a.c6, b.c6  
from a join b on (a.c1 = b.c1) 
where a.c6 = (case when b.c6 = '��' then 'M'
                   when b.c6 = '��' then 'F' end)   
;                    

-- 11.2.2 
-- select case 
select a.c1, a.c6, b.c6, 
       case when b.c6 = '��' or b.c6 = '��' then '1'
            when b.c6 is null then 'null'
            else '0' 
       end ��Ī���� 
from a join b on (a.c1 = b.c1) ;

-- 11.2 case ǥ���� 
-- Tip ��¥���� �� ��ȯ�ϱ� 
select now(); 
select current_date; 
-- to_char(��¥, '����(����)') 
select to_char(now(), 'YYYY-MM');
select to_char(now(), 'YYYY');

-- ����1 ���� ����� ���� ���Ͻÿ�.  
select to_char(death_ymd, 'YYYY-MM') as ��, count(1) as ����ڼ� 
from covid19_death 
group by 1 
--group by to_char(death_ymd, 'YYYY-MM')
order by 1;

-- �Լ���() 
-- ����2 ���� ����� ���� ���ϰ� ����ڰ� ���� ���� 0���� ǥ���Ͻÿ�. 
-- ���� '2021.11.11'�� date�� ��ȯ 
select '2021.11.11'::date ;
select date '2020.01.01';
select cast('2021.01.01' as date);
-- ���� '2021.11.11'�� timestamp�� ��ȯ 
select '2021.11.11'::timestamp ;
-- ������ ������ ���� 1���� 9 
select generate_series(1, 9) t;
-- �Ⱓ�� ���� ���� 
select GENERATE_SERIES(
         (date '2020.01.01')::timestamp,
         (date '2021.12.31')::timestamp, interval '1 month'
                      );

select to_char(t.t, 'YYYY-MM') as ��, count(a.death_ymd) as ����ڼ� 
from (select GENERATE_SERIES(
           (date '2020.01.01')::timestamp,
           (date '2022.12.31')::timestamp, interval '1 month') as t) t 
      left outer join covid19_death a 
      on (to_char(t.t, 'YYYY-MM') = to_char(a.death_ymd, 'YYYY-MM'))
group by 1
order by 1;

-- 11.3.1  pivot  p.278  
-- ����3 �Ʒ� �׸��� ���� ���� ����� ���� ���ϰ� ����ڰ� ���� ���� 0���� ǥ���Ͻÿ�.   
select to_char(t.t, 'YYYY') as ��, 
       count(case when to_char(t.t, 'MM') = '01' then a.death_ymd end) as c1��,  
       count(case when to_char(t.t, 'MM') = '02' then a.death_ymd end) as c2��,
       count(case when to_char(t.t, 'MM') = '03' then a.death_ymd end) as c3��,
       count(case when to_char(t.t, 'MM') = '04' then a.death_ymd end) as c4��,
       count(case when to_char(t.t, 'MM') = '05' then a.death_ymd end) as c5��,
       count(case when to_char(t.t, 'MM') = '06' then a.death_ymd end) as c6��,
       count(case when to_char(t.t, 'MM') = '07' then a.death_ymd end) as c7��,
       count(case when to_char(t.t, 'MM') = '08' then a.death_ymd end) as c8��,
       count(case when to_char(t.t, 'MM') = '09' then a.death_ymd end) as c9��,
       count(case when to_char(t.t, 'MM') = '10' then a.death_ymd end) as c10��,
       count(case when to_char(t.t, 'MM') = '11' then a.death_ymd end) as c11��,
       count(case when to_char(t.t, 'MM') = '12' then a.death_ymd end) as c12��
from (select GENERATE_SERIES(
           (date '2020.01.01')::timestamp,
           (date '2025.12.31')::timestamp, interval '1 month') as t) t 
      left outer join covid19_death a 
           on (to_char(t.t, 'YYYY-MM') = to_char(a.death_ymd, 'YYYY-MM'))
group by 1
order by 1;

-- 11.3.2  ��������  

-- 11.3.0 0���� ������ ���� 
select 11/0 ;  

select c1/c4 from b ;

-- ���� 4 0���� ������ ������ �߻��մϴ�. ������ ���� �ʰ� ������ �ϰ� ��� ���� �����Ͻÿ�. 
select b.*, case when c4 != 0 and c4 is not null then c1/c4 
            end as div 
from b ; 
-- ���� 5 ���� 4������ �������� �Ҽ��� 2�ڸ����� ǥ���ϰ� �ݿø� �Ͻÿ�. 
-- round(��, �Ҽ��ڸ���)
select b.*, case when c4 != 0 then round(c1/c4, 2) end as div 
from b ;
-- ���� 6 ���� 4������ �������� �Ҽ��� 2�ڸ����� ǥ���ϰ� ���� �Ͻÿ�. 
-- trunc(��, ������ġ) 
select b.*, case when c4 != 0 then trunc(c1/c4, 2) end as div 
from b ;

-- 11.3.4 ���Ǻ� ������Ʈ 
select c6, 
       case when c6 = 'M' then '��'
            when c6 = 'F' then '��' 
       end as ���氪 
from a ;

-- update ���� 
update ���̺�� 
set Į���� = �����ϰ����ϴ°�, Į���� = �����ϰ����ϴ°�, Į���� = �����ϰ����ϴ°�  
where ���� ;

-- ���� 7 a ���̺��� c6�� M�� �� F�� �� �� �����Ͻÿ�. 
update a 
set c6 = (case when c6 = 'M' then '��'
               when c6 = 'F' then '��' 
          end) 
;

select * from a ;

-- 11.3.5 Null �� ó�� 

select c3 from b ;

-- ���� 8 b���̺� ��ü�� ��ȸ�ϰ� c3 ���� null �� '������'���� ǥ���Ͻÿ�.  
select c1, c2, 
       case when c3 is null then '������'
            else c3 end as c3, 
       c4, c5 
from b ;

-- null ����� Ȯ�� 
select 134 * null ;

select ifnull(c3, '��')
from b ;

select coalesce(c3, '��', c2) 
from b;

-- 12.1 Ʈ�����  

-- 13.1.1 �ε��� ���� 
create index idx_covid19 on covid19 (adm_date);

drop index idx_covid19;

-- 14.1 
create view summary as (
select to_char(ent_date, 'YYYY') as �⵵, count(1) as ��ü�Ǽ�, 
       sum(case when to_char(ent_date, 'MM') = '01' then 1 end) as c1��,
       sum(case when to_char(ent_date, 'MM') = '02' then 1 end) as c2��,
       sum(case when to_char(ent_date, 'MM') = '03' then 1 end) as c3��,
       sum(case when to_char(ent_date, 'MM') = '04' then 1 end) as c4��,
       sum(case when to_char(ent_date, 'MM') = '05' then 1 end) as c5��,
       sum(case when to_char(ent_date, 'MM') = '06' then 1 end) as c6��,
       sum(case when to_char(ent_date, 'MM') = '07' then 1 end) as c7��,
       sum(case when to_char(ent_date, 'MM') = '08' then 1 end) as c8��,
       sum(case when to_char(ent_date, 'MM') = '09' then 1 end) as c9��,
       sum(case when to_char(ent_date, 'MM') = '10' then 1 end) as c10��,
       sum(case when to_char(ent_date, 'MM') = '11' then 1 end) as c11��,
       sum(case when to_char(ent_date, 'MM') = '12' then 1 end) as c12��
from study.pop_covid19
group by to_char(ent_date, 'YYYY')
order by 1 asc 
);

select * from summary ;

-- 15. 

select * from pg_catalog.pg_tables where tablename = 'covid19';

select table_schema,
       table_name,
       ordinal_position as position,
       column_name,
       data_type,
       case when character_maximum_length is not null
            then character_maximum_length
            else numeric_precision end as max_length,
       is_nullable,
       column_default as default_value
from information_schema.columns
where table_schema not in ('information_schema', 'pg_catalog')
and table_name = 'covid19'
order by table_schema, 
         table_name,
         ordinal_position;

-- 16. 

select c.abo, round((count(1) / t.total::decimal) * 100, 2)||' %'  
from study.covid19 c  
     cross join (select count(1) as total from study.covid19 
        where abo is not null and abo != '') as t 
where c.abo is not null and c.abo != ''
group by c.abo, t.total;

-- abo�� null �Ǵ� �������� 
select abo, count(1) as cnt 
from covid19 
where abo is not null and abo != ''
group by abo ;

-- 16.1.1 ������ �����츦 ����Ͽ� ��ü �Ǽ� Į���߰� p.353
select abo, count(1) as cnt, sum(count(1)) over() as total  
from covid19 
where abo is not null and abo != ''
group by abo ;

-- ���� 1 abo�� ��ü��� ������ ���Ͻÿ�.  
select c.abo, count(1) as cnt, sum(count(1)) over() as total, 
       max(count(1)) over(partition by c.abo) as totalbyabo, 
       count(1) / (sum(count(1)) over()) * 100 as ratio 
from study.covid19 c  
where c.abo is not null and c.abo != ''
group by c.abo;

-- 16.1.2 ���� 
-- rank(), row_number(), dense_rank()  
select * from b ;

select c1, c2, rank() over(), row_number() over() 
from b ;

select c1, c2, rank() over(order by c1), 
               row_number() over(partition by c1),
               dense_rank() over(order by c1)
from b ;

-- 16.3.3 group_concat() �Լ� 
-- ���� 1 �ι��̻� �Կ��� ȯ���� �Կ����ڸ� �ϳ��� �÷��� ǥ���Ͻÿ�. 
select pat_sbst_no, 
       group_concat(to_char(adm_date, 'YYYY-MM-DD') order by adm_date)
from covid19 
group by pat_sbst_no 
having count(1) > 1 ;