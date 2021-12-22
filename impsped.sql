# Host: localhost  (Version 8.0.18)
# Date: 2021-12-22 14:19:50
# Generator: MySQL-Front 6.0  (Build 2.20)


#
# Structure for table "empresas"
#

DROP TABLE IF EXISTS `empresas`;
CREATE TABLE `empresas` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `razao` varchar(255) NOT NULL DEFAULT '',
  `cnpj` varchar(14) NOT NULL DEFAULT '',
  `uf` varchar(2) DEFAULT NULL,
  `ie` varchar(30) DEFAULT NULL,
  `perfil` varchar(10) DEFAULT NULL,
  `atividade` varchar(10) DEFAULT NULL,
  `fantasia` varchar(255) DEFAULT NULL,
  `endereco` varchar(255) DEFAULT NULL,
  `numero` varchar(15) DEFAULT NULL,
  `complemento` varchar(150) DEFAULT NULL,
  `bairro` varchar(100) DEFAULT NULL,
  `fone` varchar(155) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `contador` varchar(155) DEFAULT NULL,
  `cpfcontador` varchar(14) DEFAULT NULL,
  `crccontador` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `t1` (`razao`),
  KEY `t33` (`cnpj`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE = utf8mb4_unicode_ci;

#
# Data for table "empresas"
#


#
# Structure for table "itemnf"
#

DROP TABLE IF EXISTS `itemnf`;
CREATE TABLE `itemnf` (
  `Idempresa` int(11) NOT NULL AUTO_INCREMENT,
  `codparti` varchar(60) NOT NULL DEFAULT '',
  `numdoc` varchar(9) NOT NULL DEFAULT '',
  `serie` varchar(3) NOT NULL DEFAULT '',
  `coditem` varchar(60) NOT NULL DEFAULT '',
  `descricao` varchar(100) DEFAULT NULL,
  `qtde` decimal(15,5) NOT NULL DEFAULT '0.00000',
  `unidade` varchar(6) DEFAULT NULL,
  `vlitem` decimal(10,2) DEFAULT '0.00',
  `vldesc` decimal(10,2) DEFAULT '0.00',
  `cst` int(3) DEFAULT NULL,
  `cfop` int(4) DEFAULT NULL,
  `natureza` varchar(10) DEFAULT NULL,
  `baseicms` decimal(10,2) DEFAULT NULL,
  `aliqicms` decimal(6,2) DEFAULT NULL,
  `valicms` decimal(10,2) DEFAULT NULL,
  `baseicmst` decimal(10,2) DEFAULT NULL,
  `aliqicmsst` decimal(10,2) DEFAULT NULL,
  `valicmsst` decimal(10,2) DEFAULT NULL,
  `cstipi` varchar(2) DEFAULT NULL,
  `basecalcipi` decimal(10,2) DEFAULT NULL,
  `aliqipi` decimal(10,2) DEFAULT NULL,
  `vlipi` decimal(10,2) DEFAULT NULL,
  `cstpis` varchar(2) DEFAULT NULL,
  `vlrbasepis` decimal(10,2) DEFAULT NULL,
  `aliqpis` decimal(8,4) DEFAULT '0.0000',
  `vlrpis` decimal(10,2) DEFAULT NULL,
  `cstconfins` varchar(2) DEFAULT NULL,
  `basecalcconfins` decimal(10,2) DEFAULT NULL,
  `aliqconfins` decimal(8,4) DEFAULT NULL,
  `valconfins` decimal(10,2) DEFAULT NULL,
  `vlrabatido` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`Idempresa`,`codparti`,`numdoc`,`serie`,`coditem`),
  KEY `f1` (`codparti`),
  KEY `numdoc` (`numdoc`,`serie`,`coditem`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE = utf8mb4_unicode_ci;

#
# Data for table "itemnf"
#


#
# Structure for table "notasfiscais"
#

DROP TABLE IF EXISTS `notasfiscais`;
CREATE TABLE `notasfiscais` (
  `idempresa` int(11) NOT NULL,
  `idnotaf` int(11) NOT NULL DEFAULT '0',
  `codparti` varchar(60) NOT NULL DEFAULT '',
  `codmodelo` varchar(2) NOT NULL DEFAULT '',
  `situacao` int(2) NOT NULL DEFAULT '0',
  `serie` varchar(3) NOT NULL DEFAULT '',
  `numdoc` varchar(9) NOT NULL DEFAULT '',
  `chave` varchar(44) NOT NULL DEFAULT '',
  `dtemissao` date NOT NULL DEFAULT '0000-00-00',
  `dtentrsaida` date NOT NULL DEFAULT '0000-00-00',
  `vlrdocumento` decimal(10,2) NOT NULL DEFAULT '0.00',
  `indpgto` varchar(1) DEFAULT NULL,
  `vlrdesconto` decimal(10,2) DEFAULT NULL,
  `tpfrete` varchar(1) DEFAULT NULL,
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
  `indemitente` varchar(1) DEFAULT NULL,
  `indoperacao` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`idempresa`,`idnotaf`),
  KEY `f1` (`idempresa`,`numdoc`,`serie`,`chave`),
  KEY `f2` (`idempresa`,`dtemissao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE = utf8mb4_unicode_ci;

#
# Data for table "notasfiscais"
#


#
# Structure for table "participantes"
#

DROP TABLE IF EXISTS `participantes`;
CREATE TABLE `participantes` (
  `idempresa` varchar(11) NOT NULL DEFAULT '',
  `Id` int(11) NOT NULL DEFAULT '0',
  `nome` varchar(100) NOT NULL DEFAULT '',
  `cnpj` varchar(14) DEFAULT '',
  `insest` varchar(30) DEFAULT NULL,
  `cpf` varchar(11) DEFAULT NULL,
  `municipio` varchar(7) DEFAULT NULL,
  `endereco` varchar(75) DEFAULT NULL,
  `complemento` varchar(65) DEFAULT NULL,
  `bairro` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `codparti` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`idempresa`,`Id`),
  KEY `f1` (`nome`),
  KEY `f2` (`cnpj`),
  KEY `f3` (`cpf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE = utf8mb4_unicode_ci;

#
# Data for table "participantes"
#


#
# Structure for table "produtos"
#

DROP TABLE IF EXISTS `produtos`;
CREATE TABLE `produtos` (
  `Idempresa` int(11) NOT NULL DEFAULT '0',
  `id` int(11) NOT NULL DEFAULT '0',
  `coditem` varchar(60) NOT NULL DEFAULT '',
  `descricao` varchar(150) NOT NULL DEFAULT '',
  `codbarra` varchar(40) DEFAULT NULL,
  `unidade` varchar(6) DEFAULT NULL,
  `tipoitem` varchar(2) DEFAULT NULL,
  `codncm` varchar(8) DEFAULT NULL,
  `tipi` varchar(3) DEFAULT NULL,
  `genero` varchar(2) DEFAULT NULL,
  `lista` varchar(5) DEFAULT NULL,
  `icms` decimal(10,2) DEFAULT NULL,
  `cest` varchar(7) DEFAULT NULL,
  PRIMARY KEY (`Idempresa`,`id`),
  KEY `f1` (`descricao`),
  KEY `f2` (`codncm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE = utf8mb4_unicode_ci;

#
# Data for table "produtos"
#


#
# Structure for table "resumonfe"
#

DROP TABLE IF EXISTS `resumonfe`;
CREATE TABLE `resumonfe` (
  `Idempresa` int(11) NOT NULL AUTO_INCREMENT,
  `codpart` varchar(60) NOT NULL DEFAULT '',
  `numdoc` varchar(9) NOT NULL DEFAULT '',
  `serie` varchar(3) NOT NULL DEFAULT '',
  `cst` varchar(3) NOT NULL DEFAULT '',
  `cfop` varchar(4) NOT NULL DEFAULT '',
  `aliquota` decimal(10,2) NOT NULL DEFAULT '0.00',
  `vloperacao` decimal(10,2) NOT NULL DEFAULT '0.00',
  `basecalc` decimal(10,2) DEFAULT '0.00',
  `valicms` decimal(10,2) DEFAULT NULL,
  `baseicmsst` decimal(10,2) DEFAULT NULL,
  `valoricmsst` decimal(10,2) DEFAULT NULL,
  `valreducao` decimal(10,2) DEFAULT NULL,
  `vlripi` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`Idempresa`,`numdoc`,`codpart`,`serie`,`cst`,`cfop`,`aliquota`),
  KEY `f1` (`numdoc`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE = utf8mb4_unicode_ci;

#
# Data for table "resumonfe"
#

