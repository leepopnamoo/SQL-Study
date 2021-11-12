-- 테스트 테이블 생성 
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
(1, 'a', '가', 'M'),
(2, 'b', '나', 'F'),
(3, 'c', '다', 'M'),
(4, 'd', '라', 'F'),
(5, 'e', '마', 'M'),
(6, 'f', '바', 'F');
-- insert data to b 
insert into b (c1, c2, c3, c4, c6 )
values 
(1, '1', 'a', 1.1, '남'),
(1, '2', 'a', 1.2, '남'),
(2, '1', 'b', 2.1, '여'),
(4, '1', 'd', 4.1, '여'),
(6, '1', 'f', 0.0, '여'),
(6, '2', 'f', 6.1, '여'),
(6, '3', 'f', 6.2, null),
(7, '1', null, 7.1, '남');

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

-- 10.1 문제 1 covid19 테이블과 pop_covid19 테이블을 join하여 
-- 입원 한사람 중 100세 이상이면서 여자인 사람의 pat_sbst_no, ent_date, 
-- sex, age, adm_date를 조회하시오.   
select b.pat_sbst_no, b.ent_date, a.sex, a.age, a.adm_date 
from covid19 a join pop_covid19 b on (a.pat_sbst_no = b.pat_sbst_no)
where b.ward = 'I' and a.age >= 100 and a.sex = 'F';

-- 10.1 문제 2 covid19 테이블과 pop_covid19 테이블을 join하여 
-- 생활치료센터에 입소 경험이 있는 25세 남자의 pat_sbst_no, ent_date, 
-- sex, age, adm_date를 조회하시오.
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

-- 10.1 문제 3 입원한 사람중 19세 환자의 대체번호와 나이, 
-- 입원일자를 모두 조회하고 생활치료센터의 입소하였던 내원일자 이력을 표시하시오. 
select a.pat_sbst_no, a.age, a.adm_date, b.ent_date 
from covid19 a left outer join pop_covid19 b on 
              (a.pat_sbst_no = b.pat_sbst_no and b.ward = 'L')
where a.age = 19 ;

-- 10.1.2 

-- 사망정보 테이블 생성 
--drop table covid19_death ;
create table COVID19_DEATH ( 
PAT_SBST_NO varchar(9) not null, 
DEATH_YN char(1) not null, 
DEATH_YMD date not null, 
constraint pk_covid_death primary key (PAT_SBST_NO)
); 

select * from covid19_death;

-- 10.1 문제 4 COVID19로 우리병원에 입원한 사람중 사망한 사람의 대체번호, 
-- 나이, 성별, 사망일자를 조회하시오. 
select a.pat_sbst_no, a.age, a.sex, b.death_ymd 
from covid19 a join covid19_death b on (a.pat_sbst_no = b.pat_sbst_no)
;
-- 10.1.2 p.260 
-- 3개 이상 테이블 조인 
-- 10.1 문제 5 COVID19로 우리병원에 입원하고 사망한 사람의 대체번호, 
-- 나이, 성별, 사망일자, 생치병원구분, 내원일자 를 조회하시오. 
select a.pat_sbst_no, a.age, a.sex, b.death_ymd, c.ward, c.ent_date 
from covid19 a join covid19_death b on (a.pat_sbst_no = b.pat_sbst_no)
               join pop_covid19 c on (a.pat_sbst_no = c.pat_sbst_no)
;

-- 10.1.2 
-- 10.1 문제6 COVID19 입원한 사람중 65세 에서 71세 이면서 남자인 목록을 
-- 조회하고 사망일자를 표시하시오. 
select a.pat_sbst_no, a.age, a.sex, b.death_ymd 
from covid19 a left outer join covid19_death b 
                            on (a.pat_sbst_no = b.pat_sbst_no)
where a.age between 65 and 71 and a.sex = 'M' ;

-- 10.1 문제7 COVID19 입원한 사람중 65세 에서 71세 이면서 남자인 목록을 조회하고 
-- 사망일자와 생활치료센터 내원(입소)일자를 표시하시오.  
select a.pat_sbst_no, a.age, a.sex, b.death_ymd, c.ent_date  
from covid19 a left outer join covid19_death b 
               on (a.pat_sbst_no = b.pat_sbst_no)
               left outer join pop_covid19 c 
               on (a.pat_sbst_no = c.pat_sbst_no and c.ward = 'L')
where a.age between 65 and 71 and a.sex = 'M' ;

-- 10.2 교차 join : skip p.261 
select a.*, b.* 
from a cross join b  order by 1 ;

-- 10.3 natural join 사용하지 않음 p.269 
-- 건수를 비교해 보고 Query Plan을 확인해보시오.  
select count(1) 
from covid19 a natural join pop_covid19 b ;

select count(1) 
from covid19 a join pop_covid19 b on (a.pat_sbst_no = b.pat_sbst_no);

-- 11 조건식 
-- 11.1
-- 11.2 case  
-- 11.2.1 
-- select 구문안에 case 문 
-- 사망자중 생활치료센터 입소 유무 구분 
select a.*,  
       case when exists (select 1 from pop_covid19 c 
                         where c.pat_sbst_no = a.pat_sbst_no 
                         and c.ward = 'L') then '생활치료센터입소'
            else '생활치료센터입소없음' 
       end as 상태 
from covid19_death a 
;
-- 11.3.5 
-- null인 경우 모두 'F'로 됨 
select a.c1, a.c6, b.c6  
from a join b on (a.c1 = b.c1) 
where a.c6 = (case when b.c6 = '남' then 'M'
                   else 'F' end);  
-- null인 경우 누락                    
select a.c1, a.c6, b.c6  
from a join b on (a.c1 = b.c1) 
where a.c6 = (case when b.c6 = '남' then 'M'
                   when b.c6 = '여' then 'F' end)   
;                    

-- 11.2.2 
-- select case 
select a.c1, a.c6, b.c6, 
       case when b.c6 = '남' or b.c6 = '여' then '1'
            when b.c6 is null then 'null'
            else '0' 
       end 매칭유무 
from a join b on (a.c1 = b.c1) ;

-- 11.2 case 표현식 
-- Tip 날짜에서 월 변환하기 
select now(); 
select current_date; 
-- to_char(날짜, '형식(포멧)') 
select to_char(now(), 'YYYY-MM');
select to_char(now(), 'YYYY');

-- 문제1 월별 사망자 수를 구하시오.  
select to_char(death_ymd, 'YYYY-MM') as 월, count(1) as 사망자수 
from covid19_death 
group by 1 
--group by to_char(death_ymd, 'YYYY-MM')
order by 1;

-- 함수명() 
-- 문제2 월별 사망자 수를 구하고 사망자가 없는 월은 0으로 표시하시오. 
-- 문자 '2021.11.11'를 date로 변환 
select '2021.11.11'::date ;
select date '2020.01.01';
select cast('2021.01.01' as date);
-- 문자 '2021.11.11'를 timestamp로 변환 
select '2021.11.11'::timestamp ;
-- 가상의 범위값 생성 1에서 9 
select generate_series(1, 9) t;
-- 기간내 월을 생성 
select GENERATE_SERIES(
         (date '2020.01.01')::timestamp,
         (date '2021.12.31')::timestamp, interval '1 month'
                      );

select to_char(t.t, 'YYYY-MM') as 월, count(a.death_ymd) as 사망자수 
from (select GENERATE_SERIES(
           (date '2020.01.01')::timestamp,
           (date '2022.12.31')::timestamp, interval '1 month') as t) t 
      left outer join covid19_death a 
      on (to_char(t.t, 'YYYY-MM') = to_char(a.death_ymd, 'YYYY-MM'))
group by 1
order by 1;

-- 11.3.1  pivot  p.278  
-- 문제3 아래 그림과 같이 월별 사망자 수를 구하고 사망자가 없는 월은 0으로 표시하시오.   
select to_char(t.t, 'YYYY') as 년, 
       count(case when to_char(t.t, 'MM') = '01' then a.death_ymd end) as c1월,  
       count(case when to_char(t.t, 'MM') = '02' then a.death_ymd end) as c2월,
       count(case when to_char(t.t, 'MM') = '03' then a.death_ymd end) as c3월,
       count(case when to_char(t.t, 'MM') = '04' then a.death_ymd end) as c4월,
       count(case when to_char(t.t, 'MM') = '05' then a.death_ymd end) as c5월,
       count(case when to_char(t.t, 'MM') = '06' then a.death_ymd end) as c6월,
       count(case when to_char(t.t, 'MM') = '07' then a.death_ymd end) as c7월,
       count(case when to_char(t.t, 'MM') = '08' then a.death_ymd end) as c8월,
       count(case when to_char(t.t, 'MM') = '09' then a.death_ymd end) as c9월,
       count(case when to_char(t.t, 'MM') = '10' then a.death_ymd end) as c10월,
       count(case when to_char(t.t, 'MM') = '11' then a.death_ymd end) as c11월,
       count(case when to_char(t.t, 'MM') = '12' then a.death_ymd end) as c12월
from (select GENERATE_SERIES(
           (date '2020.01.01')::timestamp,
           (date '2025.12.31')::timestamp, interval '1 month') as t) t 
      left outer join covid19_death a 
           on (to_char(t.t, 'YYYY-MM') = to_char(a.death_ymd, 'YYYY-MM'))
group by 1
order by 1;

-- 11.3.2  존재유무  

-- 11.3.0 0으로 나누기 오류 
select 11/0 ;  

select c1/c4 from b ;

-- 문제 4 0으로 나누면 오류가 발생합니다. 오류가 나지 않게 나누기 하고 모든 값을 나열하시오. 
select b.*, case when c4 != 0 and c4 is not null then c1/c4 
            end as div 
from b ; 
-- 문제 5 문제 4번에서 나눈값의 소수점 2자리까지 표현하고 반올림 하시오. 
-- round(값, 소수자리수)
select b.*, case when c4 != 0 then round(c1/c4, 2) end as div 
from b ;
-- 문제 6 문제 4번에서 나눈값의 소수점 2자리까지 표현하고 절사 하시오. 
-- trunc(값, 절사위치) 
select b.*, case when c4 != 0 then trunc(c1/c4, 2) end as div 
from b ;

-- 11.3.4 조건부 업데이트 
select c6, 
       case when c6 = 'M' then '남'
            when c6 = 'F' then '여' 
       end as 변경값 
from a ;

-- update 구분 
update 테이블명 
set 칼럼명 = 변경하고자하는값, 칼럼명 = 변경하고자하는값, 칼럼명 = 변경하고자하는값  
where 조건 ;

-- 문제 7 a 테이블의 c6를 M은 남 F는 여 로 변경하시오. 
update a 
set c6 = (case when c6 = 'M' then '남'
               when c6 = 'F' then '여' 
          end) 
;

select * from a ;

-- 11.3.5 Null 값 처리 

select c3 from b ;

-- 문제 8 b테이블에 전체를 조회하고 c3 값중 null 을 '값없음'으로 표시하시오.  
select c1, c2, 
       case when c3 is null then '값없음'
            else c3 end as c3, 
       c4, c5 
from b ;

-- null 계산결과 확인 
select 134 * null ;

select ifnull(c3, '널')
from b ;

select coalesce(c3, '널', c2) 
from b;

-- 12.1 트랜잭션  

-- 13.1.1 인덱스 생성 
create index idx_covid19 on covid19 (adm_date);

drop index idx_covid19;

-- 14.1 
create view summary as (
select to_char(ent_date, 'YYYY') as 년도, count(1) as 전체건수, 
       sum(case when to_char(ent_date, 'MM') = '01' then 1 end) as c1월,
       sum(case when to_char(ent_date, 'MM') = '02' then 1 end) as c2월,
       sum(case when to_char(ent_date, 'MM') = '03' then 1 end) as c3월,
       sum(case when to_char(ent_date, 'MM') = '04' then 1 end) as c4월,
       sum(case when to_char(ent_date, 'MM') = '05' then 1 end) as c5월,
       sum(case when to_char(ent_date, 'MM') = '06' then 1 end) as c6월,
       sum(case when to_char(ent_date, 'MM') = '07' then 1 end) as c7월,
       sum(case when to_char(ent_date, 'MM') = '08' then 1 end) as c8월,
       sum(case when to_char(ent_date, 'MM') = '09' then 1 end) as c9월,
       sum(case when to_char(ent_date, 'MM') = '10' then 1 end) as c10월,
       sum(case when to_char(ent_date, 'MM') = '11' then 1 end) as c11월,
       sum(case when to_char(ent_date, 'MM') = '12' then 1 end) as c12월
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

-- abo가 null 또는 공백제외 
select abo, count(1) as cnt 
from covid19 
where abo is not null and abo != ''
group by abo ;

-- 16.1.1 데이터 윈도우를 사용하여 전체 건수 칼럼추가 p.353
select abo, count(1) as cnt, sum(count(1)) over() as total  
from covid19 
where abo is not null and abo != ''
group by abo ;

-- 문제 1 abo별 전체대비 비율을 구하시오.  
select c.abo, count(1) as cnt, sum(count(1)) over() as total, 
       max(count(1)) over(partition by c.abo) as totalbyabo, 
       count(1) / (sum(count(1)) over()) * 100 as ratio 
from study.covid19 c  
where c.abo is not null and c.abo != ''
group by c.abo;

-- 16.1.2 순위 
-- rank(), row_number(), dense_rank()  
select * from b ;

select c1, c2, rank() over(), row_number() over() 
from b ;

select c1, c2, rank() over(order by c1), 
               row_number() over(partition by c1),
               dense_rank() over(order by c1)
from b ;

-- 16.3.3 group_concat() 함수 
-- 문제 1 두번이상 입원한 환자의 입원일자를 하나의 컬럼에 표시하시오. 
select pat_sbst_no, 
       group_concat(to_char(adm_date, 'YYYY-MM-DD') order by adm_date)
from covid19 
group by pat_sbst_no 
having count(1) > 1 ;