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

namespace OnionTool\Controller;
use OnionSrv\Abstracts\AbstractController;
use OnionSrv\Config;
use OnionSrv\Debug;
use OnionSrv\System;
use OnionSrv\Help;
use OnionLib\String;
use OnionLib\Util;

abstract class ToolAbstract extends AbstractController
{

	protected $_sModelPath;
	
	protected $_sLayoutVendor;
	
	protected $_sClientFolder;
	
	protected $_sClientName;
	
	protected $_sClientDomain;
	
	protected $_sModuleName = null;
	
	
	/**
	 * 
	 * @param string $psFolder
	 */
	public function setClientFolder($psFolder)
	{
		$this->_sClientFolder = $psFolder;
		
		return $this;
	}
	
	
	/**
	 * 
	 * @param string $psDomain
	 */
	public function setClientDomain($psDomain)
	{
		$this->_sClientDomain = $psDomain;
		
		if (empty($this->_sClientDomain))
		{
			$this->_sClientDomain = $this->_sClientFolder;
		}
		
		return $this;
	}
	
	
	/**
	 * 
	 * @param string $psClient
	 */
	public function setClientName($psClient)
	{
		$this->_sClientName = $psClient;
		
		if (empty($this->_sClientName))
		{
			$laClientFolder = explode(".", $this->_sClientFolder);
			$this->_sClientName = ucfirst($laClientFolder[0]);
		}
		
		return $this;
	}
	
	
	/**
	 * 
	 * @param string $psModule
	 */
	public function setModuleName($psModule)
	{
		if (!empty($psModule))
		{
			$this->_sModuleName = ucfirst($psModule);
		}

		return $this;
	}
	
	
	/**
	 *
	 * @param string $psPath
	 * @param bool $pbHtaccess
	 * @param int $pnChmod
	 * @param string $pnChown
	 * @param string $pnChown
	 */
	public function createDir ($psPath, $pbHtaccess = true, $pnChmod = null, $psChown = null, $psChgrp = null)
	{
		System::createDir($psPath, $pnChmod, $psChown, $psChgrp);
		
		if ($pbHtaccess)
		{
			$lsFileContent = System::localRequest($this->_sModelPath . DS . "deny.model");
			$lsFilePath = $psPath . DS . '.htaccess';
			System::saveFile($lsFilePath, $lsFileContent);
		}
	}
	
	
	/**
	 *
	 * @param string $psPathConfig
	 */
	public function setModuleAutoload ($psPathConfig)
	{
		$lsModulesPath = $psPathConfig . DS . "modules.php";
		$lsAclPath = $psPathConfig . DS . "acl.php";
		$lsMenuPath = $psPathConfig . DS . "menu.php";
		
		if (file_exists($lsModulesPath))
		{
			$laModules = include ($lsModulesPath);
		
			$laModules['available'][$this->_sModuleName] = true;
				
			$lsFileContent = System::arrayToFile($laModules);
		
			System::saveFile($lsModulesPath, $lsFileContent);
		}
		
		if (file_exists($lsAclPath))
		{
			$laAcl = include ($lsAclPath);
		
			$laAcl['acl']['resources']['allow'][$this->_sModuleName] = array(
				'index' => 'admin',
            	'trash' => 'admin',
            	'add' => 'admin',
            	'edit' => 'admin',
            	'view' => 'admin',
            	'move' => 'admin',
            	'delete' => 'admin',
            	'move-list' => 'admin',
            	'delete-list' => 'admin',
            	'search-select' => 'admin',
            	'search' => 'admin',
            	'message' => 'guest'
			);
		
			$lsFileContent = System::arrayToFile($laAcl);
		
			System::saveFile($lsAclPath, $lsFileContent);
		}
		
		if (file_exists($lsMenuPath))
		{
			$laMenu = include ($lsMenuPath);
		
			$lsRoute = String::slugfy($this->_sModuleName);
			$lsModuleLabel = preg_replace("/_/", " ", ucfirst($lsRoute));
			
			$laMenu['admin'][$this->_sModuleName] = array(
				'accesskey' => '',
				'label' => $lsModuleLabel,
				'link' => "/{$lsRoute}",
				'description' => '',
				'icon' => 'glyphicon glyphicon-cog',
				'submenu' => null,
			);
		
			$lsFileContent = System::arrayToFile($laMenu);
		
			System::saveFile($lsMenuPath, $lsFileContent);
		}
	}
	
	
	/**
	 * 
	 * @param string $psPathConfig
	 */
	public function setSrvModuleAutoload ($psPathConfig)
	{
		$lsSrvModulePath = $psPathConfig . DS . "srv-module.php";
		
		if (file_exists($lsSrvModulePath))
		{
			$laModuleLoader = include ($lsSrvModulePath);
				
			if (is_array($laModuleLoader))
			{
				foreach ($laModuleLoader as $lsModuleAlias => $laValuePath)
				{
					$laModuleLoader[$lsModuleAlias] = "//array(CLIENT_DIR . DS . 'service' . DS . '{$lsModuleAlias}' . DS . 'src')";
				}
			}
			
			$laModuleLoader[$this->_sModuleName] = "//array(CLIENT_DIR . DS . 'service' . DS . '{$this->_sModuleName}' . DS . 'src')";
			$lsFileContent = "<?php\nreturn array(\n" . System::arrayToString($laModuleLoader) . ");";

			System::saveFile($lsSrvModulePath, $lsFileContent);
		}
	}
	

	/**
	 * 
	 * @param string $psPackage
	 * @return string
	 */
	public function getLicense ($psPackage)
	{
		$lsAuthor = $this->getRequestArg('author', "Humberto Lourenço");
		$lsEmail = $this->getRequestArg('email', "betto@m3uzz.com");
		$lsLink = $this->getRequestArg('link', "http://github.com/m3uzz/onionsrv");
		$lsCopyrightIni = $this->getRequestArg('cinit', "2014");
		
		$lsLicensePath = $this->_sModelPath . DS . 'LICENSE.model';
		$lsFileLicense = System::localRequest($lsLicensePath);
		
		Util::parse($lsFileLicense, "#%PACKAGE%#", $psPackage);
		Util::parse($lsFileLicense, "#%AUTHOR%#", $lsAuthor);
		Util::parse($lsFileLicense, "#%EMAIL%#", $lsEmail);
		Util::parse($lsFileLicense, "#%LINK%#", $lsLink);
		Util::parse($lsFileLicense, "#%COPYRIGHT%#", $lsCopyrightIni . "-" . date('Y'));
		
		return $lsFileLicense;
	}
	
	
	/**
	 * 
	 * @param string $psPath
	 * @param string $psFile
	 * @param string $psFileLicense
	 * @param string $psFileType
	 */
	public function saveFile ($psPath, $psFile, $psFileLicense = "", $psFileType = "php")
	{
		switch ($psFile)
		{
			case 'htaccess':
				$lsFileName = ".{$psFile}";
				break;
			case 'Entity':
				$lsFileName = "{$this->_sModuleName}.php";
				break;
			case 'actionIndex':
				$lsFileName = "index.phtml";
				break;
			default:
				$lsFileName = "{$psFile}.{$psFileType}";
				$lsFileName = preg_replace("/_/", $this->_sModuleName, $lsFileName);
		}
		
		
		$lsFilePath = $psPath . DS . $lsFileName;

		if (!file_exists($lsFilePath))
		{
			$lsFileContent = System::localRequest($this->_sModelPath . DS . "{$psFile}.model");
			
			Util::parse($lsFileContent, "#%LICENSE%#", $psFileLicense);
			Util::parse($lsFileContent, "#%MODULE%#", $this->_sModuleName);
			Util::parse($lsFileContent, "#%ACTION%#", String::lcfirst($this->_sModuleName));
			
			Util::parse($lsFileContent, "#%ROUTE%#", String::slugfy($this->_sModuleName));
			
			Util::parse($lsFileContent, "#%PACKAGE%#", $this->_sClientFolder);
			Util::parse($lsFileContent, "#%CLIENT-NAME%#", $this->_sClientName);
			Util::parse($lsFileContent, "#%DATE%#", date('Y-m-d'));
			Util::parse($lsFileContent, "#%DOMAIN%#", $this->_sClientDomain);
			
			System::saveFile($lsFilePath, $lsFileContent);
		}
	}
	
	
	/**
	 * 
	 */
	public function confApacheAction ()
	{
		$lsDomain = "local.project-name";
		$lsDocumentRoot = "/var/www/path/to/the/client/public";
		$lsVirtualHost = $this->apacheConf($lsDocumentRoot, $lsDomain);
		$lsAppFolder = "/foo/bar/application/folder";
		
		$loHelp = new Help();
		$loHelp->clear();
		
		$loHelp->set("        *** m3uzz OnionSrv - Version: " . $loHelp::VERSION . " ***        ", $loHelp::PURPLE, $loHelp::BGBLACK);
		$loHelp->set("\n");
		$loHelp->set("AUTHOR:  Humberto Lourenço <betto@m3uzz.com>             ", $loHelp::CYAN, $loHelp::BGBLACK);
		$loHelp->set("\n");
		$loHelp->set("LINK:    http://github.com/m3uzz/onionsrv                ", $loHelp::CYAN, $loHelp::BGBLACK);
		$loHelp->set("\n");
		$loHelp->set("LICENCE: http://www.opensource.org/licenses/BSD-3-Clause ", $loHelp::CYAN, $loHelp::BGBLACK);
		$loHelp->set("\n\n");
		
		$loHelp->set("    **** Apache 2.2 - Config development environment ****    \n", $loHelp::BROWN, "", $loHelp::B);
		
		$loHelp->setTopic("STEP 1:");
		$loHelp->setLine("DocumentRoot", "Move or create a link of the application to the Apache document root (Linux default is /var/www)");
		$loHelp->setLine("Moving", "$ sudo mv {$lsAppFolder} /var/www/");
		$loHelp->setLine("Or");
		$loHelp->setLine("Simblink", "$ sudo ln -s {$lsAppFolder} /var/www/");
		
		$loHelp->setTopic("STEP 2:");
		$loHelp->setLine("CHMOD project", "$ sudo chmod 755 {$lsAppFolder} -R");
		$loHelp->setLine("CHGPR project", "$ sudo chgrp www-data {$lsAppFolder} -R");
		
		$loHelp->setTopic("STEP 3:");
		$loHelp->setLine("Set hosts file", "$ sudo echo 127.0.0.1	{$lsDomain} >> /etc/hosts");
		
		$loHelp->setTopic("STEP 4:");
		$loHelp->setLine("Edit a new vhost", "$ sudo vi /etc/apache2/sites-available/{$lsDomain}.conf");
		$loHelp->setLine("Copy, paste & edit", $lsVirtualHost);
		
		$loHelp->setTopic("STEP 5:");
		$loHelp->setLine("Active in sites-enable", '$ sudo a2ensite {$lsDomain}');
		
		$loHelp->setTopic("STEP 6:");
		$loHelp->setLine("Reload Apache2", "$ sudo /etc/init.d/apache2 reload");
		
		$loHelp->display();
	}
	
	
	/**
	 * 
	 */
	public function virtualHostDevAction ()
	{
		if ($_SERVER["USER"] == "root")
		{
			$lsApacheGroup = $this->getRequestArg('apachegrp', "www-data");

			Debug::display("CHGPR project folder");
			$laReturn = System::execute("chgrp {$lsApacheGroup} " . BASE_DIR . " -R");
			Debug::debug($laReturn);
				
			$lsDocRoot = $this->getRequestArg('docroot', DS . "var" . DS . "www" . DS, false);
			
			Debug::display("Create project link to document root: " . BASE_DIR . "  to {$lsDocRoot}");
			System::simblink(BASE_DIR, $lsDocRoot);
	
			if (System::confirm("Create Apache virtual host?") == "y")
			{
				$lsClientFolder = $this->getRequestArg('folder', null, false);
				$lsDomain = $this->getRequestArg('domain', null, false);
				$lsPort = $this->getRequestArg('port', '80', false);
				$lsHosts = $this->getRequestArg('hosts', DS . "etc" . DS . "hosts", false);
				$lsLocalhost = $this->getRequestArg('localhost', "127.0.0.1", false);
				$lsApacheDir = $this->getRequestArg('apachedir', DS . "etc" . DS . "apache2" . DS);
				
				Debug::display("Backuping {$lsHosts} to {$lsHosts}.bkp");
				$laReturn = System::execute("cp {$lsHosts} {$lsHosts}.bkp");
				Debug::debug($laReturn);
				Debug::display("Seting '{$lsLocalhost}\t{$lsDomain}' to {$lsHosts}");
				$laReturn = System::execute("echo {$lsLocalhost}\t{$lsDomain} >> {$lsHosts}");
				Debug::debug($laReturn);
				
				$laAppDirName = explode(DS, BASE_DIR);
				$lsAppDirName = array_pop($laAppDirName);
				$lsDocumentRoot = $lsDocRoot . $lsAppDirName . DS . 'client' . DS . $lsClientFolder . DS . 'public';
				$lsSitesAvailablePath = $lsApacheDir . 'sites-available' . DS . "{$lsDomain}.conf";
				
				Debug::display("Creating vhost: " . $lsSitesAvailablePath);
				$lsVirtualHost = $this->apacheConf($lsDocumentRoot, $lsDomain, $lsPort);
				Debug::debug($lsVirtualHost);
				$laReturn = System::saveFile($lsSitesAvailablePath, trim($lsVirtualHost));
				Debug::debug($laReturn);
				
				Debug::display("Enable vhost {$lsDomain}");
				$laReturn = System::execute("a2ensite {$lsDomain}");
				Debug::debug($laReturn);
			
				if (System::confirm("Reload Apache2?") == "y")
				{
					Debug::display("Apache reload");
					$laReturn = System::execute(DS . "etc" . DS . "init.d" . DS . "apache2 reload");
					Debug::debug($laReturn);
				}
			}
		}
		else
		{
			Debug::exitError("You need root access to run this action! Please try run this action using sudo.");
		}
	}
	
	
	/**
	 * 
	 * @param string $psDocRoot
	 * @param string $psDomain
	 * @param string $psPort
	 * @return string
	 */
	public function apacheConf ($psDocRoot, $psDomain, $psPort = "80")
	{
		$lsVirtualHost = '
		<VirtualHost *:' . $psPort . '>
			ServerName ' . $psDomain . '
			ServerAdmin webmaster@localhost
			SetEnv APPLICATION_ENV "development"
			#SetEnv APPLICATION_ENV "production"
					
			DocumentRoot ' . $psDocRoot . '
					
			#<Directory />
			#	Options FollowSymLinks
			#	AllowOverride None
			#</Directory>
			#<Directory ' . $psDocRoot . '/>
			#	Options Indexes FollowSymLinks MultiViews
			#	AllowOverride All
			#	Order allow,deny
			#	allow from all
			#</Directory>
			
			#ScriptAlias /cgi-bin/ /usr/lib/cgi-bin/
			#<Directory "/usr/lib/cgi-bin">
			#	AllowOverride None
			#	Options +ExecCGI -MultiViews +SymLinksIfOwnerMatch
			#	Order allow,deny
			#	Allow from all
			#</Directory>
			
			ErrorLog ${APACHE_LOG_DIR}/error.log
			
			# Possible values include: debug, info, notice, warn, error, crit,
			# alert, emerg.
			LogLevel warn
			
			CustomLog ${APACHE_LOG_DIR}/access.log combined
		</VirtualHost>
		';
		
		return $lsVirtualHost;
	}
	
	
	/**
	 * 
	 */
	public function checkDependenciesAction ()
	{
		return true;
	}
}