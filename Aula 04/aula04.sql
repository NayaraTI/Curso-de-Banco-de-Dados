#################### Trabalhando com Índices ####################4

#Índices servem para otimizar as consultas em um banco de dados
#Os índices estão atrelados a uma tabela e um campo de tabela

## Criar uma tabela com Índice ##

create table cliente(
id_cliente integer not null auto_increment,
cod_cliente varchar(10),
Nome varchar(50),
Sobrenome varchar(50),
cpf integer,
d_cadastro date,
primary key(id_cliente),
index ind_cod_cliente(cod_cliente)
);

## Criar um Índice em uma tabela existente ##
