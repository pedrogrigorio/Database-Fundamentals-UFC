--a) Encontre os fornecedores que só fornecem peças para projetos em Quixadá.

SELECT *
FROM fornecedor f
WHERE f.fid NOT IN(
    SELECT r.fid
    FROM projetos j, fornpecaproj r
    WHERE r.jid = j.jid and j.cidade <> 'Quixadá'
);

--b) Encontre as peças que não são fornecidas nem pelo fornecedor ‘João Silva’ nem pela ‘Maria Silva’.

SELECT *
FROM peca p
WHERE p.pid NOT IN(
    SELECT DISTINCT r.pid
    FROM fornpecaproj r, fornecedor f
    WHERE r.fid = f.fid and (f.fnome = 'João Silva' or f.fnome = 'Maria Silva')
);

--c) Encontre para cada peça, a quantidade total em que ela é fornecida considerando todos os projetos.

SELECT p.pnome, SUM(r.qtd)
FROM fornpecaproj r JOIN peca p ON r.pid = p.pid
GROUP BY p.pid;

--d) Encontre os fornecedores que fornecem peças usadas no projeto ‘J1’.

SELECT DISTINCT f.fid, f.fnome
FROM (fornpecaproj r JOIN projetos j ON r.jid=j.jid) JOIN fornecedor f ON f.fid=r.fid
WHERE j.jnome = 'J1';

--e) Retorne as peças fornecidas pelo fornecedor ‘F1’.

SELECT p.pid, p.pnome
FROM (fornpecaproj r JOIN fornecedor f ON r.fid=f.fid) JOIN peca p ON r.pid=p.pid
WHERE f.fnome = 'F1';

--f) Encontre para cada peça fornecida: o nome da peça, a quantidade máxima e quantidade mínima em que esta peça é fornecida, excluindo as entregas feitas pelo fornecedor ‘F1’.

SELECT p.pnome, MAX(r.qtd), MIN(r.qtd)
FROM (fornpecaproj r JOIN peca p ON r.pid=p.pid) JOIN fornecedor f ON r.fid=f.fid
WHERE f.fnome <> 'F1'
GROUP BY p.pnome;

--g) Encontre o número de todas as peças que são fornecidas por mais de um fornecedor.

SELECT p.pid, p.pnome, Count(*)
FROM fornpecaproj r JOIN peca p ON r.pid=p.pid
GROUP BY p.pid
HAVING Count(*) > 1;

--h) Encontre a quantidade total de peças fornecidas por cada fornecedor. Nessa relação deve constar mesmo os fornecedores que não fornecem para nenhum projeto.

SELECT f.fnome, SUM(r.qtd)
FROM fornpecaproj r JOIN fornecedor f ON r.fid=f.fid
GROUP BY f.fnome;
