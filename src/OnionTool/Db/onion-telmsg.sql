SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `telmsg`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `AccessToken`
--

CREATE TABLE IF NOT EXISTS `AccessToken` (
  `id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned NOT NULL,
  `stToken` varchar(255) NOT NULL,
  `stLabel` varchar(255) DEFAULT NULL,
  `stResource` varchar(100) NOT NULL,
  `stAction` varchar(100) NOT NULL,
  `Resource_id` int(10) unsigned NOT NULL,
  `stEmail` varchar(255) NOT NULL,
  `stName` varchar(150) NOT NULL,
  `txtMessage` text NOT NULL,
  `dtLastAccess` datetime DEFAULT NULL,
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned DEFAULT '0',
  `isActive` enum('0','1') DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `CashFlow`
--

CREATE TABLE IF NOT EXISTS `CashFlow` (
  `id` int(10) unsigned NOT NULL,
  `User_id` int(11) DEFAULT NULL,
  `CashRegister_id` int(10) unsigned DEFAULT NULL,
  `stResource` varchar(50) DEFAULT NULL,
  `ServiceOrder_id` int(10) unsigned NOT NULL DEFAULT '0',
  `stInvoice` varchar(100) DEFAULT NULL,
  `numValue` decimal(10,3) unsigned NOT NULL DEFAULT '0.000',
  `numAddValue1` decimal(10,3) unsigned DEFAULT '0.000',
  `numAddValue2` decimal(10,3) unsigned DEFAULT '0.000',
  `numDiscount` decimal(10,3) unsigned DEFAULT '0.000',
  `numFreight` decimal(10,3) unsigned DEFAULT '0.000',
  `numTotal` decimal(10,3) unsigned NOT NULL DEFAULT '0.000',
  `stType` varchar(50) NOT NULL,
  `txtTransactionReturn` text,
  `stTransactionStatus` varchar(10) DEFAULT NULL,
  `dtToReceive` date DEFAULT NULL,
  `stBestTime` varchar(20) DEFAULT NULL,
  `dtReceived` date DEFAULT NULL,
  `Collector_id` int(10) unsigned DEFAULT NULL,
  `stReceiveCep` varchar(10) DEFAULT NULL,
  `stReceiveCountry` varchar(100) DEFAULT NULL,
  `stReceiveEstate` varchar(100) DEFAULT NULL,
  `stReceiveCity` varchar(100) DEFAULT NULL,
  `stReceiveNeighborhood` varchar(100) DEFAULT NULL,
  `stReceiveStreet` varchar(255) DEFAULT NULL,
  `stReceiveNumber` varchar(10) DEFAULT NULL,
  `stReceiveComplement` varchar(100) DEFAULT NULL,
  `stReceiveReference` varchar(255) DEFAULT NULL,
  `txtDescription` text,
  `isPrinted` enum('0','1') NOT NULL DEFAULT '0',
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `isActive` enum('0','1') NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `CashRegister`
--

CREATE TABLE IF NOT EXISTS `CashRegister` (
  `id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned NOT NULL COMMENT 'Usuário que pode acessar os dados da conta',
  `Company_id` int(10) unsigned DEFAULT NULL,
  `numTotal` decimal(10,2) unsigned DEFAULT NULL COMMENT 'Id da tabela company',
  `dtClose` datetime DEFAULT NULL COMMENT 'Id de integração com o sistema de billing',
  `dtDrawee` datetime DEFAULT NULL,
  `enumCashStatus` enum('0','1','2') DEFAULT '0',
  `txtDescription` text COMMENT 'Ip de integração com o sistema de ipbx',
  `dtInsert` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `dtUpdate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(3) unsigned DEFAULT '0',
  `isActive` enum('0','1') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `Client`
--

CREATE TABLE IF NOT EXISTS `Client` (
  `id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `stName` varchar(250) DEFAULT NULL COMMENT '- Nome do ser humano',
  `enumGender` enum('F','M') DEFAULT NULL COMMENT '- Sexo do ser humano (Genero)',
  `dtBirthdate` date DEFAULT NULL COMMENT '- Data de nascimento',
  `stCitizenId` varchar(20) DEFAULT NULL COMMENT '- Documento de identidade RG',
  `stDoc2` varchar(14) DEFAULT NULL COMMENT '- Documento de identidade 2 CPF',
  `stEmail` varchar(255) DEFAULT NULL,
  `stMobile` varchar(15) DEFAULT NULL,
  `stMobile2` varchar(15) DEFAULT NULL,
  `stMobile3` varchar(15) DEFAULT NULL,
  `stWhatsapp` varchar(15) DEFAULT NULL,
  `stHomePhone` varchar(15) DEFAULT NULL,
  `stHomeCep` varchar(10) DEFAULT NULL,
  `stHomeCountry` varchar(100) DEFAULT NULL,
  `stHomeEstate` varchar(100) DEFAULT NULL,
  `stHomeCity` varchar(100) DEFAULT NULL,
  `stHomeNeighborhood` varchar(100) DEFAULT NULL,
  `stHomeStreet` varchar(255) DEFAULT NULL,
  `stHomeNumber` varchar(10) DEFAULT NULL,
  `stHomeComplement` varchar(100) DEFAULT NULL,
  `stHomeReference` varchar(100) DEFAULT NULL,
  `stWorkPhone` varchar(15) DEFAULT NULL,
  `stWorkCep` varchar(10) DEFAULT NULL,
  `stWorkCountry` varchar(100) DEFAULT NULL,
  `stWorkEstate` varchar(100) DEFAULT NULL,
  `stWorkCity` varchar(100) DEFAULT NULL,
  `stWorkNeighborhood` varchar(100) DEFAULT NULL,
  `stWorkStreet` varchar(255) DEFAULT NULL,
  `stWorkNumber` varchar(10) DEFAULT NULL,
  `stWorkComplement` varchar(100) DEFAULT NULL,
  `stWorkReference` varchar(255) DEFAULT NULL,
  `txtData` text COMMENT 'json with extra data about person',
  `enumType` enum('0','1') NOT NULL DEFAULT '0',
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Person data ';

-- --------------------------------------------------------

--
-- Estrutura da tabela `Company`
--

CREATE TABLE IF NOT EXISTS `Company` (
  `id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `stName` varchar(250) NOT NULL COMMENT '- Razão social;',
  `stAliasName` varchar(250) DEFAULT NULL COMMENT '- Nome Fantasia',
  `stRegistry` varchar(25) DEFAULT NULL COMMENT '- Registro (ex.: Cnpj)',
  `stRegistry2` varchar(25) DEFAULT NULL COMMENT '- Inscrição Estadual',
  `stArea` varchar(25) DEFAULT NULL COMMENT '- Área de atuação da empresa',
  `stDescription` text COMMENT '- Descrição da empresa',
  `stLogoPath` varchar(250) DEFAULT NULL COMMENT '- Caminho para o arquivo físico da logo',
  `stLink` varchar(255) DEFAULT NULL COMMENT '- Domínio do link google.com',
  `stKeywords` varchar(255) DEFAULT NULL,
  `txtData` text COMMENT 'json with extra data about company',
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table of companies for all purposes';

-- --------------------------------------------------------

--
-- Estrutura da tabela `Crm`
--

CREATE TABLE IF NOT EXISTS `Crm` (
  `id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned NOT NULL,
  `Client_SenderId` int(10) unsigned NOT NULL,
  `Client_ReceiverId` int(10) unsigned NOT NULL,
  `ServiceOrder_id` int(10) unsigned DEFAULT NULL,
  `txtObservation` text NOT NULL,
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned DEFAULT '0',
  `isActive` enum('0','1') DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `File`
--

CREATE TABLE IF NOT EXISTS `File` (
  `id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `stType` varchar(20) NOT NULL DEFAULT 'other',
  `stTitle` varchar(250) NOT NULL COMMENT '- Titulo da foto',
  `stVersion` varchar(15) NOT NULL DEFAULT '1',
  `stDescription` varchar(250) DEFAULT NULL COMMENT '- Descrição da foto',
  `stSource` varchar(250) DEFAULT NULL COMMENT '- Fonte da foto, autor ...',
  `stFilePath` varchar(250) DEFAULT NULL COMMENT '- Caminho para o arquivo físico (Nome do arquivo)',
  `stKeywords` text,
  `isNew` enum('0','1') NOT NULL DEFAULT '0',
  `isHighlighted` enum('0','1') NOT NULL DEFAULT '0',
  `dtPublish` datetime DEFAULT NULL,
  `stThumb` varchar(255) DEFAULT NULL,
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='File is a table that records and manage upload files, as pdf';

-- --------------------------------------------------------

--
-- Estrutura da tabela `LogAccess`
--

CREATE TABLE IF NOT EXISTS `LogAccess` (
  `id` int(10) unsigned NOT NULL,
  `dtInsert` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `User_id` int(10) unsigned DEFAULT NULL COMMENT 'User owner or the user that created this record. The user registred',
  `txtCredentials` text NOT NULL,
  `stSession` varchar(255) DEFAULT NULL,
  `stIP` varchar(20) DEFAULT NULL,
  `txtServer` text NOT NULL,
  `stPriority` varchar(1) DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `isActive` enum('0','1') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Records of access log';

-- --------------------------------------------------------

--
-- Estrutura da tabela `LogClick`
--

CREATE TABLE IF NOT EXISTS `LogClick` (
  `id` int(10) unsigned NOT NULL,
  `dtInsert` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `stResource` varchar(50) DEFAULT NULL,
  `Resource_Id` int(10) unsigned DEFAULT NULL,
  `stUrl` varchar(250) DEFAULT NULL,
  `stPriority` varchar(1) DEFAULT NULL,
  `stIP` varchar(20) DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `isActive` enum('0','1') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log of click action. Can be used for all tables or modules';

-- --------------------------------------------------------

--
-- Estrutura da tabela `LogEvent`
--

CREATE TABLE IF NOT EXISTS `LogEvent` (
  `id` int(10) unsigned NOT NULL,
  `dtInsert` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `User_id` int(10) unsigned DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `stIP` varchar(20) DEFAULT NULL,
  `txtServer` text NOT NULL,
  `stPriority` varchar(1) DEFAULT NULL,
  `stMsg` text,
  `dtUpdate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `isActive` enum('0','1') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Records of system event log';

-- --------------------------------------------------------

--
-- Estrutura da tabela `LogSearch`
--

CREATE TABLE IF NOT EXISTS `LogSearch` (
  `id` int(10) unsigned NOT NULL,
  `dtInsert` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `stQuery` varchar(250) DEFAULT NULL,
  `numResults` int(10) unsigned DEFAULT NULL,
  `stPriority` varchar(1) DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `isActive` enum('0','1') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Records of key words used in search action';

-- --------------------------------------------------------

--
-- Estrutura da tabela `LogView`
--

CREATE TABLE IF NOT EXISTS `LogView` (
  `id` int(10) unsigned NOT NULL,
  `dtInsert` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `stResource` varchar(50) DEFAULT NULL,
  `Resource_Id` int(10) unsigned DEFAULT NULL,
  `stUrl` varchar(250) DEFAULT NULL,
  `stPriority` varchar(1) DEFAULT NULL,
  `stIP` varchar(20) DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `isActive` enum('0','1') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Records of view logs. Can be used for count view action for ';

-- --------------------------------------------------------

--
-- Estrutura da tabela `Person`
--

CREATE TABLE IF NOT EXISTS `Person` (
  `id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `stName` varchar(250) DEFAULT NULL COMMENT '- Nome do ser humano',
  `enumGender` enum('F','M') DEFAULT NULL COMMENT '- Sexo do ser humano (Genero)',
  `dtBirthdate` date DEFAULT NULL COMMENT '- Data de nascimento',
  `stCitizenId` char(20) DEFAULT NULL COMMENT '- Documento de identidade RG',
  `stDoc2` char(14) DEFAULT NULL COMMENT '- Documento de identidade 2 CPF',
  `stPassport` char(10) DEFAULT NULL COMMENT '- Numero de passaporte',
  `stNationality` varchar(100) DEFAULT NULL COMMENT '- Nacionalidade',
  `txtData` text COMMENT 'json with extra data about person',
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Person data ';

--
-- Extraindo dados da tabela `Person`
--

INSERT INTO `Person` (`id`, `User_id`, `stName`, `enumGender`, `dtBirthdate`, `stCitizenId`, `stDoc2`, `stPassport`, `stNationality`, `txtData`, `dtInsert`, `dtUpdate`, `numStatus`, `isActive`) VALUES
(1, NULL, 'Administrador', 'M', '2014-06-04', '', '', '', '', NULL, '2014-06-22 21:05:24', '2014-07-08 22:30:49', 0, '1');

-- --------------------------------------------------------

--
-- Estrutura da tabela `Service`
--

CREATE TABLE IF NOT EXISTS `Service` (
  `id` int(10) unsigned NOT NULL COMMENT 'Id do produto',
  `User_id` int(10) unsigned DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `Company_id` int(10) unsigned DEFAULT NULL COMMENT 'Id da empresa',
  `stServicetKey` varchar(45) DEFAULT NULL COMMENT 'Código do produto (especificado pela empresa)',
  `stName` varchar(250) DEFAULT NULL COMMENT 'Nome do produto',
  `txtDescription` text COMMENT 'detalhes do produto',
  `txtSpecification` text COMMENT 'especificação técnica',
  `txtApplication` text COMMENT 'modo de uso',
  `txtWarranty` text COMMENT 'garantia',
  `stKeywords` varchar(250) DEFAULT NULL,
  `numOldPrice` decimal(10,3) unsigned DEFAULT '0.000' COMMENT 'preço antigo',
  `numMinPrice` decimal(10,3) unsigned DEFAULT '0.000',
  `numPrice` decimal(10,3) unsigned DEFAULT '0.000' COMMENT 'preço',
  `numAddPrice1` decimal(10,3) unsigned DEFAULT '0.000',
  `numAddPrice2` decimal(10,3) unsigned DEFAULT '0.000',
  `numFreight` decimal(10,3) unsigned DEFAULT '0.000',
  `numDiscount` decimal(10,3) unsigned DEFAULT '0.000' COMMENT 'preço com desconto',
  `isInterestFree` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'Sem juros?',
  `numDivideInto` int(5) unsigned DEFAULT NULL COMMENT 'Numero de parcelas',
  `isPromotion` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'É promoção',
  `dtEndPromotion` timestamp NULL DEFAULT NULL COMMENT 'Data de finalização de promoção.',
  `isHighlighted` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'É destaque?',
  `isNew` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'Se é um produto em lançamento',
  `enumPresentation` enum('0','1','2') NOT NULL DEFAULT '0' COMMENT '0=apenas orçamento, 1=disponível para venda online, 2=somente apresentação',
  `photo_id` int(10) unsigned DEFAULT NULL COMMENT '- Id da foto principal do produto',
  `stLink` varchar(255) DEFAULT NULL,
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Service records';

-- --------------------------------------------------------

--
-- Estrutura da tabela `ServiceOrder`
--

CREATE TABLE IF NOT EXISTS `ServiceOrder` (
  `id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned NOT NULL,
  `Service_id` int(10) unsigned DEFAULT NULL,
  `Client_SenderId` int(10) unsigned DEFAULT NULL,
  `Client_ReceiverId` int(10) unsigned DEFAULT NULL,
  `enumType` enum('0','1') NOT NULL DEFAULT '0',
  `numOrderType` tinyint(4) unsigned DEFAULT NULL,
  `dtSpecialDate` date DEFAULT NULL,
  `stCommemorationType` varchar(50) DEFAULT NULL,
  `stRelationship` varchar(50) DEFAULT NULL,
  `dtSendInit` datetime DEFAULT NULL,
  `dtSendEnd` datetime DEFAULT NULL,
  `dtSent` datetime DEFAULT NULL,
  `User_SenderId` int(10) unsigned DEFAULT NULL,
  `txtObservation` text,
  `txtTextBefore` text,
  `txtTextAfter` text,
  `txtOferedBy` text,
  `txtMessage` text,
  `isPaid` enum('0','1') DEFAULT '0',
  `enumPhoneUsed` enum('l','m') DEFAULT NULL,
  `stPhoneUsed` varchar(15) DEFAULT NULL,
  `stDeliveryPhoneMobile` varchar(15) DEFAULT NULL,
  `stDeliveryPhoneMobile2` varchar(15) DEFAULT NULL,
  `stDeliveryPhoneMobile3` varchar(15) DEFAULT NULL,
  `stDeliveryPhoneLine` varchar(15) DEFAULT NULL,
  `stDeliveryCep` varchar(10) DEFAULT NULL,
  `stDeliveryCountry` varchar(100) DEFAULT NULL,
  `stDeliveryEstate` varchar(100) DEFAULT NULL,
  `stDeliveryCity` varchar(100) DEFAULT NULL,
  `stDeliveryNeighborhood` varchar(100) DEFAULT NULL,
  `stDeliveryStreet` varchar(255) DEFAULT NULL,
  `stDeliveryNumber` varchar(10) DEFAULT NULL,
  `stDeliveryComplement` varchar(100) DEFAULT NULL,
  `stDeliveryReference` varchar(100) DEFAULT NULL,
  `File_id` int(10) unsigned DEFAULT NULL,
  `stSurvey` varchar(255) DEFAULT NULL,
  `stRemarketing` varchar(255) DEFAULT NULL,
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `isActive` enum('0','1') NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `ServiceOrder_has_Service`
--

CREATE TABLE IF NOT EXISTS `ServiceOrder_has_Service` (
  `id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned DEFAULT NULL,
  `ServiceOrder_id` int(10) unsigned DEFAULT NULL,
  `Service_id` int(10) unsigned DEFAULT NULL,
  `stName` varchar(250) DEFAULT NULL,
  `numOldPrice` decimal(10,3) unsigned DEFAULT '0.000',
  `numMinPrice` decimal(10,3) unsigned DEFAULT '0.000',
  `numPrice` decimal(10,3) unsigned DEFAULT '0.000',
  `numAddPrice1` decimal(10,3) unsigned DEFAULT '0.000',
  `numAddPrice2` decimal(10,3) unsigned DEFAULT '0.000',
  `numFreight` decimal(10,3) unsigned DEFAULT '0.000',
  `numDiscount` decimal(10,3) unsigned DEFAULT '0.000',
  `numAmount` decimal(10,3) unsigned NOT NULL DEFAULT '1.000',
  `dtInsert` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `dtUpdate` timestamp NULL DEFAULT NULL,
  `numStatus` tinyint(4) unsigned DEFAULT '0',
  `isActive` enum('0','1') DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `User`
--

CREATE TABLE IF NOT EXISTS `User` (
  `id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned DEFAULT NULL COMMENT 'User owner or the user that created this user',
  `Person_id` int(10) unsigned DEFAULT NULL COMMENT 'Relationship with on person',
  `UserGroup_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Relashionship with a group that this user is a member',
  `stUsername` varchar(250) NOT NULL COMMENT 'Access login, in usual it is a valid e-mail',
  `stPassword` varchar(250) DEFAULT NULL COMMENT 'Encripted password',
  `stEmail` varchar(255) DEFAULT NULL,
  `stPhoneExtension` varchar(20) DEFAULT NULL,
  `stPicture` varchar(255) DEFAULT NULL,
  `stQuestion` varchar(255) DEFAULT NULL,
  `stAnswer` varchar(255) DEFAULT NULL,
  `stPasswordSalt` varchar(255) DEFAULT NULL,
  `stIpContext` varchar(50) DEFAULT NULL,
  `isContextDenied` enum('0','1') NOT NULL DEFAULT '0',
  `stUserAgent` varchar(255) DEFAULT NULL,
  `stRegistrationToken` varchar(255) DEFAULT NULL,
  `enumEmailConfirmed` enum('0','1') NOT NULL DEFAULT '0',
  `dtConfirmation` timestamp NULL DEFAULT NULL,
  `txtUserRole` text COMMENT 'The Access Control Level data, ia a json conteining the access rules for this user.',
  `txtUserPref` text COMMENT 'It is a json data that can be used to registre the user pref, as color, template, language, timezone, avatar, social id, photo ...',
  `isSystem` enum('0','1') DEFAULT '0' COMMENT 'If 1, it can''t be deleted',
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Table that make part of system ACL';

--
-- Extraindo dados da tabela `User`
--

INSERT INTO `User` (`id`, `User_id`, `Person_id`, `UserGroup_id`, `stUsername`, `stPassword`, `stEmail`, `stPhoneExtension`, `stPicture`, `stQuestion`, `stAnswer`, `stPasswordSalt`, `stIpContext`, `isContextDenied`, `stUserAgent`, `stRegistrationToken`, `enumEmailConfirmed`, `dtConfirmation`, `txtUserRole`, `txtUserPref`, `isSystem`, `dtInsert`, `dtUpdate`, `numStatus`, `isActive`) VALUES
(1, NULL, 1, 2, 'betto@m3uzz.com', '652af61bd2b724ad2312073421aa65ef', 'betto@m3uzz.com', NULL, NULL, NULL, NULL, '5j4loc,g%hStPy7qF_K`HD@3be8]\\"3qkG^\\,iD1Rw&#r=t9{@', NULL, '0', NULL, NULL, '0', NULL, NULL, NULL, NULL, '2014-06-30 02:12:47', '2015-06-12 14:37:11', 0, '1');

-- --------------------------------------------------------

--
-- Estrutura da tabela `UserGroup`
--

CREATE TABLE IF NOT EXISTS `UserGroup` (
  `id` smallint(5) unsigned NOT NULL,
  `User_id` int(10) unsigned DEFAULT NULL COMMENT 'group owner or the user that created this group',
  `UserGroup_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Father group',
  `stName` varchar(45) NOT NULL COMMENT 'Group name unique that identify this one',
  `stLabel` varchar(15) NOT NULL COMMENT 'Title that identify the group.',
  `isSystem` enum('0','1') DEFAULT '0' COMMENT 'If 1, it can''t be deleted',
  `txtGroupRole` text COMMENT 'The Access Control Level data, ia a json conteining the access rules for this group.',
  `txtGroupPref` text COMMENT 'it is a json data that can be used to registre the group pref, as color, template, language, timezone, avatar ...',
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='Table that make part of system ACL';

--
-- Extraindo dados da tabela `UserGroup`
--

INSERT INTO `UserGroup` (`id`, `User_id`, `UserGroup_id`, `stName`, `stLabel`, `isSystem`, `txtGroupRole`, `txtGroupPref`, `dtInsert`, `dtUpdate`, `numStatus`, `isActive`) VALUES
(1, NULL, NULL, 'guest', 'Visitante', '1', NULL, NULL, '2014-06-27 04:29:50', '2014-07-08 22:34:34', 0, '1'),
(2, NULL, NULL, 'admin', 'Administrador', '1', NULL, NULL, '2014-07-08 06:00:00', '2014-07-08 22:34:56', 0, '1'),
(3, 1, NULL, 'financeiro', 'Financeiro', '0', NULL, NULL, '2014-09-04 17:17:39', '2014-12-14 13:43:06', 0, '1'),
(4, 1, NULL, 'operador', 'Operador', '0', NULL, NULL, '2014-09-04 17:18:05', '2014-12-14 13:43:06', 0, '1'),
(5, 1, NULL, 'cobrador', 'Cobrador', '0', NULL, NULL, '2015-02-19 22:57:56', '2015-02-19 22:57:56', 0, '1');

-- --------------------------------------------------------

--
-- Indexes for dumped tables
--

--
-- Indexes for table `AccessToken`
--
ALTER TABLE `AccessToken`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `stToken` (`stToken`),
  ADD KEY `stEmail` (`stEmail`),
  ADD KEY `stLabel` (`stLabel`);

--
-- Indexes for table `CashFlow`
--
ALTER TABLE `CashFlow`
  ADD PRIMARY KEY (`id`),
  ADD KEY `CashRegister_id` (`CashRegister_id`),
  ADD KEY `ServiceOrder_id` (`ServiceOrder_id`),
  ADD KEY `stInvoice` (`stInvoice`),
  ADD KEY `stTransactionStatus` (`stTransactionStatus`),
  ADD KEY `Collector_id` (`Collector_id`),
  ADD KEY `dtInsert` (`dtInsert`);

--
-- Indexes for table `CashRegister`
--
ALTER TABLE `CashRegister`
  ADD PRIMARY KEY (`id`),
  ADD KEY `User_id` (`User_id`);

--
-- Indexes for table `Client`
--
ALTER TABLE `Client`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_Person_stCitzenId` (`stCitizenId`),
  ADD KEY `User_id` (`User_id`),
  ADD KEY `stName` (`stName`),
  ADD KEY `dtBirthdate` (`dtBirthdate`),
  ADD KEY `stMobile` (`stMobile`),
  ADD KEY `stHomePhone` (`stHomePhone`);

--
-- Indexes for table `Company`
--
ALTER TABLE `Company`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_Company_stName_UNIQUE` (`stName`),
  ADD KEY `fk_Company_User` (`User_id`),
  ADD KEY `idx_Company_stAliasName` (`stAliasName`),
  ADD KEY `idx_Company_stRegistry` (`stRegistry`),
  ADD KEY `idx_Company_stRegistry2` (`stRegistry2`),
  ADD KEY `idx_Company_stArea` (`stArea`);

--
-- Indexes for table `Crm`
--
ALTER TABLE `Crm`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ServiceOrder_id` (`ServiceOrder_id`),
  ADD KEY `User_id` (`User_id`),
  ADD KEY `dtInsert` (`dtInsert`);

--
-- Indexes for table `File`
--
ALTER TABLE `File`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_File_User` (`User_id`),
  ADD KEY `idx_File_dtPublish` (`dtPublish`),
  ADD FULLTEXT KEY `stTitle` (`stTitle`,`stDescription`,`stSource`,`stKeywords`);

--
-- Indexes for table `LogAccess`
--
ALTER TABLE `LogAccess`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_coreLogAccess_coreUser` (`User_id`),
  ADD KEY `idx_LogAccess_dtInsert` (`dtInsert`);

--
-- Indexes for table `LogClick`
--
ALTER TABLE `LogClick`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_LogClick_dtInsert` (`dtInsert`),
  ADD KEY `idx_LogClick_stTable` (`stResource`),
  ADD KEY `idx_LogClick_numId` (`Resource_Id`),
  ADD KEY `idx_LogClick_stUrl` (`stUrl`);

--
-- Indexes for table `LogEvent`
--
ALTER TABLE `LogEvent`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_LogEvent_User` (`User_id`),
  ADD KEY `idx_LogEvent_dtInsert` (`dtInsert`);

--
-- Indexes for table `LogSearch`
--
ALTER TABLE `LogSearch`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_LogSearch_dtInsert` (`dtInsert`),
  ADD KEY `idx_LogSearch_stQuery` (`stQuery`);

--
-- Indexes for table `LogView`
--
ALTER TABLE `LogView`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_LogView_dtInsert` (`dtInsert`),
  ADD KEY `idx_LogView_stTable` (`stResource`),
  ADD KEY `idx_LogView_numId` (`Resource_Id`),
  ADD KEY `idx_LogView_stUrl` (`stUrl`);

--
-- Indexes for table `Person`
--
ALTER TABLE `Person`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_Person_stName_stCitizenId` (`stName`),
  ADD KEY `idx_Person_stDoc2` (`stDoc2`),
  ADD KEY `idx_Person_stPassport` (`stPassport`),
  ADD KEY `idx_Person_stCitzenId` (`stCitizenId`),
  ADD KEY `User_id` (`User_id`);

--
-- Indexes for table `Service`
--
ALTER TABLE `Service`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Service_Company` (`Company_id`),
  ADD KEY `fk_Service_User` (`User_id`),
  ADD KEY `idx_Service_stName` (`stName`),
  ADD KEY `idx_Service_numPrice` (`numPrice`),
  ADD KEY `idx_Service_numDescount` (`numDiscount`);

--
-- Indexes for table `ServiceOrder`
--
ALTER TABLE `ServiceOrder`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Service_id` (`Service_id`),
  ADD KEY `numOrderType` (`numOrderType`),
  ADD KEY `dtInsert` (`dtInsert`),
  ADD KEY `dtSent` (`dtSent`),
  ADD KEY `User_id` (`User_id`),
  ADD KEY `Client_SenderId` (`Client_SenderId`),
  ADD KEY `Client_ReceiverId` (`Client_ReceiverId`),
  ADD KEY `dtSpecialDate` (`dtSpecialDate`),
  ADD KEY `stCommemorationType` (`stCommemorationType`),
  ADD KEY `stRelationship` (`stRelationship`),
  ADD KEY `User_SenderId` (`User_SenderId`),
  ADD KEY `numStatus` (`numStatus`);

--
-- Indexes for table `ServiceOrder_has_Service`
--
ALTER TABLE `ServiceOrder_has_Service`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ServiceOrder_id` (`ServiceOrder_id`),
  ADD KEY `Service_id` (`Service_id`),
  ADD KEY `ServiceOrder_id_2` (`ServiceOrder_id`),
  ADD KEY `Service_id_2` (`Service_id`);

--
-- Indexes for table `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_User_stUsername_UNIQUE` (`stUsername`),
  ADD UNIQUE KEY `stEmail` (`stEmail`),
  ADD KEY `fk_User_Person1` (`Person_id`),
  ADD KEY `fk_User_User1` (`User_id`),
  ADD KEY `fk_User_UserGroup1` (`UserGroup_id`),
  ADD KEY `stRegistrationToken` (`stRegistrationToken`);

--
-- Indexes for table `UserGroup`
--
ALTER TABLE `UserGroup`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_Group_stName_UNIQUE` (`stName`),
  ADD KEY `fk_Group_User1` (`User_id`),
  ADD KEY `UserGroup_id` (`UserGroup_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `AccessToken`
--
ALTER TABLE `AccessToken`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `CashRegister`
--
ALTER TABLE `CashRegister`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Client`
--
ALTER TABLE `Client`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Company`
--
ALTER TABLE `Company`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Crm`
--
ALTER TABLE `Crm`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `File`
--
ALTER TABLE `File`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `LogAccess`
--
ALTER TABLE `LogAccess`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `LogClick`
--
ALTER TABLE `LogClick`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `LogEvent`
--
ALTER TABLE `LogEvent`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `LogSearch`
--
ALTER TABLE `LogSearch`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `LogView`
--
ALTER TABLE `LogView`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Person`
--
ALTER TABLE `Person`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Service`
--
ALTER TABLE `Service`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id do produto';
--
-- AUTO_INCREMENT for table `ServiceOrder`
--
ALTER TABLE `ServiceOrder`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `ServiceOrder_has_Service`
--
ALTER TABLE `ServiceOrder_has_Service`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `User`
--
ALTER TABLE `User`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `UserGroup`
--
ALTER TABLE `UserGroup`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT;