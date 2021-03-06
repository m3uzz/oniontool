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
use OnionTool\Repository\InstallRepository;
use OnionSrv\Config;
use OnionSrv\Debug;
use OnionSrv\System;
use OnionLib\String;
use OnionLib\Util;

class CmsController extends ToolAbstract
{
	
	/**
	 */
	public function init ()
	{
	    $this->checkCli();
	    
		$this->_sModelPath = dirname($this->_sControllerPath) . DS . 'Model' . DS . 'cms';
		$this->_sDbPath = dirname($this->_sControllerPath) . DS . 'Db';
		$this->_sLayoutVendor = BASE_DIR . DS . 'layout' . DS . 'vendor';
	}


	/**
	 * 
	 */
	public function cmsAction ()
	{
		$this->help(true);
	}
	
	
	/**
	 * 
	 */
	public function prepareAction ()
	{
		if (System::confirm("Create onionTool link on bin folder?"))
		{
			$this->tool2BinAction();
		}

		if ($this->checkEnvAction())
		{
			if (System::confirm("Install layout dependencies?"))
			{
				$this->layoutGitAction();
				$this->layoutDistAction();
			}
		}
		
		if (System::confirm("Show Onion Tool help?"))
		{
			$this->help(true, true);
		}
	}
	
	
	/**
	 *
	 */
	public function tool2BinAction ()
	{
		$lsOrigem = BIN_DIR . DS . "cmstool.php";
		$lsLink = BASE_DIR . DS . "bin" . DS . "cmstool";
		System::simblink($lsOrigem, $lsLink);
		
		$loSrv = new SrvController();
		$loSrv->tool2BinAction();
	}
	
	
	/**
	 * 
	 */
	public function newClientAction ()
	{
		$this->setClientFolder($this->getRequestArg('folder', "onionapp.com"));
		$this->setClientDomain($this->getRequestArg('domain', "local.{$this->_sClientFolder}"));
		$this->setClientName($this->getRequestArg('client', "OnionApp"));
		
		$lsPathClient = $this->_sClientPath;
		
		$this->createDir($lsPathClient);
		
		if (file_exists($lsPathClient))
		{
			$lsFileLicense = $this->getLicense($this->_sClientFolder);
			
			$lsPathConfig = $lsPathClient . DS . 'config';			
			$this->createDir($lsPathConfig);
			$this->saveFile($lsPathConfig, 'acl');
			$this->saveFile($lsPathConfig, 'backend');
			$this->saveFile($lsPathConfig, 'cache');
			$this->saveFile($lsPathConfig, 'client.global');
			$this->saveFile($lsPathConfig, 'db');
			$this->saveFile($lsPathConfig, 'form');
			$this->saveFile($lsPathConfig, 'frontend');
			$this->saveFile($lsPathConfig, 'hooks');
			$this->saveFile($lsPathConfig, 'layout');
			$this->saveFile($lsPathConfig, 'log');
			$this->saveFile($lsPathConfig, 'mail');
			$this->saveFile($lsPathConfig, 'menu');
			$this->saveFile($lsPathConfig, 'modules');
			$this->saveFile($lsPathConfig, 'plugins');
			$this->saveFile($lsPathConfig, 'service');
			$this->saveFile($lsPathConfig, 'status');
			$this->saveFile($lsPathConfig, 'table');

			$lsPathData = $lsPathClient . DS . 'data';
			$this->createDir($lsPathData, true, 0777);
			$lsPathDataCache = $lsPathData . DS . 'cache';
			$this->createDir($lsPathDataCache, true, 0777);
			$lsPathDataLogs = $lsPathData . DS . 'logs';
			$this->createDir($lsPathDataLogs, true, 0777);
			$lsPathDataTemp = $lsPathData . DS . 'temp';
			$this->createDir($lsPathDataTemp, true, 0777);
			$lsPathDataUploads = $lsPathData . DS . 'uploads';
			$this->createDir($lsPathDataUploads, true, 0777);
				
			$lsPathLayout = $lsPathClient . DS . 'layout';
			$this->createDir($lsPathLayout);
			$lsPathLayoutTheme = $lsPathLayout . DS . 'theme';
			$this->createDir($lsPathLayoutTheme);
			$lsPathLayoutTemplate = $lsPathLayout . DS . 'template';
			$this->createDir($lsPathLayoutTemplate);
				
			$lsPathPublic = $lsPathClient . DS . 'public';
			$this->createDir($lsPathPublic, false);
			$this->saveFile($lsPathPublic, 'index', $lsFileLicense);
			$this->saveFile($lsPathPublic, 'htaccess');
			$this->saveFile($lsPathPublic, 'robots', null, 'txt');
			$this->saveFile($lsPathPublic, 'sitemap', null, 'xml');
			
			$lsPathPublicCss = $lsPathPublic . DS . 'css';
			$this->createDir($lsPathPublicCss);
			$lsPathPublicFonts = $lsPathPublic . DS . 'fonts';
			$this->createDir($lsPathPublicFonts);
			$lsPathPublicImg = $lsPathPublic . DS . 'img';
			$this->createDir($lsPathPublicImg);
			$lsPathPublicJs = $lsPathPublic . DS . 'js';
			$this->createDir($lsPathPublicJs);
			
			$lsPathModule = $lsPathClient . DS . 'module';
			$this->createDir($lsPathModule);
		}
		
		$this->newModuleAction("Backend");
		
		$this->newModuleAction("Frontend");
		
		$this->setModuleName($this->getRequestArg('module'));
		
		if ($this->_sModuleName != null && $this->_sModuleName != "Frontend")
		{
			$this->_sAction = "newModule";
			$this->newModuleAction();
		}
		
		if (System::confirm("Configure onioncms database?"))
		{
			$this->_sAction = "installDb";
			$this->installDbAction();
		}
		
		if (System::confirm("Configure Apache 2 virtual host for dev environment? (You need to have root access!)"))
		{
			$this->_sAction = "virtualHostDev";
			$this->virtualHostDevAction();
		}
		else
		{
			$this->showVHostConfAction();
		}
	}
	
	
	/**
	 * 
	 * @param string $psModuleName
	 */
	public function newModuleAction ($psModuleName = null)
	{
		if ($psModuleName == null)
		{
			$this->setClientFolder($this->getRequestArg('folder', "onionapp.com"));
			$this->setModuleName($this->getRequestArg('module', null, true));
		}
		else 
		{
			$this->setModuleName($psModuleName);
		}	
		
		if ($this->_sModuleName == null)
		{
			System::echoError("The param module is required! Please, use --help for further information.");
			return;
		}
		
		$lsPathClient = $this->_sClientPath;
		$lsPathModules = $lsPathClient . DS . 'module';
		$lsPathConfig = $lsPathClient . DS . 'config';
		
		if (file_exists($lsPathModules))
		{
			$lsPathModule = $lsPathModules . DS . $this->_sModuleName;
			$this->createDir($lsPathModule);
			
			if (file_exists($lsPathModule))
			{
				$lsFileLicense = $this->getLicense($this->_sModuleName);
				
				$this->saveFile($lsPathModule, 'Module', $lsFileLicense);
				
				$lsPathModuleConfig = $lsPathModule . DS . 'config';
				$this->createDir($lsPathModuleConfig);	
				
				if ($this->_sModuleName == "Backend")
				{
				    $this->saveFile($lsPathModuleConfig, 'dashboard.config', $lsFileLicense);
				}
				elseif ($this->_sModuleName == "Frontend")
				{
				    $this->saveFile($lsPathModuleConfig, 'site.config', $lsFileLicense);
				}
				else
				{
				    $this->saveFile($lsPathModuleConfig, 'module.config', $lsFileLicense);
				}
				
				$lsModuleRoute = String::slugfy($this->_sModuleName);
				
				$lsPathView = $lsPathModule . DS . 'view';
				$this->createDir($lsPathView);
				$lsPathViewModule = $lsPathView . DS . $lsModuleRoute;
				$this->createDir($lsPathViewModule);
				$lsPathViewController = $lsPathViewModule . DS . $lsModuleRoute;
				$this->createDir($lsPathViewController);
				
				$this->saveFile($lsPathViewController, 'message', $lsFileLicense, 'phtml');
				
				if ($this->_sModuleName == "Backend")
				{
				    $this->saveFile($lsPathViewController, 'dashboard', $lsFileLicense, 'phtml');
				}
				elseif ($this->_sModuleName == "Frontend")
				{
				    $this->saveFile($lsPathViewController, 'site', $lsFileLicense, 'phtml');
				}
				else
				{
				    $this->saveFile($lsPathViewController, 'actionIndex', $lsFileLicense);
				    $this->saveFile($lsPathViewController, 'add', $lsFileLicense, 'phtml');
    				$this->saveFile($lsPathViewController, 'edit', $lsFileLicense, 'phtml');
    				$this->saveFile($lsPathViewController, 'trash', $lsFileLicense, 'phtml');
    				$this->saveFile($lsPathViewController, 'view', $lsFileLicense, 'phtml');
				}
				
				$lsPathSrc = $lsPathModule . DS . 'src';
				$this->createDir($lsPathSrc);
										
				if (file_exists($lsPathSrc))
				{
					$lsPathSrcModule = $lsPathSrc . DS . $this->_sModuleName;
					$this->createDir($lsPathSrcModule);

					if (file_exists($lsPathSrcModule))
					{
						$lsPathController = $lsPathSrcModule . DS . 'Controller';
						$this->createDir($lsPathController);
						
						if ($this->_sModuleName == "Backend")
				        {
				            $this->saveFile($lsPathController, '_Dashboard', $lsFileLicense);
				        }
				        elseif ($this->_sModuleName == "Frontend")
				        {
				            $this->saveFile($lsPathController, '_Site', $lsFileLicense);
				        }
				        else
				        {
						    $this->saveFile($lsPathController, '_Controller', $lsFileLicense);
				        }

				        if ($this->_sModuleName != "Backend" && $this->_sModuleName != "Frontend")
						{
    						$lsPathEntity = $lsPathSrcModule . DS . 'Entity';
    						$this->createDir($lsPathEntity);
    						$this->saveFile($lsPathEntity, 'Entity', $lsFileLicense);
    						$this->saveFile($lsPathEntity, '_Basic', $lsFileLicense);
    						$this->saveFile($lsPathEntity, '_Extended', $lsFileLicense);
    						$this->saveFile($lsPathEntity, '_Repository', $lsFileLicense);
    						
    						$lsPathForm = $lsPathSrcModule . DS . 'Form';
    						$this->createDir($lsPathForm);
    						$this->saveFile($lsPathForm, '_Form', $lsFileLicense);
    						
    						//$lsPathGrid = $lsPathSrcModule . DS . 'Grid';
    						//$this->createDir($lsPathGrid);
    						//$this->saveFile($lsPathGrid, 'Grid', $lsFileLicense);

							$this->setModuleAutoload($lsPathConfig);
						}
					}
				}
			}
		}
		else
		{
			System::echoError("Client folder do not exist! You need to create a new client first. Please, use --help for further information.");
		}
	}
	
	
	/**
	 * 
	 */
	public function layoutGitAction ()
	{
		$lsDependency = System::localRequest(BASE_DIR . DS . "layout" . DS . "layout.json");
		$laDependency = json_decode($lsDependency, true);
		Debug::debug($laDependency);
		
		if (isset($laDependency['require']) && is_array($laDependency['require']))
		{
			System::createDir($this->_sLayoutVendor);
			
			foreach ($laDependency['require'] as $lsPackage => $lsRelease)
			{
				$laPackage = explode("/", $lsPackage);
				$lsPackageDir = $this->_sLayoutVendor . DS . $laPackage[0];
				$lsPackageReleaseDir = $lsPackageDir . DS . $laPackage[1] . "-" . preg_replace("/[^0-9\.]/", "", $lsRelease);
				System::createDir($lsPackageDir);
				
				if (is_dir($lsPackageDir) && !is_dir($lsPackageReleaseDir))
				{
					chdir($lsPackageDir);
					
					echo("Getting https://github.com/{$lsPackage}/archive/{$lsRelease}.tar.gz\n");
					System::execute("wget https://github.com/{$lsPackage}/archive/{$lsRelease}.tar.gz");
					
					$lsGzFile = $lsRelease . ".tar.gz";
					$lsGzFilePath = $lsPackageDir . DS . $lsGzFile;
					
					if (is_file($lsGzFilePath))
					{
						System::execute("tar -xzf {$lsGzFile}");
						System::removeFile($lsGzFile);

						$this->clearDir ($lsPackageReleaseDir);
					}
				}
			}
		}
	}
	
	
	/**
	 * 
	 */
	public function clearDir ($psPackageReleaseDir)
	{
		chdir($psPackageReleaseDir);
		
		if (is_dir($psPackageReleaseDir . DS . "dist"))
		{
			$loDir = dir($psPackageReleaseDir);
				
			while (false !== ($lsResource = $loDir->read()))
			{
				Debug::debug($lsResource);
		
				if ($lsResource != 'dist' && $lsResource != 'lang' && $lsResource != '.' && $lsResource != '..')
				{
					if (is_dir($loDir->path . DS . $lsResource))
					{
						System::removeDir($loDir->path . DS . $lsResource);
					}
					else
					{
						System::removeFile($loDir->path . DS . $lsResource);
					}
				}
			}
				
			$loDir->close();
		}
		else
		{
			$loDir = dir($psPackageReleaseDir);
		
			$lsDependency = System::localRequest(BASE_DIR . DS . "layout" . DS . "layout.json");
			$laDependency = json_decode($lsDependency, true);
			Debug::debug($laDependency);
			
			if (isset($laDependency['ignore']))
			{
				$laPatern = $laDependency['ignore'];
			}
			else 
			{	
				$laPatern = array(
					"^dev",
					"^src",
					"^build",
					"^external",
					"^test",
					"^log",
					"^error",
					"^task",
					"^extra",
					"^script",
					"^meteor",
					"^template",
					"^sample",
					"^example",
					"^demo",
					"^doc",
					"\.json$",
					"\.md$",
					"\.txt$",
					"\.rb$",
					"\.yml$",
					"\.xml$",
					"\.html$",
					"\.htm$",
					"\.sh$",
					"gruntfile.js",
					"^\."
				);
			}
							
			while (false !== ($lsResource = $loDir->read()))
			{
				Debug::debug($lsResource);
					
				if ($lsResource != 'dist' && $lsResource != 'lang' && $lsResource != '.' && $lsResource != '..')
				{
					foreach ($laPatern as $lsPatern)
					{
						if (preg_match("/$lsPatern/i", $lsResource))
						{
							if (is_dir($loDir->path . DS . $lsResource))
							{
								System::removeDir($loDir->path . DS . $lsResource);
							}
							else
							{
								System::removeFile($loDir->path . DS . $lsResource);
							}
						}
					}
				}
			}
		
			$loDir->close();
		}		
	}
	
	
	/**
	 *
	 */
	public function layoutDistAction ()
	{
		$lsDependency = System::localRequest(BASE_DIR . DS . "layout" . DS . "layout.json");
		$laDependency = json_decode($lsDependency, true);
		Debug::debug($laDependency);
	
		if (isset($laDependency['dist']) && is_array($laDependency['dist']))
		{
			System::createDir($this->_sLayoutVendor);
				
			foreach ($laDependency['dist'] as $lsPackage => $lsDist)
			{
				$laPackage = explode("/", $lsPackage);
				$lsPackageDir = $this->_sLayoutVendor . DS . $laPackage[0];
				System::createDir($lsPackageDir);
	
				if (is_dir($lsPackageDir))
				{
					chdir($lsPackageDir);
						
					echo("Getting {$lsDist}\n");
					System::execute("wget {$lsDist}");

					$laDist = parse_url($lsDist);
					$laPath = explode("/", $laDist['path']);
						
					$lsGzFile = $laPath[count($laPath) - 1];
					$lsGzFilePath = $lsPackageDir . DS . $lsGzFile;
						
					if (is_file($lsGzFilePath))
					{
						if (preg_match("/.zip$/", $lsGzFile))
						{
							System::execute("unzip {$lsGzFile}");
						}
						elseif (preg_match("/.tar.gz$/", $lsGzFile))
						{
							System::execute("tar -xzf {$lsGzFile}");
						}
						
						System::removeFile($lsGzFile);
					}
				}
			}
		}
	}
	
	
	/**
	 *
	 */
	public function installDbAction ()
	{
		$this->setClientFolder($this->getRequestArg('folder', null, true));
		
		$lsDbPath = 'config' . DS . 'db.php';
		$laDbClientConf = require($this->_sClientPath . DS . $lsDbPath);
		
		$lsDbDriver = $this->getRequestArg('driver', $laDbClientConf['production']['driver']);
		$lsDbCharset = $this->getRequestArg('charset', $laDbClientConf['production']['charset']);
		$lsDbHost = $this->getRequestArg('host', $laDbClientConf['production']['hostname']);
		$lsDbPort = $this->getRequestArg('port', $laDbClientConf['production']['port']);
		$lsDbUser = $this->getRequestArg('user', $laDbClientConf['production']['username']);
		$lsDbPass = $this->getRequestArg('pass', $laDbClientConf['production']['password']);
		$lsDbName = $this->getRequestArg('dbname', $laDbClientConf['production']['database'], true);
		
		$laDbConf = array(
		    'driver' => $lsDbDriver,
		    'charset' => $lsDbCharset,
			'hostname' => $lsDbHost,
			'port' => $lsDbPort,
			'username' => $lsDbUser,
			'password' => $lsDbPass,
		);
		
		$this->_aRepository['newDb'] = new InstallRepository($laDbConf);
		
		if ($this->_aRepository['newDb']->connect())
		{
			if (!$this->_aRepository['newDb']->checkDb($lsDbName))
			{
				if (System::confirm("The database [{$lsDbName}] does not exists! Create a new database useing dbname [{$lsDbName}]?"))
				{
					if ($this->_aRepository['newDb']->createDb($lsDbName))
					{
						$laDbConf['database'] = $lsDbName;
					}
					else
					{
						System::echoError($this->_aRepository['newDb']->getErrorMsg());
						return;
					}
				}
				else 
				{
					System::echoWarning("You need a database to continue. Aborting proccess!");
					return;
				}
			}
			elseif (System::confirm("The database [{$lsDbName}] already exists! Confirm use this database?"))
			{
				$laDbConf['database'] = $lsDbName;
			}
			else
			{
				System::echoWarning("You need a database to continue. Aborting proccess!");
				return;
			}
		}
		else 
		{
			System::echoError($this->_aRepository['newDb']->getErrorMsg());
			return;
		}
		
		echo("Select a database type:\n");
		echo("[1] onion-base (default)\n");
		echo("[2] onion-full\n");
		echo("[3] onion-parking\n");
		echo("[4] onion-service\n");
		echo("[5] onion-telmsg\n");
		
		$lsAnswer = System::prompt("Option:");
		
		switch ($lsAnswer)
		{
			case "2":
				$lsDbFile = "onion-full.sql";
				break;
			case "3":
				$lsDbFile = "onion-parking.sql";
				break;
			case "4":
				$lsDbFile = "onion-service.sql";
				break;
			case "5":
				$lsDbFile = "onion-telmsg.sql";
				break;
			default:
				$lsDbFile = "onion-base.sql";
		}
		
		$lsDbBase = System::localRequest($this->_sDbPath . DS . $lsDbFile);
		
		$this->_aRepository['newDb']->setDbConf($laDbConf);
		
		if (!$this->_aRepository['newDb']->importDb($lsDbBase))
		{
			System::echoError($this->_aRepository['newDb']->getErrorMsg());
		}
		else
		{
			System::echoSuccess("Success in configure database!");				
		}	
		
		$this->confDbAction($laDbConf);
	}
	
	
	/**
	 * 
	 */
	public function createTableBaseAction ()
	{
	    $this->setClientFolder($this->getRequestArg('folder', null, true));
		
		$lsDbPath = 'config' . DS . 'db.php';
		$laDbClientConf = require($this->_sClientPath . DS . $lsDbPath);
		
		$lsDbDriver = $this->getRequestArg('driver', $laDbClientConf['production']['driver']);
		$lsDbCharset = $this->getRequestArg('charset', $laDbClientConf['production']['charset']);		
		$lsDbHost = $this->getRequestArg('host', $laDbClientConf['production']['hostname']);
		$lsDbPort = $this->getRequestArg('port', $laDbClientConf['production']['port']);
		$lsDbUser = $this->getRequestArg('user', $laDbClientConf['production']['username']);
		$lsDbPass = $this->getRequestArg('pass', $laDbClientConf['production']['password']);
		$lsDbName = $this->getRequestArg('dbname', $laDbClientConf['production']['database'], true);
		
		$laDbConf = array(
		    'driver' => $lsDbDriver,
		    'charset' => $lsDbCharset,		        
			'hostname' => $lsDbHost,
			'port' => $lsDbPort,
			'username' => $lsDbUser,
			'password' => $lsDbPass,
		    'database' => $lsDbName,
		);
		
		$this->_aRepository['Db'] = new InstallRepository($laDbConf);
		
		if ($this->_aRepository['Db']->connect())
		{
		    $lsTableName = $this->getRequestArg('table', null, true);
		    
			if ($this->_aRepository['Db']->createTableBase($lsTableName))
			{
			    System::echoSuccess('Successful on create table base!');
			}
			else 
			{
			    System::echoError($this->_aRepository['Db']->getErrorMsg());
			}
		}
		else
		{
		    System::echoError($this->_aRepository['Db']->getErrorMsg());
		}
	}

	
	/**
	 * 
	 */
	public function createUserDbAction ()
	{
		$lsDbDriver = $this->getRequestArg('driver', 'PDOMySql');
		$lsDbCharset = $this->getRequestArg('charset', 'UTF8');	    
		$lsDbHost = $this->getRequestArg('host', 'localhost');
		$lsDbUser = $this->getRequestArg('user', null, true);
		$lsDbPass = $this->getRequestArg('pass', null, true);
		$lsDbName = $this->getRequestArg('dbname', null, true);
		$lsDbTable = $this->getRequestArg('table', '*');
		
		$laDbConf = array(
		    'driver' => $lsDbDriver,
		    'charset' => $lsDbCharset,		        
			'hostname' => '',
			'port' => '',
			'username' => '',
			'password' => '',
		    'database' => '',
		);		
		
		$this->_aRepository['Db'] = new InstallRepository($laDbConf);
		    
		$lsScript = $this->_aRepository['Db']->createUser($lsDbHost, $lsDbUser, $lsDbPass, $lsDbName, $lsDbTable);

		Debug::display($lsScript);
	}
	
	
	/**
	 * 
	 */
	public function confDbAction (array $paDbConf = null)
	{
		$this->setClientFolder($this->getRequestArg('folder', null, true));
		
		$lsDbPath = $this->_sClientPath . DS . 'config' . DS . 'db.php';
		$laDbClientConf = require($lsDbPath);

		if ($paDbConf == null)
		{
		    $lsDbDriver = $this->getRequestArg('driver', $laDbClientConf['production']['driver']);
		    $lsDbCharset = $this->getRequestArg('charset', $laDbClientConf['production']['charset']);			    
			$lsDbHost = $this->getRequestArg('host', $laDbClientConf['production']['hostname']);
			$lsDbPort = $this->getRequestArg('port', $laDbClientConf['production']['port']);
			$lsDbUser = $this->getRequestArg('user', $laDbClientConf['production']['username']);
			$lsDbPass = $this->getRequestArg('pass', $laDbClientConf['production']['password']);
			$lsDbName = $this->getRequestArg('dbname', $laDbClientConf['production']['database'], true);
			
			$paDbConf = array(
		        'driver' => $lsDbDriver,
		        'charset' => $lsDbCharset,	
				'hostname' => $lsDbHost,
				'port' => $lsDbPort,
				'username' => $lsDbUser,
				'password' => $lsDbPass,
				'database' => $lsDbName
			);
		}
				
		$laDbClientConf['production']['driver'] = $paDbConf['driver'];
		$laDbClientConf['production']['charset'] = $paDbConf['charset'];
		$laDbClientConf['production']['hostname'] = $paDbConf['hostname'];
		$laDbClientConf['production']['port'] = $paDbConf['port'];
		$laDbClientConf['production']['username'] = $paDbConf['username'];
		$laDbClientConf['production']['password'] = $paDbConf['password'];
		$laDbClientConf['production']['database'] = $paDbConf['database'];
		
		$laDbClientConf['development']['driver'] = $paDbConf['driver'];
		$laDbClientConf['development']['charset'] = $paDbConf['charset'];		
		$laDbClientConf['development']['hostname'] = $paDbConf['hostname'];
		$laDbClientConf['development']['port'] = $paDbConf['port'];
		$laDbClientConf['development']['username'] = $paDbConf['username'];
		$laDbClientConf['development']['password'] = $paDbConf['password'];
		$laDbClientConf['development']['database'] = $paDbConf['database'];
		
		$lsFileContent = System::arrayToFile($laDbClientConf);
		
		System::saveFile($lsDbPath, $lsFileContent);
	}
	
    
	/**
	 * 
	 */
	public function setFormAction ()
	{
		$this->setClientFolder($this->getRequestArg('folder', null, true));
		$this->setModuleName($this->getRequestArg('module', null, true));
		
		$lsDbPath = 'config' . DS . 'db.php';
		$laDbClientConf = require($this->_sClientPath . DS . $lsDbPath);
		
		$lsDbDriver = $this->getRequestArg('driver', $laDbClientConf['production']['driver']);
		$lsDbCharset = $this->getRequestArg('charset', $laDbClientConf['production']['charset']);		
		$lsDbHost = $this->getRequestArg('host', $laDbClientConf['production']['hostname']);
		$lsDbPort = $this->getRequestArg('port', $laDbClientConf['production']['port']);
		$lsDbUser = $this->getRequestArg('user', $laDbClientConf['production']['username']);
		$lsDbPass = $this->getRequestArg('pass', $laDbClientConf['production']['password']);
		$lsDbName = $this->getRequestArg('dbname', $laDbClientConf['production']['database'], true);
		
		$laDbConf = array(
		    'driver' => $lsDbDriver,
		    'charset' => $lsDbCharset,		        
			'hostname' => $lsDbHost,
			'port' => $lsDbPort,
			'username' => $lsDbUser,
			'password' => $lsDbPass,
		    'database' => $lsDbName,
		);
		
		$this->_aRepository['Db'] = new InstallRepository($laDbConf);
		
		if ($this->_aRepository['Db']->connect())
		{
		    $lsTableName = $this->getRequestArg('table', $this->_sModuleName, true);
		    
		    $laTable = $this->_aRepository['Db']->descEntity($lsTableName);

			if (is_array($laTable))
			{
			    $lsField = "";
                $lsFieldSet = "";
                
			    foreach ($laTable as $laField)
			    {
			        if ($laField['Field'] != 'id')
			        {
    			        $lsRequired = 'false';
    			        
    			        if ($laField['Null'] == 'NO')
    			        {
    			            $lsRequired = 'true';
    			        }
    			        
					    $lsFieldSet .= "'{$laField['Field']}',\n\t\t\t\t\t";
    			        		        
    			        $lsField .= "\$this->add(array(\n";
    			        $lsField .= "\t\t\t'name' => '{$laField['Field']}',\n";
    			        $lsField .= "\t\t\t'attributes' => array(\n";
    			        $lsField .= "\t\t\t\t'id' => '{$laField['Field']}',\n";
    			        $lsField .= "\t\t\t\t'type' => 'text',\n";
    			        $lsField .= "\t\t\t\t'title' => Translator::i18n(''),\n";
    			        $lsField .= "\t\t\t\t'class' => 'form-control',\n";
    			        $lsField .= "\t\t\t\t'required' => {$lsRequired},\n";
    			        $lsField .= "\t\t\t\t'placeholder' => Translator::i18n(''),\n";
    			        $lsField .= "\t\t\t\t'data-mask' => '',\n";
    			        $lsField .= "\t\t\t\t'data-mastalt' => '',\n";
    			        $lsField .= "\t\t\t\t'pattern' => '',\n";
    			        $lsField .= "\t\t\t),\n";
    			        $lsField .= "\t\t\t'options' => array(\n";
    			        $lsField .= "\t\t\t\t'label' => Translator::i18n('{$laField['Field']}') . ': ',\n";
    			        $lsField .= "\t\t\t\t'for' => '{$laField['Field']}',\n";
    			        $lsField .= "\t\t\t\t'length' => 6,\n";
    			        $lsField .= "\t\t\t)\n";
    			        $lsField .= "\t\t));\n\n\n\t\t";
			        }
			    }
			    
		        $lsPathSrcModule = $this->_sClientPath . DS . 'module' . DS . $this->_sModuleName . DS . 'src' . DS . $this->_sModuleName;			    
    		    $lsPathForm = $lsPathSrcModule . DS . 'Form' . DS . "{$this->_sModuleName}Form.php";
                $lsFileContent = System::localRequest($lsPathForm);
			
		        Util::parse($lsFileContent, "#%FIELDS%#", $lsField);
		        Util::parse($lsFileContent, "#%FIELDSET%#", $lsFieldSet);
		        System::saveFile($lsPathForm, $lsFileContent);
			}
			else 
			{
			    System::echoError($this->_aRepository['Db']->getErrorMsg());
			}
		}
		else 
		{
		    System::echoError($this->_aRepository['Db']->getErrorMsg());
		}
	}

	
	/**
	 * 
	 */
	public function setEntityAction ()
	{
		$this->setClientFolder($this->getRequestArg('folder', null, true));
		$this->setModuleName($this->getRequestArg('module', null, true));
		
		$lsDbPath = 'config' . DS . 'db.php';
		$laDbClientConf = require($this->_sClientPath . DS . $lsDbPath);
		
		$lsDbDriver = $this->getRequestArg('driver', $laDbClientConf['production']['driver']);
		$lsDbCharset = $this->getRequestArg('charset', $laDbClientConf['production']['charset']);		
		$lsDbHost = $this->getRequestArg('host', $laDbClientConf['production']['hostname']);
		$lsDbPort = $this->getRequestArg('port', $laDbClientConf['production']['port']);
		$lsDbUser = $this->getRequestArg('user', $laDbClientConf['production']['username']);
		$lsDbPass = $this->getRequestArg('pass', $laDbClientConf['production']['password']);
		$lsDbName = $this->getRequestArg('dbname', $laDbClientConf['production']['database'], true);
		
		$laDbConf = array(
		    'driver' => $lsDbDriver,
		    'charset' => $lsDbCharset,		        
			'hostname' => $lsDbHost,
			'port' => $lsDbPort,
			'username' => $lsDbUser,
			'password' => $lsDbPass,
		    'database' => $lsDbName,
		);
		
		$this->_aRepository['Db'] = new InstallRepository($laDbConf);
		
		if ($this->_aRepository['Db']->connect())
		{
		    $lsTableName = $this->getRequestArg('table', $this->_sModuleName, true);
		    
		    $laTable = $this->_aRepository['Db']->descEntity($lsTableName);

			if (is_array($laTable))
			{
			    $lsField = "";
			    
			    foreach ($laTable as $laField)
			    {
			        $lsF = $laField['Field'];
			        
			        if ($lsF != 'id' && $lsF != 'User_id' && $lsF != 'dtInsert' && $lsF != 'dtUpdate' && $lsF != 'numStatus' && $lsF != 'isActive')
			        {
    			        $lsDefault = "";
    			        $lsDefaultType = 'string';
    			        $lsPri = "";
    			        $lsAuto = "";
    			        $lsNull = '* @ORM\Column(nullable=true)';
    			        
    			        if ($laField['Key'] == 'PRI')
    			        {
    			            $lsPri = "\t" . '* @ORM\Id' . "\n";
    			        }
    			        
    			    	if ($laField['Extra'] == 'auto_increment')
    			        {
    			            $lsAuto = "\t" . '* @ORM\GeneratedValue(strategy="AUTO")' . "\n";
    			        }
    			        
    			        if ($laField['Null'] == 'NO')
    			        {
    			            $lsNull = '* @ORM\Column(nullable=false)';
    			        }
    			        
    			        $laType = explode("(", $laField['Type']);
    			        $lsType = $laType[0];
    			        
    			    	switch ($lsType)
    			        {
    			            case 'int':
    			            case 'tinyint':
    			            case 'smallint':
    			            case 'mediumint':
    			            case 'bigint':
    			                 $lsFieldType = '* @ORM\Column(type="integer")';
    			                 $lsDefaultType = 'int';
    			                 break;
    			            case 'text':
    			            case 'tinytext':
    			            case 'mediumtext':
    			            case 'longtext':
    			            case 'blob':
    			            case 'tinyblob':
    			            case 'mediumblob':
    			            case 'longblob':
    			                 $lsFieldType = '* @ORM\Column(type="text")';
    			                 break;
    			            case 'date':
    			            case 'time':			                 
    			            case 'timestamp':
    			            case 'datetime':
    			                 $lsFieldType = '* @ORM\Column(type="datetime")';
    			                 break;
    			            case 'decimal':
    			            case 'float':
    			            case 'double':
    			            case 'real':
    			                 $lsFieldType = '* @ORM\Column(type="decimal")';
    			                 $lsDefaultType = 'decimal';
    			                 break;
    			            case 'boolean':
    			                 $lsFieldType = '* @ORM\Column(type="boolean")';
    			                 break;
    			            default:
    			                 $lsFieldType = '* @ORM\Column(type="string")';
    			        }	
    			        
			            if ($laField['Default'] == '0' || !empty($laField['Default']))
    			        {   
    			            if ($lsDefaultType == 'string')
    			            {
    			                $lsDefault = " = '{$laField['Default']}'";
    			            }
    			            else
    			            {
    			                $lsDefault = " = {$laField['Default']}";
    			            }
    			        }    			        
    			        
    			        $lsField .= "\t/**\n{$lsPri}{$lsAuto}\t{$lsFieldType}\n\t{$lsNull}\n\t*/\n\tprotected \${$laField['Field']}{$lsDefault};\n\n";
			        }
			    }
			    
		        $lsPathSrcModule = $this->_sClientPath . DS . 'module' . DS . $this->_sModuleName . DS . 'src' . DS . $this->_sModuleName;			    
    		    $lsPathEntity = $lsPathSrcModule . DS . 'Entity' . DS . "{$lsTableName}.php";
                $lsFileContent = System::localRequest($lsPathEntity);
			
			    if ($lsFileContent == false)
                {
                    $lsFileContent = System::localRequest($this->_sModelPath . DS . "Entity.model");
                    $lsFileLicense = $this->getLicense($this->_sModuleName);
        			Util::parse($lsFileContent, "#%LICENSE%#", $lsFileLicense);
        			Util::parse($lsFileContent, "#%MODULE%#", $this->_sModuleName);
        			Util::parse($lsFileContent, "#%TABLE%#", $lsTableName);
                }
                
		        Util::parse($lsFileContent, "#%FIELDS%#", $lsField);
		        System::saveFile($lsPathEntity, $lsFileContent);
			}
			else 
			{
			    System::echoError($this->_aRepository['Db']->getErrorMsg());
			}
		}
		else 
		{
		    System::echoError($this->_aRepository['Db']->getErrorMsg());
		}
	}
	
	
	public function getModuleDefaultAction ()
	{
	
	}
	
	
	public function confAclAction ()
	{
	
	}
	
	
	public function confBackendAction ()
	{
	
	}
	
	
	public function confCacheAction ()
	{
	
	}
	
	
	public function confClientAction ()
	{
	
	}
	
	public function confFrontendAction ()
	{
	
	}
	
	
	public function confLogAction ()
	{
	
	}
	
	
	public function confMailAction ()
	{
	
	}
	
	
	public function confMenuAction ()
	{
	
	}
}