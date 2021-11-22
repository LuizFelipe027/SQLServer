	/* Variaveis com Select */

	create table resultado(
		IdResultado int
	)
	go

	/*Exemplo*/
	insert into resultado
	values((select 10 + 10))
	go

	select * from resultado
	go

	/* Atribuindo SELECTS a variáveis*/ 
	declare 
			@Resultado int
			set @Resultado = (select 10 + 20)
			insert into resultado values(@Resultado)
			print 'valor inserido na tabela ' + cast(@resultado as varchar)
			go

	/* Trigger update */
	create table empregado(
		IDEmpregado int primary key,
		Nome varchar(30),
		Salario money,
		IDGerente int
	)
	go

	alter table empregado add constraint FK_Gerente
	foreign key(IDGerente) references empregado(IDEmpregado)
	go

	insert into empregado values(1, 'clara', 5000.00, null)
	insert into empregado values(2, 'luiz', 4000.00, 1)
	insert into empregado values(3, 'joao', 3400.00, 1)

	select * from empregado

	create table Hist_Salario(
		IDEmpregado int,
		Antigo_Salario money,
		Novo_salario money,
		Data datetime
	)
	go

	select * from Hist_Salario
	select * from empregado

	create trigger TG_Salario 
	on dbo.empregado 
	for update as 
	if  update(Salario)
	begin
		insert into Hist_Salario(IDEmpregado, Antigo_Salario, Novo_salario, Data)
		select d.IDEmpregado, d.Salario, i.Salario, getdate()
		from deleted d, inserted i
		where d.IDEmpregado = i.IDEmpregado /*Para poder pegar todos os funcionarios mesmo depois do update*/
	end
	go

	update empregado set salario = (Salario * 0.5)/*Para atualizar o salario de todos da empresa*/
	go

	select salario from empregado
	select * from Hist_Salario
