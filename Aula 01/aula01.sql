# Cerquilha ou jogo da velha utilizamos para comentário
# Tudo que for comentado não será lido pelo codigo SQL 

-- Também usado para comentários

## O SQL é dividido entre os 3 principais tipos de Manipulação:
## DML - Para manipulação de registros em tabelas - INSERT, UPDATE, DELETE
## DDL - Para alteração estrutural do banco de dados - CREATE, ALTER, DROP
## DQL - Consulta e filtro de informações - SELECT


## Para começar precisamos criar um banco de dados
## Vamos usar o comando DDL create 

create database basedados;

## Criar a tabela cadastro com comando DDL create

create table cadastro(
id_cad integer not null auto_increment,
Nome varchar(100) not null,
Sobrenome varchar(100) not null,
CPF varchar(11) not null,
primary key(id_cad)
);

### DDL para apagar algo estrutural com o comando DROP 

drop table cadastro;

## DDL Alterar dado estrutural do Banco já existente ALTER

alter table cadastro add cep int(9) after CPF;

## 	Alterar tipo de valor de uma coluna existente

alter table cadastro change column cep cep varchar(10);

### DML Manipulaçao

## Insert insere registros em uma tabela

insert into cadastro(Nome,Sobrenome,cpf,cep) values("Nayara", "Santos", "06337470923", "88102090");

# Registro DML Update
# Todo comando Update deve ser seguido de uma cláusula de filtro 
 # ou indicação de registro

update cadastro set nome="Pedro"
where id_cad= 1;

update cadastro set cep="88102090"
where id_cad= 1;

# Manipulação DML Delete
# No Delete também utilizamos cláusulas de filtro e
# indicação de registro

delete from cadastro
where id_cad = 5;





### Manipulação de consulta DQL
select * from cadastro;



select Nome,cpf from cadastro;


## Comando truncate na tabela, limpa os registros de tabela, porém preserva a mesma 

truncate cadastro;



#################### Trabalhando com Selects ############################

# O uso do select possui diversas funções e cláusulas para o uso e filtragem
# das informações nas tabelas

## Order by - Ordenar baseado na coluna (alfabética ou Numeral)

select Nome,Sobrenome from cadastro
order by id_cad; desc # ordenar em ordem decrescente

select Nome,Sobrenome from cadastro
order by Nome; desc # ordenar em ordem decrescente;

select Nome,Sobrenome from cadastro
order by Nome;

## Cláusula where (onde)

select Nome,Sobrenome from cadastro
where Nome = "Nayara";

select Nome,Sobrenome from cadastro
where Nome != "Nayara";

select Nome,Sobrenome,id_cad from cadastro
where id_cad >= 3;

# A cláusula like faz busca coringa de pedaços de registros
# Passados no where. Pode ser utilizado para buscar inicio ou fim

select Nome,Sobrenome from cadastro
where Nome like "Jo%"; # busca coringa

select Nome,Sobrenome from cadastro
where Nome like "%ria";


### Consultas Lógicas com os operadores OR, AND, NOT
# AND= Operador and é usado quando todos os resultados das condições forem verdadeiros

# OR = é usado apenas quando o resultado de 1 condição for verdadeira

# NOT = é usado quando forem negativos

select Nome,Sobrenome from cadastro
where Nome = "Roberto" and Sobrenome = "Ferreira";

select Nome,Sobrenome from cadastro
where Nome = "Roberto" or Sobrenome = "Silva";

select Nome,Sobrenome from cadastro
where not Nome = "Nayara" ;

## Cláusulas IN e NOT IN

#IN consta na tabela baseado na cláusula
#NOT IN inverte o sentido da cláusula

select id_cad,Nome,Sobrenome from cadastro
where id_cad in (1,2);

select id_cad,Nome,Sobrenome from cadastro
where id_cad not in (1,2);

### Operador Distinct
#Filtra os valores distintos em apenas uma saída de registro

select distinct Sobrenome from cadastro;

## Subselect

# Subselect é o resultado de um select dentro de outro select
# é a junção de 2 selects

# Utilizado fortemente quando filtramos tabelas distintas 

select Nome,Sobrenome from cadastro
where nome not in (select nome from cadastro where nome= "José")











