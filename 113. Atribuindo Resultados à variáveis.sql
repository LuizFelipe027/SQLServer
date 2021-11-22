	create table Carros(
		Carro varchar(20),
		Fabricante Varchar(30)
	)
	go

	insert into carros values('ka','ford')
	insert into carros values('fiesta','ford')
	insert into carros values('prisma','chevrolet')
	insert into carros values('clio','renault')
	insert into carros values('sandero','renault')
	insert into carros values('chevete','chevrolet')
	insert into carros values('omega','chevrolet')
	insert into carros values('palio','fiat')
	insert into carros values('doblo','fiat')
	insert into carros values('uno','fiat')
	insert into carros values('gol','volkswagen')
	go

	declare
		@V_Cont_Ford int,
		@V_Cont_Fiat int
	begin
		/* Método 1: O select precisa retornar uma simples coluna
		 E um só resultado */

		set @V_Cont_Ford = (select count(*) from Carros where Fabricante = 'ford')
		print 'Número de Carros da Ford: ' + cast(@V_Cont_Ford as varchar)

		 --Método 2:
		 select @V_Cont_Fiat = count(*) from Carros where Fabricante = 'fiat'
		 print 'Quantidade de carros da fiat: ' + convert(varchar, @V_Cont_Fiat)
	end
	go
