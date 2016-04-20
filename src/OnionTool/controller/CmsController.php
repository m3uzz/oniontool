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

include_once ("ToolAbstract.php");

class CmsController extends ToolAbstract
{
	
	/**
	 */
	public function init ()
	{
		$this->_sConfigPath = CONFIG_DIR;
		$this->_sModelPath = dirname($this->_sControllerPath) . DS . 'model' . DS . 'cms';
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
	public function newClientAction ()
	{
		$lsClient = $this->getRequest('client', "onionapp.com");
		$lsModule = $this->getRequest('module');
		
		$lsPathClient = CLIENT_DIR . DS . strtolower($lsClient);
		
		$this->createDir($lsPathClient);
		
		if (file_exists($lsPathClient))
		{
			$lsFileLicense = $this->getLicense($lsClient);
			
			$lsPathConfig = $lsPathClient . DS . 'config';			
			$this->createDir($lsPathConfig);
			$this->saveFile($lsPathConfig, 'acl', $lsFileLicense);
			$this->saveFile($lsPathConfig, 'backend', $lsFileLicense);
			$this->saveFile($lsPathConfig, 'cache', $lsFileLicense);
			$this->saveFile($lsPathConfig, 'client.global', $lsFileLicense);
			$this->saveFile($lsPathConfig, 'db', $lsFileLicense);
			$this->saveFile($lsPathConfig, 'form', $lsFileLicense);
			$this->saveFile($lsPathConfig, 'frontend', $lsFileLicense);
			$this->saveFile($lsPathConfig, 'hooks', $lsFileLicense);
			$this->saveFile($lsPathConfig, 'layout', $lsFileLicense);
			$this->saveFile($lsPathConfig, 'log', $lsFileLicense);
			$this->saveFile($lsPathConfig, 'mail', $lsFileLicense);
			$this->saveFile($lsPathConfig, 'menu', $lsFileLicense);
			$this->saveFile($lsPathConfig, 'modules', $lsFileLicense);
			$this->saveFile($lsPathConfig, 'plugins', $lsFileLicense);
			$this->saveFile($lsPathConfig, 'service', $lsFileLicense);
			$this->saveFile($lsPathConfig, 'status', $lsFileLicense);
			$this->saveFile($lsPathConfig, 'table', $lsFileLicense);

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
				
			$lsPathModule = $lsPathClient . DS . 'module';
			$this->createDir($lsPathModule);
				
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
		}
		
		if ($lsModule == null)
		{
			$this->newModuleAction();
		}
	}
	
	
	/**
	 * 
	 */
	public function newModuleAction ()
	{
		$lsClient = $this->getRequest('client', "onionapp.com");
		$lsModule = $this->getRequest('module', "OnionApp");
		$lsModule = ucfirst($lsModule);
		
		$lsPathClient = CLIENT_DIR . DS . strtolower($lsClient);
		$lsPathService = $lsPathClient . DS . 'service';
		$lsPathConfig = $lsPathClient . DS . 'config';
		
		if (file_exists($lsPathService))
		{
			$lsPathModule = $lsPathService . DS . $lsModule;
			$this->createDir($lsPathModule);
			
			if (file_exists($lsPathModule))
			{
				$lsFileLicense = $this->getLicense($lsModule);
				
				$lsPathModuleConfig = $lsPathModule . DS . 'config';
				$this->createDir($lsPathModuleConfig);	
				$this->saveFile($lsPathModuleConfig, 'help', $lsFileLicense, $lsModule);
					
				$lsPathSrc = $lsPathModule . DS . 'src';
				$this->createDir($lsPathSrc);
										
				if (file_exists($lsPathSrc))
				{
					$lsPathSrcModule = $lsPathSrc . DS . $lsModule;
					$this->createDir($lsPathSrcModule);

					if (file_exists($lsPathSrcModule))
					{
						$lsPathController = $lsPathSrcModule . DS . 'Controller';
						$this->createDir($lsPathController);
						$this->saveFile($lsPathController, 'Controller', $lsFileLicense, $lsModule);

						$lsPathEntity = $lsPathSrcModule . DS . 'Entity';
						$this->createDir($lsPathEntity);
						$this->saveFile($lsPathEntity, 'Entity', $lsFileLicense, $lsModule);
						
						$lsPathRepository = $lsPathSrcModule . DS . 'Repository';
						$this->createDir($lsPathRepository);
						$this->saveFile($lsPathRepository, 'Repository', $lsFileLicense, $lsModule);
						
						$lsPathView = $lsPathSrcModule . DS . 'View';
						$this->createDir($lsPathView);
						
						$this->setModuleAutoload($lsPathConfig, $lsModule, $lsClient);
					}
				}
			}
		}
	}
}