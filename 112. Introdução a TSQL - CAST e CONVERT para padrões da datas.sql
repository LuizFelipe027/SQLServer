	/* Bloco de Execução */
	begin
		print 'Primeiro Bloco'
	end
	go

	/* Blocos de atribuição de variáveis */

	declare
		@contador int
	begin
		set @contador = 5
		print @contador
	end
	go

	/**/

	declare 
		@V_Num numeric(10,2) = 100.54,
		@V_Data datetime = '20170207'

	begin 
		print 'Valor Numerico: ' + cast(@V_Num as varchar)
		print 'Valor Númerico: ' + convert(varchar, @V_Num)
		print 'valor de data: ' + cast(@V_Data as varchar)
		print 'valor de data: ' + convert(varchar, @V_Data, 121)
		print 'valor de data: ' + convert(varchar, @V_Data, 120)
		print 'valor de data: ' + convert(varchar, @V_Data, 105)
	end
	go