	/* Blocos if e else */

	declare 
		@Numero int = 5
	begin
 		if @Numero = 5 --Expressao Booleana - true or false
			print 'O valor é verdadeiro'
		else
			print 'O valor é falso'
	end
	go

	/* case */
	declare 
		@Contador int

	begin
		select case --o case representa uma coluna 
					when Fabricante = 'fiat' then 'faixa 1'
					when Fabricante = 'chevrolet' then 'faixa 2'
				else 'outras faixas'
		end as "Informacoes", * from Carros
	end
	go
	