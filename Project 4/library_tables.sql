begin;
DROP TABLE IF EXISTS editoras CASCADE;
DROP TABLE IF EXISTS autores CASCADE;
DROP TABLE IF EXISTS livros CASCADE;
DROP TABLE IF EXISTS livros_autores CASCADE;

create table EDITORAS(
    id int,
    nome varchar(50),
    PRIMARY KEY(id));

create table AUTORES(
    id int,
    nome varchar(50),
    PRIMARY KEY (id));

create table LIVROS(
    isbn char(13),
    titulo varchar(50),
    ano_publicacao int,
    qtd_estoque int,
    valor decimal(10,2),
    id_editora int,
    PRIMARY KEY(isbn),
    FOREIGN KEY(id_editora) REFERENCES EDITORAS(id));

create table LIVROS_AUTORES(
    isbn char(13),
    id_autor int,
    PRIMARY KEY(isbn, id_autor),
    FOREIGN KEY(isbn) REFERENCES LIVROS(isbn),
    FOREIGN KEY(id_autor) REFERENCES AUTORES(id));

insert into EDITORAS values
    (1, 'Ática'),
    (2, 'FTD'),
    (3, 'Melhoramentos'),
    (4, 'Novatec'),
    (5, 'Bookman');

insert into AUTORES values
    (1, 'João'),
    (2, 'Maria'),
    (3, 'José'),
    (4, 'Lúcia'),
    (5, 'Carlos'),
    (6, 'Pedro'),
    (7, 'Ana');

insert into LIVROS values
    ('213', 'Banco de Dados', 2011, 2, 40.00, 4),
    ('425', 'Sistemas Operacionais', 2010, 3, 80.00, 3),
    ('732', 'Lógica de Programação', 2009, 1, 60.00, 2),
    ('441', 'Programação Orientada a Objetos', 2012, 1, 70.00, 1),
    ('659', 'Java para Nerds', 2010, 3, 100.00, NULL),
    ('863', 'Engenharia de Software', 2010, 2, 40.00, 2),
    ('376', 'Redes de Computadores', 2008, 1, 100.00, 3);

insert into LIVROS_AUTORES values
    ('732', 1),
    ('425', 3),
    ('659', 4),
    ('441', 2),
    ('659', 1),
    ('425', 5),
    ('213', 3);
commit;