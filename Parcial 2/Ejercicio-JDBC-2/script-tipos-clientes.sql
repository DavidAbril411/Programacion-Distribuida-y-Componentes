use pdc
go

drop table if exists dbo.subtipos_clientes
go
drop table if exists dbo.tipos_clientes
go
drop table if exists dbo.unidades_negocio
go

/* ------------------------------------------
   Tabla: unidades_negocio
   ------------------------------------------ */
create table dbo.unidades_negocio
(
 cod_unidad_negocio		varchar(3)		not null
						constraint PK__unidades_negocio__END primary key,
 nom_unidad_negocio		varchar(100)	not null
)
go

insert into dbo.unidades_negocio(cod_unidad_negocio, nom_unidad_negocio)
values('CG', 'Carreras de Grado'),
      ('EC', 'Diplomaturas y Cursos'),
      ('EX', 'Extensión'),
      ('II', 'Programas de Intercambio Internacional'),
      ('PG', 'Carreras de Posgrado')
go

/* ------------------------------------------
   Tabla: tipos_clientes
   ------------------------------------------ */
create table dbo.tipos_clientes
(
 cod_tipo_cliente		varchar(3)		not null
						constraint PK__tipos_clientes__END primary key,
 nom_tipo_cliente		varchar(40)		not null
)
go

insert into dbo.tipos_clientes(cod_tipo_cliente, nom_tipo_cliente)
values('A', 'Alumno'),
      ('D', 'Docente'),
	  ('E', 'Egresado'),
	  ('I', 'Interesado'),
	  ('P', 'Personal')
go

/* ------------------------------------------
   Tabla: subtipos_clientes
   ------------------------------------------ */
create table dbo.subtipos_clientes
(
 cod_tipo_cliente		varchar(3)		not null
						constraint FK__subtipos_clientes__tipos_clientes__END references dbo.tipos_clientes, 
 nro_subtipo			tinyint			not null, 
 cod_unidad_negocio		varchar(3)		null
						constraint FK__subtipos_clientes__unidades_negocio__END references dbo.unidades_negocio, 
 habilitado				char(1)			not null
						constraint CK__subtipos_clientes__habilitado__END check (habilitado in ('S', 'N'))
						constraint DF__subtipos_clientes__habilitado__S__END default 'S'
 constraint PK__subtipos_clientes__END
			primary key (cod_tipo_cliente, nro_subtipo),
 constraint UK__subtipos_clientes__END
			unique (cod_tipo_cliente, cod_unidad_negocio)
)
go

insert into dbo.subtipos_clientes(cod_tipo_cliente, nro_subtipo, cod_unidad_negocio, habilitado)
values('A', 1, 'CG', 'S'),
      ('A', 2, 'EC', 'S'),
      ('A', 3, 'EX', 'S'),
      ('A', 4, 'II', 'S'),
      ('A', 5, 'PG', 'S'),
      ('D', 1, 'CG', 'S'),
      ('D', 2, 'EC', 'S'),
      ('D', 3, 'EX', 'S'),
      ('D', 4, 'II', 'S'),
      ('D', 5, 'PG', 'S'),
      ('E', 1, 'CG', 'S'),
      ('E', 2, 'PG', 'S'),
      ('I', 1, 'CG', 'S'),
      ('I', 2, 'EC', 'S'),
      ('I', 3, 'EX', 'S'),
      ('I', 4, 'PG', 'S'),
	  ('P', 1, null, 'S')
go

/* ------------------------------------------
   Consulta de unidades de negocio
   ------------------------------------------ */
select cod_unidad_negocio = '-1',
       nom_unidad_negocio = 'No informada',
	   nro_orden          = 0
 union all
select cod_unidad_negocio = cod_unidad_negocio,
       nom_unidad_negocio = nom_unidad_negocio,
	   nro_orden          = row_number() over(order by nom_unidad_negocio)
  from dbo.unidades_negocio (nolock)
 order by nro_orden
go
 
/* ------------------------------------------
   Procedimiento: get_subtipos_clientes
   ------------------------------------------ */
create or alter procedure dbo.get_subtipos_clientes
(
 @cod_unidad_negocio varchar(3) = null
)
as
begin

  select tc.nom_tipo_cliente,
         sc.habilitado,
		 sc.cod_tipo_cliente,
		 sc.nro_subtipo
    from dbo.subtipos_clientes sc (nolock)
	     join dbo.tipos_clientes tc (nolock)
		   on sc.cod_tipo_cliente   = tc.cod_tipo_cliente
   where (sc.cod_unidad_negocio = @cod_unidad_negocio
      or  @cod_unidad_negocio   is null
	 and  sc.cod_unidad_negocio is null)
   order by tc.nom_tipo_cliente

end
go

-- execute dbo.get_subtipos_clientes

/* ------------------------------------------
   Sentencia para la actualización de datos
   ------------------------------------------ */
declare @cod_tipo_cliente	varchar(3)	= 'A',
        @nro_subtipo		tinyint		= 4,
		@habilitado			char(1)		= 'N'

update sc
   set habilitado = @habilitado
  from dbo.subtipos_clientes sc
 where cod_tipo_cliente = @cod_tipo_cliente
   and nro_subtipo      = @nro_subtipo
go
