<?php
/**
 * This file is part of Onion Tool
 *
 * Copyright (c) 2014-2016, Humberto Lourenço <betto@m3uzz.com>.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 *   * Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *
 *   * Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in
 *     the documentation and/or other materials provided with the
 *     distribution.
 *
 *   * Neither the name of Humberto Lourenço nor the names of his
 *     contributors may be used to endorse or promote products derived
 *     from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 * COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
 * ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 *
 * @category   PHP
 * @package    OnionTool
 * @author     Humberto Lourenço <betto@m3uzz.com>
 * @copyright  2014-2016 Humberto Lourenço <betto@m3uzz.com>
 * @license    http://www.opensource.org/licenses/BSD-3-Clause  The BSD 3-Clause License
 * @link       http://github.com/m3uzz/oniontool
 */

return array(
	"onionTool" => array(
		"srv" => array(
			"newClient" => array(
				"desc" => "Create a new client structure folder",
				"params" => array(
					"folder" => "Client folder name",
					"service" => "Service name",
					"author" => "Author name",
					"email" => "Author e-mail",
					"link" => "Project link or repository",
					"cinit" => "Copyrigth year",
				),
			),
			"newService" => array(
				"desc" => "Create a new service for a existent client",
				"params" => array(
					"folder" => "Client folder name",
					"service" => "Service name",
					"author" => "Author name",
					"email" => "Author e-mail",
					"link" => "Project link or repository",
					"cinit" => "Copyrigth year",
				),
			),
			"setEntity" => array(
				"desc" => "Set module entity as table structure",
				"params" => array(
					"folder" => "Client folder name",
				    "service" => "Service name",
				    "driver" => "Database driver",
				    "charset" => "Database charset",
					"host" => "Database server host address",
					"port" => "Database server port",
					"user" => "Database user",
					"pass" => "Database user password",
					"dbname" => "Database name",
				    "table" => "Database database table name",
				),
			),		        
			"virtualHostDev" => array(
				"desc" => "Configure Apache2 virutal hosts for the dev environment",
				"params" => array(
					"folder" => "Client folder name",
					"domain" => "Domain for the virtual host access",
					"httpport" => "Apache port to access virtual host",
					"docroot" => "Apache document root folder",
					"hosts" => "Hosts file path",
					"localhost" => "Localhost IP address",
					"apachedir" => "Apache config path",
					"apachegrp" => "Apache group access",
				),
			),
			"showVHostConf" => array(
				"desc" => "Information to set Apache2 and configure the virtual host",
				"params" => array(),
			),
			"uninstallClient" => array(
				"desc" => "Remove all references about client project",
				"params" => array(
					"folder" => "Client folder name",
					"domain" => "Domain for the virtual host access",
					"docroot" => "Apache document root folder",
					"apachedir" => "Apache config path",
				),
			),		    
			"checkEnv" => array(
				"desc" => "Check system environment to verify dependencies",
				"params" => array(),
			),
		),
		"cms" => array(
			"newClient" => array(
				"desc" => "Create a new client structure folder",
				"params" => array(
					"folder" => "Client folder name",
					"client" => "Client name",
					"domain" => "Host domain",
					"module" => "Module name",
					"author" => "Author name",
					"email" => "Author e-mail",
					"link" => "Project link or repository",
					"cinit" => "Copyrigth year",
				),
			),
			"newModule" => array(
				"desc" => "Create a new module for a existent client",
				"params" => array(
					"folder" => "Client folder name",
					"module" => "Module name",
					"author" => "Author name",
					"email" => "Author e-mail",
					"link" => "Project link or repository",
					"cinit" => "Copyrigth year",
				),
			),
			"layoutDist" => array(
				"desc" => "Install layout vendors scripts from distribution link",
				"params" => array(),
			),
			"layoutGit" => array(
				"desc" => "Install layout vendors scripts from github",
				"params" => array(),
			),
			"prepare" => array(
				"desc" => "Prepare Onion CMS. Install layout dependencie ",
				"params" => array(),
			),
			"installDb" => array(
				"desc" => "Configure Onion database for a generic application",
				"params" => array(
					"folder" => "Client folder name",
				    "driver" => "Database driver",
				    "charset" => "Database charset",				        
					"host" => "Database server host address",
					"port" => "Database server port",
					"user" => "Database user",
					"pass" => "Database user password",
					"dbname" => "Database name",
				),
			),
			"createTableBase" => array(
				"desc" => "Create a base table with some default fields",
				"params" => array(
					"folder" => "Client folder name",
				    "driver" => "Database driver",
				    "charset" => "Database charset",				        
					"host" => "Database server host address",
					"port" => "Database server port",
					"user" => "Database user",
					"pass" => "Database user password",
					"dbname" => "Database name",
				    "table" => "Database table name to create",
				),
			),		     
			"setEntity" => array(
				"desc" => "Set module entity as table structure",
				"params" => array(
					"folder" => "Client folder name",
				    "module" => "Module name",
				    "driver" => "Database driver",
				    "charset" => "Database charset",				        
					"host" => "Database server host address",
					"port" => "Database server port",
					"user" => "Database user",
					"pass" => "Database user password",
					"dbname" => "Database name",
				    "table" => "Database table name",
				),
			),	
			"setForm" => array(
				"desc" => "Set module form as table structure",
				"params" => array(
					"folder" => "Client folder name",
				    "module" => "Module name",
				    "driver" => "Database driver",
				    "charset" => "Database charset",				        
					"host" => "Database server host address",
					"port" => "Database server port",
					"user" => "Database user",
					"pass" => "Database user password",
					"dbname" => "Database name",
				    "table" => "Database table name",
				),
			),			        
			"createUserDb" => array(
				"desc" => "Generate a sql command to create a new user to access database",
				"params" => array(
				    "driver" => "Database driver",
				    "charset" => "Database charset",				        
					"host" => "Database server host address",
					"user" => "Database new username",
					"pass" => "Database new user password",
					"dbname" => "Database name to give access",
					"table" => "Database specifique table to give access",
				),
			),		        
			"virtualHostDev" => array(
				"desc" => "Configure Apache2 virutal hosts for the dev environment",
				"params" => array(
					"folder" => "Client folder name",
					"domain" => "Domain for the virtual host access",
					"httpport" => "Apache port to access virtual host",
					"docroot" => "Apache document root folder",
					"hosts" => "Hosts file path",
					"localhost" => "Localhost IP address",
					"apachedir" => "Apache config path",
					"apachegrp" => "Apache group access",
				),
			),
			"showVHostConf" => array(
				"desc" => "Information to set Apache2 and configure the virtual host",
				"params" => array(),
			),
			"uninstallClient" => array(
				"desc" => "Remove all references about client project",
				"params" => array(
					"folder" => "Client folder name",
					"domain" => "Domain for the virtual host access",
					"docroot" => "Apache document root folder",
					"apachedir" => "Apache config path",
				),
			),		    
			"checkEnv" => array(
				"desc" => "Check system environment to verify dependencies",
				"params" => array(),
			),
		),
	),
);
