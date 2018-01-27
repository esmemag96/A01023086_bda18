-- Ejercicios Triggers Esmeralda A01023086

create trigger update_salario after update of salary on employee referencing new as new_values old as old_values for each row mode db2sql when (new_values.salary  > (old_values * 1.3)) begin atomic signal sqlstate '56001' ('ERROR, no se puede actualizar el salario'); end 

create table orders (id_producto int varchar(255) not null, cant_productos int , estado varchar(255)not null) 
create trigger insert_orden before insert of id_producto on orders referencing new as new_values when (new_values > select qty from inventory) begin atomic signal sqlstate '56001' ('ERROR'); end 


create trigger delete_productos after update on orders referencing new as new_values for each row when(new_values.QTY>select quantity from inventory where PID like new_values.id_producto)) begin atomic signal sqlstate '56001' ('ERROR'); end 

create trigger estado_productos after update of ID on Ordenes referencing new as new_values for each row mode db2sql when (new_value.estado = 1) begin atomic update inventory set quantity = quantity - new_values.cantidad; end



