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

class SrvController extends ToolAbstract
{
	
	/**
	 */
	public function init ()
	{
        $this->checkCli();
	    
		$this->_sModelPath = dirname($this->_sControllerPath) . DS . 'Model' . DS . 'srv';
	}


	/**
	 * 
	 */
	public function srvAction ()
	{
		$this->help(true);
	}
	
	
	/**
	 * 
	 */
	public function tool2BinAction ()
	{
		$lsOrigem = BIN_DIR . DS . "srvtool.php";
		$lsLink = BASE_DIR . DS . "bin" . DS . "srvtool";
		System::simblink($lsOrigem, $lsLink);
	}
	
	
	/**
	 * 
	 */
	public function newClientAction ()
	{
		$this->setClientFolder($this->getRequestArg('folder', "onionapp.com"));
		$this->setModuleName($this->getRequestArg('service', "index"));
		
		$lsPathClient = $this->_sClientPath;
		
		$this->createDir($lsPathClient);
		
		if (file_exists($lsPathClient))
		{
			$lsFileLicense = $this->getLicense($this->_sClientFolder);
			
			$this->saveFile($lsPathClient, 'onionsrv', $lsFileLicense);
			
			$lsPathConfig = $lsPathClient . DS . 'config';			
			$this->createDir($lsPathConfig);
			$this->saveFile($lsPathConfig, 'srv-config');
			$this->saveFile($lsPathConfig, 'srv-module');
			$this->saveFile($lsPathConfig, 'srv-service');
			$this->saveFile($lsPathConfig, 'srv-validate');
			
			$lsPathData = $lsPathClient . DS . 'data';
			$this->createDir($lsPathData, true, 0777);
			$lsPathDataLogs = $lsPathData . DS . 'logs';
			$this->createDir($lsPathDataLogs, true, 0777);
			
			$lsPathLayout = $lsPathClient . DS . 'layout';
			$this->createDir($lsPathLayout);
			$lsPathLayoutTheme = $lsPathLayout . DS . 'theme';
			$this->createDir($lsPathLayoutTheme);
			$lsPathLayoutTemplate = $lsPathLayout . DS . 'template';
			$this->createDir($lsPathLayoutTemplate);
			
			$lsPathPublic = $lsPathClient . DS . 'srv-public';			
			$this->createDir($lsPathPublic, false);
			$this->saveFile($lsPathPublic, 'index', $lsFileLicense);
			$this->saveFile($lsPathPublic, 'htaccess');
			$this->saveFile($lsPathPublic, 'robots');
			$this->saveFile($lsPathPublic, 'sitemap');
			
			$lsPathPublicCss = $lsPathPublic . DS . 'css';
			$this->createDir($lsPathPublicCss);
			$lsPathPublicFonts = $lsPathPublic . DS . 'fonts';
			$this->createDir($lsPathPublicFonts);
			$lsPathPublicImg = $lsPathPublic . DS . 'img';
			$this->createDir($lsPathPublicImg);
			$lsPathPublicJs = $lsPathPublic . DS . 'js';
			$this->createDir($lsPathPublicJs);
			
			$lsPathService = $lsPathClient . DS . 'service';
			$this->createDir($lsPathService);
		}
		
		if ($this->_sModuleName == null)
		{
			$this->setModuleName("Index");
		}
		
		$this->newServiceAction();
		
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
	 */
	public function newServiceAction ()
	{
		$this->setClientFolder($this->getRequestArg('folder', "onionapp.com"));
		$this->setModuleName($this->getRequestArg('service', null, true));
		
		if ($this->_sModuleName == null)
		{
			System::echoError("The param service is required! Please, use --help for further information.");
			return;
		}
		
		$lsPathClient = $this->_sClientPath;
		$lsPathService = $lsPathClient . DS . 'service';
		$lsPathConfig = $lsPathClient . DS . 'config';
		
		if (file_exists($lsPathService))
		{
			$lsPathModule = $lsPathService . DS . $this->_sModuleName;
			$this->createDir($lsPathModule);
			
			if (file_exists($lsPathModule))
			{
				$lsFileLicense = $this->getLicense($this->_sModuleName);
				
				$lsPathModuleConfig = $lsPathModule . DS . 'config';
				$this->createDir($lsPathModuleConfig);	
				$this->saveFile($lsPathModuleConfig, 'help');

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
						$this->saveFile($lsPathController, '_Controller', $lsFileLicense);

						$lsPathEntity = $lsPathSrcModule . DS . 'Entity';
						$this->createDir($lsPathEntity);
						$this->saveFile($lsPathEntity, 'Entity', $lsFileLicense);
						
						$lsPathRepository = $lsPathSrcModule . DS . 'Repository';
						$this->createDir($lsPathRepository);
						$this->saveFile($lsPathRepository, '_Repository', $lsFileLicense);
						
						$lsPathView = $lsPathSrcModule . DS . 'View';
						$this->createDir($lsPathView);
						
						$lsPathViewController = $lsPathView . DS . $this->_sModuleName;
						$this->createDir($lsPathViewController);
						
						$this->setSrvModuleAutoload($lsPathConfig);
					}
				}
			}
		}
		else 
		{
			System::exitError("Client folder do not exist! You need to create a new client first. Please, use --help for further information.");
		}
	}
	
	
	/**
	 * 
	 */
	public function setEntityAction ()
	{
		$this->setClientFolder($this->getRequestArg('folder', null, true));
		$this->setModuleName($this->getRequestArg('service', null, true));
		
		$lsDbPath = 'config' . DS . 'srv-service.php';
		$laDbClientConf = require($this->_sClientPath . DS . $lsDbPath);
		
		$lsDbHost = $this->getRequestArg('host', $laDbClientConf['db']['host']);
		$lsDbPort = $this->getRequestArg('port', $laDbClientConf['db']['port']);
		$lsDbUser = $this->getRequestArg('user', $laDbClientConf['db']['user']);
		$lsDbPass = $this->getRequestArg('pass', $laDbClientConf['db']['pass']);
		$lsDbName = $this->getRequestArg('dbname', $laDbClientConf['db']['db'], true);
		
		$laDbConf = array(
			'host' => $lsDbHost,
			'port' => $lsDbPort,
			'user' => $lsDbUser,
			'pass' => $lsDbPass,
		    'db' => $lsDbName,
		);
		
		$this->_aRepository['Db'] = new InstallRepository($laDbConf);
		
		if ($this->_aRepository['Db']->connect())
		{
		    $lsTableName = $this->getRequestArg('table', $this->_sModuleName, true);
		    
		    $laTable = $this->_aRepository['Db']->getTableDesc($lsTableName);

			if (is_array($laTable))
			{
			    $lsField = "";
			    $lsData = "";
			    
			    foreach ($laTable as $laField)
			    {
			        $lsF = $laField['Field'];
			        
			        if ($lsF != 'id' && $lsF != 'User_id' && $lsF != 'dtInsert' && $lsF != 'dtUpdate' && $lsF != 'numStatus' && $lsF != 'isActive')
			        {
    			        $lsDefault = "";
    			        $lsPri = "";
    			        
    			    	if ($laField['Default'] == '0' || !empty($laField['Default']))
    			        {
    			            $lsDefault = " = {$laField['Default']}";
    			        }
    			        
    			        if ($laField['Key'] == 'PRI')
    			        {
    			            $lsPri = " PK";
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
    			                 $lsFieldType = '* @var integer';
    			                 break;
    			            case 'text':
    			            case 'tinytext':
    			            case 'mediumtext':
    			            case 'longtext':
    			            case 'blob':
    			            case 'tinyblob':
    			            case 'mediumblob':
    			            case 'longblob':
    			                $lsFieldType = '* @var text';
    			                 break;
    			            case 'date':
    			            case 'time':			                 
    			            case 'timestamp':
    			            case 'datetime':
    			                 $lsFieldType = '* @var datetime';
    			                 break;
    			            case 'decimal':
    			            case 'float':
    			            case 'double':
    			            case 'real':
    			                 $lsFieldType = '* @var decimal';
    			                 break;
    			            case 'boolean':
    			                 $lsFieldType = '* @var boolean';
    			                 break;
    			            default:
    			                 $lsFieldType = '* @var string';
    			        }	
    			        
    			        $lsField .= "\t/**\n\t{$lsFieldType}{$lsPri}\n\t*/\n\tprotected \${$laField['Field']}{$lsDefault};\n\n";
			        }
			    }
			    
		        $lsPathSrcModule = $this->_sClientPath . DS . 'service' . DS . $this->_sModuleName . DS . 'src' . DS . $this->_sModuleName;			    
    		    $lsPathEntity = $lsPathSrcModule . DS . 'Entity' . DS . "{$lsTableName}.php";
                $lsFileContent = System::localRequest($lsPathEntity);
			
                if ($lsFileContent == false)
                {
                    $lsFileContent = System::localRequest($this->_sModelPath . DS . "Entity.model");
                    $lsFileLicense = $this->getLicense($this->_sModuleName);
        			Util::parse($lsFileContent, "#%LICENSE%#", $psFileLicense);
        			Util::parse($lsFileContent, "#%MODULE%#", $this->_sModuleName);
                }
                
		        Util::parse($lsFileContent, "#%FIELDS%#", $lsField);
		        System::saveFile($lsPathEntity, $lsFileContent);
			}
		}	    
	}	
}