delimiter $$

create procedure show_products(

IN linea_producto varchar(50))
BEGIN 
	declare line varchar(50);

    set line = concat(linea_producto, "%");
    select * from products
    where productLine like line;
    
END$$


create procedure
ClientByName(in linea_customerName varchar(50))
BEGIN

  	declare line varchar (50);
  	declare cont int default 0;
    
    set line =concat(linea_customerName,"%");
    
    select count(*) into cont from customers where customerName like line;
    select contador;
    
END$$

create procedure  ComparaPrecios()

BEGIN
    declare caro
    declare barato 
    
	select productname into barato from products barato
	order by buyPrice DESC LIMIT 1;

	select productname into caro  from products caro
	order by buyPrice ASC LIMIT 1;

	select barato, caro;
    
END$$

delimiter ;
