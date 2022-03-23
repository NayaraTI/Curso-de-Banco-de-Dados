### Criação da Chave estrangeira e a segunda tabela
# Em modelo físico a foreign key é chamada de constraint

## Criar a tabela produtos

create table produtos(

id_prod integer not null auto_increment,
Nome varchar(100) not null,
Valor float not null,
Quantidade integer(11) not null,
id_cad integer not null,
primary key(id_prod)
);

## Criar a foreign key

alter table produtos add constraint fk_cadastro_produtos
foreign key(id_cad)
references cadastro(id_cad)
on delete no action
on update no action

select * from produtos

### Subconsultas ou Subselects

select Nome,Sobrenome from cadastro
where id_cad in (Select id_cad from produtos where id_cad);

select Nome,Sobrenome from cadastro
where id_cad not in (Select id_cad from produtos where id_cad);

select Nome,
(select Nome from cadastro where id_cad = produtos.id_cad) from produtos

## Fazer um select ou subselect criando uma alias na saída

select Nome,
(select Nome from cadastro where id_cad = produtos.id_cad) as Clientes from produtos

## Join ou Iner Join é a função de operação relacional , onde você combina
#as colunas de 1 ou mais tabelas

## Select sem JOIN

select Nome,Quantidade,Sobrenome as Prod_Vendido
from produtos,cadastro
where cadastro.id_cad = produtos.id_cad # campo de relacionamento entre as tabelas
order by Quantidade;

## Resolver o problema de ambiguidade

alter table cadastro change column Nome Nome_Cadastro varchar(100)

alter table produtos change column Nome Nome_Produtos varchar(100)

select Nome_Cadastro,Nome_Produtos,Quantidade,Sobrenome 
from produtos,cadastro
where cadastro.id_cad = produtos.id_cad # campo de relacionamento entre as tabelas
order by Quantidade;

## Criando o Join

select * from produtos
join cadastro

select Nome_Cadastro,Nome_Produtos from produtos
join cadastro on
produtos.id_cad = cadastro.id_cad
order by Nome_Cadastro

## Right Join e o Left Join

select * from cadastro
left join produtos on
produtos.id_cad = cadastro.id_cad

select * from produtos
right join cadastro on
produtos.id_cad = cadastro.id_cad

# Criando, inserindo e modificando dados em tabelas utilizando select

## Criar uma tabela

create table produtos2(
select * from produtos
where Quantidade >10)

select * from produtos2

insert into produtos2(select id_prod,Nome_Produtos,Valor,Quantidade,id_cad from produtos)

## Atualizando e Deletando - Não recomendado

update produtos2 set Nome_Produtos = "Abacaxi"
where Nome_Produtos in (select Nome_Produtos from produtos)

delete from produtos2
where Nome_Produtos in (select Nome_Produtos from produtos)


####################### Funções de Agregação ########################

# Fazem o processo de agregar os valores dos registros e um unico valor

## Group by agrupa os registros

insert into produtos (Nome_Produtos,Valor,Quantidade,id_cad) values ("Laranja", 3.50, 15,1)

select * from produtos

select Nome_Cadastro,Nome_Produtos as Prod_Vendidos
from cadastro,produtos
where cadastro.id_cad = produtos.id_cad
group by Nome_Produtos
order by Nome_Produtos

## 	Função Count conta os registros de uma tabela

select count(*) from produtos;

## Having Count é a contagem com condições

select Nome_Cadastro,Nome_Produtos,count(Nome_Produtos)
from produtos,cadastro
where cadastro.id_cad = produtos.id_cad
group by Nome_Produtos
having count(Nome_Produtos) > 1

#  MAX e MIN maior valor e menor valor de um registro

select max(Quantidade) as QT_PROD from produtos
select min(Quantidade) as QT_PROD from produtos

select min(Quantidade) as QT_PROD_MIN, max(Quantidade) as QT_PROD_MAX from produtos

## Sum calcula o valor agregado total dos registros

select sum(Quantidade) as QT_TOTAL, sum(Valor) as Valor_Total from produtos

## AVG ou average média

select avg(Valor) from produtos
select format(avg(valor),2) from produtos


######### Função de String #######

## Funções Subst e Length

## Substring obtém dados passando um pedaço de caracter
## Length captura pelo comprimento de caracter

select Nome_Produtos from produtos
where substr(Nome_Produtos,1,6)= 'melanc' and length(Nome_Produtos) >4

## Concat e Concat WS

# Concat concatena caracteres no select

select concat(Nome_Cadastro," Gosta de: " ,Nome_Produtos) as Gosto_frutas from cadastro,produtos
where cadastro.id_cad = produtos.id_cad
order by Nome_Cadastro

# Concatws concatena um delimitador entre os campos dos registros

select concat_ws(';', Nome_Produtos,Quantidade,Valor) from produtos
where Nome_Produtos like 'l%'

# Lcase Ucase

select lcase(Nome_Cadastro),ucase(Nome_Cadastro) from cadastro


########################## Função de cálculos e Operadores Aritméticos #############################

## Round função de arredondamento

select round(33331.2214,3)

## Sqrt

select sqrt(40) as raiz_quadrada

# pi

select pi()

## Funções Matemáticas - Adição, Subtração, Multiplicação e Divisão

# Multiplicação

select (Quantidade * Valor) as multiplicação from produtos
where id_prod = 4

# Adição

select (Quantidade + Valor) as adição from produtos
where id_prod = 4

# Divisão

select (Quantidade / Valor) as divisão from produtos
where id_prod = 4


######### Funções de data ###########

## Função de data mmanipulam e calculam tipos de dados data

# curdate - traz a data atual

select curdate()

# data e hora atual

select now()
select sysdate()

## Traz dados de horas

select curtime()

## Intervalo de datas

select datediff('2019-02-01','2021-01-09')

## Adicionar dias a uma data

select date_add('2020-01-30' ,interval 60 day)

## Retorna dia da semana de uma data

select dayname('2017-10-29')

## Retorna dia do mês

select dayofmonth('2019-01-10')

## Extrair o ano

select extract(year from '2021-10-10')

## Retorna o último dia do mês de uma data

select last_day('2017-12-12')

## Mudar o formato de uma data ##

select date_format('2014-12-23',get_format(date,'EUR'))

select str_to_date('05.05.2016',get_format(date,'USA'))	


###################### Condicionais IF e CASE ###########################

## IF

select Nome_Produtos,
if(Quantidade <=20,"Baixo","Alto") as Estoque from produtos

select Valor,
if(valor <>10.00,"Diferente","Igual") as Valores_de_Quantidades from produtos

## CASE

select Nome_Produtos, case

when Quantidade <=4 then "Baixo Estoque"
when Quantidade <=15 then "Estoque Bom"
when Quantidade <=30 then "Estoque Médio"
else 'Estoque Alto'
end as Quantidade,
count(*) Quantidade from produtos
group by quantidade
order by quantidade

## IF com JOIN

select Nome_Cadastro,Nome_Produtos,Quantidade,
if(quantidade >=10,'Alto','Baixo') as Compras_Clientes
from produtos join cadastro on
cadastro.id_cad = produtos.id_cad
order by Compras_Clientes

# Quantidade de clientes com vendas boas e ruins

select case
when Quantidade <=10 then 'Clientes com Poucas Vendas'
else 'Clientes com Vendas Boas'
end as Compras_Clientes,
count(*) Nome_Cadastro
from produtos join cadastro on produtos.id_cad = cadastro.id_cad
group by Compras_Clientes
order by Compras_Clientes





