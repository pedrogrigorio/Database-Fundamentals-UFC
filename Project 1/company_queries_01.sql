-- a) Recupere a data de nascimento e o endereço dos funcionários cujo nome seja ‘João B. Silva’.


SELECT Datanasc, Endereco
FROM funcionario
WHERE Pnome='João' and Minicial='B' and Unome='Silva';

-- b) Recupere o nome e endereço de todos os funcionários que trabalham para o departamento ‘Pesquisa’

SELECT Pnome, Endereco
FROM funcionario
WHERE Dnr=5;

-- c) Para cada projeto localizado em ‘Mauá’, liste o número do projeto, o número do departamento que o
--    controla e o sobrenome, endereço e data de nascimento do gerente do departamento.

SELECT Projnumero, Dnum, Unome, Endereco, Datanasc
FROM projeto, departamento, funcionario
WHERE Projlocal='Maua' and Cpf=Cpf_gerente and Dnr=Dnum;

-- d) Para cada funcionário, recupere o primeiro e o último nome do funcionário e o primeiro e o último nome de seu supervisor imediato.

SELECT f1.pnome, f1.unome, f2.pnome, f2.unome
FROM funcionario f1, funcionario f2
WHERE f2.cpf=f1.cpf_supervisor;

-- e) Consulte todos os Cpfs de FUNCIONARIO.

SELECT Cpf
FROM funcionario;

-- f) Consulte Cpf e Dnome (nome de departamento) de cada funcionário.

SELECT Cpf, Dnome
FROM funcionario, departamento
WHERE Dnumero=Dnr;

-- g) Recupere todos os valores de salário distintos de funcionários.

SELECT DISTINCT Salario
FROM funcionario;

-- h) Exiba os números dos projetos que possuem funcionário ou gerente com o último nome ‘Silva’.

SELECT Projnumero
FROM projeto, funcionario
WHERE Dnum=Dnr and Unome='Silva';

-- i) Mostrar nome completo do funcionário e salário acrescido de 10% dos funcionários que trabalham no projeto ‘ProdutoX’.

SELECT Pnome, Minicial, Unome, Salario*1.1
FROM funcionario, projeto, trabalha_em
WHERE Projnome='ProdutoX' and Cpf=Fcpf and Pnr=Projnumero;

-- j) Recuperar nome completo de todos os funcionários no departamento 5, cujo salário esteja entre R$ 30.000,00 e R$ 40.000,00.

SELECT Pnome, Minicial, Unome, Salario
FROM funcionario
WHERE Dnr=5 and Salario >= 30000 and Salario <= 40000;

