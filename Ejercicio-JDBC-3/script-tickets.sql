use pdc
go

drop table if exists dbo.tickets
go
drop table if exists dbo.solicitantes
go

create table dbo.solicitantes
(
 nro_solicitante		integer			not null
						constraint PK__solicitantes__END primary key,
 nom_solicitante		varchar(255)	not null,
 e_mail_solicitante		varchar(255)	not null
						constraint UK__solicitantes__END unique
)
go

create table dbo.tickets
(
 año_ticket				smallint		not null,
 nro_ticket				smallint		not null,
 fecha_ticket			smalldatetime	not null
						constraint DF__tickets__fecha_ticket__current_timestamp__END default current_timestamp,
 asunto_ticket			varchar(255)	not null,
 texto_ticket			varchar(max)	not null,
 nro_solicitante		integer			not null
						constraint FK__tickets__solicitantes__END references dbo.solicitantes,
 constraint PK__tickets__END
            primary key (año_ticket, nro_ticket)
)
go

insert into dbo.solicitantes(nro_solicitante, nom_solicitante, e_mail_solicitante)
values(1, 'SOLICITANTE 1', 'solicitante1@ubp.edu.ar'),
      (2, 'SOLICITANTE 2', 'solicitante2@ubp.edu.ar'),
	  (3, 'SOLICITANTE 3', 'solicitante3@ubp.edu.ar')
go

insert into dbo.tickets(año_ticket, nro_ticket, fecha_ticket, asunto_ticket, texto_ticket, nro_solicitante)
values(2024, 1, '2024-02-08 17:12', 'ASUNTO 1', 'TEXTO 1 TEXTO 1 TEXTO 1 TEXTO 1 TEXTO 1 TEXTO 1 TEXTO 1 TEXTO 1 TEXTO 1 TEXTO 1 TEXTO 1 TEXTO 1 TEXTO 1 TEXTO 1 TEXTO 1 TEXTO 1 TEXTO 1 TEXTO 1 TEXTO 1 TEXTO 1 TEXTO 1', 1),
      (2024, 2, '2024-03-07 16:00', 'ASUNTO 2', 'TEXTO 2 TEXTO 2 TEXTO 2 TEXTO 2 TEXTO 2 TEXTO 2 TEXTO 2 TEXTO 2 TEXTO 2 TEXTO 2', 2),
	  (2024, 3, '2024-05-16 10:30', 'ASUNTO 3', 'TEXTO 3 TEXTO 3 TEXTO 3 TEXTO 3 TEXTO 3 TEXTO 3 TEXTO 3 TEXTO 3 TEXTO 3 TEXTO 3 TEXTO 3 TEXTO 3 TEXTO 3 TEXTO 3 TEXTO 3 TEXTO 3 TEXTO 3 TEXTO 3 TEXTO 3 TEXTO 3 TEXTO 3 TEXTO 3 TEXTO 3 TEXTO 3 TEXTO 3', 3),
	  (2024, 4, '2024-05-16 11:00', 'ASUNTO 4', 'TEXTO 4 TEXTO 4 TEXTO 4 TEXTO 4 TEXTO 4 TEXTO 4 TEXTO 4', 1),
	  (2024, 5, '2024-05-20 12:00', 'ASUNTO 5', 'TEXTO 5 TEXTO 5 TEXTO 5 TEXTO 5 TEXTO 5 TEXTO 5 TEXTO 5 TEXTO 5 TEXTO 5 TEXTO 5 TEXTO 5 TEXTO 5 TEXTO 5 TEXTO 5 TEXTO 5 TEXTO 5 TEXTO 5 TEXTO 5 TEXTO 5 TEXTO 5 TEXTO 5 TEXTO 5 TEXTO 5', 2)
go

declare @string_busqueda	varchar(255),
        @ordenar_por		char(1)		= 'F'

select ticket        = convert(varchar(4), t.año_ticket) + '-' + replicate('0', 5 - len(convert(varchar(5), t.nro_ticket))) + convert(varchar(5), t.nro_ticket),
       fecha_ticket  = convert(varchar(10), t.fecha_ticket, 103) + ' ' + convert(varchar(5), t.fecha_ticket, 108), 
	   solicitante   = s.nom_solicitante,
	   asunto_ticket = t.asunto_ticket,
	   texto_ticket  = t.texto_ticket
  from dbo.tickets t (nolock)
       join dbo.solicitantes s (nolock)
	     on t.nro_solicitante = s.nro_solicitante
 where (t.asunto_ticket   like '%' + isnull(ltrim(rtrim(@string_busqueda)), '') + '%'
    or  t.texto_ticket    like '%' + isnull(ltrim(rtrim(@string_busqueda)), '') + '%'
  	or  s.nom_solicitante like '%' + isnull(ltrim(rtrim(@string_busqueda)), '') + '%')
 order by case @ordenar_por
               when 'F'
			   then convert(varchar(10), t.fecha_ticket, 112) + ' ' + convert(varchar(5), t.fecha_ticket, 108)
			   when 'S'
			   then s.nom_solicitante
			   when 'T'
			   then convert(varchar(4), t.año_ticket) + '-' + replicate('0', 5 - len(convert(varchar(5), t.nro_ticket))) + convert(varchar(5), t.nro_ticket)
		 end
go

create or alter procedure dbo.ins_ticket
(
 @asunto_ticket			varchar(255),
 @texto_ticket			varchar(max),
 @nom_solicitante		varchar(255),
 @e_mail_solicitante	varchar(255)
)
as
begin

  set nocount on
  
  declare @año_ticket		smallint,
          @nro_ticket		smallint,
		  @nro_solicitante	integer

  select @asunto_ticket      = ltrim(rtrim(@asunto_ticket)),
         @texto_ticket       = ltrim(rtrim(@texto_ticket)),
		 @nom_solicitante    = upper(ltrim(rtrim(@nom_solicitante))),
		 @e_mail_solicitante = lower(ltrim(rtrim(@e_mail_solicitante))) 

  if @asunto_ticket is null or @asunto_ticket = ''
     begin
	   raiserror('Debe informar el asunto del ticket', 16, 1)
	   return
	 end

  if @texto_ticket is null or @texto_ticket = ''
     begin
	   raiserror('Debe describir su pedido', 16, 1)
	   return
	 end

  if @nom_solicitante is null or @nom_solicitante = ''
     begin
	   raiserror('Debe informar su nombre', 16, 1)
	   return
	 end

  if @e_mail_solicitante is null or @e_mail_solicitante = ''
     begin
	   raiserror('Debe un correo al que podamos contactarlo', 16, 1)
	   return
	 end

  select @nro_solicitante = nro_solicitante
    from dbo.solicitantes (nolock)
   where e_mail_solicitante = @e_mail_solicitante

  if @nro_solicitante is not null
     begin
	   update dbo.solicitantes
	      set nom_solicitante = @nom_solicitante
		where nro_solicitante = @nro_solicitante
	 end
  else
     begin
	   select @nro_solicitante = isnull(max(nro_solicitante), 0) + 1
	     from dbo.solicitantes (tablockx)

	   insert into dbo.solicitantes(nro_solicitante, nom_solicitante, e_mail_solicitante)
	   values(@nro_solicitante, @nom_solicitante, @e_mail_solicitante)
     end

  select @año_ticket = year(getdate()),
         @nro_ticket = isnull(max(nro_ticket), 0) + 1
    from dbo.tickets (tablockx)
   where año_ticket = year(getdate())

  insert into dbo.tickets(año_ticket, nro_ticket, asunto_ticket, texto_ticket, nro_solicitante)
  values(@año_ticket, @nro_ticket, @asunto_ticket, @texto_ticket, @nro_solicitante)

  set nocount off

end
go

-- execute dbo.ins_ticket @asunto_ticket='ASUNTO 6', @texto_ticket='TEXTO 6', @nom_solicitante='SOLICITANTE 4', @e_mail_solicitante='solicitante6@ubp.edu.ar'
-- execute dbo.ins_ticket @asunto_ticket='ASUNTO 7', @texto_ticket='TEXTO 7', @nom_solicitante='SOLICITANTE 4', @e_mail_solicitante='solicitante6@ubp.edu.ar'
