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
		$this->_sModelPath = dirname($this->_sControllerPath) . DS . 'Model' . DS . 'cms';
		
		$this->setClientFolder($this->getRequest('folder', "onionapp.com"));
		$this->setModuleName($this->getRequest('module'));
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
		$this->setClientDomain($this->getRequest('domain'));
		$this->setClientName($this->getRequest('client'));
		
		$lsPathClient = CLIENT_DIR . DS . strtolower($this->_sClientFolder);
		
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
			$this->createDir($lsPathData, 0777);
			$lsPathDataCache = $lsPathData . DS . 'cache';
			$this->createDir($lsPathDataCache, 0777);
			$lsPathDataLogs = $lsPathData . DS . 'logs';
			$this->createDir($lsPathDataLogs, 0777);
			$lsPathDataTemp = $lsPathData . DS . 'temp';
			$this->createDir($lsPathDataTemp, 0777);
			$lsPathDataUploads = $lsPathData . DS . 'uploads';
			$this->createDir($lsPathDataUploads, 0777);
				
			$lsPathLayout = $lsPathClient . DS . 'layout';
			$this->createDir($lsPathLayout);
			$lsPathLayoutTheme = $lsPathLayout . DS . 'theme';
			$this->createDir($lsPathLayoutTheme);
			$lsPathLayoutTemplate = $lsPathLayout . DS . 'template';
			$this->createDir($lsPathLayoutTemplate);
				
			$lsPathPublic = $lsPathClient . DS . 'public';
			$this->createDir($lsPathPublic);
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
			
			$lsPathModule = $lsPathClient . DS . 'module';
			$this->createDir($lsPathModule);
		}
		
		$this->setModuleName("Backend");
		$this->newModuleAction();
		
		$this->setModuleName("Frontend");
		$this->newModuleAction();
		
		$this->setModuleName($this->getRequest('module'));
		
		if ($this->_sModuleName != null)
		{
			$this->newModuleAction();
		}
	}
	
	
	/**
	 * 
	 */
	public function newModuleAction ()
	{
		if ($this->_sModuleName == null)
		{
			Debug::exitError("The param module is required! Please, use --help for further information.");
		}
		
		$lsPathClient = CLIENT_DIR . DS . strtolower($this->_sClientFolder);
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
				$this->saveFile($lsPathModuleConfig, 'module.config', $lsFileLicense);
					
				$lsModuleRoute = String::slugfy($this->_sModuleName);
				
				$lsPathView = $lsPathModule . DS . 'view';
				$this->createDir($lsPathView);
				$lsPathViewModule = $lsPathView . DS . $lsModuleRoute;
				$this->createDir($lsPathViewModule);
				$lsPathViewController = $lsPathViewModule . DS . $lsModuleRoute;
				$this->createDir($lsPathViewController);
				$this->saveFile($lsPathViewController, 'actionIndex', $lsFileLicense);
				$this->saveFile($lsPathViewController, 'add', $lsFileLicense, 'phtml');
				$this->saveFile($lsPathViewController, 'edit', $lsFileLicense, 'phtml');
				$this->saveFile($lsPathViewController, 'message', $lsFileLicense, 'phtml');
				$this->saveFile($lsPathViewController, 'trash', $lsFileLicense, 'phtml');
				$this->saveFile($lsPathViewController, 'view', $lsFileLicense, 'phtml');
				
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
						$this->saveFile($lsPathEntity, '_Basic', $lsFileLicense);
						$this->saveFile($lsPathEntity, '_Extended', $lsFileLicense);
						$this->saveFile($lsPathEntity, '_Repository', $lsFileLicense);
						
						$lsPathForm = $lsPathSrcModule . DS . 'Form';
						$this->createDir($lsPathForm);
						$this->saveFile($lsPathForm, '_Form', $lsFileLicense);
						
						//$lsPathGrid = $lsPathSrcModule . DS . 'Grid';
						//$this->createDir($lsPathGrid);
						//$this->saveFile($lsPathGrid, 'Grid', $lsFileLicense);
						
						if ($this->_sModuleName != "Backend" && $this->_sModuleName != "Frontend")
						{
							$this->setModuleAutoload($lsPathConfig);
						}
					}
				}
			}
		}
		else
		{
			Debug::exitError("Client folder do not exist! You need to create a new client first. Please, use --help for further information.");
		}
	}
}