SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

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
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT for table `User`
--
ALTER TABLE `User`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `UserGroup`
--
ALTER TABLE `UserGroup`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;