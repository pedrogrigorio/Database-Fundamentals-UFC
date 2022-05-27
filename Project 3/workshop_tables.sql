begin;
DROP TABLE IF EXISTS Fornecedor CASCADE;
DROP TABLE IF EXISTS Peca CASCADE;
DROP TABLE IF EXISTS Projetos CASCADE;
DROP TABLE IF EXISTS FornPecaProj CASCADE;

CREATE TABLE Fornecedor(
    FID int,
    FNOME varchar,
    CIDADE varchar,
    PRIMARY KEY(FID)
);

CREATE TABLE Peca(
    PID int,
    PNOME varchar,
    COR varchar,
    PRIMARY KEY(PID)
);

CREATE TABLE Projetos(
    JID int,
    JNOME varchar,
    CIDADE varchar,
    PRIMARY KEY(JID)
);

CREATE TABLE FornPecaProj(
    FID int,
    PID int,
    JID int,
    QTD int,
    PRIMARY KEY(FID, PID, JID),
    FOREIGN KEY(PID) REFERENCES Peca(PID),
    FOREIGN KEY(JID) REFERENCES Projetos(JID)
);

INSERT INTO Fornecedor VALUES    
    (1, 'Dois irmãos','Quixadá'),
    (2, 'João Silva','Quixeramobim'),
    (3, 'KG Pecas','Iguatu'),
    (4, 'Maria Silva', 'Quixadá'),
    (5, 'F1', 'Iguatu');

INSERT INTO Peca VALUES
    (1,'Pneu', 'Preto'),
    (2,'Chassi', 'Prata'),
    (3,'Bateria', 'Cinza'),
    (4,'Embreagem', 'Preto');

INSERT INTO Projetos VALUES
    (1,'J1', 'Quixadá'),
    (2,'J2', 'Quixadá'),
    (3,'J3', 'Iguatu');

INSERT INTO FornPecaProj VALUES -- RELAÇÕES
-- Fornecedor, peca,  projeto, quantidade

    (1, 1, 1, 4),  -- forn: DOIS IRMÃOS peca: PNEU      proj: J1 quant: 4
    (1, 2, 1, 3),  -- forn: DOIS IRMÃOS peca: CHASSI    proj: J2 quant: 3
    (2, 1, 1, 5),  -- forn: JOÃO SILVA  peca: PNEU      proj: J2 quant: 5
    (2, 3, 2, 10), -- forn: JOÃO SILVA  peca: BATERIA   proj: J1 quant: 10
    (3, 1, 3, 14), -- forn: KG PECAS    peca: PNEU      proj: J1 quant: 14
    (3, 3, 1, 32), -- forn: KG PECAS    peca: BATERIA   proj: J2 quant: 32
    (4, 3, 2, 24), -- forn: MARIA SILVA peca: BATERIA   proj: J2 quant: 24
    (4, 3, 3, 24), -- forn: MARIA SILVA peca: BATERIA   proj: J3 quant: 24
    (5, 2, 3, 16), -- forn: F1          peca: CHASSI    proj: J3 quant: 16
    (5, 4, 3, 13); -- forn: F1          peca: EMBREAGEM proj: J3 quant: 13

commit;