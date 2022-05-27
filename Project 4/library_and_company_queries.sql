--1. Obter o(s) título(s) do(s) livro(s) que possuem o valor mais alto.

SELECT l.titulo
FROM livros l
WHERE valor = (
    SELECT MAX(valor)
    FROM livros
);

--2. Obter o(s) nome(s) do(s) autor(es) que publicaram o livro mais barato. 

SELECT a.nome
FROM autores a JOIN livros_autores r ON a.id = r.id_autor
WHERE r.isbn IN(
    SELECT isbn
    FROM livros
    WHERE valor = (
        SELECT min(valor)
        FROM livros
    )
);

--3. Listar os autores que publicaram livros cujo valor esteja acima da média de preço de livros. Mostrar os resultados em ordem alfabética pelo nome do autor.

SELECT a.nome
FROM autores a JOIN livros_autores r ON a.id = r.id_autor
WHERE r.isbn IN (
    SELECT isbn
    FROM livros
    WHERE valor > (
        SELECT AVG(valor)
        FROM livros
    )
)
ORDER BY a.nome;

--4. Exibir os títulos dos livros e o valor total existente em estoque para cada título. Somente os livros com mais de um exemplar em estoque devem ser exibidos. Os livros devem ser exibidos em ordem decrescente pelo seu valor total em estoque.

SELECT titulo, qtd_estoque
FROM livros
WHERE qtd_estoque > 1
ORDER BY qtd_estoque DESC;

--5 Listar os nomes dos autores e quantos livros cada um deles escreveu. Inclusive autores que não publicaram livros devem ser exibidos. Ordenar do autor que escreveu mais livros até o autor que escreveu menos livros.

SELECT a.nome, r.id_autor, Count(*) as livros_escritos
FROM autores a RIGHT OUTER JOIN livros_autores r ON a.id = r.id_autor
GROUP BY r.id_autor, a.nome
ORDER BY livros_escritos DESC;

--6 Listar os nomes das editoras e o maior e menor valor unitário de livro publicado por cada uma delas.

SELECT e.id, e.nome, min(valor), max(valor)
FROM editoras e JOIN livros l ON e.id = l.id_editora
GROUP BY e.id, e.nome;

--7 Listar os nomes das editoras cujo maior valor unitário de livro é maior que R$ 30,00.

SELECT e.nome
FROM editoras e JOIN livros l ON e.id = l.id_editora
WHERE l.valor > 30.00;

--8 Listar os nomes das editoras que possuem mais de um livro.

SELECT e.nome
FROM editoras e JOIN livros l ON e.id = l.id_editora
GROUP BY l.id_editora, e.nome
HAVING count(*) > 1;

--9 Listar os nomes dos autores que publicaram livros pela editora ‘Melhoramentos’.

SELECT a.nome
FROM ((livros l JOIN editoras e ON e.id = l.id_editora) JOIN livros_autores r ON l.isbn=r.isbn) JOIN autores a ON a.id=r.id_autor
WHERE e.nome = 'Melhoramentos';


--10 Listar somente os nomes dos autores que não possuem livros publicados.

SELECT *
FROM autores a
WHERE a.id NOT IN(
    SELECT id_autor
    FROM livros_autores
);

SELECT *
FROM autores a
WHERE NOT EXISTS(
    SELECT *
    FROM livros_autores r
    WHERE r.id_autor=a.id
);

--11 Listar os títulos de livros com valor unitário maior ou igual ao maior valor unitário de livro. Nesta questão, escreva duas consultas. Uma delas usando função agregada e a outra sem o uso de função agregada.

SELECT *
FROM livros
WHERE valor >= (
    SELECT max(valor)
    FROM livros
);

SELECT *
FROM livros l
WHERE NOT EXISTS(
    SELECT *
    FROM livros r
    WHERE r.valor > l.valor
);

--12 Listar título do livro, nome do autor e nome da editora. A listagem deve exibir inclusive livros sem editora, livros sem autor, autores sem livro e editoras sem livro.

SELECT l.titulo, a.nome, e.nome
FROM ((livros_autores r RIGHT OUTER JOIN livros l ON r.isbn=l.isbn) FULL OUTER JOIN autores a ON r.id_autor=a.id) FULL OUTER JOIN editoras e ON l.id_editora=e.id;

--13 Baseado no banco de dados Empresa, crie uma visão para cada uma das seguintes consultas SQL

--13.a) Exibir o nome do departamento e o total salarial pago aos funcionários dele. Mostrar os departamentos com maior gasto com pessoal primeiro. Mostrar inclusive os departamentos que não possuem funcionário, caso exista.

CREATE VIEW salario_por_departamento as(
SELECT d.dnome, SUM(salario) as total_salario
FROM funcionario f LEFT OUTER JOIN departamento d ON f.dnr=d.dnumero
GROUP BY f.dnr, d.dnome
ORDER BY total_salario DESC);

SELECT *
FROM salario_por_departamento;

--13.b) Para cada cidade de projeto, exibir o seu nome e o número de pessoas que trabalham em projetos nessa cidade. Mostrar inclusive as cidades onde não há pessoas trabalhando em projetos.

CREATE VIEW func_por_cidade as(
SELECT p.projlocal, count(*) as funcionarios
FROM projeto p LEFT OUTER JOIN trabalha_em t ON p.projnumero=t.pnr
GROUP BY p.projlocal);

SELECT *
FROM func_por_cidade;

--13.c) Para cada funcionário, exibir quantos dependentes do sexo masculino e quantos dependentes do sexo feminino, ele tem.

CREATE VIEW qntd_dep AS(
SELECT f.pnome, (
    SELECT count(*) as fem
    FROM dependente d
    WHERE d.fcpf=f.cpf and d.sexo='F'),
   (SELECT count(*) as masc
    FROM dependente d
    WHERE d.fcpf=f.cpf and d.sexo='M')
FROM funcionario f LEFT OUTER JOIN dependente d ON f.cpf=d.fcpf
GROUP BY f.cpf, f.pnome);

SELECT *
FROM qntd_dep;

--13.d) Exibir os nomes dos funcionários que recebem o maior salário pago pela empresa. Faça duas consultas: 
-- i.  uma usando funções de agregação.

CREATE VIEW func_maior_salario1 AS(
SELECT f.pnome
FROM funcionario f
WHERE salario = (
    SELECT max(salario)
    FROM funcionario)
);

SELECT *
FROM func_maior_salario1;
-- ii. uma que não faça uso de funções de agregação.

CREATE VIEW func_maior_salario2 AS(
SELECT f.pnome
FROM funcionario f
WHERE NOT EXISTS (
    SELECT salario
    FROM funcionario f1
    WHERE f1.salario > f.salario)
);

SELECT *
FROM func_maior_salario2;

--14. Crie uma visão para exibir nome completo do funcionário, nome completo do supervisor, nome do departamento e quantidade de projetos onde o funcionário trabalha.

CREATE VIEW func AS(
SELECT f1.pnome || ' ' || f1.minicial || ' ' || f1.unome as funcionario, f2.pnome || ' ' || f2.minicial || ' ' || f2.unome as supervisor, d.dnome, count(*) as projetos
FROM ((funcionario f1 LEFT OUTER JOIN funcionario f2 ON f2.cpf=f1.cpf_supervisor)JOIN departamento d ON f1.dnr=d.dnumero) JOIN trabalha_em t ON f1.cpf=t.fcpf
GROUP BY f1.cpf, f1.pnome, f1.minicial, f1.unome, f2.pnome, f2.minicial, f2.unome, d.dnome
);

SELECT *
FROM func;

--15. Crie um visão com o nome completo do funcionário e a quantidade de projetos onde ele trabalha. Somente devem ser exibidos os funcionários que trabalham em mais de um projeto. 

CREATE OR REPLACE VIEW func2 AS(
SELECT f1.pnome || ' ' || f1.minicial || ' ' || f1.unome as funcionario, Count(*) as qtd_projetos
FROM funcionario f1 JOIN trabalha_em t ON f1.cpf=t.fcpf
GROUP BY f1.cpf, f1.pnome, f1.minicial, f1.unome
HAVING count(*) > 1
);

SELECT *
FROM func2;