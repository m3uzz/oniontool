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
use OnionTool\Controller\ToolAbstract;
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
		$this->_sModelPath = dirname($this->_sControllerPath) . DS . 'Model' . DS . 'srv';
		
		$this->setClientFolder($this->getRequest('folder', "onionapp.com"));
		$this->setModuleName($this->getRequest('module'));
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
	public function newClientAction ()
	{
		$lsPathClient = CLIENT_DIR . DS . strtolower($this->_sClientFolder);
		
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
			$this->createDir($lsPathData, 0777);
			$lsPathDataLogs = $lsPathData . DS . 'logs';
			$this->createDir($lsPathDataLogs, 0777);
			
			$lsPathLayout = $lsPathClient . DS . 'layout';
			$this->createDir($lsPathLayout);
			$lsPathLayoutTheme = $lsPathLayout . DS . 'theme';
			$this->createDir($lsPathLayoutTheme);
			$lsPathLayoutTemplate = $lsPathLayout . DS . 'template';
			$this->createDir($lsPathLayoutTemplate);
			
			$lsPathPublic = $lsPathClient . DS . 'srv-public';			
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
			
			$lsPathService = $lsPathClient . DS . 'service';
			$this->createDir($lsPathService);
		}
		
		if ($this->_sModuleName == null)
		{
			$this->setModuleName("SrvApp");
		}
		
		$this->newModuleAction();
	}
	
	
	/**
	 * 
	 */
	public function newServiceAction ()
	{
		if ($this->_sModuleName == null)
		{
			Debug::exitError("The param module is required! Please, use --help for further information.");
		}
		
		$lsPathClient = CLIENT_DIR . DS . strtolower($this->_sClientFolder);
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
			Debug::exitError("Client folder do not exist! You need to create a new client first. Please, use --help for further information.");
		}
	}
}