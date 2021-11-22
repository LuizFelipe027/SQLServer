	select * from Hist_Salario 

	/* Sal�rio Antigo, Novo, Data e Nome do Emprego */

	create table Salario_Range(
		MinSal money,
		MaxSal money
	)
	
	insert into Salario_Range values (2000.00, 6000.00)

	create trigger Tg_Range
	on dbo.Empregado
	for insert, update
	as 
		declare 
			@MinSal money,
			@MaxSal money,
			@AtualSal money

			select @Minsal = MinSal, @MaxSal = MaxSal from Salario_Range

			select @AtualSal - i.Salario
			from inserted i

			if(@AtualSal < @MinSal)
			begin
				Raiserror('Sal�rio Menor que o piso!', 16,1)
				rollback transaction
			end

			if(@AtualSal > @MaxSal)
			begin 
				raiserror('Sal�rio maior que o teto', 16,1)
				rollback transaction
			end

	update Empregado set salario  = 9000.00
	where IDEmp = 1

	update Empregado set salario  = 1000.00
	where IDEmp = 1

	/* Verificando o texto de uma trigger */

	sp_helptext Tg_Range



