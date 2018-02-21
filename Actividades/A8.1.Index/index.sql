create index index1 on orderdetails(orderLineNumber)
create index index2 on orderdetails(quantityOrdered, orderLineNumber)
create index index3 on orderdetails(OrderLineNumber, quantityOrdered)
create index index4 on orderdetails(OrderLineNumber, quantityOrdered) using hash

//index 1
explain format = json select * from orderdetails force index(index1) where orderLineNumber = 1 and quantityOrdered > 50
cost = 95.2

explain format = json select productCode from orderdetails force index(index1) where orderLineNumber = 1 and quantityOrdered > 50
cost = 95.2

explain format = json select orderLineNumber, count(*) from orderdetails force index(index1) where orderLineNumber = 1 and quantityOrdered > 50
cost = 95.2

//index 2

explain format = json select * from orderdetails force index(index2) where orderLineNumber = 1 and quantityOrdered > 50
cost = 93.41


explain format = json select productCode from orderdetails force index(index2) where orderLineNumber = 1 and quantityOrdered > 50
cost = 27.62

explain format = json select orderLineNumber, count(*) from orderdetails force index(index2) where orderLineNumber = 1 and quantityOrdered > 50
cost = 27.62

//index 3

explain format = json select * from orderdetails force index(index3) where orderLineNumber = 1 and quantityOrdered > 50
cost = 8.01


explain format = json select productCode from orderdetails force index(index3) where orderLineNumber = 1 and quantityOrdered > 50
cost = 3.02

explain format = json select orderLineNumber, count(*) from orderdetails force index(index3) where orderLineNumber = 1 and quantityOrdered > 50 
cost = 3.02