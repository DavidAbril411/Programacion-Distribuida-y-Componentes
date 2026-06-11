use pdc
go

drop table if exists dbo.detalle_carritos
drop table if exists dbo.carritos
drop table if exists dbo.productos
go

/* ------------------------------------------------
   Tabla: productos
   ------------------------------------------------ */
create table dbo.productos
(
 nro_producto	integer			not null
				constraint PK__productos__END primary key,
 cod_barra		varchar(13)		not null
				constraint UK__productos__END unique,
 nom_producto	varchar(100)	not null,
 precio			decimal(12,2)	not null
)
go

insert into dbo.productos(nro_producto, cod_barra, nom_producto, precio)
values(1, '7790123456789', 'Manteca', 2.50),
      (2, '7790987654321', 'Leche', 1.80),
      (3, '7790000111122', 'Coca Cola', 3.00),
      (4, '7790012345678', 'Pan', 1.20),
      (5, '7791111222233', 'Arroz', 2.00),
      (6, '7792222333344', 'Fideos', 1.50),
      (7, '7793333444455', 'Aceite', 4.20),
      (8, '7794444555566', 'Az�car', 1.90),
      (9, '7795555666677', 'Yerba', 3.50),
      (10, '7796666777788', 'Harina', 1.70),
      (11, '7797777888899', 'Galletitas', 2.30),
      (12, '7798888999900', 'Salchichas', 3.10),
      (13, '7799999000011', 'Queso', 4.80),
      (14, '7700000111222', 'Jugo', 2.60),
      (15, '7701111222333', 'Caf�', 5.00),
      (16, '7702222333444', 'T�', 1.40),
      (17, '7703333444555', 'Mermelada', 2.80),
      (18, '7704444555666', 'Milanesas', 6.20),
      (19, '7705555666777', 'Huevos', 2.90),
      (20, '7706666777888', 'Mantecol', 3.75)
go


/* ------------------------------------------------
   Tabla: carritos
   ------------------------------------------------ */
create table dbo.carritos
(
 nro_carrito			integer			not null
						constraint PK__carritos__END primary key,
 fecha_hora_registro	smalldatetime	not null
						constraint DF__carrito__fecha_hora_registro__current_timestamp__END default current_timestamp
)
go

/* ------------------------------------------------
   Tabla: detalle_carritos
   ------------------------------------------------ */
create table dbo.detalle_carritos
(
 nro_carrito			integer			not null
						constraint FK__detalle_carritos__carrito__END foreign key (nro_carrito) references dbo.carritos,
 nro_detalle			smallint		not null,
 nro_producto			integer			not null
						constraint FK__detalle_carritos__productos__END foreign key (nro_producto) references dbo.productos,
 fecha_hora_registro	smalldatetime	not null
						constraint DF__detalle_carritos__fecha_hora_registro__current_timestamp__END default current_timestamp,
 constraint PK__detalle_carritos__END 
			primary key (nro_carrito, nro_detalle)
)
go

/* ------------------------------------------------
   ins_producto_carrito
   ------------------------------------------------ */
create or alter procedure dbo.ins_producto_carrito
(
 @nro_carrito	integer		= null	output,
 @cod_barra		varchar(13)
)
as
begin
  
  declare @nro_producto integer,
          @nro_detalle	smallint
  
  select @nro_producto = nro_producto
    from dbo.productos (nolock)
   where cod_barra = @cod_barra

  if @nro_producto is null
	 begin
	   raiserror('El producto no existe', 16, 1)
	   return
	 end

  if isnull(@nro_carrito, 0) = 0
     begin
	   select @nro_carrito = isnull(max(nro_carrito), 0) + 1
	     from dbo.carritos (tablockx)

	   insert into dbo.carritos(nro_carrito)
	   values(@nro_carrito)
     end
     
  select @nro_detalle = isnull(max(nro_detalle), 0) + 1
    from dbo.detalle_carritos (tablockx)
   where nro_carrito = @nro_carrito

  insert into dbo.detalle_carritos(nro_carrito, nro_detalle, nro_producto)
  values(@nro_carrito, @nro_detalle, @nro_producto)

  select nroDetalle  = @nro_detalle,
         codBarra    = cod_barra,
         nomProducto = nom_producto,
	     precio      = precio
    from dbo.productos  (nolock)
   where nro_producto = @nro_producto

end
go

/*
declare @nro_carrito	integer		= null

execute dbo.ins_producto_carrito @nro_carrito=@nro_carrito output, @cod_barra='7790123456789'

select @nro_carrito
*/

/* ------------------------------------------------
   Elimina un producto del carrito
   ------------------------------------------------ */
declare @nro_carrito	integer = 1,
        @nro_detalle	integer	= 1

delete d
  from dbo.detalle_carritos d
 where d.nro_carrito = @nro_carrito
   and d.nro_detalle = @nro_detalle
go

/* ------------------------------------------------
   Consulta de productos del carrito
   ------------------------------------------------ */
declare @nro_carrito integer = 1

select nroDetalle  = d.nro_detalle,
       codBarra    = p.cod_barra,
       nomProducto = p.nom_producto,
	   precio      = p.precio
  from dbo.detalle_carritos d (nolock)
       join dbo.productos p (nolock)
	     on d.nro_producto = p.nro_producto
 where d.nro_carrito = @nro_carrito
 order by d.fecha_hora_registro
go
