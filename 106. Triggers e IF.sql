use empresa

create table Produtos(
	idProduto int identity primary key,
	Nome varchar(50) not null,
	Categoria varchar(30) not null,
	Preco numeric(10,2) not null /*Float antes da virgula casa normail e depois da virgula numeros de casas decimais*/
)

create table Historico(
	IDOperacao int primary key identity,
	Produto varchar(50) not null,
	Categoria varchar(30) not null,
	PrecoAntigo numeric(10,2) not null,
	PrecoNovo numeric(10,2) not null,
	Data datetime,
	Usuario varchar(30) not null,
	Mensagem varchar(100)
)
go

insert into Produtos values('livro sql server', 'livros', 98.00)
insert into Produtos values('livro oracle', 'livros', 50.00)
insert into Produtos values('licença power center', 'softwares', 45000.00)
insert into Produtos values('notebook', 'Computadores', 3150.00)
insert into Produtos values('livro business inteligence', 'livros', 50.00)
go

select * from Produtos
select * from Historico
go

/* Verificando o Usuário */
select suser_name()
go

/*Triggers de dados - DML(Data Manipulation Language) */
create trigger Trg_Atualiza_Preco
on dbo.Produtos
for update 
as 
	/*Bloco de variaveis*/
	declare @IDProduto int
	declare @Produto varchar(30)
	declare @Categoria varchar(10)
	declare @Preco numeric(10,2)
	declare @PrecoNovo numeric(10,2)
	declare @Data datetime
	declare @Usuario varchar(30)
	declare @Acao varchar(100)

	/*Bloco de Declaração de valores*/
	/*Primeiro Bloco*/
	select @IDProduto = IDProduto from inserted
	select @Produto = Nome from inserted
	select @Categoria = Categoria from inserted
	select @Preco = Preco from deleted
	select @PrecoNovo = Preco from inserted

	/*Segundo Bloco*/
	set @Data = getdate()
	set @Usuario = suser_name()
	set @Acao = 'Valor inserido pela trigger Trg_Atualiza_Preco'

	insert into Historico
	(Produto, Categoria, PrecoAntigo, PrecoNovo, Data, Usuario,Mensagem)
	values
	(@Produto, @Categoria, @Preco, @PrecoNovo, @Data, @Usuario, @Acao)

	print 'Trigger Executada com sucesso'
go

/* Executando um Update*/
update Produtos set Preco = 100.00
where idProduto = 1
go

update Produtos set nome = 'c#'
where idProduto = 1
go

select * from Produtos
select * from Historico
go



/* Programando Trigger em uma coluna */
drop trigger Trg_Atualiza_Preco
go

create trigger Trg_Atualiza_Preco
on dbo.Produtos
for update as 

if update(Preco)
begin 
		declare @IDProduto int
		declare @Produto varchar(30)
		declare @Categoria varchar(10)
		declare @Preco numeric(10,2)
		declare @PrecoNovo numeric(10,2)
		declare @Data datetime
		declare @Usuario varchar(30)
		declare @Acao varchar(100)

		/*Primeiro Bloco*/
		select @IDProduto = IDProduto from inserted
		select @Produto = Nome from inserted
		select @Categoria = Categoria from inserted
		select @Preco = Preco from deleted
		select @PrecoNovo = Preco from inserted

		/*Segundo Bloco*/
		set @Data = getdate()
		set @Usuario = suser_name()
		set @Acao = 'Valor inserido pela trigger Trg_Atualiza_Preco'

		insert into Historico
		(Produto, Categoria, PrecoAntigo, PrecoNovo, Data, Usuario,Mensagem)
		values
		(@Produto, @Categoria, @Preco, @PrecoNovo, @Data, @Usuario, @Acao)

		print 'Trigger Executada com sucesso'
	end
go
