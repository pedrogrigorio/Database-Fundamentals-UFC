-- a) Recuperar todos os funcionários cujo endereço esteja em
-- ‘São Paulo, SP’.

SELECT *
FROM funcionario
WHERE endereco like '%São Paulo, SP%';

-- b) Recuperar nome do departamento, nome completo do funcionário e 
-- nome do projeto onde ele trabalha, ordenado por departamento, e, 
-- dentro de cada departamento, ordenado alfabeticamente pelo 
-- sobrenome, depois pelo nome.

SELECT Dnome, Pnome || ' ' || Minicial || ' ' || Unome, Projnome, cpf
FROM funcionario f, departamento d, projeto p, trabalha_em t
WHERE f.Dnr=d.Dnumero and t.Pnr=p.Projnumero and t.Fcpf=f.cpf
ORDER BY d.Dnome, f.Unome, f.Pnome;

-- c) Recupere os nomes de todos os funcionários no departamento 5 que
-- trabalham mais de 10 horas por semana no projeto ‘ProdutoX’.

SELECT Pnome
FROM trabalha_em, projeto, funcionario
WHERE Dnr=5 and cpf=fcpf and Projnome='ProdutoX' and Pnr=Projnumero and Horas > 10;

-- d) Liste os nomes de todos os funcionários que possuem um dependente
-- com o primeiro nome igual a seu próprio.

SELECT *
FROM funcionario f, dependente d
WHERE d.Nome_dependente = f.Pnome and d.fcpf=f.cpf;

-- e) Ache os nomes de todos os funcionários que são supervisionados 
-- diretamente por ‘Fernando Wong’.

SELECT f1.Pnome
FROM funcionario f1, funcionario f2
WHERE f1.cpf_supervisor = f2.cpf and f2.Unome = 'Wong';

-- f) Recuperar os nomes de todos os funcionários que não possuem 
-- supervisores.

SELECT Pnome
FROM funcionario
WHERE cpf_supervisor IS NULL;

-- g) Selecionar CPFs de todos os funcionários que trabalham na mesma 
-- combinação de projeto e horas que o funcionário de CPF 12345678966
-- trabalha.

SELECT DISTINCT fcpf
FROM trabalha_em
WHERE (Pnr, Horas) IN (
    SELECT pnr, horas
    FROM trabalha_em
    WHERE fcpf='12345678966'
);

-- h) Exibir os nomes dos funcionários cujo salário é maior do que o
-- salário de todos os funcionários do departamento de número 5.

SELECT Pnome
FROM funcionario
WHERE salario > (
    SELECT MAX(salario)
    FROM funcionario
    WHERE dnr=5
);

-- i) Obter o nome de cada funcionário que tem um dependente com o 
-- mesmo sexo do funcionário.

SELECT DISTINCT Pnome
FROM funcionario f, dependente d
WHERE f.cpf = d.fcpf and f.sexo = d.sexo;

-- j) Listar os nomes dos gerentes que possuem pelo menos um dependente.

SELECT Pnome
FROM funcionario f, departamento d
WHERE f.cpf = d.Cpf_gerente and EXISTS (
    SELECT *
    FROM dependente
    WHERE fcpf = f.cpf
);

-- k) Listar os CPFs de todos os funcionários que trabalham nos 
-- projetos de números 1, 2 ou 3.

SELECT DISTINCT fcpf
FROM trabalha_em
WHERE pnr=1 or pnr=2 or pnr=3;