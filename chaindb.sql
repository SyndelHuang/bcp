-- MySQL dump 10.13  Distrib 5.5.47, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: chinadb
-- ------------------------------------------------------
-- Server version	5.5.47-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `addr_balance`
--

DROP TABLE IF EXISTS `addr_balance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `addr_balance` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `addr` char(34) DEFAULT NULL COMMENT '地址',
  `balance` decimal(65,0) DEFAULT NULL COMMENT '余额',
  `updateHeight` int(10) unsigned DEFAULT NULL COMMENT '更新高度',
  `updateTime` int(10) unsigned DEFAULT NULL COMMENT '更新时间',
  `num_tx` int(10) unsigned DEFAULT NULL COMMENT '交易次数',
  `amount_input` decimal(65,0) DEFAULT NULL COMMENT '转入总额',
  PRIMARY KEY (`id`),
  KEY `address` (`addr`)
) ENGINE=MyISAM AUTO_INCREMENT=11614 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `addr_tx`
--

DROP TABLE IF EXISTS `addr_tx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `addr_tx` (
  `addrid` int(10) unsigned NOT NULL COMMENT 'addr_balance表的id',
  `tid` int(10) unsigned NOT NULL COMMENT 'tx表的id',
  `io_balance` decimal(65,0) NOT NULL COMMENT '该地址在该交易中的值总和',
  KEY `addrid` (`addrid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='用于根据地址查找交易';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `block`
--

DROP TABLE IF EXISTS `block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block` (
  `height` int(10) unsigned DEFAULT NULL,
  `size` int(10) unsigned DEFAULT NULL,
  `version` int(10) unsigned DEFAULT NULL,
  `merkleroot` char(64) DEFAULT NULL,
  `mint` decimal(65,8) DEFAULT NULL,
  `time` int(10) unsigned DEFAULT NULL,
  `nonce` int(10) unsigned DEFAULT NULL,
  `bits` varchar(45) DEFAULT NULL,
  `difficulty` double(65,8) DEFAULT NULL,
  `flags` varchar(45) DEFAULT NULL,
  `proofhash` char(64) DEFAULT NULL,
  `entropybit` int(10) unsigned DEFAULT NULL,
  `modifier` varchar(45) DEFAULT NULL,
  `num_tx` int(10) unsigned DEFAULT NULL COMMENT '交易条数',
  `output_amount` decimal(65,0) DEFAULT NULL COMMENT '总转出额',
  `hash` char(64) DEFAULT NULL COMMENT '区块哈希',
  `previousblockhash` char(64) DEFAULT NULL COMMENT '上一区块哈希',
  `nextblockhash` char(64) DEFAULT NULL COMMENT '下一区块哈希',
  KEY `height` (`height`),
  KEY `hash` (`hash`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `info`
--

DROP TABLE IF EXISTS `info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `blocks` bigint(20) DEFAULT '-1',
  `top_refresh_time` int(11) NOT NULL DEFAULT '0',
  `weekly_refresh_time` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `top`
--

DROP TABLE IF EXISTS `top`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `top` (
  `balance` decimal(65,0) NOT NULL DEFAULT '0',
  `addrid` int(10) unsigned NOT NULL DEFAULT '0',
  `rank` int(10) unsigned DEFAULT NULL COMMENT '排名',
  `ranktime` int(10) unsigned DEFAULT NULL,
  `rankper` int(10) unsigned DEFAULT NULL,
  KEY `balance-addrid` (`balance`,`addrid`) USING BTREE,
  KEY `addrid` (`addrid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='余额排行表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `top_weekly`
--

DROP TABLE IF EXISTS `top_weekly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `top_weekly` (
  `week` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created` int(10) unsigned NOT NULL,
  `total` decimal(65,0) NOT NULL,
  PRIMARY KEY (`week`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COMMENT='每周统计一次余额前100名的地址的余额总和';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tx`
--

DROP TABLE IF EXISTS `tx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tx` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `txid` char(64) DEFAULT NULL,
  `height` int(10) unsigned DEFAULT NULL,
  `version` int(10) unsigned DEFAULT NULL,
  `txtime` int(10) unsigned DEFAULT NULL,
  `locktime` int(10) unsigned DEFAULT NULL,
  `fee` decimal(65,0) DEFAULT NULL,
  `output_amount` double(65,0) DEFAULT NULL,
  `coinbase` varchar(100) DEFAULT NULL COMMENT '旷工留言奖励型交易',
  PRIMARY KEY (`id`),
  KEY `txid` (`txid`),
  KEY `height` (`height`)
) ENGINE=MyISAM AUTO_INCREMENT=76956 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tx_vout`
--

DROP TABLE IF EXISTS `tx_vout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tx_vout` (
  `tid` int(10) unsigned NOT NULL COMMENT 'tx表的id',
  `n` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '本交易的第几个输出',
  `address` char(34) DEFAULT NULL,
  `value` decimal(65,0) DEFAULT NULL COMMENT '输入的金额，单位聪',
  `spentbytid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '被哪个交易花费掉',
  KEY `tid-n` (`tid`,`n`) USING BTREE,
  KEY `spentbytid` (`spentbytid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-04-16 23:27:33
