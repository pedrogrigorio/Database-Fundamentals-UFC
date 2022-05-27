--a) Selecionar CPFs de todos os funcionários que trabalham na mesma combinação de projeto e horas que o funcionário de CPF 12345678966 trabalha.

SELECT DISTINCT fcpf
FROM trabalha_em
WHERE (Pnr, Horas) IN (
    SELECT pnr, horas
    FROM trabalha_em
    WHERE fcpf='12345678966'
);

--b) Exibir os nomes dos funcionários cujo salário é maior do que o salário de todos os funcionários do departamento de número 5.

SELECT Pnome
FROM funcionario
WHERE salario > (
    SELECT MAX(salario)
    FROM funcionario
    WHERE dnr=5
);

--c) Obter o nome de cada funcionário que tem um dependente com o mesmo sexo do funcionário.

SELECT DISTINCT Pnome
FROM funcionario f, dependente d
WHERE f.cpf = d.fcpf and f.sexo = d.sexo;

--d) Listar os nomes dos gerentes que possuem pelo menos um dependente.

SELECT Pnome
FROM funcionario f, departamento d
WHERE f.cpf = d.Cpf_gerente and EXISTS (
    SELECT *
    FROM dependente
    WHERE fcpf = f.cpf
);

--e) Exibir a soma dos salários de todos os funcionários, o salário máximo, o salário mínimo e a média dos salários.

SELECT SUM(salario), MAX(salario), MIN(salario), AVG(salario)
FROM funcionario;

--f) Exibir a soma dos salários de todos os funcionários de cada departamento, bem como o salário máximo, o salário mínimo e a média dos salários de cada um desses departamentos.

SELECT SUM(salario), MIN(salario), MAX(salario), AVG(salario)
FROM funcionario
GROUP BY dnr;

--g) Recuperar o número total de funcionários da empresa.

SELECT COUNT(*)
FROM funcionario;

--h) Recuperar o número de funcionários de cada departamento.

SELECT COUNT(*)
FROM funcionario
GROUP BY dnr;

--i) Obter o número de valores distintos de salário.

SELECT DISTINCT salario
FROM funcionario;

--j) Exibir os nomes de todos os funcionários que possuem dois ou mais dependentes.

SELECT Pnome, cpf
FROM funcionario f
WHERE (
    SELECT COUNT(*)
    FROM dependente d
    WHERE d.fcpf = f.cpf
) > 2;

--k) Exibir o número do departamento, o número de funcionários no departamento e o salário médio do departamento, para cada departamento da empresa.

SELECT Dnr, COUNT(*), AVG(salario)
FROM funcionario, departamento
WHERE dnr = dnumero
GROUP BY dnr;

--l) Listar o número do projeto, o nome do projeto e o número de funcionários que trabalham nesse projeto, para cada projeto. 

SELECT Projnumero, Projnome, COUNT(*)
FROM projeto, trabalha_em
WHERE Pnr=Projnumero
GROUP BY projnumero;