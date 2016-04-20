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
use OnionLib\String;
use OnionLib\Util;

abstract class ToolAbstract extends AbstractController
{

	protected $_sModelPath;
	
	
	/**
	 *
	 * @param string $psPath
	 * @param int $pnChmod
	 * @param string $pnChown
	 * @param string $pnChown
	 */
	public function createDir ($psPath, $pnChmod = null, $psChown = null, $psChgrp = null)
	{
		System::createDir($psPath, $pnChmod, $psChown, $psChgrp);
		$lsFileContent = System::localRequest($this->_sModelPath . DS . "deny.model");
		Debug::debug($lsFileContent);
		$lsFilePath = $psPath . DS . '.htaccess';
		Debug::debug($lsFilePath);
		System::saveFile($lsFilePath, $lsFileContent);
	}
	
	
	/**
	 * 
	 * @param string $psPathConfig
	 * @param string $psModule
	 * @param string $psClient
	 */
	public function setModuleAutoload ($psPathConfig, $psModule, $psClient)
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
			
			$lsFileLicense = $this->getLicense($psClient);
			$laModuleLoader[$psModule] = "//array(CLIENT_DIR . DS . 'service' . DS . '{$psModule}' . DS . 'src')";
			$lsFileContent = "<?php\n{$lsFileLicense}\nreturn array(\n" . System::arrayToString($laModuleLoader) . ");";

			System::saveFile($lsSrvModulePath, $lsFileContent);
		}
	}
	

	/**
	 * 
	 */
	public function getLicense ($psPackage)
	{
		$lsName = $this->getRequest('name', "Humberto Lourenço");
		$lsEmail = $this->getRequest('email', "betto@m3uzz.com");
		$lsLink = $this->getRequest('link', "http://github.com/m3uzz/onionsrv");
		$lsCopyrightIni = $this->getRequest('cini', "2014");
		
		$lsLicensePath = $this->_sModelPath . DS . 'LICENSE.model';
		$lsFileLicense = System::localRequest($lsLicensePath);
		
		Util::parse($lsFileLicense, "#%PACKAGE%#", $psPackage);
		Util::parse($lsFileLicense, "#%AUTHOR%#", $lsName);
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
	 * @param string $psModule
	 */
	public function saveFile ($psPath, $psFile, $psFileLicense = "", $psModule = "")
	{
		$lsFileName = "{$psModule}{$psFile}.php";
		
		if ($psFile == 'htaccess')
		{
			$lsFileName = ".{$psFile}";
		}
		elseif ($psFile == 'Entity')
		{
			$lsFileName = "{$psModule}.php";
		}
		elseif ($psFile == 'help')
		{
			$lsFileName = "help.php";
		}
		
		$lsFilePath = $psPath . DS . $lsFileName;

		if (!file_exists($lsFilePath))
		{
			$lsFileContent = System::localRequest($this->_sModelPath . DS . "{$psFile}.model");
			
			Util::parse($lsFileContent, "#%LICENSE%#", $psFileLicense);
			Util::parse($lsFileContent, "#%MODULE%#", $psModule);
			Util::parse($lsFileContent, "#%ACTION%#", $this->getActionName($psModule));
			
			System::saveFile($lsFilePath, $lsFileContent);
		}
	}
	
	
	/**
	 * 
	 * @param string $psName
	 * @return string
	 */
	public function getActionName ($psName)
	{
		$lsName = String::slugfy($psName);
		$laName = explode("-", $lsName);
		
		if (is_array($laName))
		{
			$lsName = $laName[0];
			unset($laName[0]);
			
			foreach($laName as $lsValue)
			{
				$lsName .= ucfirst($lsValue);
			}
		}
		
		return $lsName;
	}
}