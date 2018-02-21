describe select productlines.ProductLine, orders.customerNumber from productlines inner join products inner join orderdetails inner join orders where customerNumber = 112;
show index from orderdetails;

create index Product on orderdetails(productCode);

