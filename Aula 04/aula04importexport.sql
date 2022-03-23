############### Importando e Exportando Dados ##################

## Export de dados 

select * from produtos into outfile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/produtos.csv'
fields terminated by ';' enclosed by '''';

## Exibir as variáveis ##

show variables

show variables like 'secure_file_priv'


### Trabalhando com imports de dados #

#Criando a tabela pra receber o import

create table ImportVendas(
CodigoPedido integer (10),
EmailCliente varchar(100),
CodigoCliente integer,
Qtd integer,
CodigoProduto integer,
CategoriaProduto varchar(50),
primary key(CodigoPedido)
);


## Importar os dados do arquivo CSV ##

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/clientes.csv'
into table importvendas fields terminated by ';' enclosed by '''' lines terminated by '\n'
ignore 1 rows;

select * from importvendas
