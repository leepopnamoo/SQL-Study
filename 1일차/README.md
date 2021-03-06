# SQL강좌 1일차    
---    
# 1.배경 
# 1.1 데이터베이스 소개 
> 데이터베이스는 관련정보의 집합이다. 
> 데이터베이스 시스템은 종이대신 전산화된 자료로 데이터를 저장함으로써 더 빠르게 검색하고, 다양한 방법으로 데이터를 색인화 하며, 최신 정보를 사용자에게 제공할 수 있습니다. 

## 1.1.1 비관계형 데이터베이스 시스템 
### File System vs DBMS
|구분|File System|DBMS|
|:----:|:---:|:---:|
|Cost|Low|High|
|Data Redundancy|O|X|
|Constraint|X|O|
|Data Dependency|O|X|
|**Multi User Access**|X|O|
|Security|파일단위의 접근 권한|세분화된 권한 부여 가능|
|Recovery|Difficult|There’s a way though…|

### File System Oracle 
![오라클파일시스템](../images/filesystem_oracle.png)

## 1.1.2 관계형 모델 - RDBMS :: Relational DataBase Management System
> 1970년 IBM 연구소의 **에드거 프랭크 커드** 박사는 '대규모 공유 데이터 뱅크를 위한 데이터의 관계형 모델'이라는 논문을 발표하고 데이터를 테이블 집항으올 나타낼 것을 제안했습니다.    
> 테이블 **엔티티**는 **기본키**를 또는 복합키를 가지며 특성에 따라 자연키, 대리키로 구분 할 수 있다. 관계형데이터베이스에서 **참조키**(외래키)를 사용하여 Join 명령어로 엔티티간의 관계를 정의한다.    
> 각각의 독립적인 정보가 한 위치에만 저장되도록 데이터베이스 설계를 수정하는 절차를 **정규화**라고 합니다.    

# 1.2 SQL 
> SEQUEL이라 불리는 언어가 등장했으며 이것을 짧게 **SQL**이라 부르게 되었습니다.    
> 1980년 중반, 미국 국립 표준 연구소(American National Standards Institute::ANSI)에서 SQL언어의 최조 표준을 발표했습니다. 
> SQL이 'Structured Query Language'를 의미한다고 주장하는 사람이 많지만, SQL은 어떤 단어의 약어가 아니다. 
> S.Q.L이라 하거나 sequel(시퀄)이라고 함. 

## 1.2.1 SQL문 분류 
1. DDL – Data Definition Language : CREATE   
2. DQl – Data Query Language : SELECT   
3. DML – Data Manipulation Language : UPDATE   
4. DCL – Data Control Language : GRANT   
5. DTL - Data Transaction Language : COMMIT    

## 1.2.2 비절차적 언어인 SQL   
> SQL의 실행은 옵티마이저라는 데이터베이스 엔진에서 담당함.   
> 사용자가 직접 힌트를 지정함으로써 옵티마이저의 결정에 영향을 줄 수 있음. (PostgreSQL 엔트프라이즈 DB와 같은 힌트기능 없음)    

![쿼리플랜보기](../images/sql_excute_plan.jpg)

## 1.2.3 SQL 예제 
> SELECT  하나 이상의 칼럼 정의   
> FROM    하나 이상의 테이블 정의    
> WHERE   하나 이상의 조건 지정     

# 1.3 MySQL - PostgreSQL 
+ 오라클 : 오라클데이터베이스, Oracle v5 Client/Server 지원     
+ 마이크로소프트 : SQL 서버 (SQL Server - Sybase Server(ASE::Adaptive Server Enterprise)    
+ IBM : DB2 
+ 오픈소스 관계형 데이터베이스 : MySQL(Sun>Oracle), PostgreSQL, MariaDB 

---   

# 2. 데이터베이스 생성과 데이터 추가 
# 2.1 데이터베이스 생성    
```
create database [database name];   
create schema study ;   -- 생성후 SQL로 확인 
``` 
  + PostgreSQL 설치   
  + DBeaver 설치 
  + dvdrental 샘플 db 생성 
  
# 2.2 command 명령어 도구 사용 방법    
+ 콘솔실행 
  1. 윈도에서 cmd 명령으로 콘솔창 실행 
  2. 디렉토리 변경 
  ```
  cd "C:\Program Files\PostgreSQL\13\bin" 
  ```
  3. psql 실행 
  ```
  psql -U postgres   
  ```
  4. select 실행 
  ```
  select now(); 
  ```   
  
![콘솔](../images/console_psql.jpg) 

# 2.3 자료형    
참조문서 <https://www.postgresql.org/docs/14/multibyte.html>
## 2.3.1 문자 데이터   
> char(20)  - fixed-length    
> varchar(20)  - variable-length 
 
## 2.3.2 숫자 데이터   

|자료형|설명|
|:--:|--|
|tinyint|-128 ~ 127|
|smallint|-32,768 ~ 32,767|
|int|-2,147,483,648 ~ 2,147,483,647|
|float(p,s)|-38.402823466E+38 ~ -1.175494351-38   1.175494351-38 ~ 38.402823466E+38|

> float(4,2) 
> > 4 :: 소수점 아래 부분을 포함한 자리수    
> > 2 :: 소수점 아래 자리수 

## 2.3.3 시간 데이터    

|자료형|기본형식|
|:---:|---|
|date|YYYY-MM-DD|
|datetime|YYYY-MM-DD HH:MM:SS|
|timestamp|YYYY-MM-DD HH:MM:SS|

> timestamp :: 1970-01-01 ~ 2038-01-18 

# 2.4 테이블 생성   

> Entity를 1개 이상의 Attribute 표현한 것 
  
## 2.4.1 단계 1 : 설계 

+ 요구서 정의 및 분석   
+ Entity 선정, 객체(Object) 
  + Entity - COVID19 환자 
  + 속성 - 성별, 나이, 키, 몸무게 ....   

+ [COVID19 요구서](../실습자료/DHL-P1-300D-COVID19_코호트_V1.7.pdf) 

## 2.4.2 단계 2 : 정제    

+ 속성의 특성 및 자료 분석  
+ 중복 또는 복합열이 존재하지 않도록 정규화      

> DW(Data Warehouse), 연구 분석용 레지스트리는 역(반)정규화 

## 2.4.3 단계 3 : SQL 스키마 문 생성    

+ 테이블 정의서 작성    
+ DDL문을 작성    

+ [COVID19 테이블 정의서](../실습자료/DHL-P2-304D-DM_테이블_항목정의서_COVID19_v1.1.pdf)    

> CREATE TABLE covid19 ( ... );   
> CREATE TABLE covid19_pop ( ... );   

``` 
-- study schema에 테이블 생성 
CREATE TABLE big ( 
  a SERIAL       NOT NULL,
  b CHAR(3)      NOT NULL, 
  c VARCHAR(3)       NULL,
  d NUMERIC(5,2)  DEFAULT 0.00, 
constraint pk_big primary key(a)
); 
``` 

```
-- [SHOW DATABASES]
SELECT datname FROM pg_database;

-- [SHOW TABLES]
SELECT table_name FROM information_schema.tables WHERE table_schema = 'study';

-- [SHOW COLUMNS]
SELECT column_name FROM information_schema.columns WHERE table_name = 'big';
``` 

**NULL**이란?    
1. 알 수 없는 항목    
2. count 되지 않는 항목    
3. 공백과 다른 의미    
4. 비교 연산자 또는 IF 문에서 처리되지 않는다.  
5. 테이블의 칼럼 정의시 NULL 허용 유무를 정의할 수 있다.    
6. IFNUL, ISNULL, is null 등으로 확인 가능하다. 

# 2.5 테이블 수정 
```
alter table big alter column b TYPE CHAR(6); 
```

## 2.5.1 데이터 삽입  
``` 
-- 입력 
insert into big (b, c, d)
values 
  ('1', 'a', 1.0)
, ('2', 'b', 2.0)
, ('3', 'c', 3.0)
, ('11', 'aa', 11.01)
, ('22', 'bb', 22.02)
, ('33', 'cc', 33.03)
, ('111', 'aaa', 111.1)
, ('222', 'bbb', 222.2)
, ('333', 'ccc', 333.3);
-- 필수 항목만 입력 
insert into big (b)
values
  ('1')
, ('2')
, ('3')
, ('11')
, ('22')
, ('33');

select * from big ;
select count(c) from big ;
``` 
## 2.5.2 데이터 수정   
```
-- 긴자료형 
update big 
set   c = 'NULL'
where b = '1' 
and   c is null ; 
-- 수정후 입력 
update big 
set   c = 'NUL'
where b = '1' 
and   c is null ; 
``` 

## 2.5.3 데이터 삭제    
``` 
-- b 칼럼이 3을 포함하고 c 가 null 인 경우 삭제 
delete from big 
where b like '%3%'
and c is null ; 
```
# 2.6 좋은 구문을 망치는 경우 
## 2.6.1 고유하지 않은 기본 키    
> 파일로 관리하는 연구 분석용 자료에서 중복 자료 종종 확인.     
## 2.6.2 존재하지 않는 외래 키   
> 검사 결과값은 있으나 환자정보가 존재하지 않는 경우.   
## 2.6.3 열 값 위반       
> 성별을 'M', 'F'로 정의하였으나 그외 문자가 존재하는 경우   
## 2.6.4 잘못된 날짜 변환   
> datetime to char 
``` 
select now() ;
select to_char(now(), 'YYYY-MM-DD');
select to_char(now(), 'HH24:MI:SS');

select '20211029'::date, '2021-01-02'::date; 
select date '2021-10-18';
select to_date('01022021','MMDDYYYY'), to_date('2021-12-25', 'YYYY-MM-DD');
select to_timestamp('2021-01-01 20:12:12', 'YYYY-MM-DD HH24:MI:SS'); 
``` 

## 2.7 샤키라 데이터베이스   
> PostgreSQL dvdrental SAMPLE database 만들기 
---

# 3. 쿼리입문 
## 3.1 쿼리역학 
+ 이 구문을 실행할 권한이 있는가? 
+ 원하는 데이터에 접근 할 수 있는 권한이 있는가? 
+ 구문의 문법이 정확한가? 

> 옵티미이저 - from절 조인 확인 - where절 index 확인- Query Plan - 실행    

``` 
-- dvdrental public에 생성이후 실행 
select first_name, last_name from customer where last_name = 'Jackson';
select * from category ;
``` 

## 3.2 쿼리절 

|절이름|목적|
|:---|:-----|
|select|쿼리 결과에 포함할 칼럼을 결정합니다|
|from|데이터를 검색할 테이블과, 테이블을 조인하는 방법을 식별합니다|
|where|필요한 데이터 조건을 정의합니다|
|group by|공통의 칼럼값을 기준으로 행을 그룹화 합니다|
|having|그룹한 결과에 조건으로 걸러냅니다|
|order by|하나 이상의 칼럼 기준으로 최종결과의 행을 정렬합니다|     

## 3.3 Select 절  

``` 
select * from language;
``` 

### 3.3.1 열의 별칭 

``` 
select Upper(name) as name_upper, language_id as id from language;
``` 

### 3.3.2 중복제거  

``` 
select actor_id from film_actor;
select distinct actor_id from film_actor;
select distinct actor_id from film_actor order by actor_id;
select distinct actor_id from film_actor order by 1;
``` 
## 3.4 from 절 
### 3.4.1 테이블 유형 

|명칭|설명|
|:---:|-----|
|영구 테이블|create table문으로 생성|
|파생 테이블|하위 쿼리에서 반환하고 메모리에 보관된 행|
|임시 테이블|메모리에 저장된 휘발성 데이터| 
|가상 테이블|create view 문으로 생성|  

--- 

# Install PostgreSQL :: Database Server 
1. 설치 파일 다운로드 :   
  <https://www.enterprisedb.com/downloads/postgres-postgresql-downloads> 
2. 설치 파일 실행 :  
  postgresql-14.0-1-windows-x64.exe 
3. 환경설정 파일   
  C:\Program Files\PostgreSQL\13\data 
  
|File Name|Description| 
|-----|-----|
|pg_hba.conf|ip대역별 접근권한을 설정한다. (Host Base Authentication)|
|pg_ident.conf|사용자 계정별 접근권한을 설정한다. (pg_hba.conf method설정에 따라)|
|postgresql.conf|서버환경 설정을 한다. 기본포트는 5432|

# Install DBeaver :: SQL Tool  
1. 설치 파일 다운로드 :
  <https://dbeaver.io/download/> 
2. 설치 파일 실행 :   
  dbeaver-ce-21.2.3-x86_64-setup.exe    
**※ 설치시 인터넷이 연결되어 있어야 드라이브 설치가 원활합니다.** 

# Connect Database 
1. 메뉴 열기 
  ![메뉴팝업](../images/db_connect_menu.jpg)
2. 데이터베이스 선택 
  ![연결설정1](../images/db_connection_pop1.jpg)
3. 연결 설정후 완료 
  ![연결설정2](../images/db_connection_pop2.jpg)
