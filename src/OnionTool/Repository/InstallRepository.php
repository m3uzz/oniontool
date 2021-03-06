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
 
namespace OnionTool\Repository;
use OnionSrv\Abstracts\AbstractRepository;
use OnionSrv\Debug;

class InstallRepository extends AbstractRepository
{
	/**
	 * 
	 * @param string $psDbName
	 * @return array|boolean
	 */
	public function checkDb ($psDbName)
	{
		$lsSql = "USE {$psDbName}";
		
		if (!$this->execute($lsSql))
		{
			return false;
		}
		
		return true;
	}
	
	
	/**
	 * 
	 * @param string $psDbName
	 * @return array|boolean
	 */
	public function createDb ($psDbName)
	{
		$lsSql = "CREATE DATABASE {$psDbName}";
		
		return $this->create($lsSql);
	}
	
	
	/**
	 * 
	 * @param string $psDbName
	 * @return array|boolean
	 */
	public function dropDb ($psDbName)
	{
		$lsSql = "DROP DATABASE {$psDbName}";
		
		return $this->execute($lsSql);
	}
	
	
	/**
	 *
	 * @param string $psDbTables
	 * @return array|boolean
	 */
	public function importDb ($psDbTables)
	{
		return $this->execute($psDbTables);
	}
	
	
	/**
	 * 
	 * @param string $psTableName
	 * @return array|boolean
	 */
	public function createTableBase ($psTableName)
	{
	    $lsSql = "CREATE TABLE IF NOT EXISTS `{$psTableName}` (
                    `id` int(10) unsigned NOT NULL,
                    `User_id` int(10) unsigned NOT NULL,
                    `dtInsert` timestamp NULL DEFAULT NULL,
                    `dtUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                    `numStatus` tinyint(4) unsigned DEFAULT '0',
                    `isActive` enum('0','1') DEFAULT '0'
                  ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

                  ALTER TABLE `{$psTableName}` ADD PRIMARY KEY (`id`);";
	    
	    return $this->create($lsSql);
	}
	
	
	/**
	 * 
	 * @param string $psHost
	 * @param string $psUser
	 * @param string $psPass
	 * @param string $psDb
	 * @param string $psTable
	 * @return string
	 */
	public function createUser ($psHost, $psUser, $psPass, $psDb, $psTable)
	{
	    if (empty($psTable))
	    {
	        $psTable = '*';
	    }
	    
	    if (empty($psHost))
	    {
	        $psHost = '%';
	    }
	    
	    $lsSql = "GRANT SELECT, INSERT, UPDATE, DELETE, FILE, INDEX ON {$psDb}.{$psTable} TO '{$psUser}'@'{$psHost}' IDENTIFIED BY '{$psPass}';";
		
		return $lsSql;
	}

	/**
	 * 
	 * @param array $paConf
	 * @return bool
	 */	
	public function connect (array $paConf = null)
	{
	    return $this->_oConnection->connect($paConf);
	}
}
