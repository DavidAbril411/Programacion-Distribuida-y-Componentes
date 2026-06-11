use pdc
go

drop table if exists dbo.reclamos
go
drop table if exists dbo.vehiculos
go

create table dbo.vehiculos
(
 nro_chasis		varchar(17)		not null
				constraint PK__vehiculos__END primary key,
 modelo			varchar(100)	not null,
 año			smallint		not null,
 dominio		varchar(10)		null
);
go

insert into dbo.vehiculos(nro_chasis, modelo, año, dominio)
values('8F8693A675F14DE9A', 'MODELO-1', 2013, 'MDA277'),
      ('2BAF33F1B52247509', 'MODELO-1', 2014, 'NDA635'),
      ('8FCCF9F24D0F4AE7B', 'MODELO-2', 2015, 'OKI712'),
      ('93A015A5A4F3491D8', 'MODELO-2', 2015, NULL);
go

create table dbo.reclamos
(
 nro_reclamo	integer			not null identity(1, 1)
				constraint PK__reclamos__END primary key,
 fecha_hora		smalldatetime	not null
				constraint DF__reclamos__fecha_hora__current_timestamp__END default current_timestamp,
 nro_chasis		varchar(17)		null
				constraint FK__reclamos__vehiculos__END references dbo.vehiculos,
 dominio		varchar(10)		null,
 km				integer			null,
 apellido		varchar(100)	not null,
 nombre			varchar(255)	not null,
 email			varchar(255)	not null,
 telefono		varchar(100)	null,
 contactar		char(1)			not null
				constraint CK__reclamos__contactar__END check(contactar in ('S', 'N'))
				constraint DF__reclamos__contactar__S__END default 'S',
 reclamo		varchar(4000)	not null,
 constraint CK__reclamos__vehiculo__END
			check(nro_chasis is null     and dominio is null      and km is null or
			      nro_chasis is not null and dominio is not null)
);
go

create or alter trigger dbo.ti_ri_reclamos
on dbo.reclamos 
for insert
as
begin

  if exists(select 1
              from inserted i
			 where i.dominio is not null
			   and not exists(select 1
			                    from dbo.vehiculos v (nolock)
					           where v.nro_chasis = i.nro_chasis
						         and v.dominio    = i.dominio))
     begin
	   raiserror('El dominio no pertenece al chasis informado', 16, 1)
	   rollback transaction
	   return
	 end

end;
go

create or alter procedure dbo.val_vehiculo
(
 @nro_chasis	varchar(17),
 @dominio		varchar(10)	= null,
 @existe		char(1)		output
)
as
begin

   if ltrim(rtrim(@dominio)) = ''
      set @dominio = null

   if exists(select 1
               from dbo.vehiculos (nolock)
			  where  nro_chasis = @nro_chasis
			    and (@dominio   is null
				 or  dominio    = @dominio))
	  set @existe = 'S'
   else
	  set @existe = 'N'

end;
go

/*
declare @existe char(1)

execute dbo.val_vehiculos @nro_chasis='8F8693A675F14DE9A', @existe=@existe output
select @existe

execute dbo.val_vehiculos @nro_chasis='8F8693A675F14DE9A', @dominio='ABC123', @existe=@existe output
select @existe

execute dbo.val_vehiculos @nro_chasis='2BAF33F1B52247509', @dominio='NDA635', @existe=@existe output
select @existe
*/

insert into dbo.reclamos(nro_chasis, dominio, km, apellido, nombre, email, telefono, contactar, reclamo)
values(NULL, NULL, NULL, 'APELLIDO1', 'NOMBRE1', 'nombre1.apellido1@ubp.edu.ar', NULL, 'S', 'RECLAMO'),
      ('8F8693A675F14DE9A', 'MDA277', NULL, 'APELLIDO2', 'NOMBRE2', 'nombre2.apellido2@ubp.edu.ar', '03514144444', 'S', 'RECLAMO');
go

/*
select *
  from dbo.reclamos
*/