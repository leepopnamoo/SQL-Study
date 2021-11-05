# 2 일차   
---
# 4 데이터베이스 생성    
## 4.1 조건평가 

+ customer 테이블에서 이름이 Steven 이면서 생성일자가 2006.01.01 이후 자료를 조회하시오.   
+ customer 테이블에서 이름이 Steven 이거나 생성일자가 2006.01.01 이후 자료를 조회하시오.   

<details>
<summary>코드보기</summary>
<div markdown="1"> 
  
```
select * from public.customer 
where first_name = 'Steven' and create_date > '2006.01.01';  

select * from public.customer 
where first_name = 'Steven' or create_date > '2006.01.01';  
```
</div>
</details>    

### 4.1.1 괄호사용 

+ customer 테이블에서 이름이 Steven 또는 성이 Young인 사람중 이거나 생성일자가 2006.01.01 이후 자료를 조회하시오.   

<details>
<summary>코드보기</summary>
<div markdown="1"> 
  
```
select * from public.customer 
where (first_name = 'Steven' or last_name = 'Young') 
and create_date > '2006.01.01';  
```
</div>
</details>    

### 4.1.2 not 연산자 사용 

``` 
select * from public.customer 
where not (first_name = 'Steven' or last_name = 'Young') 
and create_date > '2006.01.01';  

select * from public.customer 
where first_name != 'Steven' and last_name != 'Young'  
and create_date > '2006.01.01';  
``` 

## 4.2 조건작성 

+ 두번 이상 내원한 사람의 대체번호, 성별, 내원건수를 구하시오. 
+ 월별 건수를 구하시오. 
+ 평균재원일수를 구하시오. 

<details>
<summary>코드보기</summary>
<div markdown="1">   
	
``` 
-- covid19 총건수 1,571, 총인원 1,654 
select count(1) from study.covid19; 
select count(distinct pat_sbst_no) from study.covid19;

-- 2번 이상 내원한 사람의 대체번호, 성별, 내원건수   
select pat_sbst_no, sex, count(1) as cnt 
from study.covid19 c 
group by pat_sbst_no, sex  
having count(1) > 1 ;

-- 월별건수를 구해보세요. 
select to_char(adm_date, 'YYYY-MM') as month, count(1) as cnt 
from study.covid19 c 
group by to_char(adm_date, 'YYYY-MM')
order by 1 ;

-- 평균 재원기간을 구해보세요. 
select avg(disch_date - adm_date) 평균재원일수, min(disch_date - adm_date), max(disch_date - adm_date) 
from study.covid19 
where disch_date != '2070-12-31';

-- 입원일자 퇴원일자 점검 
select min(adm_date), max(disch_date)
from study.covid19;

-- 재원기간이 0인경우 검증 
select disch_state, disch_survive_state 
from study.covid19 
where (disch_date - adm_date) = 0;
``` 
</div>
</details>     

## 4.3 조건유형 

+ 혈액형이 엽려된 사람중 형액형별 비율을 구하시오. 

<details>
<summary>코드보기</summary>
<div markdown="1">   

```
-- 혈액형이 입력된 사람중 형액형별 비율을 구하시오. 
select abo, count(1) as cnt, (select count(1) from study.covid19 a where a.abo is not null) as total, t.total    
from study.covid19 cross join (select count(1) as total from study.covid19 where abo is not null) t  
where abo is not null
group by abo, t.total; 
-- 혈액형별 비율 
select abo, count(1) as cnt, t.total, round((count(1) / t.total::decimal) * 100.00,2) as perabo     
from study.covid19 cross join (select count(1) as total from study.covid19 where abo is not null) t  
where abo is not null
group by abo, t.total;
``` 
</div>
</details>      

### 4.3.1 동등조건 

+ 남자의 혈맥형 비율을 구하시오. 
+ 남자가 아닌 경우 혈액형 비율을 구하시오. 

<details>
<summary>코드보기</summary>
<div markdown="1"> 

```
-- 혈액형 비율 남자 
select abo, count(1) as cnt, t.total, round((count(1) / t.total::decimal) * 100.00,2) as perabo     
from study.covid19 cross join (select count(1) as total from study.covid19 where abo is not null) t  
where abo is not null and sex = 'M'
group by abo, t.total;

-- 혈액형 비율 남자가 아닌 경우 
select abo, count(1) as cnt, t.total, round((count(1) / t.total::decimal) * 100.00,2) as perabo     
from study.covid19 cross join (select count(1) as total from study.covid19 where abo is not null) t  
where abo is not null and sex != 'M'
group by abo, t.total;

``` 
</div>
</details>      

### 4.3.2 범위조건 

+ pop_covid19 테이블의 ward 칼럼에서 'L'(생활지료센터)값을 아래와 같이 출력 되로록 작성하시오.  
   
```
c_year|c_1m|c_2m|c_3m|c_4m|c_5m|c_6m|c_7m|c_8m|c_9m|c_10m|c_11m|c_12m|
------|----|----|----|----|----|----|----|----|----|-----|-----|-----|
2021  | 473| 103| 169| 832| 951| 495|1207| 785|    |     |     |     |
2020  |    |  17|  25|   7|  12|   4|   4|  36|  53|   24|   49|  531|
```   
+ 항목값의 social|Social|Social.|SOCIAL|사회적 단어가 있는 사람을 조회하시오.  
+ 막걸리|맥주|소주|보드카|소병|위스키|와인|양주|포도주 포함하고 있는 항목을 조회하시오. 
+ 주종을 분류하고 각 건수를 구하시오.    
   
<details>
<summary>코드보기</summary>
<div markdown="1">  
	
``` 
-- pop_covid19 ward 칼럼의 'L' 생활 지료센터에 2021년 
-- 년도별(row) 월별(column) 건수  
select to_char(ent_date, 'YYYY') as c_year, 
       sum(case when to_char(ent_date, 'MM') = '01' then 1 end) as c_1M, 
       sum(case when to_char(ent_date, 'MM') = '02' then 1 end) as c_2M,
       sum(case when to_char(ent_date, 'MM') = '03' then 1 end) as c_3M,
       sum(case when to_char(ent_date, 'MM') = '04' then 1 end) as c_4M,
       sum(case when to_char(ent_date, 'MM') = '05' then 1 end) as c_5M,
       sum(case when to_char(ent_date, 'MM') = '06' then 1 end) as c_6M,
       sum(case when to_char(ent_date, 'MM') = '07' then 1 end) as c_7M,
       sum(case when to_char(ent_date, 'MM') = '08' then 1 end) as c_8M,
       sum(case when to_char(ent_date, 'MM') = '09' then 1 end) as c_9M,
       sum(case when to_char(ent_date, 'MM') = '10' then 1 end) as c_10M,
       sum(case when to_char(ent_date, 'MM') = '11' then 1 end) as c_11M,
       sum(case when to_char(ent_date, 'MM') = '12' then 1 end) as c_12M 
from study.pop_covid19 
--where ent_date between '2021-01-01' and '2021-12-31'
group by 1 ; 

-- 문자열 범위 : 문자열 처리 
-- 음주습관 항목값을 조회하세요. 
select alcohol_amount 
from study.covid19 
order by 1 ;

-- 항목값의 social|Social|Social.|SOCIAL|사회적 단어가 있는 사람을 조회하세요. 
select alcohol_amount,
       case when alcohol_amount ~ '(한잔|한 잔)' then 1 
            when alcohol_amount ~ '(한병|한 병)' then 5 
            when alcohol_amount ~ '-' then 0 
            when alcohol_amount ~ '(social|Social|Social.|SOCIAL|사회적)' then 4
            else -1
       end as drink 
from study.covid19 
order by 1 ;

-- 막걸리|맥주|소주|보드카|소병|위스키|와인|양주|포도주 포함하고 있는 항목을 조회하시오.    
select alcohol_amount,
       case when alcohol_amount ~ '(막걸리)' then '막걸리' 
            when alcohol_amount ~ '(맥주|맥 주)' then '맥주' 
            when alcohol_amount ~ '(소주|소병)' then '소주' 
            when alcohol_amount ~ '(보드카|위스키|양주)' then '양주'
            when alcohol_amount ~ '(와인|포도주)' then '양주'
       end as 주종  
from study.covid19 
where alcohol_amount ~ '(막걸리|맥주|소주|보드카|소병|위스키|와인|양주|포도주)'
order by 1 ;

-- 주종을 분류하고 각 건수를 구하시오.
select 
       case when alcohol_amount ~ '(막걸리)' then '막걸리' 
            when alcohol_amount ~ '(맥주|맥 주)' then '맥주' 
            when alcohol_amount ~ '(소주|소병)' then '소주' 
            when alcohol_amount ~ '(보드카|위스키|양주)' then '양주'
            when alcohol_amount ~ '(와인|포도주)' then '양주'
       end as 주종,  
       count(1) as 건수  
from study.covid19 
where alcohol_amount ~ '(막걸리|맥주|소주|보드카|소병|위스키|와인|양주|포도주)'
group by 1 
order by 1 ;
``` 
</div>
</details>     

### 4.3.3 멤버십조건  

+ 입력된 학력구분을 조회하시오. 
+ 학력구분별 건수를 나이대별로 아래와 같이 조회하시오. 

```  
학력|c20대|c30대|c40대|c50대|c60대|c70대_이상|
--|----|----|----|----|----|-------|
01|   1|   4|    |   9|  61|    130|
02|    |    |    |   1|   2|      5|
03|   1|    |   3|  27|  65|     31|
05|  37|  37|  88| 185| 112|     29|
08|  31|   2|   2|   3|   1|       |
``` 
+ covid19_pop 모집단에서 생치(L)에 입원한 사람을 기준으로 covid19 10명을 조회하시오. 

<details>
<summary>코드보기</summary>
<div markdown="1">    
	
```
-- 입력된 학력구분을 조회하시오. 
select distinct education  
from study.covid19 
order by 1 ;

-- 학력구분이 '01', '02', '03', '05', '08' 인 사람중 나이대별 학력별 건수를 구하시오. 
select education as 학력, 
	   sum(case when age between 20 and 29 then 1 end) as c20대,
	   sum(case when age between 30 and 39 then 1 end) as c30대,
	   sum(case when age between 40 and 49 then 1 end) as c40대,
	   sum(case when age between 50 and 59 then 1 end) as c50대,
	   sum(case when age between 60 and 69 then 1 end) as c60대,
	   sum(case when age >= 70 then 1 end) as c70대_이상
from study.covid19 
where education in ('01', '02', '03', '05', '08')
and age >= 20
group by 1 
order by 1 
;

-- covid19_pop 모집단에서 생치(L)에 입원한 사람을 기준으로 covid19 10명을 조회하시오. 
-- 서버 쿼리 
select c.pat_sbst_no, c.adm_date, c.sex, c.age 
from study.covid19 c 
where c.pat_sbst_no in (select p.pat_sbst_no from study.pop_covid19 p where p.ward = 'L')
limit 10
; 
``` 
</div>
</details>     
	
### 4.3.4 일치조건 
## 4.4 Null 
## 4.5 학습 점검 
### 4.5.1 실습 4-1 
### 4.5.2 실습 4-2 
### 4.5.3 실습 4-3 
### 4.5.4 실습 4-4 
--- 
# 5 다중 테이블 쿼리 

``` 
-- 1에서 9까지 row생성 
select GENERATE_SERIES(1,9) as t;
select unnest(ARRAY(SELECT * FROM generate_series(1, 9)));
```  

## 5.1 조인 
### 5.1.1 데카르트 곱 

``` 
select a, b 
from GENERATE_SERIES(1,9) a cross join  
     GENERATE_SERIES(1,9) b ;

-- 1달 생성     
select generate_series(
           (date '2021-11-01')::timestamp,
           (date '2021-11-30')::timestamp,
           interval '1 day' -- 1 month 1 year  
         ); 
```  
### 5.1.2 내부 조인 
### 5.1.3 ANSI 조인 문법 
## 5.2 세 개 이상 테이블 조건 
### 5.2.1 서브쿼리 사용  

``` 
select count(1) from study.pop_covid19 where ward = 'L'; 
select count(1) from study.pop_covid19 where ward = 'I';

-- 생활치표센터에서 전원된 60대 이상을 조회하시오. 
select c.pat_sbst_no, c.pat_idx, c.age  
from study.covid19 c join 
     (select pat_sbst_no from study.pop_covid19 where ward = 'L') t on ( t.pat_sbst_no = c.pat_sbst_no)
where c.age > 60     
;     
```   

### 5.2.2 테이블 재사용 
## 5.3 셀프 조인 

+ pop_covid19 테이블 하나를 이용하여 self join 으로 생활치료센터, 병원 입원이 있는 사람을 조회하시오. 
+ 생치에서 병원, 병원에서 생치로 이송된 사람을 구분하고 각 건수를 구하시오.  

<details>  
<summary>코드보기</summary>   
<div markdown="1">          
   	
```     
-- pop_covid19 테이블 하나를 이용하여 self join 으로 생활치료센터, 병원 입원이 있는 사람을 조회하시오. 
select distinct a.pat_sbst_no
from study.pop_covid19 a join study.pop_covid19 b on (a.pat_sbst_no = b.pat_sbst_no)
where a.ward = 'L' and b.ward = 'I';

-- 생치에서 병원, 병원에서 생치로 이송된 사람을 구분하고 각 건수를 구하시오. 
select -- a.pat_sbst_no, a.ent_date, b.ent_date,
       case when a.ent_date >= b.ent_date then '생치에서 병원'
            when a.ent_date < b.ent_date then '병원에서 생치' end as 구분 
       , count(1) as 건수 
from study.pop_covid19 a join study.pop_covid19 b on (a.pat_sbst_no = b.pat_sbst_no)
where a.ward = 'L' and b.ward = 'I'
group by 1 ;    
```    				
</div>
</details>             
   				
## 5.4 학습 점검 
### 5.4.1 실습 5-1 
### 5.4.2 실습 5-2 
### 5.4.3 실습 5-3 
--- 
# 6 집합 연산자 
## 6.1 집합 이론  
   
``` 
select count(1) from (
	select pat_sbst_no from study.pop_covid19 where ward = 'L' 
	union all 
	select pat_sbst_no from study.pop_covid19 where ward = 'I'
) t ;

select count(1) from (
	select pat_sbst_no from study.pop_covid19 where ward = 'L' 
	union  
	select pat_sbst_no from study.pop_covid19 where ward = 'I'
) t ;

select count(1) from (
	select pat_sbst_no from study.pop_covid19 where ward = 'L' 
	intersect   
	select pat_sbst_no from study.pop_covid19 where ward = 'I'
) t ;

select count(1) from (
	select pat_sbst_no from study.pop_covid19 where ward = 'L' 
	except    
	select pat_sbst_no from study.pop_covid19 where ward = 'I'
) t ; 
```   

## 6.2 집합 이론 실습 
## 6.3 집합 연산자 
### 6.3.1 union 연산자 
### 6.3.2 intersect 연산자 
### 6.3.3 except 연산자 
## 6.4 집합 연산 규칙 
### 6.4.1 복합 쿼리의 결과 정렬 
### 6.4.2 집합 연산의 순서 
## 6.5 학습 점검 
### 6.5.1 실습 6-1 
### 6.5.2 실습 6-2 
### 6.5.3 실습 6-3 
--- 
# 7 데이터 생성, 조작과 변환 
## 7.1 문자열 데이터 처리 

``` 
select '빅데이터''s' as title;
select $$빅데이터's$$ as title; 
```   

### 7.1.1 문자열 생성 
   
``` 
select 'first line'||chr(10)||'second line' as multi_line;  
``` 
   
### 7.1.2 문자열 조작 
   
``` 
-- rh 값이 있는 사람을 조회하시오 
select rh from study.covid19 where rh is not null;

-- right로 rh 값에서 +, - 를 추출하세요 
select right(trim(rh),1) as RH from study.covid19 where rh is not null;
select length(rh) from study.covid19 where rh is not null;
select length(trim(rh)) from study.covid19 where rh is not null;
select case when position('+' in rh) > 0 then '+' else '-' end as RH from study.covid19 where rh is not null; 
``` 

## 7.2 숫자 데이터 처리   

``` 
select mod(10,4);
select pow(2,8); 
```  

### 7.2.1 산술 함수 
### 7.2.2 숫자 자릿수 관리 
### 7.2.3 Signed 데이터 처리 
## 7.3 시간 데이터 처리 
	
+ 나이대별 최소 입원일자를 구하시오.   
+ 요일별 입원건수를 구하시오. 	
+ 입원기간을 계산하시오.   	
	
<details>
<summary>코드보기</summary>
<div markdown="1">    	
   
``` 
-- 나이대별 최소 입원일자를 구하시오.  
select 
	   case when age < 20 then '10대'  
	        when age between 20 and 29 then '20대'
	        when age between 30 and 39 then '30대'
	        when age between 40 and 49 then '40대'
	        when age between 50 and 59 then '50대' 
	        when age between 60 and 69 then '60대' 
	        when age >= 70 then 'c70이상' end as age_group   
from study.covid19; 

select * 
from (
	select (case when (age/10) <= 1 then 1 
	             when (age/10) >= 7 then 7 
	             else (age/10) end)||'0대' as age_group, 
	       adm_date,       
	       row_number() over (partition by (case when (age/10) <= 1 then 1 
									             when (age/10) >= 7 then 7 
									             else (age/10) end) order by adm_date asc) as adm_rank	      
	from study.covid19
) t 
where t.adm_rank = 1 ; 

-- 요일별 입원건수를 구하시오. 1.sunday 
select to_char(adm_date, 'D') 요일, count(1) as 건수 
from study.covid19 
group by 1 
order by 1 
; 

-- 입원기간을 계산하시오 
--select datediff(dd, adm_date, disch_date) from study.covid19

select DATE_PART('day', disch_date::timestamp - adm_date::timestamp), disch_date
from study.covid19

```   
</div>
</details>      
	
### 7.3.1 시간대 처리 
### 7.3.2 시간 데이터 생성 
## 7.4 변환 함수 
## 7.5 학습 점검 
### 7.5.1 실습 7-1 
### 7.5.2 실습 7-2 
### 7.5.3 실습 7-3 
--- 
# 8 그룹화와 집계 
## 8.1 그룹화의 개념 
## 8.2 집계 함수 
### 8.2.1 명시적 그룹과 암시적 그룹 
### 8.2.2 고유한 값 계산 
### 8.2.3 표현식 사용 
### 8.2.4 Null 처리 방법 
## 8.3 그룹 생성 
### 8.3.1 단일 열 그룹화 
### 8.3.2 다중 열 그룹화 
### 8.3.3 그룹화와 표현식 
### 8.3.4 롤업 생성 
## 8.4 그룹 필터조건 
## 8.5 학습 점검 
### 8.5.1 실습 8-1 
### 8.5.2 실습 8-2 
### 8.5.3 실습 8-3 
--- 
# 9 서브쿼리 
## 9.1 서브쿼리 
## 9.2 서브쿼리의 유형 
## 9.3 비상관 서브쿼리 
### 9.3.1 단일 열을 가진 다중 행을 반환하는 서브쿼리 
### 9.3.2 다중 열 서브쿼리 
## 9.4 상관 서브쿼리 
### 9.4.1 exists 연산자 
### 9.4.2 상관 서브쿼리를 이용한 데이터 조작 
## 9.5 서브쿼리를 사용하는 경우 
### 9.5.1 데이터 소스로서의 서브쿼리 
### 9.5.2 표현식 생성기로서의 서브쿼리 
## 9.6 서브쿼리 요약 정리 
## 9.7 학습 점검
### 9.7.1 실습 9-1 
### 9.7.2 실습 9-2 
### 9.7.3 실습 9-3 

# 기타 실습 







