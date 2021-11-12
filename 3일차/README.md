# 3 일차 
---
# 10 조인의 심화   
## 10.1 Outer Join 

### 10.1.1 Left, Right Join 
### 10.1.2 3 way outer join 
## 10.2 교차 조인 
## 10.3 자연 조인 
## 10.4 학습 점검 
### 10.4.1 실습 10-1 
### 10.4.2 실습 10-2 
### 10.4.3 실습 10-3 
# 11 조건식   
## 11.1 조건식 
## 11.2 case 표현식 - p.274 
> case 표현식은 SQL 문법에 내장되어 있으며, select, insert, update, delete 문에 포함될 수 있습니다. 
## 11.2.1 검색에서의 case 문 
``` 
case 
  when 조건1 then 값1 
  when 조건2 then 값2 
  when 조건3 then 값3 
  ... 
  when 조건n then 값n 
  [ELSE 값] 
end 
```
- select 구문안에 case 문 
- 사망자중 생활치료센터 입소 유무 구분 
```
select a.*,  
       case when exists (select 1 from pop_covid19 c where c.pat_sbst_no = a.pat_sbst_no and c.ward = 'L') then '생황치료센터입소'
            else '생활치료센터입소없음' 
       end as 상태 
from covid19_death a 
``` 

## 11.3 case 표현식의 예 

## 11.4 학습 점검 
### 11.4.1 실습 11-1 
### 11.4.2 실습 11-2 
# 12 트랜젝션   
> transaction 테스트 환경구성을 위해서 아래와 같이 설정을 진행합니다. 
> DBeaver에서 PostgreSQL에 연결돤 데이터베이스 connection을 추가로 복사하고 설정을 아래와 같이 변경. (나머지 동일) 
![데이터베이스연결](../images/connectsetup.jpg)   
## 12.1 다중 사용자 데이터베이스 
- Autocommit 를 False로 설정하여 접속한 connection에서 새로운 script 창을 생성합니다. 
- script 창에 아래 1 과 2 를 차례대로 실행합니다. 
- 3 script는 실행하지 않아야 하며, 3 script를 실행하기 전까지는 a테이블의 c6 항목의 페이지가 locking된 상태로 
- 유지됩니다. 
- 4 번 script를 Autocommit True가 되어 있는 창에서 실행해 봅니다. 
- 결과가 어떻게 보이는지 확인 합니다. 
- 다시 script 3을 Autocommit False가 되어 있는 창에서 결과를 조호해보고 Rollback한 후 결과를 확인합니다. 
``` 
-- 1 
update a 
set c6 = (case when c6 = 'M' then '남'
               when c6 = 'F' then '여' end) 
;
-- 2 
select * from a;

-- 3
rollback ;
``` 
- 기존 창에서 a 테이블의 값이 변경되었는지 확인 
``` 
-- 4 
select * from a; 
``` 

### 12.1.1 lock  p.288 
- 앞에서 테스트한 환경에서 동일한 Update 구문을 Autocommit False 창에서 먼저 실행하고 
- Autocommit True 창에서 다시 실행하면 어떤 현상이 발생되지 확인을 합니다.    
### 12.1.2 lock의 단위   
> table lock : 테이블 단위의 lock 관리 
> page lock : 동일한 페이지 단위의 lock을 관리(page size 2kb ~ 16kb) 
> row lock : 하나의 행에 대해 lock 관리 
> column lock : column 단위 lock 
## 12.2 트랜잭션   
- 트랜잭션의 완료는 commit, rollback 입니다. 
- commit는 수행한 모든 작업을 database에 적용하며 
- rollback는 이전까지 수행한 모든 작업을 작업시작전으로 되돌려 놓습니다. 
## 12.3 학습 점검 
### 12.3.1 실습 12-1 
# 13 인덱스와 제약조건   
## 13.1 인덱스 
## 13.2 제약조건 
## 13.3 학습 점검 
### 13.3.1 실습 13-1 
### 13.3.2 실습 13-2 
# 14 뷰   
## 14.1 뷰 
## 14.2 뷰를 사용하는 이유 
## 14.3 갱신 가능한 뷰 
## 14.4 학습 점검 
### 14.4.1 실습 14-1 
### 14.4.2 실습 14-2 
# 15 메타데이터   
## 15.1 데이터에 관한 데이터 
## 15.2 정보 스키마 
## 15.3 메타데이터로 작업하기 
## 15.4 학습점검 
### 15.4.1 실습 15-1 
### 15.4.2 실습 15-2 
# 16 분석함수   
## 16.1 분석 함수의 개념 
### 16.1.1 데이터 윈도우 
### 16.1.2 로컬 정렬 
## 16.2 순위 
### 16.2.1 순위 함수
### 16.2.2 다양한 순위 생성 
## 16.3 리포팅 함수  
### 16.3.1 윈도우 프레임 
### 16.3.2 lag() 함수와 lead() 함수 
### 16.3.3 group_concat() 함수 
## 16.4 학습 점검 
### 16.4.1 실습 16-1 
### 16.4.2 실습 16-2 
### 16.4.3 실습 16-3 

