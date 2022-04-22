 update dicionario set tamdisp = 64 where tabela = 'Clientes' and camposistema = 'Nome' ;
 COMMIT 
 

SELECT * FROM dicionario WHERE tabela = 'clientes'


update dicionario set tamdisp = 46 where tabela = 'Clientes' and camposistema = 'Nome'



SELECT * FROM notasfiscais WHERE chave = '24190103656804001707651080000051071000051078'

DELETE FROM notasfiscais;
DELETE FROM empresas;
DELETE FROM resumonfe ;
DELETE FROM itemnf ;
DELETE FROM produtos;
DELETE FROM participantes ; 
DELETE FROM speds;

Select Count(*) as N1 from resumonfe where idEmpresa = 1 and CONCAT( codpart , numdoc , serie , cfop) = 'SA10107YZ3SQ00145480041202'

 SELECT * from notasfiscais where idEmpresa = 1 and numdoc = '5013'
 
 
 SELECT COUNT(*) , Idnotaf FROM notasfiscais 
 GROUP BY idnotaF HAVING COUNT(*) > 1
 
 
 SELECT COUNT(*) , numdoc FROM notasfiscais 
 GROUP BY numdoc HAVING COUNT(*) > 1
 
  SELECT * from notasfiscais where idnotaf = 1

Select Count(*) AS T1 From notasfiscais

SET NAMES utf8mb4; 
ALTER DATABASE impsped CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci;

SHOW VARIABLES WHERE Variable_name LIKE 'character\_set\_%' OR Variable_name LIKE 'collation%';

SELECT * FROM `information_schema`.`innodb_trx` ORDER BY `trx_started`

KILL 22;KILL 23;KILL 18;KILL 14;KILL 27;
KILL 26197

insert into notasfiscais(IDEMPRESA,
IDNOTAF,
CODPARTI,
CODMODELO,
SITUACAO,
SERIE,
NUMDOC,
CHAVE,
DTEMISSAO,
DTENTRSAIDA,
VLRDOCUMENTO,
INDPGTO,
VLRDESCONTO,
TPFRETE,
VLRFRETE,
VLRSEGURO,
VLROUTROS,
BASEICMS,
VLRICMS,
BASEICMSST,
VLRICMSST,
VLRIPI,
VLRPIS,
VLRCONFINS,
INDEMITENTE,
INDOPERACAO) Values (1,
11662,
'',
'65',
'00',
'103',
'9020',
'24190103656804001707651030000090201000090203',
'2019-01-22',
'2019-01-22',
'149.5',
'2',
'0',
'9',
'0',
'0',
'0',
'149.5',
'26.91',
'0',
'0',
'0',
'0',
'0',
'0',
'1');COMMIT;



insert into speds(IDEMP,
ID,
TIPOARQ,
PERIODO,
DATA) Values (1,
1437812,
1,
0101201931012019,
'2021-12-24')


