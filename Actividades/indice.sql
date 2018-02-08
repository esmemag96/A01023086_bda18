explain

show index from orderdetails;
drop index ordernumeridx on orderdetails;

describe orderdetails 


select quantityordered 

explain
select * 
from orderdetails
where quantityOrdered = 45 



create index quantity_idx on orderdetails (quantityOrdered)
show index from orderdetails




