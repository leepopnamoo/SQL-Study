-- page 33, 34 

-- 테이블 생성 
create table covid 
( pat_sbst_no char(9) not null, 
  sex         char(1) not null, 
  constraint pk_corporation primary key (pat_sbst_no)
 );
 
-- 데이터 추가 
insert into covid ( pat_sbst_no, sex ) 
values ( '123456789', 'F'); 

-- 조회 
select name from covid where pat_sbst_no = 'F' ; 

-- page 36, 37  

-- SQLite sample database 에서 실습 
select customer.firstname, invoice.invoiceid, invoice.total 
from customer join invoice on (customer.customerid = invoice.customerid);

select customer.firstname, invoice.invoiceid, invoice.total 
from customer join invoice on (customer.customerid = invoice.customerid)
where firstname = 'Alexandre' and total > 5;

-- page 38 

-- 데이터 추가 
insert into covid ( pat_sbst_no, sex ) 
values ( '987654321', 'F'); 

-- 데이터 변경 
update covid 
set sex = 'M' 
where pat_sbst_no = '987654321'; 

-- 전체 조회 
select * from covid ;

