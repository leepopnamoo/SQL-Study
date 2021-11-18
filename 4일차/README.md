# 4일차 
--- 
# 대용량 데이터베이스 작업 
## 17.1 분할 
### 17.1.1 분할개념 
### 17.1.2 테이블 분할 
### 17.1.3 인덱스 분할 
### 17.1.4 분할 방시 
### 17.1.5 분할 이점 
## 17.2 군집화 
## 17.3 샤딩 
## 17.4 빅데이터 
### 17.4.1 하둡 
### 17.4.2 NoSQL과 문서 데이터베이스 
### 17.4.3 클라우딩 컴퓨팅 
### 17.4.4 결론 

# SQL과 빅데이터 
## 18.1 아파치 드릴 소개 
## 18.2 드릴로 파일 쿼리하기 
## 18.3 드릴로 MySQL 쿼리하기 
## 18.4 드릴로 몽고 DB 쿼리하기 
## 18.5 다양한 데이터소스를 사용한 드릴 
--- 
# 데이터베이스 실습 

## x.1 DDL 
### x.1.1 테이블의 생성 
``` 
create table "테이블명" ( 
칼럼명1  칼럼타입1 [Null or Not Null], 
칼럼명2  칼럼타입2 [Null or Not Null], 
칼럼명3  칼럼타입3 [Null or Not Null], 
칼럼명4  칼럼타입4 [Null or Not Null], 
...
칼럼명n  칼럼타입n [Null or Not Null], 
constraint "키이름" primary key ("칼럼명x", "칼럼명x" ...)
) ; 
``` 
### x.1.2 테이블의 삭제 
```
drop table "테이블명" ; 
-- 강제삭제 : 참조키가 있을 경우 삭제 안됨 
drop table "테이블명" cascade ; 
``` 
### x.1.2 모든 데이터 삭제 
```
delete from "테이블명" ; 
-- 테이블 비우기 
truncate table "테이블명" ; 
``` 
## 울산모범식당 자료 처리 

[울산모범식당현황](https://www.data.go.kr/data/15083263/fileData.do) 
[울산모범음식점](https://data.ulsan.go.kr/user/apimng/dataset/totalView.ulsan?searchCondition=REG_TITLE&postSearch=%EB%AA%A8%EB%B2%94%EC%9D%8C%EC%8B%9D%EC%A0%90&searchRegGroup=&apiRegSid=169&regType=&orderField=VIEW_COUNT&orderSort=DESC&menuCd=DOM_000000101005000000&pageIndex=1&regGroupArr=&offerInstArr=#read/page=1&perPage=10) 

## x.1 원본자료 생성 
### x.1.1 CSV 파일 다운로드 
### x.1.2 DDL 작성 
  > 울산 모범 식당 현황 : 테이블명 - goodrest 
  > 울산 모범 음식점 현황 : 테이블명 - bestrest 
### x.1.3 DATA Import 

## x.2 정규화 
### x.2.1 테이블 설계 
### x.2.2 DDL 작성 
### x.2.3 테이터 분류 
### x.2.4 자료 업로드 
### x.2.5 조회 

### HTML 자료 만들어 보기 
