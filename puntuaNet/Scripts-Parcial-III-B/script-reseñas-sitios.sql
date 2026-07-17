use pdc
go

drop table if exists dbo.reseñas_sitios
go

/* -------------------------------------
   Tabla: reseñas_sitios
   ------------------------------------- */
create table dbo.reseñas_sitios
(
 nro_reseña			integer			identity				
					constraint PK__reseñas_sitios__END primary key,
 fecha_reseña		smalldatetime	not null
					constraint DF__reseñas_sitios__fecha_reseña__current_timestamp__END default current_timestamp,
 sitio				varchar(255)	not null,
 correo				varchar(255)	not null,
 apodo				varchar(50)		not null,
 puntuacion			tinyint			not null
					constraint CK__reseñas_sitios__puntuacion__END check (puntuacion between 0 and 5),
 observaciones		varchar(2000)	not null
)
go

insert into dbo.reseñas_sitios(fecha_reseña, sitio, correo, apodo, puntuacion, observaciones)
values('2026-05-15 14:30', 'https://www.tecnoblog.com', 'lucas.gomez@gmail.com', 'LucasG', 5, 'Excelente contenido técnico y artículos actualizados constantemente.'),
      ('2026-04-22 09:15', 'https://www.viajeros.net', 'marina.lopez@hotmail.com', 'MarinaL', 4, 'Muy buena información para planificar viajes, aunque algunas guías necesitan actualización.'),
      ('2026-03-10 18:45', 'https://www.recetasfaciles.com', 'jorge.perez@yahoo.com', 'ChefJorge', 3, 'Las recetas son claras pero faltan fotografías en varias publicaciones.'),
      ('2026-02-05 11:20', 'https://www.deportesonline.com', 'sofia.fernandez@gmail.com', 'SofiFan', 5, 'Cobertura deportiva muy completa y resultados actualizados en tiempo real.'),
      ('2026-01-18 16:05', 'https://www.cursosdigitales.com', 'diego.martinez@outlook.com', 'DiegoDev', 2, 'La plataforma funciona bien, pero varios cursos tienen contenido desactualizado.')
go

/* -------------------------------------
   Procedimiento: ins_reseña_sitio
   ------------------------------------- */
create or alter procedure dbo.ins_reseña_sitio
(
 @sitio				varchar(255),
 @correo			varchar(255),
 @apodo				varchar(50),
 @puntuacion		tinyint,		
 @observaciones		varchar(2000)
)
as
begin

  insert into dbo.reseñas_sitios(sitio, correo, apodo, puntuacion, observaciones)
  values(@sitio, @correo, @apodo, @puntuacion, @observaciones)

end
go

/* -------------------------------------
   Consulta de últimas 3 reseñas
   ------------------------------------- */
select top 3
       sitio         = sitio, 
       apodo         = apodo,
	   puntuacion    = puntuacion,
	   observaciones = observaciones,
	   fecha         = fecha_reseña
  from dbo.reseñas_sitios (nolock)
 order by fecha_reseña desc
go 