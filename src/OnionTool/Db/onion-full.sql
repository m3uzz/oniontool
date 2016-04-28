SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `onion`
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
-- Estrutura da tabela `Address`
--

CREATE TABLE IF NOT EXISTS `Address` (
  `id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `Country_id` int(10) unsigned DEFAULT NULL COMMENT '- País ao qual o endereço pertence',
  `Estate_id` int(10) unsigned DEFAULT NULL COMMENT '- Estado ao qual o endereço pertence',
  `City_id` int(10) unsigned DEFAULT NULL COMMENT '- Cidade ao qual o endereço pertence',
  `Street_id` int(10) unsigned DEFAULT NULL COMMENT '- Rua ao qual o endereço pertence',
  `ZipCode_id` int(10) unsigned DEFAULT NULL COMMENT '- CEP ao qual o endereço pertence',
  `stNumber` varchar(10) DEFAULT NULL COMMENT '- Número',
  `stComplement` varchar(50) DEFAULT NULL COMMENT '- Complemento',
  `stPlace` varchar(250) DEFAULT NULL COMMENT '- Local (ex.: casa, escritório, filial, etc.)',
  `stGeoLocalization` varchar(100) DEFAULT NULL COMMENT '- Geo posição x e y para posicionamento em mapa',
  `stZoomMap` varchar(3) DEFAULT NULL COMMENT '- Nível de zoom para visualização de mapa',
  `enumMasterAddr` enum('0','1') NOT NULL DEFAULT '0' COMMENT '- Se o endereço é o principal ou não',
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Address or location, it registre a specific place.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `Address_has_ZipCode`
--

CREATE TABLE IF NOT EXISTS `Address_has_ZipCode` (
  `Address_id` int(10) unsigned NOT NULL,
  `ZipCode_id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A relationship between addrAddress and addrZipCode, because ';

-- --------------------------------------------------------

--
-- Estrutura da tabela `Agreement`
--

CREATE TABLE IF NOT EXISTS `Agreement` (
  `id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned DEFAULT NULL,
  `Client_id` int(10) unsigned DEFAULT NULL,
  `Service_id` int(10) unsigned DEFAULT NULL,
  `numAgreementValue` decimal(10,3) unsigned DEFAULT '0.000',
  `numBestDayToInvoice` smallint(3) unsigned DEFAULT '5',
  `dtStart` date DEFAULT NULL,
  `dtEnd` date DEFAULT NULL,
  `stBestTime` varchar(10) DEFAULT NULL,
  `numLongTerm` int(10) unsigned DEFAULT '0',
  `numArea` int(4) unsigned DEFAULT '0',
  `numFrequency` int(4) unsigned DEFAULT '0',
  `enumMon` enum('0','1') DEFAULT '0',
  `enumTue` enum('0','1') DEFAULT '0',
  `enumWed` enum('0','1') DEFAULT '0',
  `enumThu` enum('0','1') DEFAULT '0',
  `enumFri` enum('0','1') DEFAULT '0',
  `enumSat` enum('0','1') DEFAULT '0',
  `enumSun` enum('0','1') DEFAULT '0',
  `stResponsible` varchar(255) DEFAULT NULL,
  `stEmail` varchar(255) DEFAULT NULL,
  `stMobile` varchar(15) DEFAULT NULL,
  `stPhone` varchar(15) DEFAULT NULL,
  `stCep` varchar(10) DEFAULT NULL,
  `stCountry` varchar(100) DEFAULT NULL,
  `stEstate` varchar(100) DEFAULT NULL,
  `stCity` varchar(100) DEFAULT NULL,
  `stNeighborhood` varchar(100) DEFAULT NULL,
  `stStreet` varchar(255) DEFAULT NULL,
  `stNumber` varchar(10) DEFAULT NULL,
  `stComplement` varchar(100) DEFAULT NULL,
  `txtObservation` text,
  `stColor` varchar(7) DEFAULT NULL,
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `isActive` enum('0','1') NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `Billing`
--

CREATE TABLE IF NOT EXISTS `Billing` (
  `id` int(10) unsigned NOT NULL COMMENT '- id da fatura',
  `User_idClient` int(10) unsigned DEFAULT NULL COMMENT 'Client id. He need to be registred',
  `User_idVendor` int(10) unsigned DEFAULT NULL COMMENT 'Saller id, if someone helped sell',
  `stVoucher` varchar(250) DEFAULT NULL COMMENT 'A promotional code to give descount',
  `numDescount` decimal(10,3) DEFAULT NULL COMMENT 'Total descount offered',
  `numTotal` decimal(10,3) DEFAULT NULL COMMENT 'Total bill',
  `stGateway` varchar(250) DEFAULT NULL COMMENT 'Gateway identification, can be a name as PayPal',
  `enumSaleType` enum('debit','credit','billet','money','deposit','check','permutation','change') DEFAULT NULL COMMENT 'Payment kind',
  `numDivideInto` int(5) unsigned DEFAULT NULL COMMENT 'how many plots were divided',
  `numMissing` int(5) unsigned DEFAULT NULL COMMENT 'how many plots still missing',
  `enumTansactionStatus` enum('started','sent','waiting','approved','refused','canceled','error','contest') DEFAULT NULL COMMENT 'Gateway transaction status ',
  `stTransactionCode` varchar(250) DEFAULT NULL COMMENT 'Code that identify the gateway transaction',
  `txtTransactionDetails` text,
  `stPostCode` varchar(250) DEFAULT NULL COMMENT 'Post code for tracker the package',
  `enumDeliveryStatus` enum('waiting','sent','on the way','delivered','returned','lost') DEFAULT NULL,
  `txtObs` text COMMENT 'Observation about anything',
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales revenue for products';

-- --------------------------------------------------------

--
-- Estrutura da tabela `Billing_has_Product`
--

CREATE TABLE IF NOT EXISTS `Billing_has_Product` (
  `Billing_id` int(10) unsigned NOT NULL COMMENT '- Id da fatura',
  `Product_id` int(10) unsigned NOT NULL COMMENT '- id do produto',
  `numPrice` decimal(10,3) DEFAULT NULL COMMENT 'Unit price',
  `numDescount` decimal(10,3) DEFAULT NULL COMMENT 'unit descount',
  `numQuantity` decimal(10,3) DEFAULT NULL COMMENT 'hou many products',
  `txtSpecification` text COMMENT 'Product specification as color, size ...',
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Relationship between billing and products sold';

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
  `User_id` int(11) DEFAULT NULL,
  `CashRegister_id` int(10) unsigned DEFAULT NULL,
  `stResource` varchar(50) DEFAULT NULL,
  `ServiceOrder_id` int(10) unsigned NOT NULL DEFAULT '0',
  `Agreement_id` int(10) unsigned DEFAULT NULL,
  `stInvoice` varchar(100) DEFAULT NULL,
  `txtItens` text,
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
-- Estrutura da tabela `Category`
--

CREATE TABLE IF NOT EXISTS `Category` (
  `id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `Category_id` int(10) unsigned DEFAULT NULL COMMENT 'Category father',
  `stResource` varchar(50) NOT NULL COMMENT 'Table to use this category',
  `stValue` varchar(250) NOT NULL COMMENT 'Name of this category',
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table of categories for all purposes in the system. Can be t';

-- --------------------------------------------------------

--
-- Estrutura da tabela `Category_has_Resource`
--

CREATE TABLE IF NOT EXISTS `Category_has_Resource` (
  `Category_id` int(10) unsigned NOT NULL,
  `stResource` varchar(100) NOT NULL,
  `Resource_id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Relationship between categories and any resource row';

-- --------------------------------------------------------

--
-- Estrutura da tabela `City`
--

CREATE TABLE IF NOT EXISTS `City` (
  `id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `Estate_id` int(10) unsigned NOT NULL COMMENT '- Estado ao qual a cidade pertence',
  `stCity` varchar(250) NOT NULL COMMENT '- Nome da cidade',
  `stAbreviation` varchar(5) DEFAULT NULL COMMENT '- Abreviação do nome da cidade',
  `stZipCode` varchar(10) DEFAULT NULL COMMENT '- Código postal da cidade',
  `stLatitude` varchar(10) DEFAULT NULL COMMENT '- Latitude de geo localização',
  `stLongitude` varchar(10) DEFAULT NULL COMMENT '- Longitude de geo localização',
  `stGeoLocalization` varchar(100) DEFAULT NULL COMMENT '- Geo posição x e y para posicionamento em mapa',
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A database of cities';

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
-- Estrutura da tabela `Company_has_Product`
--

CREATE TABLE IF NOT EXISTS `Company_has_Product` (
  `Company_id` int(10) unsigned NOT NULL,
  `Product_id` int(10) unsigned NOT NULL,
  `numQuota` decimal(15,3) unsigned DEFAULT NULL,
  `stUnitType` varchar(20) DEFAULT NULL,
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `isActive` enum('0','1') NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `Contact`
--

CREATE TABLE IF NOT EXISTS `Contact` (
  `id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `stType` varchar(20) DEFAULT NULL,
  `stLabel` varchar(100) DEFAULT NULL COMMENT '- Ex.: se tipo for telefone o label pode ser, celular, residencial, comercial celular 2 ...',
  `stValue` varchar(250) DEFAULT NULL COMMENT '- valor referente ao tipo',
  `stPerson` varchar(250) DEFAULT NULL COMMENT '- Nome da pessoa',
  `enumMasterContact` enum('0','1') DEFAULT '0' COMMENT '- Se o contato é o principal ou não',
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table contatos.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `Country`
--

CREATE TABLE IF NOT EXISTS `Country` (
  `id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `stCountry` varchar(250) NOT NULL COMMENT '- Nome do país',
  `stAbreviationISO3` varchar(3) DEFAULT NULL COMMENT '- Abreviação do nome do país com 3 letras',
  `stAbreviationISO2` varchar(2) DEFAULT NULL COMMENT '- Abreviação do nome do país com 2 letras',
  `stTLD` varchar(4) DEFAULT NULL COMMENT '- Código TLD',
  `stLocale` varchar(5) DEFAULT NULL COMMENT '- Código ANSI para a língua, ex.: pt_br',
  `stCurrency` varchar(3) DEFAULT NULL COMMENT '- Simbolo de moeda do país',
  `stCurrencyLabel` varchar(30) DEFAULT NULL COMMENT '- Nome da moeda do país',
  `stCurrencyAbreviation` varchar(3) DEFAULT NULL,
  `stCallingCode` varchar(5) DEFAULT NULL,
  `stTimeZone` varchar(6) DEFAULT NULL,
  `stSummerTimeZone` varchar(6) DEFAULT NULL,
  `stDateFormate` varchar(10) DEFAULT NULL,
  `City_Id` int(10) unsigned DEFAULT NULL,
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A database of countries';

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
-- Estrutura da tabela `Estate`
--

CREATE TABLE IF NOT EXISTS `Estate` (
  `id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `Country_id` int(10) unsigned NOT NULL COMMENT '- País ao qual o estado pertence',
  `stEstate` varchar(250) NOT NULL COMMENT '- Nome do estado ou província',
  `stAbreviation` varchar(5) DEFAULT NULL COMMENT '- Abreviação do nome da do estado',
  `City_id` int(10) unsigned DEFAULT NULL COMMENT ' - Id da capital do estado',
  `stTimeZone` varchar(10) DEFAULT NULL COMMENT '- Time zone padrão GMT',
  `stSummerTimeZone` varchar(10) DEFAULT NULL COMMENT '- Abreviação do nome da do estado',
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A database of federation estates';

-- --------------------------------------------------------

--
-- Estrutura da tabela `Faq`
--

CREATE TABLE IF NOT EXISTS `Faq` (
  `id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `stQuestion` varchar(250) DEFAULT NULL COMMENT 'Título que identifica o classificado',
  `txtAnswer` text COMMENT 'Conteúdo do classificado',
  `stKeywords` varchar(255) DEFAULT NULL,
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Frequent Ask Question, is a table with questions and answers';

-- --------------------------------------------------------

--
-- Estrutura da tabela `Feature`
--

CREATE TABLE IF NOT EXISTS `Feature` (
  `id` int(10) unsigned NOT NULL COMMENT '- id do campo',
  `User_id` int(10) unsigned DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `stGroup` varchar(250) DEFAULT NULL COMMENT 'Group of related fields as color, size ...',
  `stLabel` varchar(250) DEFAULT NULL COMMENT 'The field name for exibition',
  `txtValue` text COMMENT 'field value, can be anything',
  `enumType` enum('text','checkbox','radiobox','file','textarea','password') DEFAULT NULL,
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Product features, fields to compare product by product';

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
-- Estrutura da tabela `File_has_User`
--

CREATE TABLE IF NOT EXISTS `File_has_User` (
  `File_id` int(10) unsigned NOT NULL COMMENT '- id do produto',
  `User_id` int(10) unsigned NOT NULL COMMENT '- Id da categoria',
  `dtLastAccess` timestamp NULL DEFAULT NULL,
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Relationship between file and its category';

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
-- Estrutura da tabela `Gallery`
--

CREATE TABLE IF NOT EXISTS `Gallery` (
  `id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `stTitle` varchar(250) DEFAULT NULL,
  `stDescription` varchar(250) DEFAULT NULL,
  `stKeywords` varchar(255) DEFAULT NULL,
  `photo_id` int(10) unsigned DEFAULT NULL COMMENT 'Cover photo for this gallery',
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Gallery of photos';

-- --------------------------------------------------------

--
-- Estrutura da tabela `Gallery_has_Photo`
--

CREATE TABLE IF NOT EXISTS `Gallery_has_Photo` (
  `Gallery_id` int(10) unsigned NOT NULL,
  `Photo_id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Relationship between gallery and its photos';

-- --------------------------------------------------------

--
-- Estrutura da tabela `Item`
--

CREATE TABLE IF NOT EXISTS `Item` (
  `id` int(10) unsigned NOT NULL COMMENT 'Id do produto',
  `User_id` int(10) unsigned DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `stManufacturer` varchar(255) DEFAULT NULL,
  `stName` varchar(250) DEFAULT NULL COMMENT 'Nome do produto',
  `txtDescription` text COMMENT 'detalhes do produto',
  `txtCondition` text,
  `stKeywords` varchar(250) DEFAULT NULL,
  `numValue` decimal(10,3) DEFAULT NULL COMMENT 'preço',
  `stPhoto1` varchar(255) DEFAULT NULL,
  `stPhoto2` varchar(255) DEFAULT NULL,
  `stPhoto3` varchar(255) DEFAULT NULL,
  `stPhoto4` varchar(255) DEFAULT NULL,
  `stPhoto5` varchar(255) DEFAULT NULL,
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Product records';

-- --------------------------------------------------------

--
-- Estrutura da tabela `Link`
--

CREATE TABLE IF NOT EXISTS `Link` (
  `id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `stTitle` varchar(100) DEFAULT NULL,
  `stLinkPrefix` varchar(45) DEFAULT NULL COMMENT '- Prefixo do link ex.: http://www.',
  `stLinkDomain` varchar(250) DEFAULT NULL COMMENT '- Domínio do link google.com',
  `stDescription` varchar(250) DEFAULT NULL COMMENT '- Descrição do link',
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='It can store some links for all purposes';

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
-- Estrutura da tabela `Loan`
--

CREATE TABLE IF NOT EXISTS `Loan` (
  `id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned NOT NULL,
  `Item_id` int(10) unsigned DEFAULT NULL,
  `User_TakerId` int(10) unsigned DEFAULT NULL,
  `dtLoan` datetime DEFAULT NULL,
  `dtExpected` datetime DEFAULT NULL,
  `dtReturned` datetime DEFAULT NULL,
  `txtObservation` text,
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
-- Estrutura da tabela `Menu`
--

CREATE TABLE IF NOT EXISTS `Menu` (
  `id` int(10) unsigned NOT NULL,
  `coreUser_id` int(10) unsigned DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `coreMenu_id` int(10) unsigned DEFAULT NULL COMMENT 'Menu father',
  `stTitle` varchar(250) NOT NULL COMMENT 'Menu title to show',
  `isExternal` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'if the link action redirect to a external site',
  `stUrlPrefix` varchar(15) DEFAULT NULL COMMENT 'url prefix, as http://www. or other common prefix',
  `stUrlDomain` varchar(250) DEFAULT NULL COMMENT 'the link whitout prefix',
  `stIcon` varchar(255) DEFAULT NULL COMMENT 'An icon file name that can represent this menu iten',
  `stValue` varchar(50) NOT NULL COMMENT 'Internal name',
  `stDescription` varchar(255) DEFAULT NULL,
  `numOrder` smallint(5) unsigned DEFAULT NULL COMMENT 'Ordem do menu.',
  `isSystem` enum('0','1') NOT NULL DEFAULT '0',
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Can be used for create dinamic menu in frontend';

-- --------------------------------------------------------

--
-- Estrutura da tabela `Newsletter`
--

CREATE TABLE IF NOT EXISTS `Newsletter` (
  `id` int(10) unsigned NOT NULL COMMENT '- id do produto',
  `User_id` int(10) unsigned DEFAULT NULL COMMENT 'If registred, it is the user id',
  `stName` varchar(255) NOT NULL COMMENT 'Name used for contact',
  `stEmail` varchar(255) NOT NULL COMMENT 'e-mail account used for contact',
  `txtInterest` text COMMENT 'A json data containig a list of subjects',
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Record the customer intention of receive newsletter from thi';

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
-- Estrutura da tabela `Photo`
--

CREATE TABLE IF NOT EXISTS `Photo` (
  `id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `stTitle` varchar(250) DEFAULT NULL COMMENT '- Titulo da foto',
  `stDescription` varchar(250) DEFAULT NULL COMMENT '- Descrição da foto',
  `stSource` varchar(250) DEFAULT NULL COMMENT '- Fonte da foto, autor ...',
  `stPath` varchar(250) DEFAULT NULL COMMENT '- Caminho para o arquivo físico (Nome do arquivo)',
  `stTags` varchar(250) DEFAULT NULL,
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '- É ativo: 0 (inativo) | 1 (ativo)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A base of images and photos';

-- --------------------------------------------------------

--
-- Estrutura da tabela `Pref`
--

CREATE TABLE IF NOT EXISTS `Pref` (
  `id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `stModule` varchar(50) DEFAULT NULL COMMENT 'Module name or idendifier',
  `stTable` varchar(50) DEFAULT NULL COMMENT 'DB Table name',
  `numRecord_id` int(10) unsigned DEFAULT NULL COMMENT 'DB Table record id',
  `txtPref` text COMMENT 'A json data pref for som table, record or module in the system',
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CorePref can be used to store module, table or record prefer';

-- --------------------------------------------------------

--
-- Estrutura da tabela `Product`
--

CREATE TABLE IF NOT EXISTS `Product` (
  `id` int(10) unsigned NOT NULL COMMENT 'Id do produto',
  `User_id` int(10) unsigned DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `Company_id` int(10) unsigned DEFAULT NULL COMMENT 'Id da empresa',
  `stProductKey` varchar(45) DEFAULT NULL COMMENT 'Código do produto (especificado pela empresa)',
  `stName` varchar(250) DEFAULT NULL COMMENT 'Nome do produto',
  `txtDescription` text COMMENT 'detalhes do produto',
  `txtSpecification` text COMMENT 'especificação técnica',
  `txtApplication` text COMMENT 'modo de uso',
  `txtWarranty` text COMMENT 'garantia',
  `stKeywords` varchar(250) DEFAULT NULL,
  `numOldPrice` decimal(10,3) unsigned DEFAULT NULL COMMENT 'preço antigo',
  `numPrice` decimal(10,3) DEFAULT NULL COMMENT 'preço',
  `numDiscount` decimal(10,3) DEFAULT '0.000' COMMENT 'preço com desconto',
  `isInterestFree` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'Sem juros?',
  `numDivideInto` int(5) unsigned DEFAULT NULL COMMENT 'Numero de parcelas',
  `numStock` decimal(10,3) DEFAULT NULL COMMENT 'Estoque de produtos',
  `isPromotion` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'É promoção',
  `dtEndPromotion` timestamp NULL DEFAULT NULL COMMENT 'Data de finalização de promoção.',
  `isHighlighted` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'É destaque?',
  `isNew` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'Se é um produto em lançamento',
  `numWeight` decimal(10,3) DEFAULT NULL COMMENT 'peso em gramas',
  `numWidth` decimal(10,3) DEFAULT NULL COMMENT 'largura em cm',
  `numHeight` decimal(10,3) DEFAULT NULL COMMENT 'altura em cm',
  `numDepth` decimal(10,3) DEFAULT NULL COMMENT 'profundidade em cm',
  `isFreeShipping` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'Frete grátis?',
  `stWhereFreeShipping` varchar(100) DEFAULT NULL COMMENT 'Estados ou cidades onde o frete é grátis',
  `dtEndFreeShipping` timestamp NULL DEFAULT NULL COMMENT 'Data de finalização para frete grátis',
  `enumPresentation` enum('0','1','2') NOT NULL DEFAULT '0' COMMENT '0=apenas orçamento, 1=disponível para venda online, 2=somente apresentação',
  `photo_id` int(10) unsigned DEFAULT NULL COMMENT '- Id da foto principal do produto',
  `stLink` varchar(255) DEFAULT NULL,
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Product records';

-- --------------------------------------------------------

--
-- Estrutura da tabela `Product_has_Feature`
--

CREATE TABLE IF NOT EXISTS `Product_has_Feature` (
  `Product_id` int(10) unsigned NOT NULL COMMENT '- id do produto',
  `Feature_id` int(10) unsigned NOT NULL COMMENT '- Id da categoria',
  `CoreUser_id` int(10) unsigned DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Relationship between product record and the features';

-- --------------------------------------------------------

--
-- Estrutura da tabela `Product_has_Product`
--

CREATE TABLE IF NOT EXISTS `Product_has_Product` (
  `Product_id` int(10) unsigned NOT NULL COMMENT 'id do produto',
  `ProductRel_id` int(10) unsigned NOT NULL COMMENT 'Produto relacionado',
  `User_id` int(10) unsigned DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Products recomended';

-- --------------------------------------------------------

--
-- Estrutura da tabela `Profile`
--

CREATE TABLE IF NOT EXISTS `Profile` (
  `id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned DEFAULT NULL COMMENT 'User owner or the user that created this user',
  `stName` varchar(255) DEFAULT NULL,
  `UserGroup_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Relashionship with a group that this user is a member',
  `stUsername` varchar(250) NOT NULL COMMENT 'Access login, in usual it is a valid e-mail',
  `stPassword` varchar(250) DEFAULT NULL COMMENT 'Encripted password',
  `stMobile` varchar(20) DEFAULT NULL,
  `enumGender` enum('M','F') DEFAULT NULL,
  `stPicture` varchar(255) DEFAULT NULL,
  `stQuestion` varchar(255) DEFAULT NULL,
  `stAnswer` varchar(255) DEFAULT NULL,
  `stPasswordSalt` varchar(255) DEFAULT NULL,
  `stFacebookId` varchar(255) DEFAULT NULL,
  `stGoogleId` varchar(255) DEFAULT NULL,
  `dtBirthdate` date DEFAULT NULL,
  `stRegistrationToken` varchar(255) DEFAULT NULL,
  `enumEmailConfirmed` enum('0','1') NOT NULL DEFAULT '0',
  `dtConfirmation` timestamp NULL DEFAULT NULL,
  `txtProfileRole` text COMMENT 'The Access Control Level data, ia a json conteining the access rules for this user.',
  `txtProfilePref` text COMMENT 'It is a json data that can be used to registre the user pref, as color, template, language, timezone, avatar, social id, photo ...',
  `isSystem` enum('0','1') DEFAULT '0' COMMENT 'If 1, it can''t be deleted',
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table that make part of system ACL';

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
-- Estrutura da tabela `Ratio`
--

CREATE TABLE IF NOT EXISTS `Ratio` (
  `id` int(10) unsigned NOT NULL,
  `stResource` varchar(45) NOT NULL,
  `Resource_id` int(10) unsigned NOT NULL,
  `numRate1` int(10) unsigned NOT NULL DEFAULT '0',
  `numRate2` int(10) unsigned NOT NULL DEFAULT '0',
  `numRate3` int(10) unsigned NOT NULL DEFAULT '0',
  `numRate4` int(10) unsigned NOT NULL DEFAULT '0',
  `numRate5` int(10) unsigned NOT NULL DEFAULT '0',
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `isActive` enum('0','1') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `Resource_has_Address`
--

CREATE TABLE IF NOT EXISTS `Resource_has_Address` (
  `stResource` varchar(45) NOT NULL,
  `Resource_Id` int(10) unsigned NOT NULL,
  `Address_id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `dtInsert` timestamp NULL DEFAULT NULL COMMENT '- Data de Cadastro do registro.',
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '- Data de Alteração',
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Relationship between person and address';

-- --------------------------------------------------------

--
-- Estrutura da tabela `Resource_has_Contact`
--

CREATE TABLE IF NOT EXISTS `Resource_has_Contact` (
  `stResource` varchar(45) NOT NULL,
  `Resource_id` int(10) unsigned NOT NULL,
  `Contact_id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Relationship between person and contacts';

-- --------------------------------------------------------

--
-- Estrutura da tabela `Resource_has_Gallery`
--

CREATE TABLE IF NOT EXISTS `Resource_has_Gallery` (
  `stResource` varchar(45) NOT NULL,
  `Resource_id` int(10) unsigned NOT NULL,
  `Gallery_id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Relationship between resources and gallery';

-- --------------------------------------------------------

--
-- Estrutura da tabela `Resource_has_Link`
--

CREATE TABLE IF NOT EXISTS `Resource_has_Link` (
  `stResource` varchar(45) NOT NULL,
  `Resource_Id` int(10) unsigned NOT NULL,
  `Link_id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Relationship between company and some links';

-- --------------------------------------------------------

--
-- Estrutura da tabela `Resource_has_Ratio`
--

CREATE TABLE IF NOT EXISTS `Resource_has_Ratio` (
  `stResource` varchar(45) NOT NULL,
  `Resource_Id` int(10) unsigned NOT NULL,
  `Ratio_id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned DEFAULT NULL,
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `isActive` enum('0','1') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `Route`
--

CREATE TABLE IF NOT EXISTS `Route` (
  `id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `Section_id` smallint(5) unsigned DEFAULT NULL,
  `Category_id` int(10) unsigned DEFAULT NULL,
  `stTitle` varchar(250) DEFAULT NULL,
  `stUri` varchar(250) DEFAULT NULL,
  `stDescription` varchar(250) DEFAULT NULL,
  `stKeywords` varchar(250) DEFAULT NULL,
  `stSlung` varchar(50) DEFAULT NULL,
  `stTemplate` varchar(250) DEFAULT NULL,
  `enumIndex` enum('0','1') DEFAULT '1',
  `enumFollow` enum('0','1') DEFAULT '1',
  `stLanguage` varchar(5) DEFAULT NULL,
  `enumRestrict` enum('0','1') DEFAULT '0',
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Can be used to create site map';

-- --------------------------------------------------------

--
-- Estrutura da tabela `Scheduling`
--

CREATE TABLE IF NOT EXISTS `Scheduling` (
  `id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned DEFAULT NULL,
  `Agreement_id` int(10) unsigned DEFAULT NULL,
  `Staff_id` int(10) unsigned DEFAULT NULL,
  `numValue` decimal(10,3) unsigned DEFAULT '0.000',
  `stBestTime` varchar(10) DEFAULT NULL,
  `dtStart` datetime DEFAULT NULL,
  `dtEnd` datetime DEFAULT NULL,
  `numDuration` time DEFAULT NULL,
  `enumPunctuality` enum('0','1','2','3','4','5') DEFAULT NULL,
  `enumTreatment` enum('0','1','2','3','4','5') DEFAULT NULL,
  `enumQuality` enum('0','1','2','3','4','5') DEFAULT NULL,
  `txtEvaluation` text,
  `txtObservation` text,
  `txtClientObservation` text,
  `isInvoiced` enum('0','1') DEFAULT '0',
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A database of federation estates';

-- --------------------------------------------------------

--
-- Estrutura da tabela `Scheduling_has_Product`
--

CREATE TABLE IF NOT EXISTS `Scheduling_has_Product` (
  `id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned DEFAULT NULL,
  `Scheduling_id` int(10) unsigned DEFAULT NULL,
  `Product_id` int(10) unsigned DEFAULT NULL,
  `stName` varchar(250) DEFAULT NULL,
  `numPrice` decimal(10,3) unsigned DEFAULT '0.000',
  `numAddPrice` decimal(10,3) unsigned DEFAULT '0.000',
  `numDiscount` decimal(10,3) unsigned DEFAULT '0.000',
  `numAmount` decimal(10,3) unsigned NOT NULL DEFAULT '1.000',
  `dtInsert` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `dtUpdate` timestamp NULL DEFAULT NULL,
  `numStatus` tinyint(4) unsigned DEFAULT '0',
  `isActive` enum('0','1') DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `Section`
--

CREATE TABLE IF NOT EXISTS `Section` (
  `id` smallint(5) unsigned NOT NULL,
  `User_id` int(10) unsigned DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `Section_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Section father',
  `stArea` varchar(50) DEFAULT NULL COMMENT 'Same a group',
  `stValue` varchar(250) NOT NULL COMMENT 'Name used for this section',
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table can be used for create sections or areas in front';

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
  `numAgreement` int(10) unsigned DEFAULT '0',
  `numArea` int(10) unsigned DEFAULT '0',
  `numFrequency` int(10) unsigned DEFAULT '0',
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
-- Estrutura da tabela `Staff`
--

CREATE TABLE IF NOT EXISTS `Staff` (
  `id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `stName` varchar(250) DEFAULT NULL COMMENT '- Nome do ser humano',
  `enumGender` enum('F','M') DEFAULT NULL COMMENT '- Sexo do ser humano (Genero)',
  `dtBirthdate` date DEFAULT NULL COMMENT '- Data de nascimento',
  `stCitizenId` varchar(20) DEFAULT NULL COMMENT '- Documento de identidade RG',
  `stDoc2` varchar(14) DEFAULT NULL COMMENT '- Documento de identidade 2 CPF',
  `stEmail` varchar(255) DEFAULT NULL,
  `stMobile` varchar(15) DEFAULT NULL,
  `stHomePhone` varchar(15) DEFAULT NULL,
  `stHomeCep` varchar(10) DEFAULT NULL,
  `stHomeCountry` varchar(100) DEFAULT NULL,
  `stHomeEstate` varchar(100) DEFAULT NULL,
  `stHomeCity` varchar(100) DEFAULT NULL,
  `stHomeNeighborhood` varchar(100) DEFAULT NULL,
  `stHomeStreet` varchar(255) DEFAULT NULL,
  `stHomeNumber` varchar(10) DEFAULT NULL,
  `stHomeComplement` varchar(100) DEFAULT NULL,
  `txtQualification` text,
  `txtSkill` text,
  `txtHealth` text,
  `stBloodType` varchar(3) DEFAULT NULL,
  `txtContact` text,
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Person data ';

-- --------------------------------------------------------

--
-- Estrutura da tabela `Street`
--

CREATE TABLE IF NOT EXISTS `Street` (
  `id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `City_id` int(10) unsigned NOT NULL COMMENT '- Cidade ao qual o endereço pertence',
  `stType` varchar(10) NOT NULL COMMENT '- Logradouro',
  `stStreet` varchar(250) NOT NULL COMMENT '- Endereço',
  `stNeighborhood` varchar(250) DEFAULT NULL COMMENT '- Bairro',
  `stLatitude` varchar(10) DEFAULT NULL COMMENT '- Latitude de geo localização',
  `stLongitude` varchar(10) DEFAULT NULL COMMENT '- Longitude de geo localização',
  `stZoomMap` varchar(3) DEFAULT NULL COMMENT '- Nível de zoom para visualização de mapa',
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A database of streets, avenues e others';

-- --------------------------------------------------------

--
-- Estrutura da tabela `Street_has_ZipCode`
--

CREATE TABLE IF NOT EXISTS `Street_has_ZipCode` (
  `Street_id` int(10) unsigned NOT NULL COMMENT '- Id do logradouro',
  `ZipCode_id` int(10) unsigned NOT NULL COMMENT '- Id do ZipCode.',
  `User_id` int(10) unsigned DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A relationship between addrLogradouro and addrZipCode, becau';

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Table that make part of system ACL';

--
-- Extraindo dados da tabela `UserGroup`
--

INSERT INTO `UserGroup` (`id`, `User_id`, `UserGroup_id`, `stName`, `stLabel`, `isSystem`, `txtGroupRole`, `txtGroupPref`, `dtInsert`, `dtUpdate`, `numStatus`, `isActive`) VALUES
(1, NULL, NULL, 'guest', 'Visitante', '1', NULL, NULL, '2014-06-27 04:29:50', '2014-07-08 22:34:34', 0, '1'),
(2, NULL, NULL, 'admin', 'Administrador', '1', NULL, NULL, '2014-07-08 06:00:00', '2014-07-08 22:34:56', 0, '1');

-- --------------------------------------------------------

--
-- Estrutura da tabela `Voucher`
--

CREATE TABLE IF NOT EXISTS `Voucher` (
  `id` int(10) unsigned NOT NULL COMMENT '- id da fatura',
  `stCode` varchar(250) NOT NULL COMMENT 'Promotional code to give some sale descount',
  `User_id` int(10) unsigned DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `User_idClient` int(10) unsigned DEFAULT NULL COMMENT 'The registred client id',
  `numValue` decimal(10,3) DEFAULT NULL COMMENT 'Descount value',
  `stOrigin` varchar(250) DEFAULT NULL COMMENT 'Origin of voucher, supplier, promotion ...',
  `dtValid` timestamp NULL DEFAULT NULL COMMENT 'expirate date for this code',
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This is a voucher control, that containing all of voucher co';

-- --------------------------------------------------------

--
-- Estrutura da tabela `ZipCode`
--

CREATE TABLE IF NOT EXISTS `ZipCode` (
  `id` int(10) unsigned NOT NULL,
  `User_id` int(10) unsigned DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `Country_id` int(10) unsigned DEFAULT NULL COMMENT '- País ao qual o CEP pertence',
  `Estate_id` int(10) unsigned DEFAULT NULL COMMENT '- Estado ao qual o CEP pertence',
  `City_id` int(10) unsigned DEFAULT NULL COMMENT '- Cidade ao qual o CEP pertence',
  `stZipCode` varchar(20) NOT NULL COMMENT '- Nome do estado ou província',
  `stRangeIni` varchar(20) DEFAULT NULL COMMENT '- Faixa de número da rua ex: 1000 a 2000',
  `stRangeEnd` int(11) NOT NULL,
  `dtInsert` timestamp NULL DEFAULT NULL,
  `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A database of Zip Code';

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
-- Indexes for table `Address`
--
ALTER TABLE `Address`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Address_City1` (`City_id`),
  ADD KEY `fk_Address_Country` (`Country_id`),
  ADD KEY `fk_Address_Estate` (`Estate_id`),
  ADD KEY `fk_Address_Logradouro` (`Street_id`),
  ADD KEY `fk_Address_ZipCode` (`ZipCode_id`),
  ADD KEY `fk_Address_User` (`User_id`),
  ADD KEY `idx_Address_stNumber` (`stNumber`),
  ADD KEY `idx_Address_stGeoLocalization` (`stGeoLocalization`),
  ADD KEY `idx_Address_Place` (`stPlace`);

--
-- Indexes for table `Address_has_ZipCode`
--
ALTER TABLE `Address_has_ZipCode`
  ADD PRIMARY KEY (`Address_id`,`ZipCode_id`),
  ADD KEY `fk_Address_has_ZipCode_ZipCode` (`ZipCode_id`),
  ADD KEY `fk_Address_has_ZipCode_User` (`User_id`);

--
-- Indexes for table `Agreement`
--
ALTER TABLE `Agreement`
  ADD PRIMARY KEY (`id`),
  ADD KEY `User_id` (`User_id`),
  ADD KEY `numStatus` (`numStatus`),
  ADD KEY `Client_id` (`Client_id`),
  ADD KEY `Service_id` (`Service_id`);

--
-- Indexes for table `Billing`
--
ALTER TABLE `Billing`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Billing_User_Client` (`User_idClient`),
  ADD KEY `fk_Billing_User_Vendor` (`User_idVendor`),
  ADD KEY `idx_Billing_stVoucher` (`stVoucher`),
  ADD KEY `idx_Billing_stTransactionCode` (`stTransactionCode`),
  ADD KEY `idx_Billing_stPostCode` (`stPostCode`);

--
-- Indexes for table `Billing_has_Product`
--
ALTER TABLE `Billing_has_Product`
  ADD PRIMARY KEY (`Billing_id`,`Product_id`),
  ADD KEY `fk_Billing_has_Product_Product` (`Product_id`);

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
  ADD KEY `CashRegister_id` (`CashRegister_id`),
  ADD KEY `ServiceOrder_id` (`ServiceOrder_id`),
  ADD KEY `ServiceOrder_id` (`Agreement_id`),
  ADD KEY `stInvoice` (`stInvoice`),
  ADD KEY `stTransactionStatus` (`stTransactionStatus`),
  ADD KEY `Collector_id` (`Collector_id`),
  ADD KEY `dtInsert` (`dtInsert`);

--
-- Indexes for table `CashRegister`
--
ALTER TABLE `CashRegister`
  ADD PRIMARY KEY (`id`),
  ADD KEY `User_id` (`User_id`),
  ADD KEY `Company_id` (`Company_id`);

--
-- Indexes for table `Category`
--
ALTER TABLE `Category`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_coreCategory_category1` (`Category_id`),
  ADD KEY `fk_coreCategory_coreUser` (`User_id`),
  ADD KEY `idx_coreCategory_stResource` (`stResource`);

--
-- Indexes for table `Category_has_Resource`
--
ALTER TABLE `Category_has_Resource`
  ADD PRIMARY KEY (`Category_id`,`Resource_id`),
  ADD KEY `fk_Category_has_Resource_User` (`User_id`);

--
-- Indexes for table `City`
--
ALTER TABLE `City`
  ADD PRIMARY KEY (`id`,`Estate_id`),
  ADD KEY `fk_City_Estate1` (`Estate_id`),
  ADD KEY `fk_City_User` (`User_id`),
  ADD KEY `idx_City_stCity` (`stCity`),
  ADD KEY `idx_City_stAbreviation` (`stAbreviation`);

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
-- Indexes for table `Company_has_Product`
--
ALTER TABLE `Company_has_Product`
  ADD PRIMARY KEY (`Company_id`);

--
-- Indexes for table `Contact`
--
ALTER TABLE `Contact`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Contact_User` (`User_id`),
  ADD KEY `idx_Contact_enumType` (`stType`),
  ADD KEY `idx_Contact_stLabel` (`stLabel`),
  ADD KEY `idx_Contact_stValue` (`stValue`);

--
-- Indexes for table `Country`
--
ALTER TABLE `Country`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Country_User` (`User_id`),
  ADD KEY `idx_Country_stCountry` (`stCountry`),
  ADD KEY `idx_Country_stAbreviation` (`stAbreviationISO3`),
  ADD KEY `idx_Country_stLocation` (`stLocale`);

--
-- Indexes for table `Crm`
--
ALTER TABLE `Crm`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ServiceOrder_id` (`ServiceOrder_id`),
  ADD KEY `User_id` (`User_id`),
  ADD KEY `dtInsert` (`dtInsert`);

--
-- Indexes for table `Driver`
--
ALTER TABLE `Driver`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `stRegistryId` (`stRegistryId`);

--
-- Indexes for table `Estate`
--
ALTER TABLE `Estate`
  ADD PRIMARY KEY (`id`,`Country_id`),
  ADD KEY `fk_Estate_Country1` (`Country_id`),
  ADD KEY `fk_Estate_User` (`User_id`),
  ADD KEY `idx_Estate_stEstate` (`stEstate`),
  ADD KEY `idx_Estate_stAbreviation` (`stAbreviation`);

--
-- Indexes for table `Faq`
--
ALTER TABLE `Faq`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Faq_User` (`User_id`),
  ADD KEY `idx_Faq_stQuestion` (`stQuestion`);

--
-- Indexes for table `Feature`
--
ALTER TABLE `Feature`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_ProductExtraField_User` (`User_id`),
  ADD KEY `idx_Feature_stGroup` (`stGroup`),
  ADD KEY `idx_Feature_stLabel` (`stLabel`);

--
-- Indexes for table `File`
--
ALTER TABLE `File`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_File_User` (`User_id`),
  ADD KEY `idx_File_dtPublish` (`dtPublish`),
  ADD FULLTEXT KEY `stTitle` (`stTitle`,`stDescription`,`stSource`,`stKeywords`);

--
-- Indexes for table `File_has_User`
--
ALTER TABLE `File_has_User`
  ADD PRIMARY KEY (`File_id`,`User_id`),
  ADD KEY `fk_File_has_User_User` (`User_id`),
  ADD KEY `fk_File_has_User_File_idx` (`File_id`);

--
-- Indexes for table `Freight`
--
ALTER TABLE `Freight`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Gallery`
--
ALTER TABLE `Gallery`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Gallery_User` (`User_id`),
  ADD KEY `fk_Gallery_Photo` (`photo_id`),
  ADD KEY `idx_Gallery_stTitle` (`stTitle`);

--
-- Indexes for table `Gallery_has_Photo`
--
ALTER TABLE `Gallery_has_Photo`
  ADD PRIMARY KEY (`Gallery_id`,`Photo_id`),
  ADD KEY `fk_Gallery_has_Photo_Photo1` (`Photo_id`),
  ADD KEY `fk_Gallery_has_Photo_User` (`User_id`),
  ADD KEY `fk_Gallery_has_Photo_Gallery1_idx` (`Gallery_id`);

--
-- Indexes for table `Item`
--
ALTER TABLE `Item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Product_Company1` (`stManufacturer`),
  ADD KEY `fk_Product_User` (`User_id`),
  ADD KEY `idx_Product_stName` (`stName`),
  ADD KEY `idx_Product_numPrice` (`numValue`),
  ADD KEY `idx_Product_numDescount` (`stPhoto1`);

--
-- Indexes for table `Link`
--
ALTER TABLE `Link`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Link_User` (`User_id`),
  ADD KEY `idx_Link_stLinkDomain` (`stLinkDomain`),
  ADD KEY `idx_Link_stTitle` (`stTitle`);

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
-- Indexes for table `Loan`
--
ALTER TABLE `Loan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Product_id` (`Item_id`),
  ADD KEY `dtInsert` (`dtInsert`),
  ADD KEY `dtLoan` (`dtLoan`),
  ADD KEY `User_id` (`User_id`),
  ADD KEY `User_TakerId` (`User_TakerId`),
  ADD KEY `dtExpected` (`dtExpected`),
  ADD KEY `dtReturned` (`dtReturned`),
  ADD KEY `numStatus` (`numStatus`);

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
-- Indexes for table `Menu`
--
ALTER TABLE `Menu`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_coreMenu_stValue_UNIQUE` (`stValue`),
  ADD KEY `fk_coreMenu_coreMenu1` (`coreMenu_id`),
  ADD KEY `fk_coreMenu_coreUser` (`coreUser_id`),
  ADD KEY `idx_coreMenu_stTitle` (`stTitle`),
  ADD KEY `idx_coreMenu_stUrlDomain` (`stUrlDomain`);

--
-- Indexes for table `Newsletter`
--
ALTER TABLE `Newsletter`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_Newsletter_stEmail_UNIQUE` (`stEmail`),
  ADD KEY `fk_Newsletter_User` (`User_id`),
  ADD KEY `idx_Newsletter_stName` (`stName`),
  ADD KEY `idx_Newsletter_stEmail` (`stEmail`);

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
-- Indexes for table `Photo`
--
ALTER TABLE `Photo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Photo_User` (`User_id`),
  ADD KEY `idx_Photo_stTitle` (`stTitle`);

--
-- Indexes for table `Pref`
--
ALTER TABLE `Pref`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Pref_User` (`User_id`),
  ADD KEY `idx_Pref_stTable` (`stTable`),
  ADD KEY `idx_Pref_stModule` (`stModule`),
  ADD KEY `idx_Pref_numRecord_id` (`numRecord_id`);

--
-- Indexes for table `Product`
--
ALTER TABLE `Product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Product_Company1` (`Company_id`),
  ADD KEY `fk_Product_User` (`User_id`),
  ADD KEY `idx_Product_stName` (`stName`),
  ADD KEY `idx_Product_numPrice` (`numPrice`),
  ADD KEY `idx_Product_numDescount` (`numDiscount`);

--
-- Indexes for table `Product_has_Feature`
--
ALTER TABLE `Product_has_Feature`
  ADD PRIMARY KEY (`Product_id`,`Feature_id`),
  ADD KEY `fk_Product_has_ProductExtraField_ProductExtraField` (`Feature_id`),
  ADD KEY `fk_Product_has_ProductExtraField_User` (`CoreUser_id`);

--
-- Indexes for table `Product_has_Product`
--
ALTER TABLE `Product_has_Product`
  ADD PRIMARY KEY (`ProductRel_id`,`Product_id`),
  ADD KEY `fk_Product_has_Product_Product` (`Product_id`),
  ADD KEY `fk_Product_has_Product_User` (`User_id`),
  ADD KEY `fk_Product_has_Product_ProductRel_idx` (`ProductRel_id`);

--
-- Indexes for table `Profile`
--
ALTER TABLE `Profile`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_User_stUsername_UNIQUE` (`stUsername`),
  ADD UNIQUE KEY `stEmail` (`stMobile`),
  ADD KEY `fk_User_Person1` (`stName`),
  ADD KEY `fk_User_User1` (`User_id`),
  ADD KEY `fk_User_UserGroup1` (`UserGroup_id`),
  ADD KEY `stRegistrationToken` (`stRegistrationToken`);

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
-- Indexes for table `Ratio`
--
ALTER TABLE `Ratio`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_Ratio_stResource` (`stResource`),
  ADD KEY `idx_Ratio_Resoutce_id` (`Resource_id`),
  ADD KEY `idx_Ratio_numRate1` (`numRate1`),
  ADD KEY `idx_Ratio_numRate2` (`numRate2`),
  ADD KEY `idx_Ratio_numRate3` (`numRate3`),
  ADD KEY `idx_Ratio_numRate4` (`numRate4`),
  ADD KEY `idx_Ratio_numRate5` (`numRate5`);

--
-- Indexes for table `Resource_has_Address`
--
ALTER TABLE `Resource_has_Address`
  ADD PRIMARY KEY (`Address_id`,`Resource_Id`,`stResource`),
  ADD KEY `fk_Person_has_Address_User` (`User_id`);

--
-- Indexes for table `Resource_has_Contact`
--
ALTER TABLE `Resource_has_Contact`
  ADD PRIMARY KEY (`Contact_id`,`Resource_id`,`stResource`),
  ADD KEY `fk_Resource_has_Contact_User` (`User_id`);

--
-- Indexes for table `Resource_has_Gallery`
--
ALTER TABLE `Resource_has_Gallery`
  ADD PRIMARY KEY (`Gallery_id`,`Resource_id`,`stResource`),
  ADD KEY `fk_Gallery_has_Photo_User0` (`User_id`),
  ADD KEY `fk_Gallery_has_Photo_Gallery1_idx` (`Gallery_id`);

--
-- Indexes for table `Resource_has_Link`
--
ALTER TABLE `Resource_has_Link`
  ADD PRIMARY KEY (`Link_id`,`Resource_Id`,`stResource`),
  ADD KEY `fk_Resource_has_Link_User` (`User_id`);

--
-- Indexes for table `Resource_has_Ratio`
--
ALTER TABLE `Resource_has_Ratio`
  ADD PRIMARY KEY (`stResource`,`Resource_Id`,`Ratio_id`),
  ADD KEY `fk_Resource_has_Ratio_User` (`User_id`),
  ADD KEY `idx_Resource_has_Ratio_Ratio_id` (`Ratio_id`);

--
-- Indexes for table `Route`
--
ALTER TABLE `Route`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_coreRoute_coreCategory1` (`Category_id`),
  ADD KEY `fk_coreRoute_coreSection1` (`Section_id`),
  ADD KEY `fk_coreRoute_coreUser` (`User_id`),
  ADD KEY `idx_coreRoute_stTitle` (`stTitle`),
  ADD KEY `idx_coreRoute_stkeywords` (`stKeywords`),
  ADD KEY `idx_coreRoute_stSlung` (`stSlung`),
  ADD KEY `idx_coreRoute_stUri` (`stUri`);

--
-- Indexes for table `Scheduling`
--
ALTER TABLE `Scheduling`
  ADD PRIMARY KEY (`id`),
  ADD KEY `User_id` (`User_id`),
  ADD KEY `Staff_id` (`Staff_id`),
  ADD KEY `dtStart` (`dtStart`),
  ADD KEY `Agreement_id` (`Agreement_id`);

--
-- Indexes for table `Scheduling_has_Product`
--
ALTER TABLE `Scheduling_has_Product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Scheduling_id` (`Scheduling_id`),
  ADD KEY `Product_id` (`Product_id`);

--
-- Indexes for table `Section`
--
ALTER TABLE `Section`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_Section_stValue_UNIQUE` (`stValue`),
  ADD KEY `fk_Section_Section1` (`Section_id`),
  ADD KEY `fk_Section_User` (`User_id`),
  ADD KEY `idx_Section_stArea` (`stArea`);

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
-- Indexes for table `Staff`
--
ALTER TABLE `Staff`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_Person_stCitzenId` (`stCitizenId`),
  ADD KEY `User_id` (`User_id`),
  ADD KEY `stName` (`stName`),
  ADD KEY `dtBirthdate` (`dtBirthdate`),
  ADD KEY `stMobile` (`stMobile`),
  ADD KEY `stHomePhone` (`stHomePhone`);

--
-- Indexes for table `Street`
--
ALTER TABLE `Street`
  ADD PRIMARY KEY (`id`,`City_id`),
  ADD KEY `fk_Logradouro_City` (`City_id`),
  ADD KEY `fk_Logradouro_User` (`User_id`),
  ADD KEY `idx_Logradouro_stAddress` (`stStreet`),
  ADD KEY `idx_Logradouro_stNeighborhood` (`stNeighborhood`);

--
-- Indexes for table `Street_has_ZipCode`
--
ALTER TABLE `Street_has_ZipCode`
  ADD PRIMARY KEY (`Street_id`,`ZipCode_id`),
  ADD KEY `fk_Logradouro_has_ZipCode_ZipCode` (`ZipCode_id`),
  ADD KEY `fk_Logradouro_has_ZipCode_User` (`User_id`);

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
-- Indexes for table `Voucher`
--
ALTER TABLE `Voucher`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_Voucehr_stCode_UNIQUE` (`stCode`),
  ADD KEY `fk_Voucher_User` (`User_id`),
  ADD KEY `fk_Voucher_UserClient` (`User_idClient`),
  ADD KEY `idx_Voucher_stOrigin` (`stOrigin`);

--
-- Indexes for table `ZipCode`
--
ALTER TABLE `ZipCode`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_ZipCode_stZipCode_UNIQUE` (`stZipCode`),
  ADD KEY `fk_ZipCode_City1` (`City_id`),
  ADD KEY `fk_ZipCode_Country1` (`Country_id`),
  ADD KEY `fk_ZipCode_Estate1` (`Estate_id`),
  ADD KEY `fk_User_ZipCode` (`User_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `AccessToken`
--
ALTER TABLE `AccessToken`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Address`
--
ALTER TABLE `Address`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Agreement`
--
ALTER TABLE `Agreement`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Billing`
--
ALTER TABLE `Billing`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '- id da fatura';
--
-- AUTO_INCREMENT for table `Burden`
--
ALTER TABLE `Burden`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `CashFlow`
--
ALTER TABLE `CashFlow`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `CashRegister`
--
ALTER TABLE `CashRegister`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Category`
--
ALTER TABLE `Category`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `City`
--
ALTER TABLE `City`
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
-- AUTO_INCREMENT for table `Company_has_Product`
--
ALTER TABLE `Company_has_Product`
  MODIFY `Company_id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Contact`
--
ALTER TABLE `Contact`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Country`
--
ALTER TABLE `Country`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Crm`
--
ALTER TABLE `Crm`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Driver`
--
ALTER TABLE `Driver`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Estate`
--
ALTER TABLE `Estate`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Faq`
--
ALTER TABLE `Faq`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Feature`
--
ALTER TABLE `Feature`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '- id do campo';
--
-- AUTO_INCREMENT for table `File`
--
ALTER TABLE `File`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Freight`
--
ALTER TABLE `Freight`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Gallery`
--
ALTER TABLE `Gallery`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Item`
--
ALTER TABLE `Item`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id do produto';
--
-- AUTO_INCREMENT for table `Link`
--
ALTER TABLE `Link`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Loader`
--
ALTER TABLE `Loader`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Loan`
--
ALTER TABLE `Loan`
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
-- AUTO_INCREMENT for table `Menu`
--
ALTER TABLE `Menu`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Newsletter`
--
ALTER TABLE `Newsletter`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '- id do produto';
--
-- AUTO_INCREMENT for table `Person`
--
ALTER TABLE `Person`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Photo`
--
ALTER TABLE `Photo`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Pref`
--
ALTER TABLE `Pref`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Product`
--
ALTER TABLE `Product`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id do produto';
--
-- AUTO_INCREMENT for table `Profile`
--
ALTER TABLE `Profile`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Queue`
--
ALTER TABLE `Queue`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Quota`
--
ALTER TABLE `Quota`
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
-- AUTO_INCREMENT for table `Ratio`
--
ALTER TABLE `Ratio`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Resource_has_Ratio`
--
ALTER TABLE `Resource_has_Ratio`
  MODIFY `Ratio_id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Route`
--
ALTER TABLE `Route`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Scheduling`
--
ALTER TABLE `Scheduling`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Section`
--
ALTER TABLE `Section`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Service`
--
ALTER TABLE `Service`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id do produto';
--
-- AUTO_INCREMENT for table `Staff`
--
ALTER TABLE `Staff`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Street`
--
ALTER TABLE `Street`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Tracker`
--
ALTER TABLE `Tracker`
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
--
-- AUTO_INCREMENT for table `Voucher`
--
ALTER TABLE `Voucher`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '- id da fatura';
--
-- AUTO_INCREMENT for table `ZipCode`
--
ALTER TABLE `ZipCode`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Limitadores para a tabela `Agreement`
--
ALTER TABLE `Agreement`
  ADD CONSTRAINT `Agreement_ibfk_1` FOREIGN KEY (`Client_id`) REFERENCES `Client` (`id`) ON UPDATE NO ACTION,
  ADD CONSTRAINT `Agreement_ibfk_2` FOREIGN KEY (`Service_id`) REFERENCES `Service` (`id`) ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `Scheduling`
--
ALTER TABLE `Scheduling`
  ADD CONSTRAINT `Scheduling_ibfk_1` FOREIGN KEY (`Agreement_id`) REFERENCES `Agreement` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `Scheduling_ibfk_2` FOREIGN KEY (`Staff_id`) REFERENCES `Staff` (`id`) ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `Scheduling_has_Product`
--
ALTER TABLE `Scheduling_has_Product`
  ADD CONSTRAINT `Scheduling_has_Product_ibfk_1` FOREIGN KEY (`Scheduling_id`) REFERENCES `Scheduling` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `Scheduling_has_Product_ibfk_2` FOREIGN KEY (`Product_id`) REFERENCES `Product` (`id`) ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
