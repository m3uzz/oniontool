SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `parking`
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
-- Estrutura da tabela `Burden`
--

CREATE TABLE IF NOT EXISTS `Burden` (
  `id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned DEFAULT NULL,
  `stCode` varchar(20) DEFAULT NULL,
  `stName` varchar(100) NOT NULL,
  `stType` varchar(50) DEFAULT NULL,
  `isAutomatic` enum('0','1') NOT NULL DEFAULT '0',
  `numInterval` smallint(3) unsigned DEFAULT NULL,
  `numNextLiberation` int(10) unsigned DEFAULT NULL,
  `UpdateUser_id` int(10) unsigned DEFAULT NULL,
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
  `User_id` int(10) DEFAULT NULL,
  `CashRegister_id` int(10) unsigned DEFAULT NULL,
  `numValue` decimal(10,2) NOT NULL,
  `stType` varchar(50) DEFAULT NULL,
  `stTag` varchar(20) NOT NULL,
  `txtTransactionReturn` text,
  `stTransactionStatus` varchar(10) DEFAULT NULL,
  `txtDescription` text,
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Table of companies for all purposes';

--
-- Extraindo dados da tabela `Company`
--

INSERT INTO `Company` (`id`, `User_id`, `stName`, `stAliasName`, `stRegistry`, `stRegistry2`, `stArea`, `stDescription`, `stLogoPath`, `stLink`, `stKeywords`, `txtData`, `dtInsert`, `dtUpdate`, `numStatus`, `isActive`) VALUES
(1, 1, 'Terminal', 'Terminal', NULL, NULL, 'Terminal', NULL, NULL, NULL, NULL, NULL, '2014-09-09 19:20:36', '2015-08-26 14:12:12', 0, '1'),
(2, 1, 'Patio', 'Patio', NULL, NULL, 'Patio', NULL, NULL, NULL, NULL, NULL, '2014-10-07 18:41:55', '2014-10-07 19:18:22', 0, '1');

-- --------------------------------------------------------

--
-- Estrutura da tabela `Driver`
--

CREATE TABLE IF NOT EXISTS `Driver` (
  `id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned DEFAULT NULL,
  `stName` varchar(255) DEFAULT NULL,
  `stRegistryId` varchar(20) DEFAULT NULL,
  `stDriverLicenceId` varchar(20) DEFAULT NULL,
  `dtLicenceValidThru` date DEFAULT NULL,
  `stMobileNumber` varchar(20) DEFAULT NULL,
  `txtObservation` text NOT NULL,
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `isActive` enum('0','1') NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `Freight`
--

CREATE TABLE IF NOT EXISTS `Freight` (
  `id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned DEFAULT NULL,
  `stType` varchar(100) DEFAULT NULL,
  `Company_ShipperId` int(10) unsigned DEFAULT NULL,
  `numKnowledge` int(10) unsigned DEFAULT NULL,
  `stVehiclePlate` varchar(10) DEFAULT NULL,
  `numBulkDeparture` decimal(10,3) unsigned DEFAULT NULL,
  `numBulkArrival` decimal(10,3) unsigned DEFAULT NULL,
  `stTypeCalc` varchar(100) DEFAULT NULL,
  `numBulkCalc` decimal(10,3) unsigned DEFAULT NULL,
  `stTypeBreak` varchar(100) DEFAULT NULL,
  `numBreakAllowed` decimal(10,3) unsigned DEFAULT NULL,
  `numBulkBreaked` decimal(10,3) DEFAULT NULL,
  `numBulkBreakAllowed` decimal(10,3) unsigned DEFAULT NULL,
  `stUnitType` varchar(100) DEFAULT NULL,
  `numTotalPrice` decimal(10,3) unsigned DEFAULT NULL,
  `numBulkCost` decimal(10,3) unsigned DEFAULT NULL,
  `numFreightUnitPrice` decimal(10,3) unsigned DEFAULT NULL,
  `numFreightPrice` decimal(10,3) unsigned DEFAULT NULL,
  `numDiscountBreak` decimal(10,3) unsigned DEFAULT NULL,
  `numInsurance` decimal(10,3) unsigned DEFAULT NULL,
  `numAdvance` decimal(10,3) unsigned DEFAULT NULL,
  `numAdministrativeFee` decimal(10,3) unsigned DEFAULT NULL,
  `numTax1` decimal(10,3) unsigned DEFAULT NULL,
  `numTax2` decimal(10,3) unsigned DEFAULT NULL,
  `numTax3` decimal(10,3) unsigned DEFAULT NULL,
  `numTax4` decimal(10,3) unsigned DEFAULT NULL,
  `numMissing` decimal(10,3) unsigned DEFAULT NULL,
  `numClassification` decimal(10,3) unsigned DEFAULT NULL,
  `numStay` decimal(10,3) unsigned DEFAULT NULL,
  `numPike` decimal(10,3) unsigned DEFAULT NULL,
  `numExtraDisc` decimal(10,3) unsigned DEFAULT NULL,
  `numExtraAdd` decimal(10,3) unsigned DEFAULT NULL,
  `numNetPrice` decimal(10,3) unsigned DEFAULT NULL,
  `numPercent` decimal(10,3) unsigned DEFAULT NULL,
  `numPercentValue` decimal(10,3) unsigned DEFAULT NULL,
  `numSituation` int(2) unsigned DEFAULT NULL,
  `txtObservation` text NOT NULL,
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `isActive` enum('0','1') NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `Loader`
--

CREATE TABLE IF NOT EXISTS `Loader` (
  `id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned DEFAULT NULL,
  `Company_ClientId` int(10) unsigned NOT NULL,
  `Company_TerminalId` int(10) unsigned DEFAULT NULL,
  `Burden_id` int(10) unsigned NOT NULL,
  `numQuota` decimal(15,3) unsigned DEFAULT NULL,
  `stUnitType` varchar(20) DEFAULT NULL,
  `numFulfilled` decimal(15,3) unsigned DEFAULT NULL,
  `numOverplus` decimal(15,3) unsigned DEFAULT NULL,
  `numAverageOver` decimal(5,3) unsigned DEFAULT '0.000',
  `numStatusQuota` smallint(5) unsigned DEFAULT NULL,
  `stWeek` varchar(8) DEFAULT NULL,
  `dtMonday` date DEFAULT NULL,
  `numMonQuota` decimal(15,3) unsigned DEFAULT '0.000',
  `txtMonFulfilled` text,
  `dtTuesday` date DEFAULT NULL,
  `numTueQuota` decimal(15,3) unsigned DEFAULT '0.000',
  `txtTueFulfilled` text,
  `dtWednesday` date DEFAULT NULL,
  `numWedQuota` decimal(15,3) unsigned DEFAULT '0.000',
  `txtWedFulfilled` text,
  `dtThursday` date DEFAULT NULL,
  `numThuQuota` decimal(15,3) unsigned DEFAULT '0.000',
  `txtThuFulfilled` text,
  `dtFriday` date DEFAULT NULL,
  `numFriQuota` decimal(15,3) unsigned DEFAULT '0.000',
  `txtFriFulfilled` text,
  `dtSaturday` date DEFAULT NULL,
  `numSatQuota` decimal(15,3) unsigned DEFAULT '0.000',
  `txtSatFulfilled` text,
  `dtSunday` date DEFAULT NULL,
  `numSunQuota` decimal(15,3) unsigned DEFAULT '0.000',
  `txtSunFulfilled` text,
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `isActive` enum('0','1') NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
-- Estrutura da tabela `Queue`
--

CREATE TABLE IF NOT EXISTS `Queue` (
  `id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned NOT NULL,
  `stTag` varchar(20) NOT NULL,
  `Company_ClientId` int(10) unsigned DEFAULT NULL,
  `Company_ShipperId` int(10) unsigned DEFAULT NULL,
  `Company_ParkingId` int(10) unsigned DEFAULT NULL,
  `Company_TerminalId` int(10) unsigned DEFAULT NULL,
  `Burden_id` int(10) unsigned DEFAULT NULL,
  `stInvoice` varchar(100) DEFAULT NULL,
  `numBulk` decimal(15,0) DEFAULT NULL,
  `stUnitType` varchar(20) DEFAULT NULL,
  `numUnitPrice` decimal(10,3) unsigned DEFAULT NULL,
  `numTotalPrice` decimal(10,3) unsigned DEFAULT NULL,
  `dtExpectedParking` datetime DEFAULT NULL,
  `isPaidToPark` enum('0','1') NOT NULL DEFAULT '0',
  `dtExpectedArrival` datetime DEFAULT NULL,
  `stVehiclePlate` varchar(10) DEFAULT NULL,
  `Driver_id` int(10) unsigned DEFAULT NULL,
  `numTrackingStatus` smallint(5) unsigned NOT NULL DEFAULT '0',
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `isActive` enum('0','1') NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `Quota`
--

CREATE TABLE IF NOT EXISTS `Quota` (
  `id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned DEFAULT NULL,
  `Company_ClientId` int(10) unsigned NOT NULL,
  `Company_TerminalId` int(10) unsigned DEFAULT NULL,
  `Burden_id` int(10) unsigned NOT NULL,
  `numQuota` decimal(15,3) unsigned DEFAULT NULL,
  `stUnitType` varchar(20) DEFAULT NULL,
  `numFulfilled` decimal(15,3) unsigned DEFAULT NULL,
  `numOverplus` decimal(15,3) unsigned DEFAULT NULL,
  `numAverageOver` decimal(5,3) unsigned DEFAULT '0.000',
  `numStatusQuota` smallint(5) unsigned DEFAULT NULL,
  `stWeek` varchar(8) DEFAULT NULL,
  `dtMonday` date DEFAULT NULL,
  `numMonQuota` decimal(15,3) unsigned DEFAULT '0.000',
  `txtMonFulfilled` text,
  `dtTuesday` date DEFAULT NULL,
  `numTueQuota` decimal(15,3) unsigned DEFAULT '0.000',
  `txtTueFulfilled` text,
  `dtWednesday` date DEFAULT NULL,
  `numWedQuota` decimal(15,3) unsigned DEFAULT '0.000',
  `txtWedFulfilled` text,
  `dtThursday` date DEFAULT NULL,
  `numThuQuota` decimal(15,3) unsigned DEFAULT '0.000',
  `txtThuFulfilled` text,
  `dtFriday` date DEFAULT NULL,
  `numFriQuota` decimal(15,3) unsigned DEFAULT '0.000',
  `txtFriFulfilled` text,
  `dtSaturday` date DEFAULT NULL,
  `numSatQuota` decimal(15,3) unsigned DEFAULT '0.000',
  `txtSatFulfilled` text,
  `dtSunday` date DEFAULT NULL,
  `numSunQuota` decimal(15,3) unsigned DEFAULT '0.000',
  `txtSunFulfilled` text,
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `isActive` enum('0','1') NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  `numOldPrice` decimal(10,3) unsigned DEFAULT NULL COMMENT 'preço antigo',
  `numPrice` decimal(10,3) DEFAULT NULL COMMENT 'preço',
  `numDescount` decimal(10,3) DEFAULT NULL COMMENT 'preço com desconto',
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
-- Estrutura da tabela `Tracker`
--

CREATE TABLE IF NOT EXISTS `Tracker` (
  `id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned NOT NULL,
  `Queue_id` int(10) unsigned NOT NULL,
  `stTag` varchar(20) DEFAULT NULL,
  `numTracker` smallint(5) unsigned DEFAULT '0',
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `isActive` enum('0','1') NOT NULL DEFAULT '1'
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
(1, NULL, 1, 2, 'admin', '652af61bd2b724ad2312073421aa65ef', 'betto@m3uzz.com', NULL, NULL, NULL, NULL, '5j4loc,g%hStPy7qF_K`HD@3be8]\\"3qkG^\\,iD1Rw&#r=t9{@', NULL, '0', NULL, NULL, '0', NULL, NULL, NULL, NULL, '2014-06-30 02:12:47', '2015-04-17 17:13:27', 0, '1');

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
(3, 1, NULL, 'client', 'Cliente', '0', NULL, NULL, '2014-09-04 17:17:39', '2014-09-04 17:17:39', 0, '1'),
(4, 1, NULL, 'patio', 'Patio', '0', NULL, NULL, '2014-09-04 17:18:05', '2014-09-04 17:18:05', 0, '1'),
(5, 1, NULL, 'terminal', 'Terminal', '0', NULL, NULL, '2014-09-04 17:18:29', '2014-09-04 17:18:29', 0, '1');

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
-- Indexes for table `Burden`
--
ALTER TABLE `Burden`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `CashFlow`
--
ALTER TABLE `CashFlow`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `stTag` (`stTag`),
  ADD KEY `CashRegister_id` (`CashRegister_id`),
  ADD KEY `User_id` (`User_id`),
  ADD KEY `dtInsert` (`dtInsert`);

--
-- Indexes for table `CashRegister`
--
ALTER TABLE `CashRegister`
  ADD PRIMARY KEY (`id`),
  ADD KEY `User_id` (`User_id`),
  ADD KEY `Company_id` (`Company_id`),
  ADD KEY `User_id_2` (`User_id`),
  ADD KEY `Company_id_2` (`Company_id`);

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
-- Indexes for table `Driver`
--
ALTER TABLE `Driver`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `stRegistryId` (`stRegistryId`);

--
-- Indexes for table `Freight`
--
ALTER TABLE `Freight`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Loader`
--
ALTER TABLE `Loader`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Company_ClientId` (`Company_ClientId`),
  ADD KEY `Company_TerminalId` (`Company_TerminalId`),
  ADD KEY `Product_id` (`Burden_id`),
  ADD KEY `stWeek` (`stWeek`);

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
-- Indexes for table `Queue`
--
ALTER TABLE `Queue`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `stTag` (`stTag`),
  ADD KEY `Company_ClientId` (`Company_ClientId`),
  ADD KEY `Company_ShipperId` (`Company_ShipperId`),
  ADD KEY `Company_ParkingId` (`Company_ParkingId`),
  ADD KEY `Company_TerminalId` (`Company_TerminalId`),
  ADD KEY `Burden_id` (`Burden_id`),
  ADD KEY `Driver_id` (`Driver_id`),
  ADD KEY `stTrackingStatus` (`numTrackingStatus`),
  ADD KEY `stInvoice` (`stInvoice`);

--
-- Indexes for table `Quota`
--
ALTER TABLE `Quota`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Company_ClientId` (`Company_ClientId`),
  ADD KEY `Company_TerminalId` (`Company_TerminalId`),
  ADD KEY `Product_id` (`Burden_id`),
  ADD KEY `stWeek` (`stWeek`);

--
-- Indexes for table `Service`
--
ALTER TABLE `Service`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Service_Company` (`Company_id`),
  ADD KEY `fk_Service_User` (`User_id`),
  ADD KEY `idx_Service_stName` (`stName`),
  ADD KEY `idx_Service_numPrice` (`numPrice`),
  ADD KEY `idx_Service_numDescount` (`numDescount`);

--
-- Indexes for table `Tracker`
--
ALTER TABLE `Tracker`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Scheduling_id` (`Queue_id`),
  ADD KEY `stTag` (`stTag`),
  ADD KEY `stTracker` (`numTracker`);

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
-- AUTO_INCREMENT for table `Burden`
--
ALTER TABLE `Burden`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `CashFlow`
--
ALTER TABLE `CashFlow`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=46;
--
-- AUTO_INCREMENT for table `CashRegister`
--
ALTER TABLE `CashRegister`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `Company`
--
ALTER TABLE `Company`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `Driver`
--
ALTER TABLE `Driver`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT for table `Freight`
--
ALTER TABLE `Freight`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `Loader`
--
ALTER TABLE `Loader`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `LogAccess`
--
ALTER TABLE `LogAccess`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=306;
--
-- AUTO_INCREMENT for table `LogClick`
--
ALTER TABLE `LogClick`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `LogEvent`
--
ALTER TABLE `LogEvent`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=242;
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
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `Queue`
--
ALTER TABLE `Queue`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=100;
--
-- AUTO_INCREMENT for table `Quota`
--
ALTER TABLE `Quota`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `Service`
--
ALTER TABLE `Service`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id do produto';
--
-- AUTO_INCREMENT for table `Tracker`
--
ALTER TABLE `Tracker`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=242;
--
-- AUTO_INCREMENT for table `User`
--
ALTER TABLE `User`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `UserGroup`
--
ALTER TABLE `UserGroup`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;