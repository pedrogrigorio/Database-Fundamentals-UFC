begin;
DROP TABLE IF EXISTS CLIENTES CASCADE;
DROP TABLE IF EXISTS CATEGORIAS CASCADE;
DROP TABLE IF EXISTS CLASSES CASCADE;
DROP TABLE IF EXISTS DISTRIBUIDORES CASCADE;
DROP TABLE IF EXISTS FILMES CASCADE;
DROP TABLE IF EXISTS LOCACOES CASCADE;

create table CLIENTES(
    id int,
    nome varchar(50),
    cpf char(11),
    data_cadastro date,
    cidade varchar(50),
    uf char(2),
    UNIQUE(cpf),
    PRIMARY KEY(id));

create table CATEGORIAS(
    id int,
    nome varchar(20),
    PRIMARY KEY(id));

create table CLASSES(
    id int,
    nome varchar(20),
    preco decimal(10,2),
    PRIMARY KEY(id));

create table DISTRIBUIDORES(
    id int,
    nome varchar(50),
    PRIMARY KEY(id));

create table FILMES(
    id int,
    titulo varchar(50),
    id_distribuidor int,
    ano_lancamento int,
    id_categoria int,
    id_classe int,
    PRIMARY KEY(id),
    FOREIGN KEY(id_distribuidor) REFERENCES DISTRIBUIDORES(id),
    FOREIGN KEY(id_categoria) REFERENCES CATEGORIAS(id),
    FOREIGN KEY(id_classe) REFERENCES CLASSES(id));

create table LOCACOES(
    id int,
    id_cliente int,
    id_filme int,
    dt_locacao date,
    dt_devolucao_prevista date,
    dt_devolucao date,
    valor decimal(10,2),
    PRIMARY KEY(id),
    FOREIGN KEY(id_cliente) REFERENCES CLIENTES(id),
    FOREIGN KEY(id_filme) REFERENCES FILMES(id));

insert into CLIENTES values
    (1, 'João', '12345678900', '2020-08-05' , 'Quixadá', 'CE'),    
    (2, 'Pedro', '11122233399', '2021-01-10' , 'Iguatu', 'CE'),
    (3, 'Maria', '00033377710', '2021-01-07' , 'Iguatu', 'CE');

insert into CATEGORIAS values
    (1, 'Ação'),    
    (2, 'Terror'),
    (3, 'Comédia');

insert into CLASSES values
    (1, 'Bronze', 5.00),    
    (2, 'Prata',  7.50),
    (3, 'Ouro', 10.00);

insert into DISTRIBUIDORES values
    (1, 'Disney'),    
    (2, 'Fox'),
    (3, 'Warner');

insert into FILMES values
    (1, 'A volta dos que não foram', 2, 2015, 3, 3),    
    (2, 'Caixa dagua pegando fogo', 1, 2017, 1, 2),
    (3, 'As tranças do rei careca', 3, 2014, 2, 1);

insert into LOCACOES values
    (1, 2, 1, '2020-08-05', '2020-09-05', '2020-08-25', 10.00),    
    (2, 3, 2, '2021-01-10', '2021-02-10', '2021-01-17', 7.50),
    (3, 1, 3, '2021-01-07', '2021-02-07', '2021-02-09', 6.00);
commit;