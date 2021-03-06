# Host: localhost  (Version 8.0.18)
# Date: 2021-12-27 17:51:13
# Generator: MySQL-Front 6.0  (Build 2.20)


#
# Structure for table "cupons"
#

DROP TABLE IF EXISTS `cupons`;
CREATE TABLE `cupons` (
  `idemp` int(11) NOT NULL DEFAULT '0',
  `idsped` int(11) NOT NULL DEFAULT '0',
  `idseq` int(11) NOT NULL DEFAULT '0',
  `codmodelo` varchar(2) DEFAULT NULL,
  `codsituacao` varchar(2) DEFAULT NULL,
  `numdoc` varchar(9) DEFAULT NULL,
  `dtdoc` date NOT NULL DEFAULT '0000-00-00',
  `vlrdoc` decimal(10,2) DEFAULT '0.00',
  `vlrpis` decimal(10,2) DEFAULT NULL,
  `vlrconfins` decimal(10,2) NOT NULL DEFAULT '0.00',
  `cpf` varchar(14) DEFAULT NULL,
  `nome` varchar(60) DEFAULT NULL,
  `status` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`idemp`,`idseq`,`idsped`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

#
# Structure for table "empresas"
#

DROP TABLE IF EXISTS `empresas`;
CREATE TABLE `empresas` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `razao` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `cnpj` varchar(14) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `uf` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ie` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `perfil` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `atividade` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fantasia` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `endereco` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `numero` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `complemento` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bairro` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fone` varchar(155) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contador` varchar(155) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cpfcontador` varchar(14) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `crccontador` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `t1` (`razao`),
  KEY `t33` (`cnpj`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

#
# Structure for table "itecupom"
#

DROP TABLE IF EXISTS `itecupom`;
CREATE TABLE `itecupom` (
  `Idempresa` int(11) NOT NULL AUTO_INCREMENT,
  `idsped` int(11) NOT NULL DEFAULT '0',
  `idseq` int(11) NOT NULL DEFAULT '0',
  `coditem` varchar(60) NOT NULL DEFAULT '',
  `qtde` decimal(10,2) DEFAULT NULL,
  `qtdcancelada` int(11) NOT NULL DEFAULT '0',
  `unidade` varchar(9) DEFAULT NULL,
  `vlitem` double(15,2) DEFAULT NULL,
  `cst` varchar(3) DEFAULT '',
  `cfop` varchar(4) DEFAULT NULL,
  `aliqicms` varchar(4) DEFAULT NULL,
  `vlconfins` decimal(10,2) DEFAULT NULL,
  `status` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`Idempresa`,`idsped`,`idseq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

#
# Structure for table "itemnf"
#

DROP TABLE IF EXISTS `itemnf`;
CREATE TABLE `itemnf` (
  `Idempresa` int(11) NOT NULL AUTO_INCREMENT,
  `iditemnf` int(11) NOT NULL DEFAULT '0',
  `codparti` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `numdoc` varchar(9) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `serie` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `coditem` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `descricao` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qtde` decimal(15,5) NOT NULL DEFAULT '0.00000',
  `unidade` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vlitem` decimal(10,2) DEFAULT '0.00',
  `vldesc` decimal(10,2) DEFAULT '0.00',
  `cst` int(3) DEFAULT NULL,
  `cfop` int(4) DEFAULT NULL,
  `natureza` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `baseicms` decimal(10,2) DEFAULT NULL,
  `aliqicms` decimal(6,2) DEFAULT NULL,
  `valicms` decimal(10,2) DEFAULT NULL,
  `baseicmst` decimal(10,2) DEFAULT NULL,
  `aliqicmsst` decimal(10,2) DEFAULT NULL,
  `valicmsst` decimal(10,2) DEFAULT NULL,
  `cstipi` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `basecalcipi` decimal(10,2) DEFAULT NULL,
  `aliqipi` decimal(10,2) DEFAULT NULL,
  `vlipi` decimal(10,2) DEFAULT NULL,
  `cstpis` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vlrbasepis` decimal(10,2) DEFAULT NULL,
  `aliqpis` decimal(8,4) DEFAULT '0.0000',
  `vlrpis` decimal(10,2) DEFAULT NULL,
  `cstconfins` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `basecalcconfins` decimal(10,2) DEFAULT NULL,
  `aliqconfins` decimal(8,4) DEFAULT NULL,
  `valconfins` decimal(10,2) DEFAULT NULL,
  `vlrabatido` decimal(10,2) DEFAULT NULL,
  `idsped` int(11) NOT NULL DEFAULT '0',
  `status` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Idempresa`,`iditemnf`,`idsped`),
  KEY `f1` (`codparti`),
  KEY `numdoc` (`numdoc`,`serie`,`coditem`),
  KEY `fk9` (`Idempresa`,`idsped`,`iditemnf`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

#
# Structure for table "notasfiscais"
#

DROP TABLE IF EXISTS `notasfiscais`;
CREATE TABLE `notasfiscais` (
  `idempresa` int(11) NOT NULL,
  `idnotaf` int(11) NOT NULL DEFAULT '0',
  `codparti` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `codmodelo` varchar(2) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `situacao` int(2) NOT NULL DEFAULT '0',
  `serie` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `numdoc` varchar(9) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `chave` varchar(44) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `dtemissao` date NOT NULL DEFAULT '0000-00-00',
  `dtentrsaida` date NOT NULL DEFAULT '0000-00-00',
  `vlrdocumento` decimal(10,2) NOT NULL DEFAULT '0.00',
  `indpgto` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vlrdesconto` decimal(10,2) DEFAULT NULL,
  `tpfrete` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vlrfrete` decimal(10,2) DEFAULT NULL,
  `vlrseguro` decimal(10,2) DEFAULT NULL,
  `vlroutros` decimal(10,2) DEFAULT NULL,
  `baseicms` decimal(10,2) DEFAULT NULL,
  `vlricms` decimal(10,2) DEFAULT NULL,
  `baseicmsst` decimal(10,2) DEFAULT NULL,
  `vlricmsst` decimal(10,2) DEFAULT NULL,
  `vlripi` decimal(10,2) DEFAULT NULL,
  `vlrpis` decimal(10,2) DEFAULT NULL,
  `vlrconfins` decimal(10,2) DEFAULT NULL,
  `indemitente` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `indoperacao` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idsped` int(11) NOT NULL DEFAULT '0',
  `status` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  UNIQUE KEY `fk1` (`idempresa`,`idnotaf`,`chave`,`serie`,`numdoc`,`idsped`),
  KEY `f1` (`idempresa`,`numdoc`,`serie`,`chave`),
  KEY `f2` (`idempresa`,`dtemissao`),
  KEY `fk5` (`idempresa`,`idsped`,`idnotaf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

#
# Structure for table "participantes"
#

DROP TABLE IF EXISTS `participantes`;
CREATE TABLE `participantes` (
  `idempresa` varchar(11) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Id` int(11) NOT NULL DEFAULT '0',
  `nome` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `cnpj` varchar(14) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `insest` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cpf` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `municipio` varchar(7) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `endereco` varchar(75) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `complemento` varchar(65) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bairro` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `codparti` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idsped` int(11) NOT NULL DEFAULT '0',
  `status` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`idempresa`,`Id`,`idsped`),
  KEY `f1` (`nome`),
  KEY `f2` (`cnpj`),
  KEY `f3` (`cpf`),
  KEY `fk9` (`idempresa`,`idsped`,`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

#
# Structure for table "produtos"
#

DROP TABLE IF EXISTS `produtos`;
CREATE TABLE `produtos` (
  `Idempresa` int(11) NOT NULL DEFAULT '0',
  `id` int(11) NOT NULL DEFAULT '0',
  `coditem` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `descricao` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `codbarra` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unidade` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tipoitem` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `codncm` varchar(8) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tipi` varchar(3) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `genero` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lista` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icms` decimal(10,2) DEFAULT NULL,
  `cest` varchar(7) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idsped` int(11) NOT NULL DEFAULT '0',
  `status` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Idempresa`,`id`,`idsped`),
  KEY `f1` (`descricao`),
  KEY `f2` (`codncm`),
  KEY `fk9` (`Idempresa`,`idsped`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

#
# Structure for table "reducaoz"
#

DROP TABLE IF EXISTS `reducaoz`;
CREATE TABLE `reducaoz` (
  `Idempresa` int(11) NOT NULL DEFAULT '0',
  `idsped` int(11) NOT NULL DEFAULT '0',
  `idseq` int(11) NOT NULL DEFAULT '0',
  `data` date NOT NULL DEFAULT '0000-00-00',
  `cro` int(11) DEFAULT '0',
  `crz` smallint(1) DEFAULT '0',
  `coofin` smallint(1) DEFAULT '0',
  `gtfin` double(15,2) DEFAULT NULL,
  `vlrbruto` double(15,2) DEFAULT NULL,
  `status` varchar(15) DEFAULT '',
  PRIMARY KEY (`Idempresa`,`idsped`,`idseq`),
  KEY `f1` (`data`,`idsped`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

#
# Structure for table "reganalitico"
#

DROP TABLE IF EXISTS `reganalitico`;
CREATE TABLE `reganalitico` (
  `Idemp` int(11) NOT NULL DEFAULT '0',
  `idsped` int(11) NOT NULL DEFAULT '0',
  `idseq` int(11) NOT NULL DEFAULT '0',
  `cst` varchar(3) NOT NULL DEFAULT '',
  `cfop` varchar(4) NOT NULL DEFAULT '',
  `aliquota` int(4) NOT NULL DEFAULT '0',
  `vlroperacao` decimal(15,2) NOT NULL DEFAULT '0.00',
  `basecalc` decimal(10,2) DEFAULT '0.00',
  `vlricms` decimal(10,2) NOT NULL DEFAULT '0.00',
  `status` varchar(15) NOT NULL DEFAULT '',
  PRIMARY KEY (`Idemp`,`idsped`,`idseq`,`cst`,`cfop`,`aliquota`),
  KEY `f233` (`Idemp`,`idsped`,`cst`,`cfop`,`aliquota`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

#
# Structure for table "resumonfe"
#

DROP TABLE IF EXISTS `resumonfe`;
CREATE TABLE `resumonfe` (
  `Idempresa` int(11) NOT NULL AUTO_INCREMENT,
  `codpart` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `numdoc` varchar(9) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `serie` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `cst` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `cfop` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `aliquota` decimal(10,2) NOT NULL DEFAULT '0.00',
  `vloperacao` decimal(10,2) NOT NULL DEFAULT '0.00',
  `basecalc` decimal(10,2) DEFAULT '0.00',
  `valicms` decimal(10,2) DEFAULT NULL,
  `baseicmsst` decimal(10,2) DEFAULT NULL,
  `valoricmsst` decimal(10,2) DEFAULT NULL,
  `valreducao` decimal(10,2) DEFAULT NULL,
  `vlripi` decimal(10,2) DEFAULT NULL,
  `idsped` int(11) NOT NULL DEFAULT '0',
  `status` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Idempresa`,`numdoc`,`codpart`,`serie`,`cst`,`cfop`,`aliquota`,`idsped`),
  KEY `f1` (`numdoc`),
  KEY `f2` (`Idempresa`,`idsped`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

#
# Structure for table "speds"
#

DROP TABLE IF EXISTS `speds`;
CREATE TABLE `speds` (
  `idemp` int(11) NOT NULL DEFAULT '0',
  `Id` int(11) NOT NULL DEFAULT '0',
  `tipoarq` varchar(1) NOT NULL DEFAULT '',
  `periodo` varchar(16) NOT NULL DEFAULT '',
  `data` date DEFAULT NULL,
  `status` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`idemp`,`Id`),
  KEY `fk1` (`data`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

#
# Structure for table "totalizadores"
#

DROP TABLE IF EXISTS `totalizadores`;
CREATE TABLE `totalizadores` (
  `Idemp` int(11) NOT NULL AUTO_INCREMENT,
  `idsped` int(11) NOT NULL DEFAULT '0',
  `idseq` int(11) NOT NULL DEFAULT '0',
  `codtotpar` varchar(7) NOT NULL DEFAULT '',
  `vlracumulado` double(10,2) DEFAULT NULL,
  `nrtotal` varchar(2) DEFAULT NULL,
  `descricao` varchar(25) DEFAULT NULL,
  `status` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`Idemp`,`idsped`,`idseq`,`codtotpar`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
