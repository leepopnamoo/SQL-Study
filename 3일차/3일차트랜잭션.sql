update a 
set c6 = (case when c6 = 'M' then '��'
               when c6 = 'F' then '��' end) 
;

select * from a;

rollback ;