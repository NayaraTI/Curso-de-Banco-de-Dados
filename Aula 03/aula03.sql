######Trabalhando com Funções########
#Funções são criadas para executar determinadas ações pré definidas sempre que for necessáro.
#Funções servem para otimizar a criação de código pois a mesma irá ser executada sempre que
#for necessário executar uma ação

# Criar a Função #

delimiter $$

create function retorna_nome(id_cad_input int)
returns varchar(50) deterministic
begin
declare nome varchar(50);
select Nome_Cadastro into nome from cadastro
where id_cad = id_cad_input;
return nome;
end $$

delimiter ;

## Function com JOIN

select Nome_Produtos,retorna_nome(id_cad),Quantidade from produtos
order by Quantidade

################## Trabalhando com Procedures #######################
#Procedures são programações ou scripts criados dentro do banco de dados afim de executar ações
#que irão manipular dados e tabelas

## Criando uma Procedure da select ##

delimiter $$

create procedure st_select()
begin

select * from produtos;

end $$

delimiter ;




## 	Chamando a procedure
call st_select()

### Criando uma procedure de carga de dados onde irá copiar os dados da produtos para a produtos2##

DELIMITER $$
CREATE PROCEDURE st_input_tabela_produtos2()
BEGIN
DECLARE done INT DEFAULT FALSE;
DECLARE INSERE_ID_PROD int default 0;
DECLARE INSERE_NOME varchar(30) default 0;
DECLARE INSERE_Valor float(10,2) default 0;
DECLARE INSERE_Quantidade int default 0;
DECLARE INSERE_ID_CAD int;
DECLARE cursor1 CURSOR FOR SELECT id_prod,Nome_Produtos,Valor,Quantidade,id_cad from produtos;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
OPEN cursor1;
read_loop: LOOP
IF done THEN
LEAVE read_loop;
END IF;
FETCH cursor1 INTO
INSERE_ID_PROD,INSERE_NOME,INSERE_VALOR,INSERE_QUANTIDADE,INSERE_ID_CAD;
insert into produtos2
Values(INSERE_ID_PROD,INSERE_NOME,INSERE_VALOR,INSERE_QUANTIDADE,INSERE_ID_CAD);
end loop;
CLOSE cursor1;
END 

$$

truncate produtos2

select * from produtos2

## Chamar a procedure

call st_input_tabela_produtos2()

## Trabalhando com agendadores de tarefas ##

# Ativar o scheduler

set global event_scheduler = on

##Criar uma tarefa agendada para executar a procedure ##

delimiter $$

create event chamada_procedure on schedule every 1 minute 
on completion not preserve disable
do

call st_input_tabela_produtos2()

# Exibe o status dos agendamentos

show events

# Ativar o agendamento

alter event chamada_procedure enable;

## Para excluir um agendamento

drop event chamada_procedure


###################### Trabalhando com Triggers ###########################33
#as triggers são acionadas a partir de uma ação pré determinada. pode ser After (insert,delete,update)
#é recomendada em uso de regra de negócio ou ação que depende de outras para ser executada

## Criar uma tabela para receber as triggers

create table ItensVenda(
Venda int,
Produto varchar(50),
Qt_Vendida int
);

delimiter $$

create trigger ItensVenda_Insert after insert
on ItensVenda
for each row
begin

update produtos set Quantidade = Quantidade - New.Qt_Vendida
where id_prod = new.produto;
end$$

create trigger ItensVenda_Delete after delete
on ItensVenda
for each row
begin

update produtos set Quantidade = Quantidade + old.Qt_Vendida
where id_prod = old.produto;
end$$

delimiter ;

## Para excluir uma trigger utilize o comando DROP

drop trigger ItensVenda_insert;
drop trigger ItensVenda_delete;

## Testar as Triggers com insert e delete

insert into Itensvenda values(1,6,15)

select * from  itensvenda

delete from itensvenda where venda = 1

## Exibir as triggers

show triggers

### Triggers aplicando valores condicionais ###

##Criando um novo campo para aplicar a condição da trigger

alter table itensvenda add column status_venda varchar(50)

##Criar a trigger conndicional ##

delimiter $

create trigger itensvenda_insert_condicional after insert
on itensvenda
for each row
begin
if new.status_venda = 'vendeu' then
update produtos set Quantidade = Quantidade - new.qt_vendida
where id_prod = new.produto;
end if;
if new.status_venda = 'devolveu' then
update produtos set Quantidade = Quantidade + new.qt_vendida
where id_prod = new.produto;
end if;
end$

delimiter ;

## Testando a trigger condicional

insert into itensvenda values (1,5,10,'vendeu')
insert into itensvenda values (1,5,10,'devolveu')

select * from itensvenda


##################### Trabalhando com views ######################

# As views são concebidas de um conjunto de selects provenientes das tabelas do banco de dados
# Que podem ser chamadas de based tables (tabelas reais)
# O resultado da construção da View é baseada em filtros de campos de 1 ou mais tabelas criando
# um objeto chamado view ou virtual table

create or replace view cadastro_produtos as

select Nome_Cadastro,Sobrenome,Nome_Produtos,Quantidade,Valor from cadastro
join produtos on
cadastro.id_cad = produtos.id_cad
order by Nome_Cadastro

# Chamar a view utilizamos o select

select * from cadastro_produtos

select Nome_Cadastro,Quantidade from cadastro_produtos
where Quantidade >= 5

## Com as views também podemos manipular dados das tabelas reais

create or replace view view_produtos as

select Nome_Produtos,Valor,Quantidade,id_cad 
from produtos

# Insert com View

insert into view_produtos values("Jabuticaba","8.70",20,9)

# Update com View

update view_produtos set valor = 10.20
where Nome_Produtos =  "Jabuticaba"

# Delete com View

delete from view_produtos where Nome_Produtos = "Jabuticaba"

## Excluir uma View com Drop

drop view view_produtosst_select


 























