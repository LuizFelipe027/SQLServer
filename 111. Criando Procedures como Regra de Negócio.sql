	/* 
		Procedures
		SP_ --> Storage Procedure
	*/

	create table Pessoa(
		IDPessoa int primary key identity,
		Nome varchar(30) not null,
		Sexo char(1) not null check(Sexo in('M','F')),
		Nascimento date not null
	)

	create table Telefone(
		IDTelefone int not  null identity,
		Tipo char(3) not null check(Tipo in ('CEL','COM')),
		Numero char(10) not null,
		ID_Pessoa int
	)

	alter table Telefone add constraint FK_Telefone_Pessoa
	foreign key (ID_Pessoa) references Pessoa(IDPessoa)
	on delete cascade

	insert into Pessoa values('Antonio','M','1981-02-13')
	insert into Pessoa values('Daniel','M','1985-03-18')
	insert into Pessoa values('Cleide','F','1979-10-13')

	select @@identity /* Guarda o último identity da sessão*/

	insert into telefone values('CEL','987654321',1)
	insert into telefone values('COM','836475892',1)
	insert into telefone values('CEL','096729472',2)
	insert into telefone values('CEL','345636736',2)
	insert into telefone values('COM','537843787',3)
	insert into telefone values('COM','748933784',2)
	insert into telefone values('CEL','748548949',3)
	go

	/* Criando a Procedure */
	create proc Soma
	as 
		select 10 + 10 as Soma
	go

	/* Executando a Procedure */
	Soma go /* ou */ 
	
	exec Soma go /*Jeito Melhor de se executar e ler*/

	/* Dinamicas - Com Parâmetros*/
	create proc Conta @Num1 int, @Num2 int
	as 
		select @Num1 + @Num2
	go

	/* Executando com parâmetros */
	exec Conta 90, 70
	go

	/* Apagando a Procedure */
	drop proc Conta
	go

	/* Procedures em Tabelas */
	select Nome, Numero
	from Pessoa
	inner join Telefone
	on IDPessoa = ID_Pessoa
	where Tipo = 'CEL'
	go

	/* Trazer os telefones de acordo com os tipos passados por parâmetro*/
	create proc Telefones @Tipo char(3)
	as
		select Nome, Numero
		from Pessoa
		inner join Telefone
		on IDPessoa = ID_Pessoa
		where Tipo = @Tipo
	go		
		
	exec Telefones 'CEL'
	go

	exec Telefones 'COM'
	go

	/* Parametos de Output */
	select Tipo, count(*) as Quantidade
	from Telefone
	group by Tipo
	go

	/* Criando procedure com parâmetro de entrada e saída*/
	 create procedure GetTipo @Tipo char(3), @Cont int output
	 as
		select @Cont = count(*)
		from Telefone
		where Tipo = @Tipo
		go

	/* Execução da Procedure com parametro de saída */
	/* Transaction_SQL --> Linguagem que o sql server trabalha*/
	declare @saida int /*Variavel declarada para poder imprimir o resultado da procedure*/
	Exec GetTipo @Tipo = 'CEL', @Cont = @Saida output
	select @Saida
	go

	declare @saida int /*Variavel declarada para poder imprimir o resultado da procedure*/
	Exec GetTipo 'CEL', @Saida output
	select @Saida
	go
	
	
	/* Procedure de Cadastro */
	create procedure cadastro @Nome varchar(30), @Sexo char(1), @Nascimento date, @Tipo char(3), @Numero varchar(10)
	as 
		declare @FK int

		insert into Pessoa values(@Nome, @Sexo, @Nascimento) --Gerar um ID

		set @FK = (select IDPessoa from Pessoa where IDPessoa = @@identity)

		insert into Telefone values (@Tipo, @Numero, @FK)
	go

	Execute Cadastro 'Jorge','M','1981-01-01','CEL','941839501'
	go

	select Pessoa.*, Telefone.*
	from Pessoa
	inner join Telefone
	on IDPessoa = ID_Pessoa
	go
