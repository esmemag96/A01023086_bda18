#Esmeralda Magdaleno Morales
#A01023086

#2
CREATE TABLE `sakila`.`LOG_FILM` (
		`id` INT not null AUTO_INCREMENT,
		`tipo` varchar(45) null,
		`film_Id` varchar(45) null,
		`last_value` varchar(45) null,
		`new_Value` varchar(45) null,
		`timestamp` TIMESTAMP not null DEFAULT CURRENT_TIMESTAMP,
		primary key (`id`)
    );
#3
drop procedure if exists `recibeDatos`;

	delimiter $$
	use `sakila`$$
	create  PROCEDURE `recibeDatos`(in filmID int, in newV varchar(45), in lastV varchar(45))
	begin
		declare fID  int;
		declare nValue  varchar(45);
		declare lValue  varchar(45);
		
		set fID = filmID;
		set nValue = newV;
		set lValue = lastV;
		insert into LOG_FILM (film_id, last_value, new_Value) values (fID,lValue, nValue);
	end$$

	delimiter;
#4
 delimiter $$
 create trigger guardaInfo after update on film 
     for each row
     begin
        call recibeDatos('update', OLD.film_id, old_value, new_value);
     end$$
delimiter ;

#5
delimiter $$
create PROCEDURE cambiaIdioma()
  begin
    declare ID int;
    declare fin int default false;
    declare continue handler for not found set fin = true;
    declare cur cursor for select film_id from film;

    open cur;
    read_loop: loop
      fetch cur into ID;
      if fin then
        leave read_loop;
      end if;
      if (select category_id from film_category where film_id = ID) = 6 then
        update film set idiomaOriginal=2 where film_id = ID;
      elseif (select category_id from film_category where film_id = ID) = 9 then
        update film set idiomaOriginal=3 where film_id = ID;
      elseif (select count(*) from film_actor where film_id = ID and actor_id=31) = 1 then
        update film set idiomaOriginal=6 where film_id = ID;
      elseif (select count(*) from film_actor where film_id = ID and actor_id=3) = 1 then
        update film set idiomaOriginal=4 where film_id = ID;
      elseif (select count(*) from film_actor where film_id = ID and actor_id=34) = 1 then
        update film set idiomaOriginal=5 where film_id = ID;
      else
        update film set idiomaOriginal=1 where film_id = ID;
      end if;
    end loop;
    close cur;
  end $$
delimiter ;

CALL cambiaIdioma();


#6

CREATE TABLE gomitas(
  IDGomita int not null generated always as identity (start with 1, increment BY 1),
  nombre varchar(150) not null,
  precio decimal(10,6) not null,
  fecha1 date not null,
  fecha2 date not null,
  period business_time(fecha1, fecha2),
  primary key(IDGomita, business_time without overlaps)
);

insert into gomitas (nombre, precio, fecha1, fecha2) values
  ('gomiloca1', 3, '2018-1-1', '2019-1-1'),
  ('gomiloca2', 9, '2018-1-1', '2019-1-1'),
  ('gomiloca3', 5, '2018-1-1', '2019-1-1'),
  ('gomiloca4', 8, '2018-1-1', '2019-1-1'),
  ('gomiloca5', 7, '2018-1-1', '2019-1-1'),
  ('gomiloca6', 10, '2018-1-1', '2019-1-1'),
  ('gomiloca7', 18, '2018-1-1', '2019-1-1'),
  ('ggomiloca8', 1, '2018-1-1', '2019-1-1'),
  ('gomiloca9', 13, '2018-1-1', '2019-1-1'),
  ('gomiloca10', 4, '2018-1-1', '2019-1-1'),
  ('gomiloca11', 8, '2018-1-1', '2019-1-1'),
  ('gomiloca12', 3, '2018-1-1', '2019-1-1');


update gomitas for portion of business_time FROM '2018-2-1' to '2019-1-1' SET precio = precio*1.45;
update gomitas for portion of business_time FROM '2018-2-15' to '2019-1-1' SET precio = (precio/1.45)*1.1;
update gomitas for portion of business_time FROM '2018-4-25' to '2019-1-1' SET precio = precio*1.45;
update gomitas for portion of business_time FROM '2018-5-5' to '2019-1-1' SET precio = (precio/1.45)*1.1;
update gomitas for portion of business_time FROM '2018-10-25' to '2019-1-1' SET precio = precio*1.45;
update gomitas for portion of business_time FROM '2018-11-5' to '2019-1-1' SET precio = (precio/1.45)*1.1;


SELECT * from gomitas WHERE nombre='gomiloca1';
SELECT SUM(precio)/COUNT(*) as AVG from gomitas WHERE nombre='gomiloca1';
SELECT MAX(precio) as MAX from gomitas WHERE nombre='gomiloca1';
SELECT MIN(precio) as MAX from gomitas WHERE nombre='gomiloca1';