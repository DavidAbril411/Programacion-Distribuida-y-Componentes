use pdc
go

drop table if exists dbo.mejoras_reservas
drop table if exists dbo.reservas
drop table if exists dbo.clientes
go

/* -----------------------------------------
   Tabla: clientes
   ----------------------------------------- */
create table dbo.clientes
(
 nro_cliente		integer			identity
					constraint PK__clientes__END primary key,
 apellido			varchar(40)		not null,
 nombre				varchar(255)	not null,
 nro_documento		varchar(20)		not null
					constraint UK__clientes__END unique
)
go

insert into dbo.clientes (apellido, nombre, nro_documento) 
values('GONZÁLEZ', 'MARTÍN ALEJANDRO', '30223123'),
      ('MENDOZA', 'JUANA CECILIA', '28345234'),
      ('SÁNCHEZ', 'ROBERTO MANUEL', '31220987'),
      ('FERNÁNDEZ', 'CARLA MABEL', '29543321'),
      ('DÍAZ', 'LUIS EDUARDO', '32455678'),
	  ('ÁLVAREZ', 'MARCELA VERÓNICA', '27455893'),
      ('ROMERO', 'ANDRÉS ESTEBAN', '30123456'),
      ('ALVAREZ', 'CINTIA NOEMÍ', '31876543'),
      ('TORRES', 'JULIO CÉSAR', '29234567'),
      ('RAMÍREZ', 'ANA LAURA', '32654123'),
      ('MEDINA', 'DIEGO HERNÁN', '28451234'),
      ('ACUÑA', 'BELÉN ROSARIO', '30987654'),
      ('MARTÍNEZ', 'SANTIAGO RAMIRO', '29887766'),
      ('GUTIÉRREZ', 'DANIELA VICTORIA', '31029384'),
      ('CASTRO', 'IGNACIO LEONEL', '28777441'),
      ('MORALES', 'PAULA NATALIA', '30111222'),
      ('RIVERO', 'JAVIER ALFONSO', '31445566'),
      ('NÚÑEZ', 'LILIANA GRACIELA', '29667345'),
      ('IBÁÑEZ', 'VICTOR HUGO', '27788990'),
      ('MEDINA', 'CLAUDIA PATRICIA', '31333444'),
      ('REYES', 'FACUNDO MAURICIO', '30293847'),
      ('SALAZAR', 'MILAGROS ANABEL', '28889977'),
      ('VIDAL', 'EZEQUIEL LUIS', '30664321'),
      ('CORONEL', 'MAGALÍ SOFÍA', '29771234'),
      ('ESCOBAR', 'RICARDO DAMIÁN', '29990001')
go

/* -----------------------------------------
   Tabla: reservas
   ----------------------------------------- */
create table dbo.reservas
(
 nro_reserva		integer			identity
					constraint PK__reservas__END primary key,
 cod_reserva		varchar(36)		not null
					constraint DF__reservas__cod_reserva__END default convert(varchar(36), newid()),
 fecha_reserva		smalldatetime	not null
					constraint DF__reservas__fecha_reserva__current_timestamp__END default current_timestamp,
 nro_cliente		integer			not null
					constraint FK__reservas__clientes__END references dbo.clientes,
 tipo_clase			varchar(3)		not null
					constraint CK__reservas__tipo_clase__END check (tipo_clase in ('ECO', 'EJ', 'PC')),
)
go

insert into dbo.reservas (nro_cliente, tipo_clase) 
values(1, 'ECO'),  -- GONZÁLEZ
      (2, 'ECO'),  -- MENDOZA
      (3, 'EJ'),   -- SÁNCHEZ
      (4, 'ECO'),  -- FERNÁNDEZ
      (5, 'PC'),   -- DÍAZ
      (6, 'ECO'),  -- ÁLVAREZ
      (7, 'ECO'),  -- ROMERO
      (8, 'EJ'),   -- ALVAREZ
      (9, 'ECO'),  -- TORRES
      (10, 'PC'),  -- RAMÍREZ
      (11, 'ECO'), -- MEDINA
      (12, 'ECO'), -- ACUÑA
      (13, 'EJ'),  -- MARTÍNEZ
      (14, 'ECO'), -- GUTIÉRREZ
      (15, 'PC'),  -- CASTRO
      (16, 'ECO'), -- MORALES
      (17, 'EJ'),  -- RIVERO
      (18, 'ECO'), -- NÚÑEZ
      (19, 'ECO'), -- IBÁÑEZ
      (20, 'PC'),  -- MEDINA
      (21, 'EJ'),  -- REYES
      (22, 'ECO'), -- SALAZAR
      (23, 'EJ'),  -- VIDAL
      (24, 'PC'),  -- CORONEL
      (25, 'ECO'); -- ESCOBAR
go

/* -----------------------------------------
   Tabla: mejoras_reservas
   ----------------------------------------- */
create table dbo.mejoras_reservas
(
 nro_reserva		integer			not null,
 tipo_clase			varchar(3)		not null
					constraint CK__mejoras_reservas__tipo_clase__END check (tipo_clase in ('ECO', 'EJ', 'PC')),
 fecha_registro		smalldatetime	not null
					constraint DF__mejoras_reservas__fecha_registro__current_timestamp__END default current_timestamp,
 monto				decimal(12,2)	not null,
 constraint PK__mejoras_reservas__END 
				primary key (nro_reserva, tipo_clase)
)
go

/* -----------------------------------------
   Procedimiento: val_reserva
   ----------------------------------------- */
create or alter procedure dbo.val_reserva
(
 @nro_documento		varchar(20),
 @cod_reserva		varchar(36)
)
as
begin

  declare @nro_reserva	integer,
          @tipo_clase	varchar(3)
		  
  select @nro_reserva = r.nro_reserva, 
         @tipo_clase  = r.tipo_clase
    from dbo.reservas r (nolock)
	     join dbo.clientes c (nolock) 
		   on r.nro_cliente = c.nro_cliente 
   where r.cod_reserva   = @cod_reserva
     and c.nro_documento = @nro_documento

   if @nro_reserva is null
      begin
	    raiserror('La reserva no es válida', 16, 1)
		return
	  end

   if @tipo_clase <> 'ECO'
      begin
	    raiserror('Su reserva no es de clase ECONÓMICA por lo que no puede hacer un upgrade', 16, 1)
		return
	  end
      
  select apellido      = c.apellido,
         nombre        = c.nombre,
		 nroCliente    = r.nro_cliente,
		 tipoClaseDesc = 'Económica',
		 tipoClase     = r.tipo_clase,		 
		 fechaReserva  = r.fecha_reserva,
		 nroReserva    = r.nro_reserva
	from dbo.reservas r (nolock)
	     join dbo.clientes c (nolock)
		   on r.nro_cliente = c.nro_cliente
   where r.nro_reserva = @nro_reserva

end
go

/*
select *
  from dbo.reservas r
       join dbo.clientes c
	     on r.nro_cliente = c.nro_cliente
 where tipo_clase = 'ECO'

execute dbo.val_reserva @nro_documento='29543321', @cod_reserva='9989742F-D5E8-4390-804C-98F3F02F720F'
*/

/* -----------------------------------------
   Sentencia de inserción de mejora
   ----------------------------------------- */
declare @nro_reserva	integer			= 1,
        @tipo_clase		varchar(3)		= 'EJ',
		@monto			decimal(12,2)	= 10

insert into dbo.mejoras_reservas(nro_reserva, tipo_clase, monto)
values(@nro_reserva, @tipo_clase, @monto)
go

