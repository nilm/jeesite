/*
 Navicat MySQL Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50630
 Source Host           : localhost
 Source Database       : accountant

 Target Server Type    : MySQL
 Target Server Version : 50630
 File Encoding         : utf-8

 Date: 09/09/2017 15:31:48 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `ACT_EVT_LOG`
-- ----------------------------
DROP TABLE IF EXISTS `ACT_EVT_LOG`;
CREATE TABLE `ACT_EVT_LOG` (
  `LOG_NR_` bigint(20) NOT NULL AUTO_INCREMENT,
  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TIME_STAMP_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DATA_` longblob,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
  `IS_PROCESSED_` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`LOG_NR_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `ACT_GE_BYTEARRAY`
-- ----------------------------
DROP TABLE IF EXISTS `ACT_GE_BYTEARRAY`;
CREATE TABLE `ACT_GE_BYTEARRAY` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BYTES_` longblob,
  `GENERATED_` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_BYTEARR_DEPL` (`DEPLOYMENT_ID_`),
  CONSTRAINT `ACT_FK_BYTEARR_DEPL` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `ACT_RE_DEPLOYMENT` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `ACT_GE_PROPERTY`
-- ----------------------------
DROP TABLE IF EXISTS `ACT_GE_PROPERTY`;
CREATE TABLE `ACT_GE_PROPERTY` (
  `NAME_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `VALUE_` varchar(300) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  PRIMARY KEY (`NAME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Records of `ACT_GE_PROPERTY`
-- ----------------------------
BEGIN;
INSERT INTO `ACT_GE_PROPERTY` VALUES ('next.dbid', '1', '1'), ('schema.history', 'create(5.21.0.0)', '1'), ('schema.version', '5.21.0.0', '1');
COMMIT;

-- ----------------------------
--  Table structure for `ACT_HI_ACTINST`
-- ----------------------------
DROP TABLE IF EXISTS `ACT_HI_ACTINST`;
CREATE TABLE `ACT_HI_ACTINST` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin NOT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CALL_PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ACT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_ACT_INST_START` (`START_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_PROCINST` (`PROC_INST_ID_`,`ACT_ID_`),
  KEY `ACT_IDX_HI_ACT_INST_EXEC` (`EXECUTION_ID_`,`ACT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `ACT_HI_ATTACHMENT`
-- ----------------------------
DROP TABLE IF EXISTS `ACT_HI_ATTACHMENT`;
CREATE TABLE `ACT_HI_ATTACHMENT` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `URL_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CONTENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TIME_` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `ACT_HI_COMMENT`
-- ----------------------------
DROP TABLE IF EXISTS `ACT_HI_COMMENT`;
CREATE TABLE `ACT_HI_COMMENT` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TIME_` datetime(3) NOT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `MESSAGE_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `FULL_MSG_` longblob,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `ACT_HI_DETAIL`
-- ----------------------------
DROP TABLE IF EXISTS `ACT_HI_DETAIL`;
CREATE TABLE `ACT_HI_DETAIL` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TIME_` datetime(3) NOT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_DETAIL_PROC_INST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_ACT_INST` (`ACT_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_TIME` (`TIME_`),
  KEY `ACT_IDX_HI_DETAIL_NAME` (`NAME_`),
  KEY `ACT_IDX_HI_DETAIL_TASK_ID` (`TASK_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `ACT_HI_IDENTITYLINK`
-- ----------------------------
DROP TABLE IF EXISTS `ACT_HI_IDENTITYLINK`;
CREATE TABLE `ACT_HI_IDENTITYLINK` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_USER` (`USER_ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_TASK` (`TASK_ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_PROCINST` (`PROC_INST_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `ACT_HI_PROCINST`
-- ----------------------------
DROP TABLE IF EXISTS `ACT_HI_PROCINST`;
CREATE TABLE `ACT_HI_PROCINST` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `START_USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `END_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `PROC_INST_ID_` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_PRO_INST_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_PRO_I_BUSKEY` (`BUSINESS_KEY_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `ACT_HI_TASKINST`
-- ----------------------------
DROP TABLE IF EXISTS `ACT_HI_TASKINST`;
CREATE TABLE `ACT_HI_TASKINST` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `CLAIM_TIME_` datetime(3) DEFAULT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `DUE_DATE_` datetime(3) DEFAULT NULL,
  `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_TASK_INST_PROCINST` (`PROC_INST_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `ACT_HI_VARINST`
-- ----------------------------
DROP TABLE IF EXISTS `ACT_HI_VARINST`;
CREATE TABLE `ACT_HI_VARINST` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` datetime(3) DEFAULT NULL,
  `LAST_UPDATED_TIME_` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_PROCVAR_PROC_INST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_PROCVAR_NAME_TYPE` (`NAME_`,`VAR_TYPE_`),
  KEY `ACT_IDX_HI_PROCVAR_TASK_ID` (`TASK_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `ACT_ID_GROUP`
-- ----------------------------
DROP TABLE IF EXISTS `ACT_ID_GROUP`;
CREATE TABLE `ACT_ID_GROUP` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `ACT_ID_INFO`
-- ----------------------------
DROP TABLE IF EXISTS `ACT_ID_INFO`;
CREATE TABLE `ACT_ID_INFO` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `VALUE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PASSWORD_` longblob,
  `PARENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `ACT_ID_MEMBERSHIP`
-- ----------------------------
DROP TABLE IF EXISTS `ACT_ID_MEMBERSHIP`;
CREATE TABLE `ACT_ID_MEMBERSHIP` (
  `USER_ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `GROUP_ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`USER_ID_`,`GROUP_ID_`),
  KEY `ACT_FK_MEMB_GROUP` (`GROUP_ID_`),
  CONSTRAINT `ACT_FK_MEMB_GROUP` FOREIGN KEY (`GROUP_ID_`) REFERENCES `ACT_ID_GROUP` (`ID_`),
  CONSTRAINT `ACT_FK_MEMB_USER` FOREIGN KEY (`USER_ID_`) REFERENCES `ACT_ID_USER` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `ACT_ID_USER`
-- ----------------------------
DROP TABLE IF EXISTS `ACT_ID_USER`;
CREATE TABLE `ACT_ID_USER` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `FIRST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LAST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EMAIL_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PWD_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PICTURE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `ACT_PROCDEF_INFO`
-- ----------------------------
DROP TABLE IF EXISTS `ACT_PROCDEF_INFO`;
CREATE TABLE `ACT_PROCDEF_INFO` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `INFO_JSON_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_INFO_PROCDEF` (`PROC_DEF_ID_`),
  KEY `ACT_IDX_INFO_PROCDEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_INFO_JSON_BA` (`INFO_JSON_ID_`),
  CONSTRAINT `ACT_FK_INFO_JSON_BA` FOREIGN KEY (`INFO_JSON_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`),
  CONSTRAINT `ACT_FK_INFO_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `ACT_RE_DEPLOYMENT`
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RE_DEPLOYMENT`;
CREATE TABLE `ACT_RE_DEPLOYMENT` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `DEPLOY_TIME_` timestamp(3) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `ACT_RE_MODEL`
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RE_MODEL`;
CREATE TABLE `ACT_RE_MODEL` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LAST_UPDATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `VERSION_` int(11) DEFAULT NULL,
  `META_INFO_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_EXTRA_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_MODEL_SOURCE` (`EDITOR_SOURCE_VALUE_ID_`),
  KEY `ACT_FK_MODEL_SOURCE_EXTRA` (`EDITOR_SOURCE_EXTRA_VALUE_ID_`),
  KEY `ACT_FK_MODEL_DEPLOYMENT` (`DEPLOYMENT_ID_`),
  CONSTRAINT `ACT_FK_MODEL_DEPLOYMENT` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `ACT_RE_DEPLOYMENT` (`ID_`),
  CONSTRAINT `ACT_FK_MODEL_SOURCE` FOREIGN KEY (`EDITOR_SOURCE_VALUE_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`),
  CONSTRAINT `ACT_FK_MODEL_SOURCE_EXTRA` FOREIGN KEY (`EDITOR_SOURCE_EXTRA_VALUE_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `ACT_RE_PROCDEF`
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RE_PROCDEF`;
CREATE TABLE `ACT_RE_PROCDEF` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VERSION_` int(11) NOT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DGRM_RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `HAS_START_FORM_KEY_` tinyint(4) DEFAULT NULL,
  `HAS_GRAPHICAL_NOTATION_` tinyint(4) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_PROCDEF` (`KEY_`,`VERSION_`,`TENANT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `ACT_RU_EVENT_SUBSCR`
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RU_EVENT_SUBSCR`;
CREATE TABLE `ACT_RU_EVENT_SUBSCR` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `EVENT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EVENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTIVITY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CONFIGURATION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATED_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EVENT_SUBSCR_CONFIG_` (`CONFIGURATION_`),
  KEY `ACT_FK_EVENT_EXEC` (`EXECUTION_ID_`),
  CONSTRAINT `ACT_FK_EVENT_EXEC` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `ACT_RU_EXECUTION`
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RU_EXECUTION`;
CREATE TABLE `ACT_RU_EXECUTION` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_EXEC_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `IS_ACTIVE_` tinyint(4) DEFAULT NULL,
  `IS_CONCURRENT_` tinyint(4) DEFAULT NULL,
  `IS_SCOPE_` tinyint(4) DEFAULT NULL,
  `IS_EVENT_SCOPE_` tinyint(4) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `CACHED_ENT_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EXEC_BUSKEY` (`BUSINESS_KEY_`),
  KEY `ACT_FK_EXE_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_EXE_PARENT` (`PARENT_ID_`),
  KEY `ACT_FK_EXE_SUPER` (`SUPER_EXEC_`),
  KEY `ACT_FK_EXE_PROCDEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_EXE_PARENT` FOREIGN KEY (`PARENT_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
  CONSTRAINT `ACT_FK_EXE_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`),
  CONSTRAINT `ACT_FK_EXE_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ACT_FK_EXE_SUPER` FOREIGN KEY (`SUPER_EXEC_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `ACT_RU_IDENTITYLINK`
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RU_IDENTITYLINK`;
CREATE TABLE `ACT_RU_IDENTITYLINK` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_IDENT_LNK_USER` (`USER_ID_`),
  KEY `ACT_IDX_IDENT_LNK_GROUP` (`GROUP_ID_`),
  KEY `ACT_IDX_ATHRZ_PROCEDEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_TSKASS_TASK` (`TASK_ID_`),
  KEY `ACT_FK_IDL_PROCINST` (`PROC_INST_ID_`),
  CONSTRAINT `ACT_FK_ATHRZ_PROCEDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`),
  CONSTRAINT `ACT_FK_IDL_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
  CONSTRAINT `ACT_FK_TSKASS_TASK` FOREIGN KEY (`TASK_ID_`) REFERENCES `ACT_RU_TASK` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `ACT_RU_JOB`
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RU_JOB`;
CREATE TABLE `ACT_RU_JOB` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RETRIES_` int(11) DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_JOB_EXCEPTION` (`EXCEPTION_STACK_ID_`),
  CONSTRAINT `ACT_FK_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `ACT_RU_TASK`
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RU_TASK`;
CREATE TABLE `ACT_RU_TASK` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DELEGATION_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `DUE_DATE_` datetime(3) DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_TASK_CREATE` (`CREATE_TIME_`),
  KEY `ACT_FK_TASK_EXE` (`EXECUTION_ID_`),
  KEY `ACT_FK_TASK_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_TASK_PROCDEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_TASK_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `ACT_RU_VARIABLE`
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RU_VARIABLE`;
CREATE TABLE `ACT_RU_VARIABLE` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_VARIABLE_TASK_ID` (`TASK_ID_`),
  KEY `ACT_FK_VAR_EXE` (`EXECUTION_ID_`),
  KEY `ACT_FK_VAR_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_VAR_BYTEARRAY` (`BYTEARRAY_ID_`),
  CONSTRAINT `ACT_FK_VAR_BYTEARRAY` FOREIGN KEY (`BYTEARRAY_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `OA_TEST_AUDIT`
-- ----------------------------
DROP TABLE IF EXISTS `OA_TEST_AUDIT`;
CREATE TABLE `OA_TEST_AUDIT` (
  `id` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '编号',
  `PROC_INS_ID` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '流程实例ID',
  `USER_ID` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '变动用户',
  `OFFICE_ID` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '归属部门',
  `POST` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '岗位',
  `AGE` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '性别',
  `EDU` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '学历',
  `CONTENT` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '调整原因',
  `OLDA` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '现行标准 薪酬档级',
  `OLDB` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '现行标准 月工资额',
  `OLDC` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '现行标准 年薪总额',
  `NEWA` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '调整后标准 薪酬档级',
  `NEWB` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '调整后标准 月工资额',
  `NEWC` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '调整后标准 年薪总额',
  `ADD_NUM` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '月增资',
  `EXE_DATE` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '执行时间',
  `HR_TEXT` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '人力资源部门意见',
  `LEAD_TEXT` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '分管领导意见',
  `MAIN_LEAD_TEXT` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '集团主要领导意见',
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `OA_TEST_AUDIT_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='审批流程测试表';

-- ----------------------------
--  Table structure for `accountant_biz`
-- ----------------------------
DROP TABLE IF EXISTS `accountant_biz`;
CREATE TABLE `accountant_biz` (
  `id` mediumint(64) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` mediumint(64) DEFAULT NULL COMMENT '用户id',
  `company_id` mediumint(64) DEFAULT NULL COMMENT '公司id',
  `name` varchar(125) NOT NULL COMMENT '业务名称',
  `sort` decimal(10,0) NOT NULL COMMENT '排序',
  `create_date` datetime NOT NULL COMMENT '填写日期',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) NOT NULL COMMENT '删除标示',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='业务类型表';

-- ----------------------------
--  Table structure for `accountant_biz_subject_record`
-- ----------------------------
DROP TABLE IF EXISTS `accountant_biz_subject_record`;
CREATE TABLE `accountant_biz_subject_record` (
  `id` mediumint(64) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` mediumint(64) DEFAULT NULL COMMENT '用户id',
  `company_id` mediumint(64) DEFAULT NULL COMMENT '公司id',
  `biz_id` mediumint(64) DEFAULT NULL COMMENT '业务id',
  `subject_id` mediumint(64) DEFAULT NULL COMMENT '账本id',
  `source_doc_id` mediumint(64) DEFAULT NULL COMMENT '原始凭证id',
  `digest` varchar(255) DEFAULT NULL COMMENT '摘要',
  `amount` decimal(19,2) NOT NULL COMMENT '金额',
  `balance` decimal(19,2) NOT NULL COMMENT '余额',
  `category` varchar(16) DEFAULT NULL COMMENT '账本类型 left right',
  `record_date` datetime NOT NULL COMMENT '记账时间',
  `status` varchar(125) NOT NULL COMMENT '当前状态',
  `audit_user_id` mediumint(64) DEFAULT NULL COMMENT '审核用户id',
  `audit_date` datetime NOT NULL COMMENT '审核日期',
  `create_date` datetime NOT NULL COMMENT '生成日期',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) NOT NULL COMMENT '删除标示',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='账本记录表';

-- ----------------------------
--  Table structure for `accountant_biz_subject_template`
-- ----------------------------
DROP TABLE IF EXISTS `accountant_biz_subject_template`;
CREATE TABLE `accountant_biz_subject_template` (
  `id` mediumint(64) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` mediumint(64) DEFAULT NULL COMMENT '用户id',
  `company_id` mediumint(64) DEFAULT NULL COMMENT '公司id',
  `biz_id` mediumint(64) DEFAULT NULL COMMENT '业务id',
  `subject_id` mediumint(64) DEFAULT NULL COMMENT '账本id',
  `fixed` char(1) DEFAULT NULL COMMENT '定选否',
  `direction` char(1) DEFAULT NULL COMMENT '1增0减 ',
  `category` varchar(16) DEFAULT NULL COMMENT '账本类型 left right',
  `status` varchar(125) NOT NULL COMMENT '当前状态',
  `create_date` datetime NOT NULL COMMENT '生成日期',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) NOT NULL COMMENT '删除标示',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='业务栏目模板表';

-- ----------------------------
--  Table structure for `accountant_source_doc`
-- ----------------------------
DROP TABLE IF EXISTS `accountant_source_doc`;
CREATE TABLE `accountant_source_doc` (
  `id` mediumint(64) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` mediumint(64) DEFAULT NULL COMMENT '用户id',
  `company_id` mediumint(64) DEFAULT NULL COMMENT '公司id',
  `biz_id` mediumint(64) DEFAULT NULL COMMENT '业务id',
  `subject1_id` mediumint(64) DEFAULT NULL COMMENT '一级科目id',
  `subject2_id` mediumint(64) DEFAULT NULL COMMENT '二级科目id',
  `amount` decimal(19,2) NOT NULL COMMENT '金额',
  `account_type` varchar(125) NOT NULL COMMENT '账户类型 现金 存款 应付 应收',
  `digest` varchar(255) DEFAULT NULL COMMENT '摘要',
  `record_date` datetime NOT NULL COMMENT '记账时间',
  `status` varchar(125) NOT NULL COMMENT '当前状态',
  `create_date` datetime NOT NULL COMMENT '填写日期',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) NOT NULL COMMENT '删除标示',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='流水记录表';

-- ----------------------------
--  Table structure for `accountant_subject`
-- ----------------------------
DROP TABLE IF EXISTS `accountant_subject`;
CREATE TABLE `accountant_subject` (
  `id` mediumint(64) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `parent_id` varchar(64) NOT NULL COMMENT '父级主键',
  `parent_ids` varchar(2000) NOT NULL COMMENT '所有父级主键',
  `code` varchar(20) NOT NULL COMMENT '科目编码',
  `sort` decimal(10,0) NOT NULL COMMENT '排序',
  `user_id` mediumint(64) DEFAULT NULL COMMENT '用户id',
  `company_id` mediumint(64) DEFAULT NULL COMMENT '商户id',
  `name` varchar(125) NOT NULL COMMENT '账本名称',
  `category` varchar(125) NOT NULL COMMENT '账本类型left  right',
  `accountant_category` varchar(125) NOT NULL COMMENT '会计分类 费用  资产 负债 收入',
  `assets_category` varchar(125) NOT NULL COMMENT '资产负债表分类',
  `profits_category` varchar(125) NOT NULL COMMENT '利润表分类',
  `version` varchar(125) NOT NULL COMMENT '会计科目版本（标准）',
  `type` varchar(125) NOT NULL COMMENT '账户类型 home家庭记账 company 公司记账',
  `status` varchar(125) NOT NULL COMMENT '当前状态',
  `create_date` datetime NOT NULL COMMENT '创建日期',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) NOT NULL COMMENT '删除标示',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='会计账本（科目）';

-- ----------------------------
--  Table structure for `base_account_alipay`
-- ----------------------------
DROP TABLE IF EXISTS `base_account_alipay`;
CREATE TABLE `base_account_alipay` (
  `id` mediumint(64) NOT NULL AUTO_INCREMENT,
  `user_id` mediumint(64) NOT NULL,
  `owner` varchar(60) NOT NULL,
  `alipay_NO` varchar(128) NOT NULL,
  `del_flag` char(1) NOT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `base_account_banks`
-- ----------------------------
DROP TABLE IF EXISTS `base_account_banks`;
CREATE TABLE `base_account_banks` (
  `id` mediumint(10) NOT NULL AUTO_INCREMENT,
  `user_id` mediumint(64) NOT NULL,
  `bankcard_owner` varchar(60) NOT NULL,
  `bank_name` varchar(50) NOT NULL,
  `bank_branch_name` varchar(500) DEFAULT NULL,
  `bank_NO` varchar(50) NOT NULL,
  `bank_code` varchar(64) NOT NULL,
  `del_flag` char(1) NOT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `create_date` datetime NOT NULL,
  `default_bank` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `base_account_cashout`
-- ----------------------------
DROP TABLE IF EXISTS `base_account_cashout`;
CREATE TABLE `base_account_cashout` (
  `id` mediumint(64) NOT NULL AUTO_INCREMENT,
  `site_id` mediumint(64) DEFAULT NULL COMMENT '站点',
  `company_id` mediumint(64) DEFAULT NULL COMMENT '合作机构',
  `webuser_id` mediumint(64) NOT NULL COMMENT '前台用户',
  `apply_amount` decimal(19,2) NOT NULL COMMENT '提现金额',
  `cashout_fee` decimal(19,2) DEFAULT NULL COMMENT '提现费用',
  `status` varchar(255) NOT NULL COMMENT '状态- 审核中-处理中-提现成功',
  `content` varchar(2000) DEFAULT NULL COMMENT '描述',
  `doing_date` datetime DEFAULT NULL,
  `audit_date` datetime DEFAULT '0000-00-00 00:00:00' COMMENT '审核时间',
  `card_type` varchar(64) NOT NULL COMMENT '提现到账类型 alipay bank',
  `card_id` mediumint(64) NOT NULL COMMENT '支付宝或银行id',
  `user_id` mediumint(64) DEFAULT NULL COMMENT '审核人',
  `apply_ip` varchar(100) NOT NULL COMMENT '申请ip',
  `create_date` datetime NOT NULL,
  `del_flag` char(1) DEFAULT NULL COMMENT '删除标示',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `base_account_funddetail`
-- ----------------------------
DROP TABLE IF EXISTS `base_account_funddetail`;
CREATE TABLE `base_account_funddetail` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `user_id` mediumint(64) NOT NULL,
  `site_id` mediumint(64) DEFAULT NULL,
  `company_id` mediumint(64) DEFAULT NULL,
  `change_type` varchar(255) NOT NULL COMMENT '交易类型',
  `operate` decimal(19,2) NOT NULL COMMENT '变化数',
  `balance` decimal(19,2) NOT NULL COMMENT '余额',
  `frozen_amount` decimal(19,2) NOT NULL DEFAULT '0.00' COMMENT '冻结资金',
  `fund_direction` varchar(255) NOT NULL COMMENT '自己流动方向',
  `change_desc` varchar(255) NOT NULL COMMENT '交易描述',
  `target_type` varchar(120) NOT NULL COMMENT '交易对象类型',
  `target` varchar(255) NOT NULL COMMENT '交易对象',
  `fund_timestamp` bigint(20) NOT NULL COMMENT '时间戳',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `del_flag` char(1) NOT NULL COMMENT '删除标示',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `base_comment`
-- ----------------------------
DROP TABLE IF EXISTS `base_comment`;
CREATE TABLE `base_comment` (
  `id` mediumint(64) NOT NULL COMMENT '主键',
  `user_id` mediumint(64) NOT NULL COMMENT '评论用户',
  `class_name` varchar(128) NOT NULL COMMENT '评论实体',
  `entity_id` mediumint(64) NOT NULL COMMENT '评论实体主键',
  `comment` varchar(255) DEFAULT NULL COMMENT '评论内容',
  `point` varchar(12) DEFAULT NULL COMMENT '评分',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `del_flag` char(1) NOT NULL COMMENT '删除标示',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `base_order`
-- ----------------------------
DROP TABLE IF EXISTS `base_order`;
CREATE TABLE `base_order` (
  `id` mediumint(64) NOT NULL AUTO_INCREMENT COMMENT '订单主键',
  `order_no` varchar(128) DEFAULT NULL COMMENT '订单号',
  `mobile_phone` varchar(64) DEFAULT NULL COMMENT '联系人手机号',
  `product_id` mediumint(64) NOT NULL COMMENT '服务id',
  `webuser_id` mediumint(64) NOT NULL COMMENT '洗车用户',
  `company_id` mediumint(64) NOT NULL COMMENT '洗车店',
  `pay_type` varchar(64) DEFAULT NULL COMMENT '支付类型  余额|在线',
  `pay_channel` varchar(64) DEFAULT NULL COMMENT '支付通道',
  `company_status` varchar(64) DEFAULT NULL COMMENT '商户订单状态',
  `bank_type` varchar(64) DEFAULT NULL COMMENT '付款银行',
  `pay_order_NO` varchar(128) DEFAULT NULL COMMENT '第三方支付订单',
  `company_clear_date` datetime DEFAULT NULL COMMENT '与商户结算时间',
  `amount` decimal(19,2) NOT NULL COMMENT '订单金额',
  `actual_amount` decimal(19,2) NOT NULL COMMENT '支付金额',
  `pay_date` datetime DEFAULT NULL COMMENT '支付时间',
  `type` varchar(64) DEFAULT NULL COMMENT '订单类型 上门|到店',
  `status` varchar(64) DEFAULT NULL COMMENT '订单状态',
  `user_id` mediumint(64) DEFAULT NULL COMMENT '洗车人',
  `create_by` mediumint(64) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` mediumint(9) DEFAULT NULL COMMENT '修改人',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标示',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
  `company_settlelog_id` mediumint(64) DEFAULT '0' COMMENT '结算单据',
  `product_class` varchar(128) DEFAULT NULL COMMENT '订单对应的产品实体类名 先不做考虑了',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=343 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Records of `base_order`
-- ----------------------------
BEGIN;
INSERT INTO `base_order` VALUES ('1', '000000', '13141235300', '1', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '30.00', '30.00', null, '0', null, null, '14', '2015-08-31 09:42:43', '14', '2015-08-31 09:44:18', '0', null, null, ''), ('2', '111111', '13141235300', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '60.00', '60.00', null, '1', null, null, '14', '2015-08-31 18:25:04', '14', '2015-08-31 18:25:09', '0', null, null, ''), ('3', '20151026105723', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '35.00', '2015-10-26 10:57:23', '1', 'paied', null, null, '2015-10-26 10:57:23', null, '2015-10-26 10:57:23', '0', null, '30', ''), ('4', '20151026105855', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '35.00', '2015-10-26 10:58:55', '1', 'paied', null, null, '2015-10-26 10:58:55', null, '2015-10-26 10:58:55', '0', null, '30', ''), ('5', '20151026112719', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '35.00', '2015-10-26 11:27:19', '1', 'paied', null, null, '2015-10-26 11:27:19', null, '2015-10-26 11:27:19', '0', null, '30', ''), ('6', '20151026112853', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '35.00', '2015-10-26 11:28:53', '1', 'paied', null, null, '2015-10-26 11:28:53', null, '2015-10-26 11:28:53', '0', null, '30', ''), ('7', '20151026135105', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '35.00', '2015-10-26 13:51:05', '1', 'paid', null, null, '2015-10-26 13:51:06', null, '2015-10-26 13:51:06', '0', null, '29', ''), ('8', '20151026135500', '13141235307', '2', '14', '1', 'online', null, 'unbalanced', null, null, '2015-11-14 23:17:19', '35.00', '35.00', '2015-10-26 13:55:00', '1', 'paid', null, null, '2015-10-26 13:55:00', null, '2015-10-26 13:55:00', '0', null, '29', ''), ('9', '20151026135510', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '35.00', '2015-10-26 13:55:10', '1', 'paid', null, null, '2015-10-26 13:55:10', null, '2015-10-26 13:55:10', '0', null, '29', ''), ('10', '20151026135922', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '35.00', '2015-10-26 13:59:22', '1', 'paid', null, null, '2015-10-26 13:59:22', null, '2015-10-26 13:59:22', '0', null, '29', ''), ('11', '20151026140934', '13141235307', '2', '14', '1', 'online', null, 'unbalanced', null, null, '2015-11-14 23:17:19', '35.00', '35.00', '2015-10-26 14:09:34', '1', 'paid', null, null, '2015-10-26 14:09:34', null, '2015-10-26 14:09:34', '0', null, '29', ''), ('12', '20151026171455', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-26 17:14:55', '1', 'paid', null, null, '2015-10-26 17:14:55', null, '2015-10-26 17:14:55', '0', null, '29', ''), ('13', '20151026173233', '13141235307', '2', '14', '1', 'online', null, 'unbalanced', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-26 17:32:33', '1', 'paid', null, null, '2015-10-26 17:32:33', null, '2015-10-26 17:32:33', '0', null, '29', ''), ('14', '20151026180934', '13141235307', '2', '14', '1', 'online', null, 'unbalanced', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-26 18:09:34', '1', 'paid', null, null, '2015-10-26 18:09:34', null, '2015-10-26 18:09:34', '0', null, '29', ''), ('15', '20151026181915', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-26 18:19:15', '1', 'paid', null, null, '2015-10-26 18:19:15', null, '2015-10-26 18:19:15', '0', null, '29', ''), ('16', '20151026182303', '13141235307', '2', '14', '1', 'online', null, 'unbalanced', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-26 18:23:03', '1', 'paid', null, null, '2015-10-26 18:23:03', null, '2015-10-26 18:23:03', '0', null, '29', ''), ('17', '20151026182908', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-26 18:29:08', '1', 'paid', null, null, '2015-10-26 18:29:08', null, '2015-10-26 18:29:08', '0', null, '29', ''), ('18', '20151026183405', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-26 18:34:05', '1', 'paid', null, null, '2015-10-26 18:34:06', null, '2015-10-26 18:34:06', '0', null, '29', ''), ('19', '20151026183748', '13141235307', '2', '14', '1', 'online', null, 'unbalanced', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-26 18:37:48', '1', 'paid', null, null, '2015-10-26 18:37:48', null, '2015-10-26 18:37:48', '0', null, '29', ''), ('20', '20151026193225', '15219497261', '2', '15', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-26 19:32:25', '1', 'paid', null, null, '2015-10-26 19:32:25', null, '2015-10-26 19:32:25', '0', null, '29', ''), ('21', '20151026193507', '15219497261', '2', '15', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-26 19:35:07', '1', 'paid', null, null, '2015-10-26 19:35:07', null, '2015-10-26 19:35:07', '0', null, '29', ''), ('22', '20151026193828', '15219497261', '2', '15', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-26 19:38:28', '1', 'paid', null, null, '2015-10-26 19:38:28', null, '2015-10-26 19:38:28', '0', null, '29', ''), ('23', '20151026195223', '15219497261', '2', '15', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-26 19:52:23', '1', 'paid', null, null, '2015-10-26 19:52:23', null, '2015-10-26 19:52:23', '0', null, '29', ''), ('24', '20151026195412', '15219497261', '2', '15', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-26 19:54:12', '1', 'paid', null, null, '2015-10-26 19:54:13', null, '2015-10-26 19:54:13', '0', null, '29', ''), ('25', '20151027153344', '13141235307', '2', '14', '1', 'online', null, 'unbalanced', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-27 15:33:44', '1', 'paid', null, null, '2015-10-27 15:33:44', null, '2015-10-27 15:33:44', '0', null, '29', ''), ('26', '20151027172836', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-27 17:28:36', '1', 'paid', null, null, '2015-10-27 17:28:36', null, '2015-10-27 17:28:36', '0', null, '29', ''), ('27', '20151027173203', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-27 17:32:03', '1', 'paid', null, null, '2015-10-27 17:32:04', null, '2015-10-27 17:32:04', '0', null, '29', ''), ('28', '20151028202732', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-28 20:27:32', '1', 'paid', null, null, '2015-10-28 20:27:32', null, '2015-10-28 20:27:32', '0', null, '29', ''), ('29', '20151028203057', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-28 20:30:57', '1', 'paid', null, null, '2015-10-28 20:30:57', null, '2015-10-28 20:30:57', '0', null, '29', ''), ('30', '20151028203256', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-28 20:32:56', '1', 'paid', null, null, '2015-10-28 20:32:56', null, '2015-10-28 20:32:56', '0', null, '29', ''), ('31', '20151028203609', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-28 20:36:09', '1', 'paid', null, null, '2015-10-28 20:36:10', null, '2015-10-28 20:36:10', '0', null, '29', ''), ('32', '20151028203731', '13141235307', '2', '14', '1', 'online', null, 'unbalanced', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-28 20:37:31', '1', 'paid', null, null, '2015-10-28 20:37:31', null, '2015-10-28 20:37:31', '0', null, '29', ''), ('33', '20151028204101', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-28 20:41:01', '1', 'paid', null, null, '2015-10-28 20:41:01', null, '2015-10-28 20:41:01', '0', null, '29', ''), ('34', '20151028204444', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-28 20:44:44', '1', 'paid', null, null, '2015-10-28 20:44:44', null, '2015-10-28 20:44:44', '0', null, '29', ''), ('35', '20151028205008', '13141235307', '2', '14', '1', 'online', null, 'unbalanced', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-28 20:50:08', '1', 'paid', null, null, '2015-10-28 20:50:08', null, '2015-10-28 20:50:08', '0', null, '29', ''), ('36', '20151028205108', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-28 20:51:08', '1', 'paid', null, null, '2015-10-28 20:51:08', null, '2015-10-28 20:51:08', '0', null, '29', ''), ('37', '20151028205231', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-28 20:52:31', '1', 'paid', null, null, '2015-10-28 20:52:31', null, '2015-10-28 20:52:31', '0', null, '29', ''), ('38', '20151029101305', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 10:13:05', '1', 'paid', null, null, '2015-10-29 10:13:05', null, '2015-10-29 10:13:05', '0', null, '29', ''), ('39', '20151029110825', '15210497261', '2', '13', '1', 'online', null, 'unbalanced', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 11:08:25', '1', 'paid', null, null, '2015-10-29 11:08:25', null, '2015-10-29 11:08:25', '0', null, '29', ''), ('40', '20151029111021', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 11:10:21', '1', 'paid', null, null, '2015-10-29 11:10:21', null, '2015-10-29 11:10:21', '0', null, '29', ''), ('41', '20151029111517', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 11:15:17', '1', 'paid', null, null, '2015-10-29 11:15:17', null, '2015-10-29 11:15:17', '0', null, '29', ''), ('42', '20151029111825', '13141235307', '2', '14', '1', 'online', null, 'unbalanced', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 11:18:25', '1', 'paid', null, null, '2015-10-29 11:18:25', null, '2015-10-29 11:18:25', '0', null, '29', ''), ('43', '20151029111827', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 11:18:27', '1', 'paid', null, null, '2015-10-29 11:18:27', null, '2015-10-29 11:18:27', '0', null, '29', ''), ('44', '20151029113811', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 11:38:11', '1', 'paid', null, null, '2015-10-29 11:38:11', null, '2015-10-29 11:38:11', '0', null, '29', ''), ('45', '20151029134548', '13141235307', '2', '14', '1', 'online', null, 'unbalanced', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 13:45:48', '1', 'paid', null, null, '2015-10-29 13:45:48', null, '2015-10-29 13:45:48', '0', null, '29', ''), ('46', '20151029135316', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 13:53:16', '1', 'paid', null, null, '2015-10-29 13:53:17', null, '2015-10-29 13:53:17', '0', null, '29', ''), ('47', '20151029141808', '13141235307', '2', '14', '1', 'online', null, 'unbalanced', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 14:18:08', '1', 'paid', null, null, '2015-10-29 14:18:08', null, '2015-10-29 14:18:08', '0', null, '29', ''), ('48', '20151029142405', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 14:24:05', '1', 'paid', null, null, '2015-10-29 14:24:05', null, '2015-10-29 14:24:05', '0', null, '29', ''), ('49', '20151029142630', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 14:26:30', '1', 'paid', null, null, '2015-10-29 14:26:30', null, '2015-10-29 14:26:30', '0', null, '29', ''), ('50', '20151029144724', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 14:47:24', '1', 'paid', null, null, '2015-10-29 14:47:24', null, '2015-10-29 14:47:24', '0', null, '29', ''), ('51', '20151029144728', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 14:47:28', '1', 'paid', null, null, '2015-10-29 14:47:28', null, '2015-10-29 14:47:28', '0', null, '29', ''), ('52', '20151029150019', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 15:00:19', '1', 'paid', null, null, '2015-10-29 15:00:19', null, '2015-10-29 15:00:19', '0', null, '29', ''), ('53', '20151029150107', '13141235307', '2', '14', '1', 'online', null, 'unbalanced', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 15:01:07', '1', 'paid', null, null, '2015-10-29 15:01:07', null, '2015-10-29 15:01:07', '0', null, '29', ''), ('54', '20151029150509', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 15:05:09', '1', 'paid', null, null, '2015-10-29 15:05:09', null, '2015-10-29 15:05:09', '0', null, '29', ''), ('55', '20151029150756', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 15:07:56', '1', 'paid', null, null, '2015-10-29 15:07:56', null, '2015-10-29 15:07:56', '0', null, '29', ''), ('56', '20151029150836', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 15:08:36', '1', 'paid', null, null, '2015-10-29 15:08:36', null, '2015-10-29 15:08:36', '0', null, '29', ''), ('57', '20151029165747', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 16:57:47', '1', 'paid', null, null, '2015-10-29 16:57:47', null, '2015-10-29 16:57:47', '0', null, '29', ''), ('58', '20151029170754', '13141235307', '1', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 17:07:54', '1', 'paid', null, null, '2015-10-29 17:07:54', null, '2015-10-29 17:07:54', '0', null, '29', ''), ('59', '20151029170931', '13141235307', '1', '14', '1', 'online', null, 'unbalanced', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 17:09:31', '1', 'paid', null, null, '2015-10-29 17:09:31', null, '2015-10-29 17:09:31', '0', null, '29', ''), ('60', '20151029170954', '13141235307', '1', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 17:09:54', '1', 'paid', null, null, '2015-10-29 17:09:54', null, '2015-10-29 17:09:54', '0', null, '29', ''), ('61', '20151029171531', '13141235307', '1', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 17:15:31', '1', 'paid', null, null, '2015-10-29 17:15:31', null, '2015-10-29 17:15:31', '0', null, '29', ''), ('62', '20151029172154', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 17:21:54', '1', 'paid', null, null, '2015-10-29 17:21:55', null, '2015-10-29 17:21:55', '0', null, '29', ''), ('63', '20151029172305', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 17:23:05', '1', 'paid', null, null, '2015-10-29 17:23:05', null, '2015-10-29 17:23:05', '0', null, '29', ''), ('64', '20151029172307', '13141235307', '2', '14', '1', 'online', null, 'unbalanced', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 17:23:07', '1', 'paid', null, null, '2015-10-29 17:23:07', null, '2015-10-29 17:23:07', '0', null, '29', ''), ('65', '20151029172356', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 17:23:56', '1', 'paid', null, null, '2015-10-29 17:23:56', null, '2015-10-29 17:23:56', '0', null, '29', ''), ('66', '20151029175220', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 17:52:20', '1', 'paid', null, null, '2015-10-29 17:52:20', null, '2015-10-29 17:52:20', '0', null, '29', ''), ('67', '20151029180601', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 18:06:01', '1', 'paid', null, null, '2015-10-29 18:06:01', null, '2015-10-29 18:06:01', '0', null, '29', ''), ('68', '20151029180611', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 18:06:11', '1', 'paid', null, null, '2015-10-29 18:06:11', null, '2015-10-29 18:06:11', '0', null, '29', ''), ('69', '20151029194636', '13141235307', '2', '14', '1', 'online', null, 'unbalanced', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 19:46:36', '1', 'paid', null, null, '2015-10-29 19:46:36', null, '2015-10-29 19:46:36', '0', null, '29', ''), ('70', '20151029194704', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 19:47:04', '1', 'paid', null, null, '2015-10-29 19:47:04', null, '2015-10-29 19:47:04', '0', null, '29', ''), ('71', '20151029194707', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 19:47:07', '1', 'paid', null, null, '2015-10-29 19:47:07', null, '2015-10-29 19:47:07', '0', null, '29', ''), ('72', '20151029194949', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 19:49:49', '1', 'paid', null, null, '2015-10-29 19:49:49', null, '2015-10-29 19:49:49', '0', null, '29', ''), ('73', '20151029195117', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 19:51:17', '1', 'paid', null, null, '2015-10-29 19:51:17', null, '2015-10-29 19:51:17', '0', null, '29', ''), ('74', '20151029195515', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 19:55:15', '1', 'paid', null, null, '2015-10-29 19:55:15', null, '2015-10-29 19:55:15', '0', null, '29', ''), ('75', '20151029195559', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 19:55:59', '1', 'paid', null, null, '2015-10-29 19:55:59', null, '2015-10-29 19:55:59', '0', null, '29', ''), ('76', '20151029195604', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 19:56:04', '1', 'paid', null, null, '2015-10-29 19:56:04', null, '2015-10-29 19:56:04', '0', null, '29', ''), ('77', '20151029195836', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 19:58:36', '1', 'paid', null, null, '2015-10-29 19:58:36', null, '2015-10-29 19:58:36', '0', null, '29', ''), ('78', '20151029200341', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 20:03:41', '1', 'paid', null, null, '2015-10-29 20:03:41', null, '2015-10-29 20:03:41', '0', null, '29', ''), ('79', '20151029200359', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 20:03:59', '1', 'paid', null, null, '2015-10-29 20:03:59', null, '2015-10-29 20:03:59', '0', null, '29', ''), ('80', '20151029200400', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 20:04:00', '1', 'paid', null, null, '2015-10-29 20:04:00', null, '2015-10-29 20:04:00', '0', null, '29', ''), ('81', '20151029200445', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 20:04:45', '1', 'paid', null, null, '2015-10-29 20:04:45', null, '2015-10-29 20:04:45', '0', null, '29', ''), ('82', '20151029200819', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 20:08:19', '1', 'paid', null, null, '2015-10-29 20:08:19', null, '2015-10-29 20:08:19', '0', null, '29', ''), ('83', '20151029200830', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 20:08:30', '1', 'paid', null, null, '2015-10-29 20:08:30', null, '2015-10-29 20:08:30', '0', null, '29', ''), ('84', '20151029201422', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 20:14:22', '1', 'paid', null, null, '2015-10-29 20:14:22', null, '2015-10-29 20:14:22', '0', null, '29', ''), ('85', '20151029201438', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 20:14:38', '1', 'paid', null, null, '2015-10-29 20:14:38', null, '2015-10-29 20:14:38', '0', null, '29', ''), ('86', '20151029201711', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 20:17:11', '1', 'paid', null, null, '2015-10-29 20:17:11', null, '2015-10-29 20:17:11', '0', null, '29', ''), ('87', '20151029201718', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-29 20:17:18', '1', 'paid', null, null, '2015-10-29 20:17:18', null, '2015-10-29 20:17:18', '0', null, '29', ''), ('88', '20151030101022', '13141235307', '2', '14', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-30 10:10:22', '1', 'paid', null, null, '2015-10-30 10:10:22', null, '2015-10-30 10:10:22', '0', null, '29', ''), ('89', '20151030110539', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-30 11:05:39', '1', 'paid', null, null, '2015-10-30 11:05:39', null, '2015-10-30 11:05:39', '0', null, '29', ''), ('90', '20151030110724', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-30 11:07:24', '1', 'paid', null, null, '2015-10-30 11:07:24', null, '2015-10-30 11:07:24', '0', null, '29', ''), ('91', '20151030111238', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-30 11:12:38', '1', 'paid', null, null, '2015-10-30 11:12:38', null, '2015-10-30 11:12:38', '0', null, '29', ''), ('92', '20151030111251', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-30 11:12:51', '1', 'paid', null, null, '2015-10-30 11:12:51', null, '2015-10-30 11:12:51', '0', null, '29', ''), ('93', '20151030111612', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-30 11:16:12', '1', 'paid', null, null, '2015-10-30 11:16:12', null, '2015-10-30 11:16:12', '0', null, '29', ''), ('94', '20151030111621', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-30 11:16:21', '1', 'paid', null, null, '2015-10-30 11:16:21', null, '2015-10-30 11:16:21', '0', null, '29', ''), ('95', '20151030111627', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-30 11:16:27', '1', 'paid', null, null, '2015-10-30 11:16:27', null, '2015-10-30 11:16:27', '0', null, '29', ''), ('96', '20151030111638', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-30 11:16:38', '1', 'paid', null, null, '2015-10-30 11:16:38', null, '2015-10-30 11:16:38', '0', null, '29', ''), ('97', '20151030112602', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-30 11:26:02', '1', 'paid', null, null, '2015-10-30 11:26:02', null, '2015-10-30 11:26:02', '0', null, '29', ''), ('98', '20151030112603', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-30 11:26:03', '1', 'paid', null, null, '2015-10-30 11:26:03', null, '2015-10-30 11:26:03', '0', null, '29', ''), ('99', '20151030112604', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-30 11:26:04', '1', 'paid', null, null, '2015-10-30 11:26:04', null, '2015-10-30 11:26:04', '0', null, '29', ''), ('100', '20151030113407', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-30 11:34:07', '1', 'paid', null, null, '2015-10-30 11:34:07', null, '2015-10-30 11:34:07', '0', null, '29', ''), ('101', '20151030114140', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-30 11:41:40', '1', 'paid', null, null, '2015-10-30 11:41:40', null, '2015-10-30 11:41:40', '0', null, '29', ''), ('102', '20151030114149', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-30 11:41:49', '1', 'paid', null, null, '2015-10-30 11:41:49', null, '2015-10-30 11:41:49', '0', null, '29', ''), ('103', '20151030134741', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-30 13:47:41', '1', 'paid', null, null, '2015-10-30 13:47:41', null, '2015-10-30 13:47:41', '0', null, '29', ''), ('104', '20151030134751', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-30 13:47:51', '1', 'paid', null, null, '2015-10-30 13:47:51', null, '2015-10-30 13:47:51', '0', null, '29', ''), ('105', '20151030134817', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-30 13:48:17', '1', 'paid', null, null, '2015-10-30 13:48:17', null, '2015-10-30 13:48:17', '0', null, '29', ''), ('106', '20151030134819', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-30 13:48:19', '1', 'paid', null, null, '2015-10-30 13:48:19', null, '2015-10-30 13:48:19', '0', null, '29', ''), ('107', '20151030135221', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-30 13:52:21', '1', 'paid', null, null, '2015-10-30 13:52:21', null, '2015-10-30 13:52:21', '0', null, '29', ''), ('108', '20151030135257', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-30 13:52:57', '1', 'paid', null, null, '2015-10-30 13:52:57', null, '2015-10-30 13:52:57', '0', null, '29', ''), ('109', '20151030161607', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-30 16:16:07', '1', 'paid', null, null, '2015-10-30 16:16:07', null, '2015-10-30 16:16:07', '0', null, '29', ''), ('110', '20151030164404', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-30 16:44:04', '1', 'paid', null, null, '2015-10-30 16:44:04', null, '2015-10-30 16:44:04', '0', null, '29', ''), ('111', '20151030170356', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-30 17:03:56', '1', 'paid', null, null, '2015-10-30 17:03:56', null, '2015-10-30 17:03:56', '0', null, '29', ''), ('112', '20151030171450', '15210497261', '1', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-30 17:14:50', '1', 'paid', null, null, '2015-10-30 17:14:50', null, '2015-10-30 17:14:50', '0', null, '29', ''), ('113', '20151030171505', '15210497261', '1', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-30 17:15:05', '1', 'paid', null, null, '2015-10-30 17:15:05', null, '2015-10-30 17:15:05', '0', null, '29', ''), ('114', '20151030171510', '15210497261', '1', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-10-30 17:15:10', '1', 'paid', null, null, '2015-10-30 17:15:10', null, '2015-10-30 17:15:10', '0', null, '29', ''), ('115', '20151102095059', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 09:50:59', '1', 'paid', null, null, '2015-11-02 09:50:59', null, '2015-11-02 09:50:59', '0', null, '29', ''), ('116', '20151102101204', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 10:12:04', '1', 'paid', null, null, '2015-11-02 10:12:05', null, '2015-11-02 10:12:05', '0', null, '29', ''), ('117', '20151102101213', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 10:12:13', '1', 'paid', null, null, '2015-11-02 10:12:13', null, '2015-11-02 10:12:13', '0', null, '29', ''), ('118', '20151102101218', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 10:12:18', '1', 'paid', null, null, '2015-11-02 10:12:18', null, '2015-11-02 10:12:18', '0', null, '29', ''), ('119', '20151102101833', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 10:18:33', '1', 'paid', null, null, '2015-11-02 10:18:33', null, '2015-11-02 10:18:33', '0', null, '29', ''), ('120', '20151102101852', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 10:18:52', '1', 'paid', null, null, '2015-11-02 10:18:52', null, '2015-11-02 10:18:52', '0', null, '29', ''), ('121', '20151102102950', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 10:29:50', '1', 'paid', null, null, '2015-11-02 10:29:51', null, '2015-11-02 10:29:51', '0', null, '29', ''), ('122', '20151102102952', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 10:29:52', '1', 'paid', null, null, '2015-11-02 10:29:52', null, '2015-11-02 10:29:52', '0', null, '29', ''), ('123', '20151102103004', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 10:30:04', '1', 'paid', null, null, '2015-11-02 10:30:04', null, '2015-11-02 10:30:04', '0', null, '29', ''), ('124', '20151102113241', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 11:32:41', '1', 'paid', null, null, '2015-11-02 11:32:41', null, '2015-11-02 11:32:41', '0', null, '29', ''), ('125', '20151102113258', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 11:32:58', '1', 'paid', null, null, '2015-11-02 11:32:58', null, '2015-11-02 11:32:58', '0', null, '29', ''), ('126', '20151102113627', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 11:36:27', '1', 'paid', null, null, '2015-11-02 11:36:27', null, '2015-11-02 11:36:27', '0', null, '29', ''), ('127', '20151102113633', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 11:36:33', '1', 'paid', null, null, '2015-11-02 11:36:33', null, '2015-11-02 11:36:33', '0', null, '29', ''), ('128', '20151102114158', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 11:41:58', '1', 'paid', null, null, '2015-11-02 11:41:58', null, '2015-11-02 11:41:58', '0', null, '29', ''), ('129', '20151102114244', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 11:42:44', '1', 'paid', null, null, '2015-11-02 11:42:44', null, '2015-11-02 11:42:44', '0', null, '29', ''), ('130', '20151102114327', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 11:43:27', '1', 'paid', null, null, '2015-11-02 11:43:27', null, '2015-11-02 11:43:27', '0', null, '29', ''), ('131', '20151102114333', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 11:43:33', '1', 'paid', null, null, '2015-11-02 11:43:33', null, '2015-11-02 11:43:33', '0', null, '29', ''), ('132', '20151102114352', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 11:43:52', '1', 'paid', null, null, '2015-11-02 11:43:52', null, '2015-11-02 11:43:52', '0', null, '29', ''), ('133', '20151102114517', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 11:45:17', '1', 'paid', null, null, '2015-11-02 11:45:17', null, '2015-11-02 11:45:17', '0', null, '29', ''), ('134', '20151102114730', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 11:47:30', '1', 'paid', null, null, '2015-11-02 11:47:30', null, '2015-11-02 11:47:30', '0', null, '29', ''), ('135', '20151102135300', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 13:53:00', '1', 'paid', null, null, '2015-11-02 13:53:01', null, '2015-11-02 13:53:01', '0', null, '29', ''), ('136', '20151102135312', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 13:53:12', '1', 'paid', null, null, '2015-11-02 13:53:12', null, '2015-11-02 13:53:12', '0', null, '29', ''), ('137', '20151102135319', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 13:53:19', '1', 'paid', null, null, '2015-11-02 13:53:19', null, '2015-11-02 13:53:19', '0', null, '29', ''), ('138', '20151102135421', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 13:54:21', '1', 'paid', null, null, '2015-11-02 13:54:21', null, '2015-11-02 13:54:21', '0', null, '29', ''), ('139', '20151102135424', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 13:54:24', '1', 'paid', null, null, '2015-11-02 13:54:24', null, '2015-11-02 13:54:24', '0', null, '29', ''), ('140', '20151102135441', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 13:54:41', '1', 'paid', null, null, '2015-11-02 13:54:41', null, '2015-11-02 13:54:41', '0', null, '29', ''), ('141', '20151102135629', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 13:56:29', '1', 'paid', null, null, '2015-11-02 13:56:29', null, '2015-11-02 13:56:29', '0', null, '29', ''), ('142', '20151102135640', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 13:56:40', '1', 'paid', null, null, '2015-11-02 13:56:40', null, '2015-11-02 13:56:40', '0', null, '29', ''), ('143', '20151102135708', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 13:57:08', '1', 'paid', null, null, '2015-11-02 13:57:08', null, '2015-11-02 13:57:08', '0', null, '29', ''), ('144', '20151102135727', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 13:57:27', '1', 'paid', null, null, '2015-11-02 13:57:27', null, '2015-11-02 13:57:27', '0', null, '29', ''), ('145', '20151102140527', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 14:05:27', '1', 'paid', null, null, '2015-11-02 14:05:27', null, '2015-11-02 14:05:27', '0', null, '29', ''), ('146', '20151102140535', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 14:05:35', '1', 'paid', null, null, '2015-11-02 14:05:35', null, '2015-11-02 14:05:35', '0', null, '29', ''), ('147', '20151102141259', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 14:12:59', '1', 'paid', null, null, '2015-11-02 14:12:59', null, '2015-11-02 14:12:59', '0', null, '29', ''), ('148', '20151102141308', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 14:13:08', '1', 'paid', null, null, '2015-11-02 14:13:08', null, '2015-11-02 14:13:08', '0', null, '29', ''), ('149', '20151102141422', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 14:14:22', '1', 'paid', null, null, '2015-11-02 14:14:22', null, '2015-11-02 14:14:22', '0', null, '29', ''), ('150', '20151102141435', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 14:14:35', '1', 'paid', null, null, '2015-11-02 14:14:35', null, '2015-11-02 14:14:35', '0', null, '29', ''), ('151', '20151102141520', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 14:15:20', '1', 'paid', null, null, '2015-11-02 14:15:20', null, '2015-11-02 14:15:20', '0', null, '29', ''), ('152', '20151102141520', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 14:15:20', '1', 'paid', null, null, '2015-11-02 14:15:20', null, '2015-11-02 14:15:20', '0', null, '29', ''), ('153', '20151102141613', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 14:16:13', '1', 'paid', null, null, '2015-11-02 14:16:13', null, '2015-11-02 14:16:13', '0', null, '29', ''), ('154', '20151102141712', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 14:17:12', '1', 'paid', null, null, '2015-11-02 14:17:12', null, '2015-11-02 14:17:12', '0', null, '29', ''), ('155', '20151102141807', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 14:18:07', '1', 'paid', null, null, '2015-11-02 14:18:07', null, '2015-11-02 14:18:07', '0', null, '29', ''), ('156', '20151102141821', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 14:18:21', '1', 'paid', null, null, '2015-11-02 14:18:21', null, '2015-11-02 14:18:21', '0', null, '29', ''), ('157', '20151102141938', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 14:19:38', '1', 'paid', null, null, '2015-11-02 14:19:38', null, '2015-11-02 14:19:38', '0', null, '29', ''), ('158', '20151102142042', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 14:20:42', '1', 'paid', null, null, '2015-11-02 14:20:42', null, '2015-11-02 14:20:42', '0', null, '29', ''), ('159', '20151102142135', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 14:21:35', '1', 'paid', null, null, '2015-11-02 14:21:35', null, '2015-11-02 14:21:35', '0', null, '29', ''), ('160', '20151102142205', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 14:22:05', '1', 'paid', null, null, '2015-11-02 14:22:05', null, '2015-11-02 14:22:05', '0', null, '29', ''), ('161', '20151102142241', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 14:22:41', '1', 'paid', null, null, '2015-11-02 14:22:41', null, '2015-11-02 14:22:41', '0', null, '29', ''), ('162', '20151102142319', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 14:23:19', '1', 'paid', null, null, '2015-11-02 14:23:19', null, '2015-11-02 14:23:19', '0', null, '29', ''), ('163', '20151102142330', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 14:23:30', '1', 'paid', null, null, '2015-11-02 14:23:30', null, '2015-11-02 14:23:30', '0', null, '29', ''), ('164', '20151102142332', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 14:23:32', '1', 'paid', null, null, '2015-11-02 14:23:32', null, '2015-11-02 14:23:32', '0', null, '29', ''), ('165', '20151102142420', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 14:24:20', '1', 'paid', null, null, '2015-11-02 14:24:20', null, '2015-11-02 14:24:20', '0', null, '29', ''), ('166', '20151102142509', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 14:25:09', '1', 'paid', null, null, '2015-11-02 14:25:09', null, '2015-11-02 14:25:09', '0', null, '29', ''), ('167', '20151102143320', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 14:33:20', '1', 'paid', null, null, '2015-11-02 14:33:20', null, '2015-11-02 14:33:20', '0', null, '29', ''), ('168', '20151102143552', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 14:35:52', '1', 'paid', null, null, '2015-11-02 14:35:52', null, '2015-11-02 14:35:52', '0', null, '29', ''), ('169', '20151102144412', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 14:44:12', '1', 'paid', null, null, '2015-11-02 14:44:12', null, '2015-11-02 14:44:12', '0', null, '29', ''), ('170', '20151102144422', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 14:44:22', '1', 'paid', null, null, '2015-11-02 14:44:22', null, '2015-11-02 14:44:22', '0', null, '29', ''), ('171', '20151102144651', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 14:46:51', '1', 'paid', null, null, '2015-11-02 14:46:51', null, '2015-11-02 14:46:51', '0', null, '29', ''), ('172', '20151102144701', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 14:47:01', '1', 'paid', null, null, '2015-11-02 14:47:01', null, '2015-11-02 14:47:01', '0', null, '29', ''), ('173', '20151102145332', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 14:53:32', '1', 'paid', null, null, '2015-11-02 14:53:32', null, '2015-11-02 14:53:32', '0', null, '29', ''), ('174', '20151102145521', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 14:55:21', '1', 'paid', null, null, '2015-11-02 14:55:21', null, '2015-11-02 14:55:21', '0', null, '29', ''), ('175', '20151102145529', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 14:55:29', '1', 'paid', null, null, '2015-11-02 14:55:29', null, '2015-11-02 14:55:29', '0', null, '29', ''), ('176', '20151102145849', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 14:58:49', '1', 'paid', null, null, '2015-11-02 14:58:49', null, '2015-11-02 14:58:49', '0', null, '29', ''), ('177', '20151102145905', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 14:59:05', '1', 'paid', null, null, '2015-11-02 14:59:05', null, '2015-11-02 14:59:05', '0', null, '29', ''), ('178', '20151102150604', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 15:06:04', '1', 'paid', null, null, '2015-11-02 15:06:04', null, '2015-11-02 15:06:04', '0', null, '29', ''), ('179', '20151102150617', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 15:06:17', '1', 'paid', null, null, '2015-11-02 15:06:17', null, '2015-11-02 15:06:17', '0', null, '29', ''), ('180', '20151102151117', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 15:11:17', '1', 'paid', null, null, '2015-11-02 15:11:17', null, '2015-11-02 15:11:17', '0', null, '29', ''), ('181', '20151102151126', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 15:11:26', '1', 'paid', null, null, '2015-11-02 15:11:26', null, '2015-11-02 15:11:26', '0', null, '29', ''), ('182', '20151102152120', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 15:21:20', '1', 'paid', null, null, '2015-11-02 15:21:20', null, '2015-11-02 15:21:20', '0', null, '29', ''), ('183', '20151102152132', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 15:21:32', '1', 'paid', null, null, '2015-11-02 15:21:32', null, '2015-11-02 15:21:32', '0', null, '29', ''), ('184', '20151102152149', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 15:21:49', '1', 'paid', null, null, '2015-11-02 15:21:49', null, '2015-11-02 15:21:49', '0', null, '29', ''), ('185', '20151102152428', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 15:24:28', '1', 'paid', null, null, '2015-11-02 15:24:28', null, '2015-11-02 15:24:28', '0', null, '29', ''), ('186', '20151102152703', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 15:27:03', '1', 'paid', null, null, '2015-11-02 15:27:03', null, '2015-11-02 15:27:03', '0', null, '29', ''), ('187', '20151102152717', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 15:27:17', '1', 'paid', null, null, '2015-11-02 15:27:17', null, '2015-11-02 15:27:17', '0', null, '29', ''), ('188', '20151102152944', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 15:29:44', '1', 'paid', null, null, '2015-11-02 15:29:44', null, '2015-11-02 15:29:44', '0', null, '29', ''), ('189', '20151102152953', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 15:29:53', '1', 'paid', null, null, '2015-11-02 15:29:53', null, '2015-11-02 15:29:53', '0', null, '29', ''), ('190', '20151102153446', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 15:34:46', '1', 'paid', null, null, '2015-11-02 15:34:46', null, '2015-11-02 15:34:46', '0', null, '29', ''), ('191', '20151102153457', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 15:34:57', '1', 'paid', null, null, '2015-11-02 15:34:57', null, '2015-11-02 15:34:57', '0', null, '29', ''), ('192', '20151102154100', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 15:41:00', '1', 'paid', null, null, '2015-11-02 15:41:00', null, '2015-11-02 15:41:00', '0', null, '29', ''), ('193', '20151102154107', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 15:41:07', '1', 'paid', null, null, '2015-11-02 15:41:07', null, '2015-11-02 15:41:07', '0', null, '29', ''), ('194', '20151102154356', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 15:43:56', '1', 'paid', null, null, '2015-11-02 15:43:57', null, '2015-11-02 15:43:57', '0', null, '29', ''), ('195', '20151102154405', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 15:44:05', '1', 'paid', null, null, '2015-11-02 15:44:05', null, '2015-11-02 15:44:05', '0', null, '29', ''), ('196', '20151102155607', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 15:56:07', '1', 'paid', null, null, '2015-11-02 15:56:07', null, '2015-11-02 15:56:07', '0', null, '29', ''), ('197', '20151102160311', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 16:03:11', '1', 'paid', null, null, '2015-11-02 16:03:11', null, '2015-11-02 16:03:11', '0', null, '29', ''), ('198', '20151102160322', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 16:03:22', '1', 'paid', null, null, '2015-11-02 16:03:22', null, '2015-11-02 16:03:22', '0', null, '29', ''), ('199', '20151102161636', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 16:16:36', '1', 'paid', null, null, '2015-11-02 16:16:36', null, '2015-11-02 16:16:36', '0', null, '29', ''), ('200', '20151102161656', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 16:16:56', '1', 'paid', null, null, '2015-11-02 16:16:56', null, '2015-11-02 16:16:56', '0', null, '29', ''), ('201', '20151102161725', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 16:17:25', '1', 'paid', null, null, '2015-11-02 16:17:25', null, '2015-11-02 16:17:25', '0', null, '29', ''), ('202', '20151102161745', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 16:17:45', '1', 'paid', null, null, '2015-11-02 16:17:45', null, '2015-11-02 16:17:45', '0', null, '29', ''), ('203', '20151102161830', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 16:18:30', '1', 'paid', null, null, '2015-11-02 16:18:30', null, '2015-11-02 16:18:30', '0', null, '29', ''), ('204', '20151102162345', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 16:23:45', '1', 'paid', null, null, '2015-11-02 16:23:45', null, '2015-11-02 16:23:45', '0', null, '29', ''), ('205', '20151102162727', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 16:27:27', '1', 'paid', null, null, '2015-11-02 16:27:27', null, '2015-11-02 16:27:27', '0', null, '29', ''), ('206', '20151102162850', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 16:28:50', '1', 'paid', null, null, '2015-11-02 16:28:50', null, '2015-11-02 16:28:50', '0', null, '29', ''), ('207', '20151102165655', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 16:56:55', '1', 'paid', null, null, '2015-11-02 16:56:55', null, '2015-11-02 16:56:55', '0', null, '29', ''), ('208', '20151102165818', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 16:58:18', '1', 'paid', null, null, '2015-11-02 16:58:18', null, '2015-11-02 16:58:18', '0', null, '29', ''), ('209', '20151102165917', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 16:59:17', '1', 'paid', null, null, '2015-11-02 16:59:17', null, '2015-11-02 16:59:17', '0', null, '29', ''), ('210', '20151102170150', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 17:01:50', '1', 'paid', null, null, '2015-11-02 17:01:50', null, '2015-11-02 17:01:50', '0', null, '29', ''), ('211', '20151102170200', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 17:02:00', '1', 'paid', null, null, '2015-11-02 17:02:00', null, '2015-11-02 17:02:00', '0', null, '29', ''), ('212', '20151102172508', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 17:25:08', '1', 'paid', null, null, '2015-11-02 17:25:08', null, '2015-11-02 17:25:08', '0', null, '29', ''), ('213', '20151102172702', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 17:27:02', '1', 'paid', null, null, '2015-11-02 17:27:02', null, '2015-11-02 17:27:02', '0', null, '29', ''), ('214', '20151102173440', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 17:34:40', '1', 'paid', null, null, '2015-11-02 17:34:40', null, '2015-11-02 17:34:40', '0', null, '29', ''), ('215', '20151102180408', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 18:04:08', '1', 'paid', null, null, '2015-11-02 18:04:08', null, '2015-11-02 18:04:08', '0', null, '29', ''), ('216', '20151102180455', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-02 18:04:55', '1', 'paid', null, null, '2015-11-02 18:04:55', null, '2015-11-02 18:04:55', '0', null, '29', ''), ('217', '20151103102417', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-03 10:24:17', '1', 'paid', null, null, '2015-11-03 10:24:18', null, '2015-11-03 10:24:18', '0', null, '29', ''), ('218', '20151103102658', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-03 10:26:58', '1', 'paid', null, null, '2015-11-03 10:26:58', null, '2015-11-03 10:26:58', '0', null, '29', ''), ('219', '20151103104314', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-03 10:43:14', '1', 'paid', null, null, '2015-11-03 10:43:14', null, '2015-11-03 10:43:14', '0', null, '29', ''), ('220', '20151103104328', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-03 10:43:28', '1', 'paid', null, null, '2015-11-03 10:43:28', null, '2015-11-03 10:43:28', '0', null, '29', ''), ('221', '20151103104739', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-03 10:47:39', '1', 'paid', null, null, '2015-11-03 10:47:39', null, '2015-11-03 10:47:39', '0', null, '29', ''), ('222', '20151103104740', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-03 10:47:40', '1', 'paid', null, null, '2015-11-03 10:47:40', null, '2015-11-03 10:47:40', '0', null, '29', ''), ('223', '20151103105004', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-03 10:50:04', '1', 'paid', null, null, '2015-11-03 10:50:04', null, '2015-11-03 10:50:04', '0', null, '29', ''), ('224', '20151103105026', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-03 10:50:26', '1', 'paid', null, null, '2015-11-03 10:50:26', null, '2015-11-03 10:50:26', '0', null, '29', ''), ('225', '20151103111054', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-03 11:10:54', '1', 'paid', null, null, '2015-11-03 11:10:54', null, '2015-11-03 11:10:54', '0', null, '29', ''), ('226', '20151103111116', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-03 11:11:16', '1', 'paid', null, null, '2015-11-03 11:11:16', null, '2015-11-03 11:11:16', '0', null, '29', ''), ('227', '20151103111412', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-03 11:14:12', '1', 'paid', null, null, '2015-11-03 11:14:12', null, '2015-11-03 11:14:12', '0', null, '29', ''), ('228', '20151103112021', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-03 11:20:21', '1', 'paid', null, null, '2015-11-03 11:20:21', null, '2015-11-03 11:20:21', '0', null, '29', ''), ('229', '20151103112322', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-03 11:23:22', '1', 'paid', null, null, '2015-11-03 11:23:22', null, '2015-11-03 11:23:22', '0', null, '29', ''), ('230', '20151103112352', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-03 11:23:52', '1', 'paid', null, null, '2015-11-03 11:23:52', null, '2015-11-03 11:23:52', '0', null, '29', ''), ('231', '20151103112450', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-03 11:24:50', '1', 'paid', null, null, '2015-11-03 11:24:50', null, '2015-11-03 11:24:50', '0', null, '29', ''), ('232', '20151103113146', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-03 11:31:46', '1', 'paid', null, null, '2015-11-03 11:31:46', null, '2015-11-03 11:31:46', '0', null, '29', ''), ('233', '20151103113417', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-03 11:34:17', '1', 'paid', null, null, '2015-11-03 11:34:18', null, '2015-11-03 11:34:18', '0', null, '29', ''), ('234', '20151103114006', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-03 11:40:06', '1', 'paid', null, null, '2015-11-03 11:40:06', null, '2015-11-03 11:40:06', '0', null, '29', ''), ('235', '20151103114216', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-03 11:42:16', '1', 'paid', null, null, '2015-11-03 11:42:16', null, '2015-11-03 11:42:16', '0', null, '29', ''), ('236', '20151103114225', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-03 11:42:25', '1', 'paid', null, null, '2015-11-03 11:42:25', null, '2015-11-03 11:42:25', '0', null, '29', ''), ('237', '20151103114831', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-03 11:48:31', '1', 'paid', null, null, '2015-11-03 11:48:31', null, '2015-11-03 11:48:31', '0', null, '29', ''), ('238', '20151103114911', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-03 11:49:11', '1', 'paid', null, null, '2015-11-03 11:49:11', null, '2015-11-03 11:49:11', '0', null, '29', ''), ('239', '20151103115023', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-03 11:50:23', '1', 'paid', null, null, '2015-11-03 11:50:23', null, '2015-11-03 11:50:23', '0', null, '29', ''), ('240', '20151103133346', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-03 13:33:46', '1', 'paid', null, null, '2015-11-03 13:33:46', null, '2015-11-03 13:33:46', '0', null, '29', ''), ('241', '20151103133405', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-03 13:34:05', '1', 'paid', null, null, '2015-11-03 13:34:05', null, '2015-11-03 13:34:05', '0', null, '29', ''), ('242', '20151103133426', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-03 13:34:26', '1', 'paid', null, null, '2015-11-03 13:34:26', null, '2015-11-03 13:34:26', '0', null, '29', ''), ('243', '20151103133531', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-03 13:35:31', '1', 'paid', null, null, '2015-11-03 13:35:31', null, '2015-11-03 13:35:31', '0', null, '29', ''), ('244', '20151103134226', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-03 13:42:26', '1', 'paid', null, null, '2015-11-03 13:42:26', null, '2015-11-03 13:42:26', '0', null, '29', ''), ('245', '20151103182351', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-03 18:23:51', '1', 'paid', null, null, '2015-11-03 18:23:51', null, '2015-11-03 18:23:51', '0', null, '29', ''), ('246', '20151103182411', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-03 18:24:11', '1', 'paid', null, null, '2015-11-03 18:24:11', null, '2015-11-03 18:24:11', '0', null, '29', ''), ('247', '20151103183009', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-03 18:30:09', '1', 'paid', null, null, '2015-11-03 18:30:09', null, '2015-11-03 18:30:09', '0', null, '29', ''), ('248', '20151103183408', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '3.00', '2015-11-03 18:34:08', '1', 'paid', null, null, '2015-11-03 18:34:08', null, '2015-11-03 18:34:08', '0', null, '29', ''), ('249', '20151103190007', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-03 19:00:07', '1', 'paid', null, null, '2015-11-03 19:00:07', null, '2015-11-03 19:00:07', '0', null, '29', ''), ('250', '20151103200459', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-03 20:04:59', '1', 'paid', null, null, '2015-11-03 20:04:59', null, '2015-11-03 20:04:59', '0', null, '29', ''), ('251', '20151103200807', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-03 20:08:07', '1', 'paid', null, null, '2015-11-03 20:08:07', null, '2015-11-03 20:08:07', '0', null, '29', ''), ('252', '20151103200923', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-03 20:09:23', '1', 'paid', null, null, '2015-11-03 20:09:23', null, '2015-11-03 20:09:23', '0', null, '29', ''), ('253', '20151104104222', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 10:42:22', '1', 'paid', null, null, '2015-11-04 10:42:22', null, '2015-11-04 10:42:22', '0', null, '29', ''), ('254', '20151104104240', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 10:42:40', '1', 'paid', null, null, '2015-11-04 10:42:40', null, '2015-11-04 10:42:40', '0', null, '29', ''), ('255', '20151104104526', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 10:45:26', '1', 'paid', null, null, '2015-11-04 10:45:26', null, '2015-11-04 10:45:26', '0', null, '29', ''), ('256', '20151104105115', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 10:51:15', '1', 'paid', null, null, '2015-11-04 10:51:15', null, '2015-11-04 10:51:15', '0', null, '29', '');
INSERT INTO `base_order` VALUES ('257', '20151104105250', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 10:52:50', '1', 'paid', null, null, '2015-11-04 10:52:50', null, '2015-11-04 10:52:50', '0', null, '29', ''), ('258', '20151104105734', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 10:57:34', '1', 'paid', null, null, '2015-11-04 10:57:34', null, '2015-11-04 10:57:34', '0', null, '29', ''), ('259', '20151104105820', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 10:58:20', '1', 'paid', null, null, '2015-11-04 10:58:20', null, '2015-11-04 10:58:20', '0', null, '29', ''), ('260', '20151104105841', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 10:58:41', '1', 'paid', null, null, '2015-11-04 10:58:41', null, '2015-11-04 10:58:41', '0', null, '29', ''), ('261', '20151104105942', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 10:59:42', '1', 'paid', null, null, '2015-11-04 10:59:42', null, '2015-11-04 10:59:42', '0', null, '29', ''), ('262', '20151104110002', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 11:00:02', '1', 'paid', null, null, '2015-11-04 11:00:02', null, '2015-11-04 11:00:02', '0', null, '29', ''), ('263', '20151104110127', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 11:01:27', '1', 'paid', null, null, '2015-11-04 11:01:27', null, '2015-11-04 11:01:27', '0', null, '29', ''), ('264', '20151104110147', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 11:01:47', '1', 'paid', null, null, '2015-11-04 11:01:47', null, '2015-11-04 11:01:47', '0', null, '29', ''), ('265', '20151104112350', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 11:23:50', '1', 'paid', null, null, '2015-11-04 11:23:50', null, '2015-11-04 11:23:50', '0', null, '29', ''), ('266', '20151104112548', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 11:25:48', '1', 'paid', null, null, '2015-11-04 11:25:48', null, '2015-11-04 11:25:48', '0', null, '29', ''), ('267', '20151104113649', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 11:36:49', '1', 'paid', null, null, '2015-11-04 11:36:49', null, '2015-11-04 11:36:49', '0', null, '29', ''), ('268', '20151104113709', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 11:37:09', '1', 'paid', null, null, '2015-11-04 11:37:09', null, '2015-11-04 11:37:09', '0', null, '29', ''), ('269', '20151104114333', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 11:43:33', '1', 'paid', null, null, '2015-11-04 11:43:33', null, '2015-11-04 11:43:33', '0', null, '29', ''), ('270', '20151104114702', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 11:47:02', '1', 'paid', null, null, '2015-11-04 11:47:02', null, '2015-11-04 11:47:02', '0', null, '29', ''), ('271', '20151104124837', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 12:48:37', '1', 'paid', null, null, '2015-11-04 12:48:37', null, '2015-11-04 12:48:37', '0', null, '29', ''), ('272', '20151104124925', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 12:49:25', '1', 'paid', null, null, '2015-11-04 12:49:25', null, '2015-11-04 12:49:25', '0', null, '29', ''), ('273', '20151104124948', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 12:49:48', '1', 'paid', null, null, '2015-11-04 12:49:48', null, '2015-11-04 12:49:48', '0', null, '29', ''), ('274', '20151104125118', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 12:51:18', '1', 'paid', null, null, '2015-11-04 12:51:18', null, '2015-11-04 12:51:18', '0', null, '29', ''), ('275', '20151104144949', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 14:49:49', '1', 'paid', null, null, '2015-11-04 14:49:49', null, '2015-11-04 14:49:49', '0', null, '29', ''), ('276', '20151104145416', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 14:54:16', '1', 'paid', null, null, '2015-11-04 14:54:16', null, '2015-11-04 14:54:16', '0', null, '29', ''), ('277', '20151104165938', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 16:59:38', '1', 'paid', null, null, '2015-11-04 16:59:38', null, '2015-11-04 16:59:38', '0', null, '29', ''), ('278', '20151104165959', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 16:59:59', '1', 'paid', null, null, '2015-11-04 16:59:59', null, '2015-11-04 16:59:59', '0', null, '29', ''), ('279', '20151104171819', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 17:18:19', '1', 'paid', null, null, '2015-11-04 17:18:19', null, '2015-11-04 17:18:19', '0', null, '29', ''), ('280', '20151104171839', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 17:18:39', '1', 'paid', null, null, '2015-11-04 17:18:39', null, '2015-11-04 17:18:39', '0', null, '29', ''), ('281', '20151104173448', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 17:34:48', '1', 'paid', null, null, '2015-11-04 17:34:48', null, '2015-11-04 17:34:48', '0', null, '29', ''), ('282', '20151104174227', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 17:42:27', '1', 'paid', null, null, '2015-11-04 17:42:27', null, '2015-11-04 17:42:27', '0', null, '29', ''), ('283', '20151104174338', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 17:43:38', '1', 'paid', null, null, '2015-11-04 17:43:38', null, '2015-11-04 17:43:38', '0', null, '29', ''), ('284', '20151104175850', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 17:58:50', '1', 'paid', null, null, '2015-11-04 17:58:51', null, '2015-11-04 17:58:51', '0', null, '29', ''), ('285', '20151104185127', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 18:51:27', '1', 'paid', null, null, '2015-11-04 18:51:27', null, '2015-11-04 18:51:27', '0', null, '29', ''), ('286', '20151104185710', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 18:57:10', '1', 'paid', null, null, '2015-11-04 18:57:10', null, '2015-11-04 18:57:10', '0', null, '29', ''), ('287', '20151104191747', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 19:17:47', '1', 'paid', null, null, '2015-11-04 19:17:47', null, '2015-11-04 19:17:47', '0', null, '29', ''), ('288', '20151104192319', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 19:23:19', '1', 'paid', null, null, '2015-11-04 19:23:20', null, '2015-11-04 19:23:20', '0', null, '29', ''), ('289', '20151104192703', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 19:27:03', '1', 'paid', null, null, '2015-11-04 19:27:03', null, '2015-11-04 19:27:03', '0', null, '29', ''), ('290', '20151104193111', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 19:31:11', '1', 'paid', null, null, '2015-11-04 19:31:11', null, '2015-11-04 19:31:11', '0', null, '29', ''), ('291', '20151104193253', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 19:32:53', '1', 'paid', null, null, '2015-11-04 19:32:53', null, '2015-11-04 19:32:53', '0', null, '29', ''), ('292', '20151104193359', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 19:33:59', '1', 'paid', null, null, '2015-11-04 19:33:59', null, '2015-11-04 19:33:59', '0', null, '29', ''), ('293', '20151104193550', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 19:35:50', '1', 'paid', null, null, '2015-11-04 19:35:50', null, '2015-11-04 19:35:50', '0', null, '29', ''), ('294', '20151104194056', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 19:40:56', '1', 'paid', null, null, '2015-11-04 19:40:56', null, '2015-11-04 19:40:56', '0', null, '29', ''), ('295', '20151104194936', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 19:49:36', '1', 'paid', null, null, '2015-11-04 19:49:36', null, '2015-11-04 19:49:36', '0', null, '29', ''), ('296', '20151104195113', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 19:51:13', '1', 'paid', null, null, '2015-11-04 19:51:13', null, '2015-11-04 19:51:13', '0', null, '29', ''), ('297', '20151104195259', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 19:52:59', '1', 'paid', null, null, '2015-11-04 19:52:59', null, '2015-11-04 19:52:59', '0', null, '29', ''), ('298', '20151104200628', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 20:06:28', '1', 'paid', null, null, '2015-11-04 20:06:28', null, '2015-11-04 20:06:28', '0', null, '29', ''), ('299', '20151104200917', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 20:09:17', '1', 'paid', null, null, '2015-11-04 20:09:17', null, '2015-11-04 20:09:17', '0', null, '29', ''), ('300', '20151104201506', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 20:15:06', '1', 'paid', null, null, '2015-11-04 20:15:06', null, '2015-11-04 20:15:06', '0', null, '29', ''), ('301', '20151104201726', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 20:17:26', '1', 'paid', null, null, '2015-11-04 20:17:26', null, '2015-11-04 20:17:26', '0', null, '29', ''), ('302', '20151104201823', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 20:18:23', '1', 'paid', null, null, '2015-11-04 20:18:24', null, '2015-11-04 20:18:24', '0', null, '29', ''), ('303', '20151104201948', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 20:19:48', '1', 'paid', null, null, '2015-11-04 20:19:48', null, '2015-11-04 20:19:48', '0', null, '29', ''), ('304', '20151104201952', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 20:19:52', '1', 'paid', null, null, '2015-11-04 20:19:52', null, '2015-11-04 20:19:52', '0', null, '29', ''), ('305', '20151104202002', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 20:20:02', '1', 'paid', null, null, '2015-11-04 20:20:02', null, '2015-11-04 20:20:02', '0', null, '29', ''), ('306', '20151104202338', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 20:23:38', '1', 'paid', null, null, '2015-11-04 20:23:38', null, '2015-11-04 20:23:38', '0', null, '29', ''), ('307', '20151104202538', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 20:25:38', '1', 'paid', null, null, '2015-11-04 20:25:38', null, '2015-11-04 20:25:38', '0', null, '29', ''), ('308', '20151104202746', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 20:27:46', '1', 'paid', null, null, '2015-11-04 20:27:46', null, '2015-11-04 20:27:46', '0', null, '29', ''), ('309', '20151104203043', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 20:30:43', '1', 'paid', null, null, '2015-11-04 20:30:43', null, '2015-11-04 20:30:43', '0', null, '29', ''), ('310', '20151104203338', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 20:33:38', '1', 'paid', null, null, '2015-11-04 20:33:38', null, '2015-11-04 20:33:38', '0', null, '29', ''), ('311', '20151104203838', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 20:38:38', '1', 'paid', null, null, '2015-11-04 20:38:38', null, '2015-11-04 20:38:38', '0', null, '29', ''), ('312', '20151104204712', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 20:47:12', '1', 'paid', null, null, '2015-11-04 20:47:12', null, '2015-11-04 20:47:12', '0', null, '29', ''), ('313', '20151104204718', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 20:47:18', '1', 'paid', null, null, '2015-11-04 20:47:18', null, '2015-11-04 20:47:18', '0', null, '29', ''), ('314', '20151104204722', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 20:47:22', '1', 'paid', null, null, '2015-11-04 20:47:22', null, '2015-11-04 20:47:22', '0', null, '29', ''), ('315', '20151104204742', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 20:47:42', '1', 'paid', null, null, '2015-11-04 20:47:42', null, '2015-11-04 20:47:42', '0', null, '29', ''), ('316', '20151104204959', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 20:49:59', '1', 'paid', null, null, '2015-11-04 20:49:59', null, '2015-11-04 20:49:59', '0', null, '29', ''), ('317', '20151104205919', '13141235307', '2', '21', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 20:59:19', '1', 'paid', null, null, '2015-11-04 20:59:19', null, '2015-11-04 20:59:19', '0', null, '29', ''), ('318', '20151104210420', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 21:04:20', '1', 'paid', null, null, '2015-11-04 21:04:20', null, '2015-11-04 21:04:20', '0', null, '29', ''), ('319', '20151104210525', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 21:05:25', '1', 'paid', null, null, '2015-11-04 21:05:25', null, '2015-11-04 21:05:25', '0', null, '29', ''), ('320', '20151104210627', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 21:06:27', '1', 'paid', null, null, '2015-11-04 21:06:28', null, '2015-11-04 21:06:28', '0', null, '29', ''), ('321', '20151104210746', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 21:07:46', '1', 'paid', null, null, '2015-11-04 21:07:46', null, '2015-11-04 21:07:46', '0', null, '29', ''), ('322', '20151104210921', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-04 21:09:21', '1', 'unpay', null, null, '2015-11-04 21:09:22', null, '2015-11-04 21:09:22', '0', null, '0', ''), ('323', '20151105202325', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-05 20:23:25', '1', 'unpay', null, null, '2015-11-05 20:23:25', null, '2015-11-05 20:23:25', '0', null, '0', ''), ('324', '20151105202618', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-05 20:26:18', '1', 'paid', null, null, '2015-11-05 20:26:18', null, '2015-11-05 20:26:18', '0', null, '29', ''), ('325', '20151105203743', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-05 20:37:43', '1', 'paid', null, null, '2015-11-05 20:37:43', null, '2015-11-05 20:37:43', '0', null, '29', ''), ('326', '20151105203837', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:19', '35.00', '1.00', '2015-11-05 20:38:37', '1', 'unpay', null, null, '2015-11-05 20:38:37', null, '2015-11-05 20:38:37', '0', null, '0', ''), ('327', '20151105203841', '15210497261', '2', '13', '1', 'online', null, 'settle', null, null, '2015-11-14 23:17:17', '35.00', '1.00', '2015-11-05 20:38:41', '1', 'paid', null, null, '2015-11-05 20:38:41', null, '2015-11-05 20:38:41', '0', null, '29', ''), ('331', '20151118170344', '13141235307', '2', '21', '1', 'online', 'weixin_JSAPI', 'unpay', null, null, null, '60.00', '1.00', '2015-11-18 17:03:44', '1', 'unpay', null, null, '2015-11-18 17:03:48', null, '2015-11-18 17:03:48', '1', null, null, null), ('332', '20151118172402', '13141235307', '2', '21', '1', 'online', 'weixin_JSAPI', 'unpay', null, null, null, '60.00', '1.00', '2015-11-18 17:24:02', '1', 'unpay', null, null, '2015-11-18 17:24:09', null, '2015-11-18 17:24:09', '1', null, null, null), ('333', '20151118172818', '13141235307', '2', '21', '1', 'online', 'weixin_JSAPI', 'unpay', null, null, null, '60.00', '1.00', '2015-11-18 17:28:18', '1', 'unpay', null, null, '2015-11-18 17:28:18', null, '2015-11-18 17:28:18', '1', null, null, null), ('334', '20151118172838', '13141235307', '2', '21', '1', 'online', 'weixin_JSAPI', 'unpay', null, null, null, '60.00', '1.00', '2015-11-18 17:28:38', '1', 'unpay', null, null, '2015-11-18 17:28:38', null, '2015-11-18 17:28:38', '1', null, null, null), ('335', '20151118174512', '13141235307', '2', '21', '1', 'online', 'weixin_JSAPI', 'unpay', null, null, null, '60.00', '1.00', '2015-11-18 17:45:12', '1', 'unpay', null, null, '2015-11-18 17:45:12', null, '2015-11-18 17:45:12', '0', null, null, null), ('336', '20151118174558', '13141235307', '2', '21', '1', 'online', 'weixin_JSAPI', 'unpay', null, null, null, '60.00', '1.00', '2015-11-18 17:45:58', '1', 'unpay', null, null, '2015-11-18 17:45:58', null, '2015-11-18 17:45:58', '0', null, null, null), ('337', '20160313172724', '15210497261', '231', '13', '405', 'online', 'weixin_JSAPI', 'unpay', null, null, null, '35.00', '1.00', '2016-03-13 17:27:24', '1', 'unpay', null, '1', '2016-03-13 17:27:24', '1', '2016-03-13 17:27:24', '0', null, null, null), ('338', '20160313172726', '15210497261', '231', '13', '405', 'online', 'weixin_JSAPI', 'unpay', null, null, null, '35.00', '1.00', '2016-03-13 17:27:26', '1', 'unpay', null, '1', '2016-03-13 17:27:26', '1', '2016-03-13 17:27:26', '0', null, null, null), ('339', '20160313172726', '15210497261', '231', '13', '405', 'online', 'weixin_JSAPI', 'unpay', null, null, null, '35.00', '1.00', '2016-03-13 17:27:26', '1', 'unpay', null, '1', '2016-03-13 17:27:26', '1', '2016-03-13 17:27:26', '0', null, null, null), ('340', '20160313172726', '15210497261', '231', '13', '405', 'online', 'weixin_JSAPI', 'unpay', null, null, null, '35.00', '1.00', '2016-03-13 17:27:26', '1', 'unpay', null, '1', '2016-03-13 17:27:26', '1', '2016-03-13 17:27:26', '0', null, null, null), ('341', '20160313172727', '15210497261', '231', '13', '405', 'online', 'weixin_JSAPI', 'unpay', null, null, null, '35.00', '1.00', '2016-03-13 17:27:27', '1', 'unpay', null, '1', '2016-03-13 17:27:27', '1', '2016-03-13 17:27:27', '0', null, null, null), ('342', '20160313172727', '15210497261', '231', '13', '405', 'online', 'weixin_JSAPI', 'unpay', null, null, null, '35.00', '1.00', '2016-03-13 17:27:27', '1', 'unpay', null, '1', '2016-03-13 17:27:27', '1', '2016-03-13 17:27:27', '0', null, null, null);
COMMIT;

-- ----------------------------
--  Table structure for `base_point_detail`
-- ----------------------------
DROP TABLE IF EXISTS `base_point_detail`;
CREATE TABLE `base_point_detail` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `user_id` mediumint(64) NOT NULL,
  `site_id` mediumint(64) DEFAULT NULL,
  `company_id` mediumint(64) DEFAULT NULL,
  `change_type` varchar(255) NOT NULL COMMENT '交易类型',
  `operate` decimal(19,2) NOT NULL COMMENT '变化数',
  `balance` decimal(19,2) NOT NULL COMMENT '余额',
  `fund_direction` varchar(255) NOT NULL COMMENT '自己流动方向',
  `change_desc` varchar(255) NOT NULL COMMENT '交易描述',
  `target_type` varchar(120) NOT NULL COMMENT '交易对象类型',
  `target` varchar(255) NOT NULL COMMENT '交易对象',
  `fund_timestamp` bigint(20) NOT NULL COMMENT '时间戳',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `del_flag` char(1) NOT NULL COMMENT '删除标示',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `base_replenish`
-- ----------------------------
DROP TABLE IF EXISTS `base_replenish`;
CREATE TABLE `base_replenish` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderId` varchar(255) NOT NULL,
  `replenishFee` decimal(10,0) NOT NULL,
  `replenishUseFee` decimal(10,0) DEFAULT NULL,
  `replenishDay` datetime DEFAULT NULL,
  `replenishStatus` varchar(255) DEFAULT NULL,
  `replenishType` varchar(255) DEFAULT NULL,
  `replenishEndDay` datetime DEFAULT NULL,
  `userId` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Records of `base_replenish`
-- ----------------------------
BEGIN;
INSERT INTO `base_replenish` VALUES ('1', '1460114631120', '100', '0', '2016-04-08 19:23:52', 'waiting', 'alipay_wap', null, '13'), ('2', '1460114654377', '100', '0', '2016-04-08 19:24:14', 'waiting', 'jdpay_wap', null, '13'), ('3', '1460114958859', '100', '0', '2016-04-08 19:29:19', 'waiting', 'alipay_wap', null, '13');
COMMIT;

-- ----------------------------
--  Table structure for `base_sms_log`
-- ----------------------------
DROP TABLE IF EXISTS `base_sms_log`;
CREATE TABLE `base_sms_log` (
  `id` mediumint(64) NOT NULL AUTO_INCREMENT,
  `site_id` mediumint(64) DEFAULT NULL COMMENT '站点',
  `company_id` mediumint(64) DEFAULT NULL COMMENT '商户',
  `user_id` mediumint(64) NOT NULL COMMENT '用户',
  `mobile` varchar(12) NOT NULL COMMENT '手机号码',
  `status` varchar(25) NOT NULL COMMENT '发送状态',
  `content` varchar(2000) DEFAULT NULL COMMENT '信息内容',
  `user_type` varchar(64) DEFAULT NULL COMMENT '用户类型（前后台）',
  `apply_ip` varchar(100) DEFAULT NULL COMMENT '申请ip',
  `create_date` datetime NOT NULL COMMENT '发送时间',
  `del_flag` char(1) DEFAULT NULL COMMENT '删除标示',
  `result` varchar(64) NOT NULL COMMENT '发送结果',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `cms_article`
-- ----------------------------
DROP TABLE IF EXISTS `cms_article`;
CREATE TABLE `cms_article` (
  `id` mediumint(64) NOT NULL AUTO_INCREMENT,
  `category_id` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '栏目编号',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标题',
  `link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '文章链接',
  `color` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题颜色',
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '文章图片',
  `keywords` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '关键字',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '描述、摘要',
  `weight` int(11) DEFAULT '0' COMMENT '权重，越大越靠前',
  `weight_date` datetime DEFAULT NULL COMMENT '权重期限',
  `hits` int(11) DEFAULT '0' COMMENT '点击数',
  `posid` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '推荐位，多选',
  `custom_content_view` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '自定义内容视图',
  `view_config` text COLLATE utf8mb4_unicode_ci COMMENT '视图配置',
  `create_by` mediumint(64) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` mediumint(64) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `cms_article_create_by` (`create_by`),
  KEY `cms_article_del_flag` (`del_flag`),
  KEY `cms_article_weight` (`weight`),
  KEY `cms_article_update_date` (`update_date`),
  KEY `cms_article_category_id` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='文章表';

-- ----------------------------
--  Records of `cms_article`
-- ----------------------------
BEGIN;
INSERT INTO `cms_article` VALUES ('1', '3', '文章标题标题标题标题', null, 'green', null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('2', '3', '文章标题标题标题标题', null, 'red', null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('3', '3', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('4', '3', '文章标题标题标题标题', null, 'green', null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('5', '3', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('6', '3', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('7', '4', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('8', '4', '文章标题标题标题标题', null, 'blue', null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('9', '4', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('10', '4', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('11', '5', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('12', '5', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('13', '5', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('14', '7', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('15', '7', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('16', '7', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('17', '7', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('18', '8', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('19', '8', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('20', '8', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('21', '8', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('22', '9', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('23', '9', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('24', '9', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('25', '9', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('26', '9', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('27', '11', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('28', '11', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('29', '11', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('30', '11', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('31', '11', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('32', '12', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('33', '12', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('34', '12', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('35', '12', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('36', '12', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('37', '13', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('38', '13', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('39', '13', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('40', '13', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('41', '14', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('42', '14', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('43', '14', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('44', '14', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('45', '14', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('46', '15', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('47', '15', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('48', '15', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('49', '16', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('50', '17', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('51', '17', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('52', '26', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('53', '26', '文章标题标题标题标题', null, null, null, '关键字1,关键字2', null, '0', null, '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
COMMIT;

-- ----------------------------
--  Table structure for `cms_article_data`
-- ----------------------------
DROP TABLE IF EXISTS `cms_article_data`;
CREATE TABLE `cms_article_data` (
  `id` mediumint(64) NOT NULL AUTO_INCREMENT,
  `content` text COLLATE utf8mb4_unicode_ci COMMENT '文章内容',
  `copyfrom` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '文章来源',
  `relation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '相关文章',
  `allow_comment` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否允许评论',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='文章详表';

-- ----------------------------
--  Records of `cms_article_data`
-- ----------------------------
BEGIN;
INSERT INTO `cms_article_data` VALUES ('1', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('2', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('3', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('4', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('5', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('6', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('7', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('8', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('9', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('10', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('11', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('12', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('13', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('14', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('15', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('16', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('17', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('18', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('19', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('20', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('21', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('22', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('23', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('24', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('25', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('26', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('27', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('28', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('29', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('30', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('31', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('32', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('33', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('34', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('35', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('36', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('37', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('38', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('39', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('40', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('41', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('42', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('43', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('44', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('45', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('46', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('47', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('48', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('49', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('50', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('51', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('52', '文章内容内容内容内容', '来源', '1,2,3', '1'), ('53', '文章内容内容内容内容', '来源', '1,2,3', '1');
COMMIT;

-- ----------------------------
--  Table structure for `cms_category`
-- ----------------------------
DROP TABLE IF EXISTS `cms_category`;
CREATE TABLE `cms_category` (
  `id` mediumint(64) NOT NULL AUTO_INCREMENT,
  `parent_id` mediumint(64) DEFAULT NULL,
  `parent_ids` varchar(2000) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '所有父级编号',
  `site_id` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT '1' COMMENT '站点编号',
  `office_id` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '归属机构',
  `module` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '栏目模块',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '栏目名称',
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '栏目图片',
  `href` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '链接',
  `target` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '目标',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '描述',
  `keywords` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '关键字',
  `sort` int(11) DEFAULT '30' COMMENT '排序（升序）',
  `in_menu` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '1' COMMENT '是否在导航中显示',
  `in_list` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '1' COMMENT '是否在分类页中显示列表',
  `show_modes` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '展现方式',
  `allow_comment` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否允许评论',
  `is_audit` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否需要审核',
  `custom_list_view` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '自定义列表视图',
  `custom_content_view` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '自定义内容视图',
  `view_config` text COLLATE utf8mb4_unicode_ci COMMENT '视图配置',
  `create_by` mediumint(64) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` mediumint(64) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `cms_category_parent_id` (`parent_id`),
  KEY `cms_category_module` (`module`),
  KEY `cms_category_name` (`name`),
  KEY `cms_category_sort` (`sort`),
  KEY `cms_category_del_flag` (`del_flag`),
  KEY `cms_category_office_id` (`office_id`),
  KEY `cms_category_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='栏目表';

-- ----------------------------
--  Records of `cms_category`
-- ----------------------------
BEGIN;
INSERT INTO `cms_category` VALUES ('1', '0', '0,', '0', '1', null, '顶级栏目', null, null, null, null, null, '0', '1', '1', '0', '0', '1', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('2', '1', '0,1,', '1', '3', 'article', '组织机构', null, null, null, null, null, '10', '1', '1', '0', '0', '1', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('3', '2', '0,1,2,', '1', '3', 'article', '网站简介', null, null, null, null, null, '30', '1', '1', '0', '0', '1', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('4', '2', '0,1,2,', '1', '3', 'article', '内部机构', null, null, null, null, null, '40', '1', '1', '0', '0', '1', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('5', '2', '0,1,2,', '1', '3', 'article', '地方机构', null, null, null, null, null, '50', '1', '1', '0', '0', '1', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('6', '1', '0,1,', '1', '3', 'article', '质量检验', null, null, null, null, null, '20', '1', '1', '1', '1', '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('7', '6', '0,1,6,', '1', '3', 'article', '产品质量', null, null, null, null, null, '30', '1', '1', '0', '1', '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('8', '6', '0,1,6,', '1', '3', 'article', '技术质量', null, null, null, null, null, '40', '1', '1', '0', '1', '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('9', '6', '0,1,6,', '1', '3', 'article', '工程质量', null, null, null, null, null, '50', '1', '1', '0', '1', '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('10', '1', '0,1,', '1', '4', 'article', '软件介绍', null, null, null, null, null, '20', '1', '1', '0', '1', '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('11', '10', '0,1,10,', '1', '4', 'article', '网络工具', null, null, null, null, null, '30', '1', '1', '0', '1', '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('12', '10', '0,1,10,', '1', '4', 'article', '浏览工具', null, null, null, null, null, '40', '1', '1', '0', '1', '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('13', '10', '0,1,10,', '1', '4', 'article', '浏览辅助', null, null, null, null, null, '50', '1', '1', '0', '1', '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('14', '10', '0,1,10,', '1', '4', 'article', '网络优化', null, null, null, null, null, '50', '1', '1', '0', '1', '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('15', '10', '0,1,10,', '1', '4', 'article', '邮件处理', null, null, null, null, null, '50', '1', '1', '0', '1', '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('16', '10', '0,1,10,', '1', '4', 'article', '下载工具', null, null, null, null, null, '50', '1', '1', '0', '1', '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('17', '10', '0,1,10,', '1', '4', 'article', '搜索工具', null, null, null, null, null, '50', '1', '1', '2', '1', '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('18', '1', '0,1,', '1', '5', 'link', '友情链接', null, null, null, null, null, '90', '1', '1', '0', '1', '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('19', '18', '0,1,18,', '1', '5', 'link', '常用网站', null, null, null, null, null, '50', '1', '1', '0', '1', '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('20', '18', '0,1,18,', '1', '5', 'link', '门户网站', null, null, null, null, null, '50', '1', '1', '0', '1', '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('21', '18', '0,1,18,', '1', '5', 'link', '购物网站', null, null, null, null, null, '50', '1', '1', '0', '1', '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('22', '18', '0,1,18,', '1', '5', 'link', '交友社区', null, null, null, null, null, '50', '1', '1', '0', '1', '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('23', '18', '0,1,18,', '1', '5', 'link', '音乐视频', null, null, null, null, null, '50', '1', '1', '0', '1', '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('24', '1', '0,1,', '1', '6', null, '百度一下', null, 'http://www.baidu.com', '_blank', null, null, '90', '1', '1', '0', '1', '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('25', '1', '0,1,', '1', '6', null, '全文检索', null, '/search', null, null, null, '90', '0', '1', '0', '1', '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('26', '1', '0,1,', '2', '6', 'article', '测试栏目', null, null, null, null, null, '90', '1', '1', '0', '1', '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('27', '1', '0,1,', '1', '6', null, '公共留言', null, '/guestbook', null, null, null, '90', '1', '1', '0', '1', '0', null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
COMMIT;

-- ----------------------------
--  Table structure for `cms_comment`
-- ----------------------------
DROP TABLE IF EXISTS `cms_comment`;
CREATE TABLE `cms_comment` (
  `id` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '编号',
  `category_id` mediumint(64) NOT NULL COMMENT '栏目编号',
  `content_id` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '栏目内容的编号',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '栏目内容的标题',
  `content` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '评论内容',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '评论姓名',
  `ip` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '评论IP',
  `create_date` datetime NOT NULL COMMENT '评论时间',
  `audit_user_id` mediumint(64) NOT NULL,
  `audit_date` datetime DEFAULT NULL COMMENT '审核时间',
  `del_flag` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `cms_comment_category_id` (`category_id`),
  KEY `cms_comment_content_id` (`content_id`),
  KEY `cms_comment_status` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='评论表';

-- ----------------------------
--  Table structure for `cms_guestbook`
-- ----------------------------
DROP TABLE IF EXISTS `cms_guestbook`;
CREATE TABLE `cms_guestbook` (
  `id` mediumint(64) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `type` char(1) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '留言分类',
  `content` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '留言内容',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '姓名',
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '邮箱',
  `phone` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '电话',
  `workunit` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '单位',
  `ip` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'IP',
  `create_date` datetime NOT NULL COMMENT '留言时间',
  `re_user_id` mediumint(64) NOT NULL COMMENT '回复人',
  `re_date` datetime DEFAULT NULL COMMENT '回复时间',
  `re_content` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '回复内容',
  `del_flag` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `cms_guestbook_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='留言板';

-- ----------------------------
--  Table structure for `cms_link`
-- ----------------------------
DROP TABLE IF EXISTS `cms_link`;
CREATE TABLE `cms_link` (
  `id` mediumint(64) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `category_id` mediumint(64) DEFAULT NULL COMMENT '栏目编号',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '链接名称',
  `color` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题颜色',
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '链接图片',
  `href` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '链接地址',
  `weight` int(11) DEFAULT '0' COMMENT '权重，越大越靠前',
  `weight_date` datetime DEFAULT NULL COMMENT '权重期限',
  `create_by` mediumint(64) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` mediumint(64) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `cms_link_category_id` (`category_id`),
  KEY `cms_link_del_flag` (`del_flag`),
  KEY `cms_link_weight` (`weight`),
  KEY `cms_link_create_by` (`create_by`),
  KEY `cms_link_update_date` (`update_date`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='友情链接';

-- ----------------------------
--  Records of `cms_link`
-- ----------------------------
BEGIN;
INSERT INTO `cms_link` VALUES ('1', '19', 'JeeSite', null, null, 'http://thinkgem.github.com/jeesite', '0', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('2', '19', 'ThinkGem', null, null, 'http://thinkgem.iteye.com/', '0', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('3', '19', '百度一下', null, null, 'http://www.baidu.com', '0', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('4', '19', '谷歌搜索', null, null, 'http://www.google.com', '0', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('5', '20', '新浪网', null, null, 'http://www.sina.com.cn', '0', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('6', '20', '腾讯网', null, null, 'http://www.qq.com/', '0', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('7', '21', '淘宝网', null, null, 'http://www.taobao.com/', '0', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('8', '21', '新华网', null, null, 'http://www.xinhuanet.com/', '0', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('9', '22', '赶集网', null, null, 'http://www.ganji.com/', '0', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('10', '22', '58同城', null, null, 'http://www.58.com/', '0', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('11', '23', '视频大全', null, null, 'http://v.360.cn/', '0', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('12', '23', '凤凰网', null, null, 'http://www.ifeng.com/', '0', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
COMMIT;

-- ----------------------------
--  Table structure for `cms_site`
-- ----------------------------
DROP TABLE IF EXISTS `cms_site`;
CREATE TABLE `cms_site` (
  `id` mediumint(64) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '站点名称',
  `title` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '站点标题',
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '站点Logo',
  `domain` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '站点域名',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '描述',
  `keywords` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '关键字',
  `theme` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'default' COMMENT '主题',
  `copyright` text COLLATE utf8mb4_unicode_ci COMMENT '版权信息',
  `custom_index_view` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '自定义站点首页视图',
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `cms_site_del_flag` (`del_flag`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='站点表';

-- ----------------------------
--  Records of `cms_site`
-- ----------------------------
BEGIN;
INSERT INTO `cms_site` VALUES ('1', '默认站点', 'JeeSite Web', null, null, 'JeeSite', 'JeeSite', 'basic', 'Copyright &copy; 2012-2013 <a href=\'http://thinkgem.iteye.com\' target=\'_blank\'>ThinkGem</a> - Powered By <a href=\'https://github.com/thinkgem/jeesite\' target=\'_blank\'>JeeSite</a> V1.0', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('2', '子站点测试', 'JeeSite Subsite', null, null, 'JeeSite subsite', 'JeeSite subsite', 'basic', 'Copyright &copy; 2012-2013 <a href=\'http://thinkgem.iteye.com\' target=\'_blank\'>ThinkGem</a> - Powered By <a href=\'https://github.com/thinkgem/jeesite\' target=\'_blank\'>JeeSite</a> V1.0', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
COMMIT;

-- ----------------------------
--  Table structure for `company_account`
-- ----------------------------
DROP TABLE IF EXISTS `company_account`;
CREATE TABLE `company_account` (
  `id` mediumint(10) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `company_id` mediumint(64) NOT NULL COMMENT '商户主键',
  `balance` decimal(19,2) DEFAULT '0.00' COMMENT '可用余额',
  `frozen_amount` decimal(19,2) DEFAULT NULL COMMENT '冻结金额',
  `create_ip` varchar(30) DEFAULT NULL COMMENT '创建ip',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Records of `company_account`
-- ----------------------------
BEGIN;
INSERT INTO `company_account` VALUES ('9', '27', '490.00', '0.00', null, '2015-11-14 23:17:14', null), ('10', '1', '233.00', '0.00', null, '2015-11-14 23:17:18', null), ('11', '30', '400.00', '500.00', null, '2015-11-21 21:09:14', null);
COMMIT;

-- ----------------------------
--  Table structure for `company_bank`
-- ----------------------------
DROP TABLE IF EXISTS `company_bank`;
CREATE TABLE `company_bank` (
  `id` mediumint(10) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `company_id` mediumint(64) NOT NULL COMMENT '商户主键',
  `bankcard_owner` varchar(60) NOT NULL COMMENT '开户名称',
  `bank_name` varchar(50) NOT NULL COMMENT '开户支行',
  `bank_branch_name` varchar(500) DEFAULT NULL COMMENT '开户支行',
  `bank_NO` varchar(50) NOT NULL COMMENT '银行卡号',
  `bank_code` varchar(64) DEFAULT NULL COMMENT '银行代码',
  `del_flag` char(1) NOT NULL COMMENT '删除标示',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_date` datetime NOT NULL COMMENT '创建日期',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `update_by` mediumint(64) DEFAULT NULL COMMENT '更新人',
  `create_by` mediumint(64) DEFAULT NULL COMMENT '创建人',
  `useable` varchar(64) DEFAULT NULL COMMENT '是否可用',
  `audit_by` mediumint(64) DEFAULT NULL COMMENT '审核人',
  `audit_date` datetime NOT NULL COMMENT '审核时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Records of `company_bank`
-- ----------------------------
BEGIN;
INSERT INTO `company_bank` VALUES ('1', '1', '北京拓达', '工商银行', '上地支行', '622632343432242', 'CMB', '0', '', '2015-11-14 23:25:04', '2015-11-15 17:51:49', '1', null, '1', null, '2015-11-14 23:25:23');
COMMIT;

-- ----------------------------
--  Table structure for `company_cashout`
-- ----------------------------
DROP TABLE IF EXISTS `company_cashout`;
CREATE TABLE `company_cashout` (
  `id` mediumint(64) NOT NULL AUTO_INCREMENT,
  `site_id` mediumint(64) DEFAULT NULL COMMENT '站点',
  `company_id` mediumint(64) DEFAULT NULL COMMENT '合作机构',
  `user_id` mediumint(64) NOT NULL COMMENT '用户',
  `apply_amount` decimal(19,2) NOT NULL COMMENT '提现金额',
  `cashout_fee` decimal(19,2) DEFAULT NULL COMMENT '提现费用',
  `status` varchar(255) NOT NULL COMMENT '状态- 审核中-处理中-提现成功',
  `content` varchar(2000) DEFAULT NULL COMMENT '描述',
  `audit_date` datetime DEFAULT '0000-00-00 00:00:00' COMMENT '审核时间',
  `audit_id` mediumint(64) DEFAULT NULL COMMENT '审核人',
  `apply_ip` varchar(100) DEFAULT NULL COMMENT '申请ip',
  `create_date` datetime NOT NULL,
  `del_flag` char(1) DEFAULT NULL COMMENT '删除标示',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Records of `company_cashout`
-- ----------------------------
BEGIN;
INSERT INTO `company_cashout` VALUES ('1', '0', '30', '1', '100.00', '2.00', 'success', '中', null, '1', '11', '2015-11-17 18:01:06', '0'), ('2', '0', '30', '1', '100.00', '10.00', 'success', '中', null, '1', '11', '2015-11-17 18:01:06', '0'), ('3', '0', '30', '1', '100.00', '5.00', 'fail', '中', null, '1', '11', '2015-11-17 18:01:06', '0'), ('4', '0', '30', '1', '100.00', '3.00', 'fail', '中', null, '1', '11', '2015-11-17 18:01:06', '0'), ('5', '0', '30', '1', '100.00', '15.00', 'audit', '中', null, '1', '11', '2015-11-17 18:01:06', '0'), ('6', '0', '30', '1', '100.00', '20.00', 'audit', '中', null, '1', '11', '2015-11-17 18:01:06', '0'), ('7', null, '1', '1', '100.00', '12.00', 'audit', '', null, null, '0:0:0:0:0:0:0:1', '2015-11-22 23:16:22', '0'), ('8', null, '1', '1', '100.00', '12.00', 'audit', '', null, null, '0:0:0:0:0:0:0:1', '2015-11-22 23:17:46', '0');
COMMIT;

-- ----------------------------
--  Table structure for `company_funddetail`
-- ----------------------------
DROP TABLE IF EXISTS `company_funddetail`;
CREATE TABLE `company_funddetail` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `user_id` mediumint(64) DEFAULT NULL,
  `site_id` mediumint(64) DEFAULT NULL,
  `company_id` mediumint(64) NOT NULL,
  `change_type` varchar(255) NOT NULL COMMENT '交易类型',
  `operate` decimal(19,2) NOT NULL COMMENT '变化数',
  `balance` decimal(19,2) NOT NULL COMMENT '余额',
  `frozen_amount` decimal(19,2) NOT NULL DEFAULT '0.00' COMMENT '冻结资金',
  `fund_direction` varchar(255) NOT NULL COMMENT '自己流动方向',
  `change_desc` varchar(255) NOT NULL COMMENT '交易描述',
  `target_type` varchar(120) NOT NULL COMMENT '交易对象类型',
  `target` varchar(255) NOT NULL COMMENT '交易对象',
  `fund_timestamp` bigint(20) NOT NULL COMMENT '时间戳',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `del_flag` char(1) NOT NULL COMMENT '删除标示',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Records of `company_funddetail`
-- ----------------------------
BEGIN;
INSERT INTO `company_funddetail` VALUES ('7', null, null, '27', 'settle', '490.00', '980.00', '0.00', 'IN', '结算', 'Portal', 'Portal', '1447514237385', '2015-11-14 23:17:17', '0', null), ('8', null, null, '1', 'settle', '233.00', '466.00', '0.00', 'IN', '结算', 'Portal', 'Portal', '1447514239568', '2015-11-14 23:17:19', '0', null), ('13', '1', null, '30', 'cashoutSuccess', '100.00', '0.00', '-200.00', 'OUT', '提现成功', 'Portal', '平台', '1448115712969', '2015-11-21 22:21:52', '0', null), ('14', '1', null, '30', 'cashoutSuccess', '100.00', '100.00', '800.00', 'OUT', '提现成功', 'Portal', '平台', '1448117002795', '2015-11-21 22:43:22', '0', null), ('15', '1', null, '30', 'cashoutSuccess', '100.00', '100.00', '700.00', 'OUT', '提现成功', 'Portal', '平台', '1448117083104', '2015-11-21 22:44:43', '0', null), ('16', '1', null, '30', 'cashoutFail', '100.00', '300.00', '600.00', 'IN', '提现失败', 'Portal', '平台', '1448117184849', '2015-11-21 22:46:24', '0', null), ('17', '1', null, '30', 'cashoutFail', '100.00', '300.00', '600.00', 'IN', '提现失败', 'Portal', '平台', '1448117429818', '2015-11-21 22:50:29', '0', null), ('18', '1', null, '30', 'cashoutFail', '100.00', '400.00', '500.00', 'IN', '提现失败', 'Portal', '平台', '1448118327774', '2015-11-21 23:05:27', '0', null);
COMMIT;

-- ----------------------------
--  Table structure for `company_settle_log`
-- ----------------------------
DROP TABLE IF EXISTS `company_settle_log`;
CREATE TABLE `company_settle_log` (
  `id` mediumint(10) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `company_id` mediumint(64) NOT NULL COMMENT '商户主键',
  `pay_net_money` decimal(19,2) NOT NULL COMMENT '支付净额',
  `poundage` decimal(19,2) NOT NULL COMMENT '手续费金额',
  `settle_money` decimal(19,2) DEFAULT NULL COMMENT '划账金额',
  `settle_type` varchar(50) NOT NULL COMMENT '单据类别',
  `create_date` datetime NOT NULL COMMENT '划账日期',
  `begin_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `bills_count` int(64) NOT NULL COMMENT '单据数量',
  `need_audit` varchar(32) DEFAULT NULL COMMENT '是否需要审核',
  `audit_status` varchar(64) DEFAULT NULL COMMENT '审核状态',
  `audit_by` mediumint(64) DEFAULT NULL COMMENT '审核人',
  `audit_date` datetime DEFAULT NULL COMMENT '审核时间',
  `del_flag` char(1) NOT NULL COMMENT '删除标示',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Records of `company_settle_log`
-- ----------------------------
BEGIN;
INSERT INTO `company_settle_log` VALUES ('29', '27', '490.00', '0.00', '490.00', 'IN', '2015-11-14 23:17:14', '2015-10-26 13:51:06', '2015-11-05 20:38:41', '318', '1', 'audit', null, null, '0', null), ('30', '1', '233.00', '0.00', '233.00', 'IN', '2015-11-14 23:17:18', '2015-08-31 09:42:43', '2015-11-05 20:38:37', '9', '1', 'audit', null, null, '0', null);
COMMIT;

-- ----------------------------
--  Table structure for `gen_scheme`
-- ----------------------------
DROP TABLE IF EXISTS `gen_scheme`;
CREATE TABLE `gen_scheme` (
  `id` mediumint(64) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `category` varchar(2000) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '分类',
  `package_name` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '生成模块名',
  `sub_module_name` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '生成子模块名',
  `function_name` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '生成功能名',
  `function_name_simple` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '生成功能名（简写）',
  `function_author` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '生成功能作者',
  `gen_table_id` mediumint(64) DEFAULT NULL,
  `create_by` mediumint(64) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` mediumint(64) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  PRIMARY KEY (`id`),
  KEY `gen_scheme_del_flag` (`del_flag`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='生成方案';

-- ----------------------------
--  Records of `gen_scheme`
-- ----------------------------
BEGIN;
INSERT INTO `gen_scheme` VALUES ('1', '单表', 'curd', 'com.thinkgem.jeesite.modules', 'test', null, '单表生成', '单表', 'ThinkGem', '1', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('2', '主子表', 'curd_many', 'com.thinkgem.jeesite.modules', 'test', null, '主子表生成', '主子表', 'ThinkGem', '2', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('3', '树结构', 'treeTable', 'com.thinkgem.jeesite.modules', 'test', null, '树结构生成', '树结构', 'ThinkGem', '4', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
COMMIT;

-- ----------------------------
--  Table structure for `gen_table`
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table` (
  `id` mediumint(64) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `comments` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '描述',
  `class_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '实体类名称',
  `parent_table` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '关联父表',
  `parent_table_fk` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '关联父表外键',
  `create_by` mediumint(64) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` mediumint(64) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  PRIMARY KEY (`id`),
  KEY `gen_table_del_flag` (`del_flag`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='业务表';

-- ----------------------------
--  Records of `gen_table`
-- ----------------------------
BEGIN;
INSERT INTO `gen_table` VALUES ('1', 'test_data', '业务数据表', 'TestData', null, null, '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('2', 'test_data_main', '业务数据表', 'TestDataMain', null, null, '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('3', 'test_data_child', '业务数据子表', 'TestDataChild', 'test_data_main', 'test_data_main_id', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('4', 'test_tree', '树结构表', 'TestTree', null, null, '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
COMMIT;

-- ----------------------------
--  Table structure for `gen_table_column`
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column` (
  `id` mediumint(64) NOT NULL AUTO_INCREMENT,
  `gen_table_id` mediumint(64) DEFAULT NULL,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `comments` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '描述',
  `jdbc_type` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '列的数据类型的字节长度',
  `java_type` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否主键',
  `is_null` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否可为空',
  `is_insert` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否为插入字段',
  `is_edit` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否编辑字段',
  `is_list` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否列表字段',
  `is_query` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否查询字段',
  `query_type` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '查询方式（等于、不等于、大于、小于、范围、左LIKE、右LIKE、左右LIKE）',
  `show_type` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '字段生成方案（文本框、文本域、下拉框、复选框、单选框、字典选择、人员选择、部门选择、区域选择）',
  `dict_type` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '字典类型',
  `settings` varchar(2000) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '其它设置（扩展字段JSON）',
  `sort` decimal(10,0) DEFAULT NULL COMMENT '排序（升序）',
  `create_by` mediumint(64) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` mediumint(64) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  PRIMARY KEY (`id`),
  KEY `gen_table_column_table_id` (`gen_table_id`),
  KEY `gen_table_column_sort` (`sort`),
  KEY `gen_table_column_del_flag` (`del_flag`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='业务表字段';

-- ----------------------------
--  Records of `gen_table_column`
-- ----------------------------
BEGIN;
INSERT INTO `gen_table_column` VALUES ('49', '1', 'id', '编号', 'varchar2(64)', 'String', 'id', '1', '0', '1', '0', '0', '0', '=', 'input', null, null, '1', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('50', '1', 'user_id', '归属用户', 'varchar2(64)', 'com.thinkgem.jeesite.modules.modules.sys.entity.User', 'user.id|name', '0', '1', '1', '1', '1', '1', '=', 'userselect', null, null, '2', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('51', '1', 'office_id', '归属部门', 'varchar2(64)', 'com.thinkgem.jeesite.modules.modules.sys.entity.Office', 'office.id|name', '0', '1', '1', '1', '1', '1', '=', 'officeselect', null, null, '3', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('52', '1', 'area_id', '归属区域', 'nvarchar2(64)', 'com.thinkgem.jeesite.modules.modules.sys.entity.Area', 'area.id|name', '0', '1', '1', '1', '1', '1', '=', 'areaselect', null, null, '4', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('53', '1', 'name', '名称', 'nvarchar2(100)', 'String', 'name', '0', '1', '1', '1', '1', '1', 'like', 'input', null, null, '5', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('54', '1', 'sex', '性别', 'char(1)', 'String', 'sex', '0', '1', '1', '1', '1', '1', '=', 'radiobox', 'sex', null, '6', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('55', '1', 'in_date', '加入日期', 'date(7)', 'java.util.Date', 'inDate', '0', '1', '1', '1', '0', '1', 'between', 'dateselect', null, null, '7', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('56', '1', 'create_by', '创建者', 'varchar2(64)', 'com.thinkgem.jeesite.modules.modules.sys.entity.User', 'createBy.id', '0', '0', '1', '0', '0', '0', '=', 'input', null, null, '8', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('57', '1', 'create_date', '创建时间', 'timestamp(6)', 'java.util.Date', 'createDate', '0', '0', '1', '0', '0', '0', '=', 'dateselect', null, null, '9', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('58', '1', 'update_by', '更新者', 'varchar2(64)', 'com.thinkgem.jeesite.modules.modules.sys.entity.User', 'updateBy.id', '0', '0', '1', '1', '0', '0', '=', 'input', null, null, '10', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('59', '1', 'update_date', '更新时间', 'timestamp(6)', 'java.util.Date', 'updateDate', '0', '0', '1', '1', '1', '0', '=', 'dateselect', null, null, '11', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('60', '1', 'remarks', '备注信息', 'nvarchar2(255)', 'String', 'remarks', '0', '1', '1', '1', '1', '0', '=', 'textarea', null, null, '12', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('61', '1', 'del_flag', '删除标记（0：正常；1：删除）', 'char(1)', 'String', 'delFlag', '0', '0', '1', '0', '0', '0', '=', 'radiobox', 'del_flag', null, '13', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('62', '2', 'id', '编号', 'varchar2(64)', 'String', 'id', '1', '0', '1', '0', '0', '0', '=', 'input', null, null, '1', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('63', '2', 'user_id', '归属用户', 'varchar2(64)', 'com.thinkgem.jeesite.modules.modules.sys.entity.User', 'user.id|name', '0', '1', '1', '1', '1', '1', '=', 'userselect', null, null, '2', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('64', '2', 'office_id', '归属部门', 'varchar2(64)', 'com.thinkgem.jeesite.modules.modules.sys.entity.Office', 'office.id|name', '0', '1', '1', '1', '0', '0', '=', 'officeselect', null, null, '3', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('65', '2', 'area_id', '归属区域', 'nvarchar2(64)', 'com.thinkgem.jeesite.modules.modules.sys.entity.Area', 'area.id|name', '0', '1', '1', '1', '0', '0', '=', 'areaselect', null, null, '4', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('66', '2', 'name', '名称', 'nvarchar2(100)', 'String', 'name', '0', '1', '1', '1', '1', '1', 'like', 'input', null, null, '5', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('67', '2', 'sex', '性别', 'char(1)', 'String', 'sex', '0', '1', '1', '1', '0', '1', '=', 'select', 'sex', null, '6', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('68', '2', 'in_date', '加入日期', 'date(7)', 'java.util.Date', 'inDate', '0', '1', '1', '1', '0', '0', '=', 'dateselect', null, null, '7', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('69', '2', 'create_by', '创建者', 'varchar2(64)', 'com.thinkgem.jeesite.modules.modules.sys.entity.User', 'createBy.id', '0', '0', '1', '0', '0', '0', '=', 'input', null, null, '8', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('70', '2', 'create_date', '创建时间', 'timestamp(6)', 'java.util.Date', 'createDate', '0', '0', '1', '0', '0', '0', '=', 'dateselect', null, null, '9', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('71', '2', 'update_by', '更新者', 'varchar2(64)', 'com.thinkgem.jeesite.modules.modules.sys.entity.User', 'updateBy.id', '0', '0', '1', '1', '0', '0', '=', 'input', null, null, '10', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('72', '2', 'update_date', '更新时间', 'timestamp(6)', 'java.util.Date', 'updateDate', '0', '0', '1', '1', '1', '0', '=', 'dateselect', null, null, '11', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('73', '2', 'remarks', '备注信息', 'nvarchar2(255)', 'String', 'remarks', '0', '1', '1', '1', '1', '0', '=', 'textarea', null, null, '12', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('74', '2', 'del_flag', '删除标记（0：正常；1：删除）', 'char(1)', 'String', 'delFlag', '0', '0', '1', '0', '0', '0', '=', 'radiobox', 'del_flag', null, '13', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('75', '3', 'id', '编号', 'varchar2(64)', 'String', 'id', '1', '0', '1', '0', '0', '0', '=', 'input', null, null, '1', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('76', '3', 'test_data_main_id', '业务主表', 'varchar2(64)', 'String', 'testDataMain.id', '0', '1', '1', '1', '0', '0', '=', 'input', null, null, '2', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('77', '3', 'name', '名称', 'nvarchar2(100)', 'String', 'name', '0', '1', '1', '1', '1', '1', 'like', 'input', null, null, '3', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('78', '3', 'create_by', '创建者', 'varchar2(64)', 'com.thinkgem.jeesite.modules.modules.sys.entity.User', 'createBy.id', '0', '0', '1', '0', '0', '0', '=', 'input', null, null, '4', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('79', '3', 'create_date', '创建时间', 'timestamp(6)', 'java.util.Date', 'createDate', '0', '0', '1', '0', '0', '0', '=', 'dateselect', null, null, '5', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('80', '3', 'update_by', '更新者', 'varchar2(64)', 'com.thinkgem.jeesite.modules.modules.sys.entity.User', 'updateBy.id', '0', '0', '1', '1', '0', '0', '=', 'input', null, null, '6', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('81', '3', 'update_date', '更新时间', 'timestamp(6)', 'java.util.Date', 'updateDate', '0', '0', '1', '1', '1', '0', '=', 'dateselect', null, null, '7', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('82', '3', 'remarks', '备注信息', 'nvarchar2(255)', 'String', 'remarks', '0', '1', '1', '1', '1', '0', '=', 'input', null, null, '8', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('83', '3', 'del_flag', '删除标记（0：正常；1：删除）', 'char(1)', 'String', 'delFlag', '0', '0', '1', '0', '0', '0', '=', 'radiobox', 'del_flag', null, '9', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('84', '4', 'id', '编号', 'varchar2(64)', 'String', 'id', '1', '0', '1', '0', '0', '0', '=', 'input', null, null, '1', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('85', '4', 'parent_id', '父级编号', 'varchar2(64)', 'This', 'parent.id|name', '0', '0', '1', '1', '0', '0', '=', 'treeselect', null, null, '2', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('86', '4', 'parent_ids', '所有父级编号', 'varchar2(2000)', 'String', 'parentIds', '0', '0', '1', '1', '0', '0', 'like', 'input', null, null, '3', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('87', '4', 'name', '名称', 'nvarchar2(100)', 'String', 'name', '0', '0', '1', '1', '1', '1', 'like', 'input', null, null, '4', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('88', '4', 'sort', '排序', 'number(10)', 'Integer', 'sort', '0', '0', '1', '1', '1', '0', '=', 'input', null, null, '5', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('89', '4', 'create_by', '创建者', 'varchar2(64)', 'com.thinkgem.jeesite.modules.modules.sys.entity.User', 'createBy.id', '0', '0', '1', '0', '0', '0', '=', 'input', null, null, '6', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('90', '4', 'create_date', '创建时间', 'timestamp(6)', 'java.util.Date', 'createDate', '0', '0', '1', '0', '0', '0', '=', 'dateselect', null, null, '7', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('91', '4', 'update_by', '更新者', 'varchar2(64)', 'com.thinkgem.jeesite.modules.modules.sys.entity.User', 'updateBy.id', '0', '0', '1', '1', '0', '0', '=', 'input', null, null, '8', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('92', '4', 'update_date', '更新时间', 'timestamp(6)', 'java.util.Date', 'updateDate', '0', '0', '1', '1', '1', '0', '=', 'dateselect', null, null, '9', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('93', '4', 'remarks', '备注信息', 'nvarchar2(255)', 'String', 'remarks', '0', '1', '1', '1', '1', '0', '=', 'textarea', null, null, '10', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0'), ('94', '4', 'del_flag', '删除标记（0：正常；1：删除）', 'char(1)', 'String', 'delFlag', '0', '0', '1', '0', '0', '0', '=', 'radiobox', 'del_flag', null, '11', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', null, '0');
COMMIT;

-- ----------------------------
--  Table structure for `gen_template`
-- ----------------------------
DROP TABLE IF EXISTS `gen_template`;
CREATE TABLE `gen_template` (
  `id` mediumint(64) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `category` varchar(2000) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '分类',
  `file_path` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '生成文件路径',
  `file_name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '生成文件名',
  `content` text COLLATE utf8mb4_unicode_ci COMMENT '内容',
  `create_by` mediumint(64) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` mediumint(64) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  PRIMARY KEY (`id`),
  KEY `gen_template_del_falg` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='代码模板表';

-- ----------------------------
--  Table structure for `oa_leave`
-- ----------------------------
DROP TABLE IF EXISTS `oa_leave`;
CREATE TABLE `oa_leave` (
  `id` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '编号',
  `process_instance_id` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '流程实例编号',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `leave_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '请假类型',
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '请假理由',
  `apply_time` datetime DEFAULT NULL COMMENT '申请时间',
  `reality_start_time` datetime DEFAULT NULL COMMENT '实际开始时间',
  `reality_end_time` datetime DEFAULT NULL COMMENT '实际结束时间',
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `oa_leave_create_by` (`create_by`),
  KEY `oa_leave_process_instance_id` (`process_instance_id`),
  KEY `oa_leave_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='请假流程表';

-- ----------------------------
--  Table structure for `oa_notify`
-- ----------------------------
DROP TABLE IF EXISTS `oa_notify`;
CREATE TABLE `oa_notify` (
  `id` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '编号',
  `type` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '类型',
  `title` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  `content` varchar(2000) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '内容',
  `files` varchar(2000) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '附件',
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '状态',
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `oa_notify_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='通知通告';

-- ----------------------------
--  Table structure for `oa_notify_record`
-- ----------------------------
DROP TABLE IF EXISTS `oa_notify_record`;
CREATE TABLE `oa_notify_record` (
  `id` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '编号',
  `oa_notify_id` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '通知通告ID',
  `user_id` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '接受人',
  `read_flag` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '阅读标记',
  `read_date` date DEFAULT NULL COMMENT '阅读时间',
  PRIMARY KEY (`id`),
  KEY `oa_notify_record_notify_id` (`oa_notify_id`),
  KEY `oa_notify_record_user_id` (`user_id`),
  KEY `oa_notify_record_read_flag` (`read_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='通知通告发送记录';

-- ----------------------------
--  Table structure for `sys_area`
-- ----------------------------
DROP TABLE IF EXISTS `sys_area`;
CREATE TABLE `sys_area` (
  `id` mediumint(64) NOT NULL AUTO_INCREMENT,
  `parent_id` mediumint(64) DEFAULT NULL,
  `parent_ids` varchar(2000) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '所有父级编号',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `sort` decimal(10,0) NOT NULL COMMENT '排序',
  `code` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '区域编码',
  `type` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '区域类型',
  `create_by` mediumint(64) DEFAULT NULL,
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` mediumint(64) DEFAULT NULL,
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_area_parent_id` (`parent_id`),
  KEY `sys_area_del_flag` (`del_flag`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='区域表';

-- ----------------------------
--  Records of `sys_area`
-- ----------------------------
BEGIN;
INSERT INTO `sys_area` VALUES ('1', '0', '0,', '中国', '10', '100000', '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('2', '1', '0,1,', '山东省', '20', '110000', '2', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('3', '2', '0,1,2,', '济南市', '30', '110101', '3', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('4', '3', '0,1,2,3,', '历城区', '40', '110102', '4', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('5', '3', '0,1,2,3,', '历下区', '50', '110104', '4', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('6', '3', '0,1,2,3,', '高新区', '60', '110105', '4', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
COMMIT;

-- ----------------------------
--  Table structure for `sys_dict`
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict` (
  `id` mediumint(64) NOT NULL AUTO_INCREMENT,
  `value` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '数据值',
  `label` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标签名',
  `type` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '类型',
  `description` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '描述',
  `sort` decimal(10,0) NOT NULL COMMENT '排序（升序）',
  `parent_id` mediumint(64) DEFAULT NULL,
  `create_by` mediumint(64) DEFAULT NULL,
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` mediumint(64) DEFAULT NULL,
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_dict_value` (`value`),
  KEY `sys_dict_label` (`label`),
  KEY `sys_dict_del_flag` (`del_flag`)
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='字典表';

-- ----------------------------
--  Records of `sys_dict`
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict` VALUES ('1', '0', '正常', 'del_flag', '删除标记', '10', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('2', '1', '删除', 'del_flag', '删除标记', '20', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('3', '1', '显示', 'show_hide', '显示/隐藏', '10', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('4', '0', '隐藏', 'show_hide', '显示/隐藏', '20', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('5', '1', '是', 'yes_no', '是/否', '10', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('6', '0', '否', 'yes_no', '是/否', '20', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('7', 'red', '红色', 'color', '颜色值', '10', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('8', 'green', '绿色', 'color', '颜色值', '20', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('9', 'blue', '蓝色', 'color', '颜色值', '30', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('10', 'yellow', '黄色', 'color', '颜色值', '40', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('11', 'orange', '橙色', 'color', '颜色值', '50', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('12', 'default', '默认主题', 'theme', '主题方案', '10', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('13', 'cerulean', '天蓝主题', 'theme', '主题方案', '20', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('14', 'readable', '橙色主题', 'theme', '主题方案', '30', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('15', 'united', '红色主题', 'theme', '主题方案', '40', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('16', 'flat', 'Flat主题', 'theme', '主题方案', '60', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('17', '1', '国家', 'sys_area_type', '区域类型', '10', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('18', '2', '省份、直辖市', 'sys_area_type', '区域类型', '20', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('19', '3', '地市', 'sys_area_type', '区域类型', '30', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('20', '4', '区县', 'sys_area_type', '区域类型', '40', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('21', '1', '公司', 'sys_office_type', '机构类型', '60', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('22', '2', '部门', 'sys_office_type', '机构类型', '70', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('23', '3', '小组', 'sys_office_type', '机构类型', '80', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('24', '4', '其它', 'sys_office_type', '机构类型', '90', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('25', '1', '综合部', 'sys_office_common', '快捷通用部门', '30', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('26', '2', '开发部', 'sys_office_common', '快捷通用部门', '40', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('27', '3', '人力部', 'sys_office_common', '快捷通用部门', '50', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('28', '1', '一级', 'sys_office_grade', '机构等级', '10', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('29', '2', '二级', 'sys_office_grade', '机构等级', '20', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('30', '3', '三级', 'sys_office_grade', '机构等级', '30', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('31', '4', '四级', 'sys_office_grade', '机构等级', '40', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('32', '1', '所有数据', 'sys_data_scope', '数据范围', '10', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('33', '2', '所在公司及以下数据', 'sys_data_scope', '数据范围', '20', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('34', '3', '所在公司数据', 'sys_data_scope', '数据范围', '30', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('35', '4', '所在部门及以下数据', 'sys_data_scope', '数据范围', '40', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('36', '5', '所在部门数据', 'sys_data_scope', '数据范围', '50', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('37', '8', '仅本人数据', 'sys_data_scope', '数据范围', '90', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('38', '9', '按明细设置', 'sys_data_scope', '数据范围', '100', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('39', '1', '系统管理', 'sys_user_type', '用户类型', '10', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('40', '2', '部门经理', 'sys_user_type', '用户类型', '20', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('41', '3', '普通用户', 'sys_user_type', '用户类型', '30', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('42', 'basic', '基础主题', 'cms_theme', '站点主题', '10', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('43', 'blue', '蓝色主题', 'cms_theme', '站点主题', '20', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1'), ('44', 'red', '红色主题', 'cms_theme', '站点主题', '30', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1'), ('45', 'article', '文章模型', 'cms_module', '栏目模型', '10', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('46', 'picture', '图片模型', 'cms_module', '栏目模型', '20', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1'), ('47', 'download', '下载模型', 'cms_module', '栏目模型', '30', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1'), ('48', 'link', '链接模型', 'cms_module', '栏目模型', '40', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('49', 'special', '专题模型', 'cms_module', '栏目模型', '50', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1'), ('50', '0', '默认展现方式', 'cms_show_modes', '展现方式', '10', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('51', '1', '首栏目内容列表', 'cms_show_modes', '展现方式', '20', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('52', '2', '栏目第一条内容', 'cms_show_modes', '展现方式', '30', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('53', '0', '发布', 'cms_del_flag', '内容状态', '10', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('54', '1', '删除', 'cms_del_flag', '内容状态', '20', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('55', '2', '审核', 'cms_del_flag', '内容状态', '15', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('56', '1', '首页焦点图', 'cms_posid', '推荐位', '10', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('57', '2', '栏目页文章推荐', 'cms_posid', '推荐位', '20', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('58', '1', '咨询', 'cms_guestbook', '留言板分类', '10', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('59', '2', '建议', 'cms_guestbook', '留言板分类', '20', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('60', '3', '投诉', 'cms_guestbook', '留言板分类', '30', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('61', '4', '其它', 'cms_guestbook', '留言板分类', '40', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('62', '1', '公休', 'oa_leave_type', '请假类型', '10', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('63', '2', '病假', 'oa_leave_type', '请假类型', '20', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('64', '3', '事假', 'oa_leave_type', '请假类型', '30', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('65', '4', '调休', 'oa_leave_type', '请假类型', '40', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('66', '5', '婚假', 'oa_leave_type', '请假类型', '60', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('67', '1', '接入日志', 'sys_log_type', '日志类型', '30', '0', '1', '2013-06-03 08:00:00', '1', '2013-06-03 08:00:00', null, '0'), ('68', '2', '异常日志', 'sys_log_type', '日志类型', '40', '0', '1', '2013-06-03 08:00:00', '1', '2013-06-03 08:00:00', null, '0'), ('69', 'leave', '请假流程', 'act_type', '流程类型', '10', '0', '1', '2013-06-03 08:00:00', '1', '2013-06-03 08:00:00', null, '0'), ('70', 'test_audit', '审批测试流程', 'act_type', '流程类型', '20', '0', '1', '2013-06-03 08:00:00', '1', '2013-06-03 08:00:00', null, '0'), ('71', '1', '分类1', 'act_category', '流程分类', '10', '0', '1', '2013-06-03 08:00:00', '1', '2013-06-03 08:00:00', null, '0'), ('72', '2', '分类2', 'act_category', '流程分类', '20', '0', '1', '2013-06-03 08:00:00', '1', '2013-06-03 08:00:00', null, '0'), ('73', 'crud', '增删改查', 'gen_category', '代码生成分类', '10', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1'), ('74', 'crud_many', '增删改查（包含从表）', 'gen_category', '代码生成分类', '20', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1'), ('75', 'tree', '树结构', 'gen_category', '代码生成分类', '30', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1'), ('76', '=', '=', 'gen_query_type', '查询方式', '10', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1'), ('77', '!=', '!=', 'gen_query_type', '查询方式', '20', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1'), ('78', '&gt;', '&gt;', 'gen_query_type', '查询方式', '30', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1'), ('79', '&lt;', '&lt;', 'gen_query_type', '查询方式', '40', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1'), ('80', 'between', 'Between', 'gen_query_type', '查询方式', '50', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1'), ('81', 'like', 'Like', 'gen_query_type', '查询方式', '60', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1'), ('82', 'left_like', 'Left Like', 'gen_query_type', '查询方式', '70', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1'), ('83', 'right_like', 'Right Like', 'gen_query_type', '查询方式', '80', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1'), ('84', 'input', '文本框', 'gen_show_type', '字段生成方案', '10', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1'), ('85', 'textarea', '文本域', 'gen_show_type', '字段生成方案', '20', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1'), ('86', 'select', '下拉框', 'gen_show_type', '字段生成方案', '30', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1'), ('87', 'checkbox', '复选框', 'gen_show_type', '字段生成方案', '40', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1'), ('88', 'radiobox', '单选框', 'gen_show_type', '字段生成方案', '50', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1'), ('89', 'dateselect', '日期选择', 'gen_show_type', '字段生成方案', '60', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1'), ('90', 'userselect', '人员选择\0', 'gen_show_type', '字段生成方案', '70', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1'), ('91', 'officeselect', '部门选择', 'gen_show_type', '字段生成方案', '80', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1'), ('92', 'areaselect', '区域选择', 'gen_show_type', '字段生成方案', '90', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1'), ('93', 'String', 'String', 'gen_java_type', 'Java类型', '10', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1'), ('94', 'Long', 'Long', 'gen_java_type', 'Java类型', '20', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1'), ('95', 'dao', '仅持久层', 'gen_category', '代码生成分类\0\0\0\0\0\0', '40', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1'), ('96', '1', '男', 'sex', '性别', '10', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '0'), ('97', '2', '女', 'sex', '性别', '20', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '0'), ('98', 'Integer', 'Integer', 'gen_java_type', 'Java类型\0\0', '30', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1'), ('99', 'Double', 'Double', 'gen_java_type', 'Java类型\0\0', '40', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1'), ('100', 'java.util.Date', 'Date', 'gen_java_type', 'Java类型\0\0', '50', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1'), ('101', 'com.thinkgem.jeesite.modules.sys.entity.User', 'User', 'gen_java_type', 'Java类型\0\0', '60', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1'), ('102', 'com.thinkgem.jeesite.modules.sys.entity.Office', 'Office', 'gen_java_type', 'Java类型\0\0', '70', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1'), ('103', 'com.thinkgem.jeesite.modules.sys.entity.Area', 'Area', 'gen_java_type', 'Java类型\0\0', '80', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1'), ('104', 'Custom', 'Custom', 'gen_java_type', 'Java类型\0\0', '90', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1'), ('105', '1', '会议通告\0\0\0\0', 'oa_notify_type', '通知通告类型', '10', '0', '1', '2013-11-08 08:00:00', '1', '2013-11-08 08:00:00', null, '0'), ('106', '2', '奖惩通告\0\0\0\0', 'oa_notify_type', '通知通告类型', '20', '0', '1', '2013-11-08 08:00:00', '1', '2013-11-08 08:00:00', null, '0'), ('107', '3', '活动通告\0\0\0\0', 'oa_notify_type', '通知通告类型', '30', '0', '1', '2013-11-08 08:00:00', '1', '2013-11-08 08:00:00', null, '0'), ('108', '0', '草稿', 'oa_notify_status', '通知通告状态', '10', '0', '1', '2013-11-08 08:00:00', '1', '2013-11-08 08:00:00', null, '0'), ('109', '1', '发布', 'oa_notify_status', '通知通告状态', '20', '0', '1', '2013-11-08 08:00:00', '1', '2013-11-08 08:00:00', null, '0'), ('110', '0', '未读', 'oa_notify_read', '通知通告状态', '10', '0', '1', '2013-11-08 08:00:00', '1', '2013-11-08 08:00:00', null, '0'), ('111', '1', '已读', 'oa_notify_read', '通知通告状态', '20', '0', '1', '2013-11-08 08:00:00', '1', '2013-11-08 08:00:00', null, '0');
COMMIT;

-- ----------------------------
--  Table structure for `sys_log`
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log` (
  `id` mediumint(64) NOT NULL AUTO_INCREMENT,
  `type` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '1' COMMENT '日志类型',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '日志标题',
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `remote_addr` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '操作IP地址',
  `user_agent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户代理',
  `request_uri` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '请求URI',
  `method` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '操作方式',
  `params` text COLLATE utf8mb4_unicode_ci COMMENT '操作提交的数据',
  `exception` text COLLATE utf8mb4_unicode_ci COMMENT '异常信息',
  PRIMARY KEY (`id`),
  KEY `sys_log_create_by` (`create_by`),
  KEY `sys_log_type` (`type`),
  KEY `sys_log_create_date` (`create_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='日志表';

-- ----------------------------
--  Table structure for `sys_mdict`
-- ----------------------------
DROP TABLE IF EXISTS `sys_mdict`;
CREATE TABLE `sys_mdict` (
  `id` mediumint(64) NOT NULL AUTO_INCREMENT,
  `parent_id` mediumint(64) DEFAULT NULL,
  `parent_ids` varchar(2000) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '所有父级编号',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `sort` decimal(10,0) NOT NULL COMMENT '排序',
  `description` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '描述',
  `create_by` mediumint(64) DEFAULT NULL,
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` mediumint(64) DEFAULT NULL,
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_mdict_parent_id` (`parent_id`),
  KEY `sys_mdict_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='多级字典表';

-- ----------------------------
--  Table structure for `sys_menu`
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `id` mediumint(64) NOT NULL AUTO_INCREMENT,
  `parent_id` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '所有父级编号',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `sort` decimal(10,0) NOT NULL COMMENT '排序',
  `href` varchar(2000) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '链接',
  `target` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '目标',
  `icon` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '图标',
  `is_show` char(1) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '是否在菜单中显示',
  `permission` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '权限标识',
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_menu_parent_id` (`parent_id`),
  KEY `sys_menu_del_flag` (`del_flag`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='菜单表';

-- ----------------------------
--  Records of `sys_menu`
-- ----------------------------
BEGIN;
INSERT INTO `sys_menu` VALUES ('1', '0', '0,', '功能菜单', '0', null, null, null, '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('2', '1', '0,1,', '系统设置', '900', null, null, null, '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('3', '2', '0,1,2,', '系统设置', '980', null, null, null, '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('4', '3', '0,1,2,3,', '菜单管理', '30', '/sys/menu/', null, 'list-alt', '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('5', '4', '0,1,2,3,4,', '查看', '30', null, null, null, '0', 'sys:menu:view', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('6', '4', '0,1,2,3,4,', '修改', '40', null, null, null, '0', 'sys:menu:edit', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('7', '3', '0,1,2,3,', '角色管理', '50', '/sys/role/', null, 'lock', '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('8', '7', '0,1,2,3,7,', '查看', '30', null, null, null, '0', 'sys:role:view', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('9', '7', '0,1,2,3,7,', '修改', '40', null, null, null, '0', 'sys:role:edit', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('10', '3', '0,1,2,3,', '字典管理', '60', '/sys/dict/', null, 'th-list', '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('11', '10', '0,1,2,3,10,', '查看', '30', null, null, null, '0', 'sys:dict:view', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('12', '10', '0,1,2,3,10,', '修改', '40', null, null, null, '0', 'sys:dict:edit', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('13', '2', '0,1,2,', '机构用户', '970', null, null, null, '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('14', '13', '0,1,2,13,', '区域管理', '50', '/sys/area/', null, 'th', '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('15', '14', '0,1,2,13,14,', '查看', '30', null, null, null, '0', 'sys:area:view', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('16', '14', '0,1,2,13,14,', '修改', '40', null, null, null, '0', 'sys:area:edit', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('17', '13', '0,1,2,13,', '机构管理', '40', '/sys/office/', null, 'th-large', '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('18', '17', '0,1,2,13,17,', '查看', '30', null, null, null, '0', 'sys:office:view', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('19', '17', '0,1,2,13,17,', '修改', '40', null, null, null, '0', 'sys:office:edit', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('20', '13', '0,1,2,13,', '用户管理', '30', '/sys/user/index', null, 'user', '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('21', '20', '0,1,2,13,20,', '查看', '30', null, null, null, '0', 'sys:user:view', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('22', '20', '0,1,2,13,20,', '修改', '40', null, null, null, '0', 'sys:user:edit', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('23', '2', '0,1,2,', '关于帮助', '990', null, null, null, '0', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('24', '23', '0,1,2,23', '官方首页', '30', 'http://jeesite.com', '_blank', null, '0', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('25', '23', '0,1,2,23', '项目支持', '50', 'http://jeesite.com/donation.html', '_blank', null, '0', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1'), ('26', '23', '0,1,2,23', '论坛交流', '80', 'http://bbs.jeesite.com', '_blank', null, '0', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1'), ('27', '1', '0,1,', '我的面板', '100', null, null, null, '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('28', '27', '0,1,27,', '个人信息', '30', null, null, null, '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('29', '28', '0,1,27,28,', '个人信息', '30', '/sys/user/info', null, 'user', '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('30', '28', '0,1,27,28,', '修改密码', '40', '/sys/user/modifyPwd', null, 'lock', '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('31', '1', '0,1,', '内容管理', '500', null, null, null, '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('32', '31', '0,1,31,', '栏目设置', '990', null, null, null, '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('33', '32', '0,1,31,32', '栏目管理', '30', '/cms/category/', null, 'align-justify', '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('34', '33', '0,1,31,32,33,', '查看', '30', null, null, null, '0', 'cms:category:view', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('35', '33', '0,1,31,32,33,', '修改', '40', null, null, null, '0', 'cms:category:edit', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('36', '32', '0,1,31,32', '站点设置', '40', '/cms/site/', null, 'certificate', '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('37', '36', '0,1,31,32,36,', '查看', '30', null, null, null, '0', 'cms:site:view', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('38', '36', '0,1,31,32,36,', '修改', '40', null, null, null, '0', 'cms:site:edit', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('39', '32', '0,1,31,32', '切换站点', '50', '/cms/site/select', null, 'retweet', '1', 'cms:site:select', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('40', '31', '0,1,31,', '内容管理', '500', null, null, null, '1', 'cms:view', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('41', '40', '0,1,31,40,', '内容发布', '30', '/cms/', null, 'briefcase', '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('42', '41', '0,1,31,40,41,', '文章模型', '40', '/cms/article/', null, 'file', '0', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('43', '42', '0,1,31,40,41,42,', '查看', '30', null, null, null, '0', 'cms:article:view', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('44', '42', '0,1,31,40,41,42,', '修改', '40', null, null, null, '0', 'cms:article:edit', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('45', '42', '0,1,31,40,41,42,', '审核', '50', null, null, null, '0', 'cms:article:audit', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('46', '41', '0,1,31,40,41,', '链接模型', '60', '/cms/link/', null, 'random', '0', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('47', '46', '0,1,31,40,41,46,', '查看', '30', null, null, null, '0', 'cms:link:view', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('48', '46', '0,1,31,40,41,46,', '修改', '40', null, null, null, '0', 'cms:link:edit', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('49', '46', '0,1,31,40,41,46,', '审核', '50', null, null, null, '0', 'cms:link:audit', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('50', '40', '0,1,31,40,', '评论管理', '40', '/cms/comment/?status=2', null, 'comment', '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('51', '50', '0,1,31,40,50,', '查看', '30', null, null, null, '0', 'cms:comment:view', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('52', '50', '0,1,31,40,50,', '审核', '40', null, null, null, '0', 'cms:comment:edit', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('53', '40', '0,1,31,40,', '公共留言', '80', '/cms/guestbook/?status=2', null, 'glass', '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('54', '53', '0,1,31,40,53,', '查看', '30', null, null, null, '0', 'cms:guestbook:view', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('55', '53', '0,1,31,40,53,', '审核', '40', null, null, null, '0', 'cms:guestbook:edit', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('56', '71', '0,1,27,71,', '文件管理', '90', '/../static/ckfinder/ckfinder.html', null, 'folder-open', '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('57', '56', '0,1,27,40,56,', '查看', '30', null, null, null, '0', 'cms:ckfinder:view', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('58', '56', '0,1,27,40,56,', '上传', '40', null, null, null, '0', 'cms:ckfinder:upload', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('59', '56', '0,1,27,40,56,', '修改', '50', null, null, null, '0', 'cms:ckfinder:edit', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('60', '31', '0,1,31,', '统计分析', '600', null, null, null, '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('61', '60', '0,1,31,60,', '信息量统计', '30', '/cms/stats/article', null, 'tasks', '1', 'cms:stats:article', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('62', '1', '0,1,', '在线办公', '200', null, null, null, '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('63', '62', '0,1,62,', '个人办公', '30', null, null, null, '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('64', '63', '0,1,62,63,', '请假办理', '300', '/oa/leave', null, 'leaf', '0', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('65', '64', '0,1,62,63,64,', '查看', '30', null, null, null, '0', 'oa:leave:view', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('66', '64', '0,1,62,63,64,', '修改', '40', null, null, null, '0', 'oa:leave:edit', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('67', '2', '0,1,2,', '日志查询', '985', null, null, null, '1', null, '1', '2013-06-03 08:00:00', '1', '2013-06-03 08:00:00', null, '0'), ('68', '67', '0,1,2,67,', '日志查询', '30', '/sys/log', null, 'pencil', '1', 'sys:log:view', '1', '2013-06-03 08:00:00', '1', '2013-06-03 08:00:00', null, '0'), ('69', '62', '0,1,62,', '流程管理', '300', null, null, null, '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('70', '69', '0,1,62,69,', '流程管理', '50', '/act/process', null, 'road', '1', 'act:process:edit', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('71', '27', '0,1,27,', '文件管理', '90', null, null, null, '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('72', '69', '0,1,62,69,', '模型管理', '100', '/act/model', null, 'road', '1', 'act:model:edit', '1', '2013-09-20 08:00:00', '1', '2013-09-20 08:00:00', null, '0'), ('73', '63', '0,1,62,63,', '我的任务', '50', '/act/task/todo/', null, 'tasks', '1', null, '1', '2013-09-24 08:00:00', '1', '2013-09-24 08:00:00', null, '0'), ('74', '63', '0,1,62,63,', '审批测试', '100', '/oa/testAudit', null, null, '1', 'oa:testAudit:view,oa:testAudit:edit', '1', '2013-09-24 08:00:00', '1', '2013-09-24 08:00:00', null, '0'), ('75', '1', '0,1,', '在线演示', '3000', null, null, null, '1', null, '1', '2013-10-08 08:00:00', '1', '2013-10-08 08:00:00', null, '1'), ('79', '1', '0,1,', '代码生成', '5000', null, null, null, '1', null, '1', '2013-10-16 08:00:00', '1', '2013-10-16 08:00:00', null, '0'), ('80', '79', '0,1,79,', '代码生成', '50', null, null, null, '1', null, '1', '2013-10-16 08:00:00', '1', '2013-10-16 08:00:00', null, '0'), ('81', '80', '0,1,79,80,', '生成方案配置', '30', '/gen/genScheme', null, null, '1', 'gen:genScheme:view,gen:genScheme:edit', '1', '2013-10-16 08:00:00', '1', '2013-10-16 08:00:00', null, '0'), ('82', '80', '0,1,79,80,', '业务表配置', '20', '/gen/genTable', null, null, '1', 'gen:genTable:view,gen:genTable:edit,gen:genTableColumn:view,gen:genTableColumn:edit', '1', '2013-10-16 08:00:00', '1', '2013-10-16 08:00:00', null, '0'), ('83', '80', '0,1,79,80,', '代码模板管理', '90', '/gen/genTemplate', null, null, '1', 'gen:genTemplate:view,gen:genTemplate:edit', '1', '2013-10-16 08:00:00', '1', '2013-10-16 08:00:00', null, '1'), ('84', '67', '0,1,2,67,', '连接池监视', '40', '/../druid', null, null, '1', null, '1', '2013-10-18 08:00:00', '1', '2013-10-18 08:00:00', null, '0'), ('85', '76', '0,1,75,76,', '行政区域', '80', '/../static/map/map-city.html', null, null, '1', null, '1', '2013-10-22 08:00:00', '1', '2013-10-22 08:00:00', null, '0'), ('86', '75', '0,1,75,', '组件演示', '50', null, null, null, '1', null, '1', '2013-10-22 08:00:00', '1', '2013-10-22 08:00:00', null, '1'), ('87', '86', '0,1,75,86,', '组件演示', '30', '/test/test/form', null, null, '1', 'test:test:view,test:test:edit', '1', '2013-10-22 08:00:00', '1', '2013-10-22 08:00:00', null, '1'), ('88', '62', '0,1,62,', '通知通告', '20', '', '', '', '1', '', '1', '2013-11-08 08:00:00', '1', '2013-11-08 08:00:00', null, '0'), ('89', '88', '0,1,62,88,', '我的通告', '30', '/oa/oaNotify/self', '', '', '1', '', '1', '2013-11-08 08:00:00', '1', '2013-11-08 08:00:00', null, '0'), ('90', '88', '0,1,62,88,', '通告管理', '50', '/oa/oaNotify', '', '', '1', 'oa:oaNotify:view,oa:oaNotify:edit', '1', '2013-11-08 08:00:00', '1', '2013-11-08 08:00:00', null, '0'), ('91', '79', '0,1,79,', '生成示例', '120', '', '', '', '1', '', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', '', '0'), ('92', '91', '0,1,79,91,', '单表', '30', '/test/testData', '', '', '1', '', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', '', '0'), ('93', '92', '0,1,79,91,92,', '编辑', '60', '', '', '', '0', 'test:testData:edit', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', '', '0'), ('94', '92', '0,1,79,91,92,', '查看', '30', '', '', '', '0', 'test:testData:view', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', '', '0'), ('95', '91', '0,1,79,91,', '主子表', '60', '/test/testDataMain', '', '', '1', '', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', '', '0'), ('96', '95', '0,1,79,91,95,', '查看', '30', '', '', '', '0', 'test:testDataMain:view', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', '', '0'), ('97', '95', '0,1,79,91,95,', '编辑', '60', '', '', '', '0', 'test:testDataMain:edit', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', '', '0'), ('98', '91', '0,1,79,91,', '树结构', '90', '/test/testTree', '', '', '1', '', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', '', '0'), ('99', '98', '0,1,79,91,98,', '查看', '30', '', '', '', '0', 'test:testTree:view', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', '', '0'), ('100', '98', '0,1,79,91,98,', '编辑', '60', '', '', '', '0', 'test:testTree:edit', '1', '2013-08-12 13:10:05', '1', '2013-08-12 13:10:05', '', '0');
COMMIT;

-- ----------------------------
--  Table structure for `sys_office`
-- ----------------------------
DROP TABLE IF EXISTS `sys_office`;
CREATE TABLE `sys_office` (
  `id` mediumint(64) NOT NULL AUTO_INCREMENT,
  `parent_id` mediumint(64) DEFAULT NULL,
  `parent_ids` varchar(2000) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '所有父级编号',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `sort` decimal(10,0) NOT NULL COMMENT '排序',
  `area_id` mediumint(64) DEFAULT NULL,
  `code` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '区域编码',
  `type` char(1) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '机构类型',
  `grade` char(1) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '机构等级',
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '联系地址',
  `zip_code` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮政编码',
  `master` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '负责人',
  `phone` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电话',
  `fax` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '传真',
  `email` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  `USEABLE` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否启用',
  `PRIMARY_PERSON` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '主负责人',
  `DEPUTY_PERSON` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '副负责人',
  `create_by` mediumint(64) DEFAULT NULL,
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` mediumint(64) DEFAULT NULL,
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_office_parent_id` (`parent_id`),
  KEY `sys_office_del_flag` (`del_flag`),
  KEY `sys_office_type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='机构表';

-- ----------------------------
--  Records of `sys_office`
-- ----------------------------
BEGIN;
INSERT INTO `sys_office` VALUES ('1', '0', '0,', '山东省总公司', '10', '2', '100000', '1', '1', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('2', '1', '0,1,', '公司领导', '10', '2', '100001', '2', '1', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('3', '1', '0,1,', '综合部', '20', '2', '100002', '2', '1', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('4', '1', '0,1,', '市场部', '30', '2', '100003', '2', '1', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('5', '1', '0,1,', '技术部', '40', '2', '100004', '2', '1', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('6', '1', '0,1,', '研发部', '50', '2', '100005', '2', '1', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('7', '1', '0,1,', '济南市分公司', '20', '3', '200000', '1', '2', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('8', '7', '0,1,7,', '公司领导', '10', '3', '200001', '2', '2', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('9', '7', '0,1,7,', '综合部', '20', '3', '200002', '2', '2', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('10', '7', '0,1,7,', '市场部', '30', '3', '200003', '2', '2', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('11', '7', '0,1,7,', '技术部', '40', '3', '200004', '2', '2', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('12', '7', '0,1,7,', '历城区分公司', '0', '4', '201000', '1', '3', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('13', '12', '0,1,7,12,', '公司领导', '10', '4', '201001', '2', '3', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('14', '12', '0,1,7,12,', '综合部', '20', '4', '201002', '2', '3', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('15', '12', '0,1,7,12,', '市场部', '30', '4', '201003', '2', '3', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('16', '12', '0,1,7,12,', '技术部', '40', '4', '201004', '2', '3', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('17', '7', '0,1,7,', '历下区分公司', '40', '5', '201010', '1', '3', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('18', '17', '0,1,7,17,', '公司领导', '10', '5', '201011', '2', '3', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('19', '17', '0,1,7,17,', '综合部', '20', '5', '201012', '2', '3', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('20', '17', '0,1,7,17,', '市场部', '30', '5', '201013', '2', '3', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('21', '17', '0,1,7,17,', '技术部', '40', '5', '201014', '2', '3', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('22', '7', '0,1,7,', '高新区分公司', '50', '6', '201010', '1', '3', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('23', '22', '0,1,7,22,', '公司领导', '10', '6', '201011', '2', '3', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('24', '22', '0,1,7,22,', '综合部', '20', '6', '201012', '2', '3', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('25', '22', '0,1,7,22,', '市场部', '30', '6', '201013', '2', '3', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('26', '22', '0,1,7,22,', '技术部', '40', '6', '201014', '2', '3', null, null, null, null, null, null, '1', null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
COMMIT;

-- ----------------------------
--  Table structure for `sys_role`
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` mediumint(64) NOT NULL AUTO_INCREMENT,
  `office_id` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '归属机构',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色名称',
  `enname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '英文名称',
  `role_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '角色类型',
  `data_scope` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '数据范围',
  `is_sys` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否系统数据',
  `useable` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否可用',
  `create_by` mediumint(64) DEFAULT NULL,
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` mediumint(64) DEFAULT NULL,
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_role_del_flag` (`del_flag`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色表';

-- ----------------------------
--  Records of `sys_role`
-- ----------------------------
BEGIN;
INSERT INTO `sys_role` VALUES ('1', '1', '系统管理员', 'dept', 'assignment', '1', null, '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('2', '1', '公司管理员', 'hr', 'assignment', '2', null, '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('3', '1', '本公司管理员', 'a', 'assignment', '3', null, '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('4', '1', '部门管理员', 'b', 'assignment', '4', null, '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('5', '1', '本部门管理员', 'c', 'assignment', '5', null, '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('6', '1', '普通用户', 'd', 'assignment', '8', null, '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('7', '7', '济南市管理员', 'e', 'assignment', '9', null, '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
COMMIT;

-- ----------------------------
--  Table structure for `sys_role_menu`
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `role_id` mediumint(64) NOT NULL DEFAULT '0',
  `menu_id` mediumint(64) NOT NULL DEFAULT '0',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色-菜单';

-- ----------------------------
--  Records of `sys_role_menu`
-- ----------------------------
BEGIN;
INSERT INTO `sys_role_menu` VALUES ('1', '1'), ('1', '2'), ('1', '3'), ('1', '4'), ('1', '5'), ('1', '6'), ('1', '7'), ('1', '8'), ('1', '9'), ('1', '10'), ('1', '11'), ('1', '12'), ('1', '13'), ('1', '14'), ('1', '15'), ('1', '16'), ('1', '17'), ('1', '18'), ('1', '19'), ('1', '20'), ('1', '21'), ('1', '22'), ('1', '23'), ('1', '24'), ('1', '25'), ('1', '26'), ('1', '27'), ('1', '28'), ('1', '29'), ('1', '30'), ('1', '31'), ('1', '32'), ('1', '33'), ('1', '34'), ('1', '35'), ('1', '36'), ('1', '37'), ('1', '38'), ('1', '39'), ('1', '40'), ('1', '41'), ('1', '42'), ('1', '43'), ('1', '44'), ('1', '45'), ('1', '46'), ('1', '47'), ('1', '48'), ('1', '49'), ('1', '50'), ('1', '51'), ('1', '52'), ('1', '53'), ('1', '54'), ('1', '55'), ('1', '56'), ('1', '57'), ('1', '58'), ('1', '59'), ('1', '60'), ('1', '61'), ('1', '62'), ('1', '63'), ('1', '64'), ('1', '65'), ('1', '66'), ('1', '67'), ('1', '68'), ('1', '69'), ('1', '70'), ('1', '71'), ('1', '72'), ('1', '73'), ('1', '74'), ('1', '75'), ('1', '76'), ('1', '77'), ('1', '78'), ('1', '79'), ('1', '80'), ('1', '81'), ('1', '82'), ('1', '83'), ('1', '84'), ('1', '85'), ('1', '86'), ('1', '87'), ('1', '88'), ('1', '89'), ('1', '90'), ('2', '1'), ('2', '2'), ('2', '3'), ('2', '4'), ('2', '5'), ('2', '6'), ('2', '7'), ('2', '8'), ('2', '9'), ('2', '10'), ('2', '11'), ('2', '12'), ('2', '13'), ('2', '14'), ('2', '15'), ('2', '16'), ('2', '17'), ('2', '18'), ('2', '19'), ('2', '20'), ('2', '21'), ('2', '22'), ('2', '23'), ('2', '24'), ('2', '25'), ('2', '26'), ('2', '27'), ('2', '28'), ('2', '29'), ('2', '30'), ('2', '31'), ('2', '32'), ('2', '33'), ('2', '34'), ('2', '35'), ('2', '36'), ('2', '37'), ('2', '38'), ('2', '39'), ('2', '40'), ('2', '41'), ('2', '42'), ('2', '43'), ('2', '44'), ('2', '45'), ('2', '46'), ('2', '47'), ('2', '48'), ('2', '49'), ('2', '50'), ('2', '51'), ('2', '52'), ('2', '53'), ('2', '54'), ('2', '55'), ('2', '56'), ('2', '57'), ('2', '58'), ('2', '59'), ('2', '60'), ('2', '61'), ('2', '62'), ('2', '63'), ('2', '64'), ('2', '65'), ('2', '66'), ('2', '67'), ('2', '68'), ('2', '69'), ('2', '70'), ('2', '71'), ('2', '72'), ('2', '73'), ('2', '74'), ('2', '75'), ('2', '76'), ('2', '77'), ('2', '78'), ('2', '79'), ('2', '80'), ('2', '81'), ('2', '82'), ('2', '83'), ('2', '84'), ('2', '85'), ('2', '86'), ('2', '87'), ('2', '88'), ('2', '89'), ('2', '90'), ('3', '1'), ('3', '2'), ('3', '3'), ('3', '4'), ('3', '5'), ('3', '6'), ('3', '7'), ('3', '8'), ('3', '9'), ('3', '10'), ('3', '11'), ('3', '12'), ('3', '13'), ('3', '14'), ('3', '15'), ('3', '16'), ('3', '17'), ('3', '18'), ('3', '19'), ('3', '20'), ('3', '21'), ('3', '22'), ('3', '23'), ('3', '24'), ('3', '25'), ('3', '26'), ('3', '27'), ('3', '28'), ('3', '29'), ('3', '30'), ('3', '31'), ('3', '32'), ('3', '33'), ('3', '34'), ('3', '35'), ('3', '36'), ('3', '37'), ('3', '38'), ('3', '39'), ('3', '40'), ('3', '41'), ('3', '42'), ('3', '43'), ('3', '44'), ('3', '45'), ('3', '46'), ('3', '47'), ('3', '48'), ('3', '49'), ('3', '50'), ('3', '51'), ('3', '52'), ('3', '53'), ('3', '54'), ('3', '55'), ('3', '56'), ('3', '57'), ('3', '58'), ('3', '59'), ('3', '60'), ('3', '61'), ('3', '62'), ('3', '63'), ('3', '64'), ('3', '65'), ('3', '66'), ('3', '67'), ('3', '68'), ('3', '69'), ('3', '70'), ('3', '71'), ('3', '72'), ('3', '73'), ('3', '74'), ('3', '75'), ('3', '76'), ('3', '77'), ('3', '78'), ('3', '79'), ('3', '80'), ('3', '81'), ('3', '82'), ('3', '83'), ('3', '84'), ('3', '85'), ('3', '86'), ('3', '87'), ('3', '88'), ('3', '89'), ('3', '90');
COMMIT;

-- ----------------------------
--  Table structure for `sys_role_office`
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_office`;
CREATE TABLE `sys_role_office` (
  `role_id` mediumint(64) NOT NULL DEFAULT '0',
  `office_id` mediumint(64) NOT NULL DEFAULT '0',
  PRIMARY KEY (`role_id`,`office_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色-机构';

-- ----------------------------
--  Records of `sys_role_office`
-- ----------------------------
BEGIN;
INSERT INTO `sys_role_office` VALUES ('7', '7'), ('7', '8'), ('7', '9'), ('7', '10'), ('7', '11'), ('7', '12'), ('7', '13'), ('7', '14'), ('7', '15'), ('7', '16'), ('7', '17'), ('7', '18'), ('7', '19'), ('7', '20'), ('7', '21'), ('7', '22'), ('7', '23'), ('7', '24'), ('7', '25'), ('7', '26');
COMMIT;

-- ----------------------------
--  Table structure for `sys_user`
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` mediumint(64) NOT NULL AUTO_INCREMENT,
  `company_id` mediumint(64) DEFAULT NULL,
  `office_id` mediumint(64) DEFAULT NULL,
  `login_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '登录名',
  `password` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `no` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '工号',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '姓名',
  `email` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电话',
  `mobile` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '手机',
  `user_type` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户类型',
  `photo` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户头像',
  `login_ip` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '最后登陆IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登陆时间',
  `login_flag` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否可登录',
  `create_by` mediumint(64) DEFAULT NULL,
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` mediumint(64) DEFAULT NULL,
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_user_office_id` (`office_id`),
  KEY `sys_user_login_name` (`login_name`),
  KEY `sys_user_company_id` (`company_id`),
  KEY `sys_user_update_date` (`update_date`),
  KEY `sys_user_del_flag` (`del_flag`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户表';

-- ----------------------------
--  Records of `sys_user`
-- ----------------------------
BEGIN;
INSERT INTO `sys_user` VALUES ('1', '1', '2', 'thinkgem', '02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032', '0001', '系统管理员', 'thinkgem@163.com', '8675', '8675', null, null, null, null, '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', '最高管理员', '0'), ('2', '1', '2', 'sd_admin', '02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032', '0002', '管理员', null, null, null, null, null, null, null, '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('3', '1', '3', 'sd_zhb', '02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032', '0003', '综合部', null, null, null, null, null, null, null, '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('4', '1', '4', 'sd_scb', '02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032', '0004', '市场部', null, null, null, null, null, null, null, '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('5', '1', '5', 'sd_jsb', '02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032', '0005', '技术部', null, null, null, null, null, null, null, '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('6', '1', '6', 'sd_yfb', '02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032', '0006', '研发部', null, null, null, null, null, null, null, '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('7', '7', '8', 'jn_admin', '02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032', '0007', '济南领导', null, null, null, null, null, null, null, '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('8', '7', '9', 'jn_zhb', '02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032', '0008', '济南综合部', null, null, null, null, null, null, null, '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('9', '7', '10', 'jn_scb', '02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032', '0009', '济南市场部', null, null, null, null, null, null, null, '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('10', '7', '11', 'jn_jsb', '02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032', '0010', '济南技术部', null, null, null, null, null, null, null, '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('11', '12', '13', 'lc_admin', '02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032', '0011', '济南历城领导', null, null, null, null, null, null, null, '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('12', '12', '18', 'lx_admin', '02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032', '0012', '济南历下领导', null, null, null, null, null, null, null, '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0'), ('13', '22', '23', 'gx_admin', '02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032', '0013', '济南高新领导', null, null, null, null, null, null, null, '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
COMMIT;

-- ----------------------------
--  Table structure for `sys_user_role`
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `user_id` mediumint(64) NOT NULL DEFAULT '0',
  `role_id` mediumint(64) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户-角色';

-- ----------------------------
--  Records of `sys_user_role`
-- ----------------------------
BEGIN;
INSERT INTO `sys_user_role` VALUES ('1', '1'), ('1', '2'), ('2', '1'), ('3', '2'), ('4', '3'), ('5', '4'), ('6', '5'), ('7', '2'), ('7', '7'), ('8', '2'), ('9', '1'), ('10', '2'), ('11', '3'), ('12', '4'), ('13', '5'), ('14', '6');
COMMIT;

-- ----------------------------
--  Table structure for `test_data`
-- ----------------------------
DROP TABLE IF EXISTS `test_data`;
CREATE TABLE `test_data` (
  `id` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '编号',
  `user_id` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '归属用户',
  `office_id` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '归属部门',
  `area_id` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '归属区域',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `sex` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '性别',
  `in_date` date DEFAULT NULL COMMENT '加入日期',
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `test_data_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='业务数据表';

-- ----------------------------
--  Table structure for `test_data_child`
-- ----------------------------
DROP TABLE IF EXISTS `test_data_child`;
CREATE TABLE `test_data_child` (
  `id` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '编号',
  `test_data_main_id` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '业务主表ID',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `test_data_child_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='业务数据子表';

-- ----------------------------
--  Table structure for `test_data_main`
-- ----------------------------
DROP TABLE IF EXISTS `test_data_main`;
CREATE TABLE `test_data_main` (
  `id` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '编号',
  `user_id` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '归属用户',
  `office_id` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '归属部门',
  `area_id` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '归属区域',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `sex` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '性别',
  `in_date` date DEFAULT NULL COMMENT '加入日期',
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `test_data_main_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='业务数据表';

-- ----------------------------
--  Table structure for `test_tree`
-- ----------------------------
DROP TABLE IF EXISTS `test_tree`;
CREATE TABLE `test_tree` (
  `id` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '编号',
  `parent_id` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '所有父级编号',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `sort` decimal(10,0) NOT NULL COMMENT '排序',
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `test_tree_del_flag` (`del_flag`),
  KEY `test_data_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='树结构表';

-- ----------------------------
--  Table structure for `web_user`
-- ----------------------------
DROP TABLE IF EXISTS `web_user`;
CREATE TABLE `web_user` (
  `id` mediumint(64) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `real_name` varchar(100) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `email_validated` char(2) DEFAULT NULL,
  `mobile` varchar(100) NOT NULL,
  `mobile_validated` char(2) NOT NULL,
  `user_type` char(2) NOT NULL,
  `id_card` varchar(64) DEFAULT NULL,
  `balance` decimal(19,2) DEFAULT '0.00',
  `frozen_amount` decimal(19,2) DEFAULT NULL,
  `points` int(10) DEFAULT NULL,
  `photo` varchar(1000) DEFAULT NULL,
  `sex` varchar(10) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `province` varchar(50) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `region` varchar(100) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `create_ip` varchar(30) NOT NULL,
  `login_ip` varchar(100) DEFAULT NULL,
  `login_date` datetime DEFAULT NULL,
  `login_flag` varchar(64) DEFAULT NULL,
  `wx_openId` varchar(100) DEFAULT NULL COMMENT '微信OpenId',
  `referrer` varchar(64) DEFAULT NULL,
  `visit_count` smallint(5) DEFAULT '0',
  `qq` varchar(20) DEFAULT NULL,
  `salt` varchar(128) DEFAULT NULL,
  `passwd_question` varchar(128) DEFAULT NULL,
  `passwd_answer` varchar(255) DEFAULT NULL,
  `create_date` datetime NOT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `invite_code` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_name` (`user_name`),
  KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Records of `web_user`
-- ----------------------------
BEGIN;
INSERT INTO `web_user` VALUES ('13', null, null, null, null, null, '15210497261', '1', '0', null, '0.00', '0.00', '0', null, null, null, null, null, null, null, '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1', '2016-04-08 19:23:18', '0', '', null, '31', null, null, null, null, '2015-04-12 19:01:20', null, 'pe5FB'), ('14', null, null, null, null, null, '13141235308', '1', '0', null, '100.00', '0.00', '0', null, null, null, null, null, null, null, '192.168.0.12', '124.205.109.130, 123.151.176.198', '2015-10-30 10:38:28', '0', '', null, '71', null, null, null, null, '2015-08-27 21:29:51', null, 'ekiHY'), ('15', null, null, null, null, null, '15219497261', '1', '0', null, '0.00', '0.00', '0', null, null, null, null, null, null, null, '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1', '2015-11-15 10:13:03', '0', '', null, '10', null, null, null, null, '2015-08-30 15:41:33', null, '7ks2D'), ('16', null, null, null, null, null, '13581804865', '1', '0', null, '0.00', '0.00', '0', null, null, null, null, null, null, null, '127.0.0.1', '192.168.100.15', '2015-10-14 16:58:09', '0', null, null, '2', null, null, null, null, '2015-10-14 16:14:48', null, 'Jnjyc'), ('17', null, null, null, null, null, '13585698465', '1', '0', null, '0.00', '0.00', '0', null, null, null, null, null, null, null, '127.0.0.1', '127.0.0.1', '2015-10-15 09:55:56', '0', null, null, '1', null, null, null, null, '2015-10-15 09:55:51', null, 'r94PZ'), ('18', null, null, null, null, null, '13584585458', '1', '0', null, '0.00', '0.00', '0', null, null, null, null, null, null, null, '127.0.0.1', '127.0.0.1', '2015-10-21 14:10:13', '0', null, null, '1', null, null, null, null, '2015-10-21 14:10:09', null, '8XGNS'), ('19', null, null, null, null, null, '13141235308', '1', '0', null, '0.00', '0.00', '0', null, null, null, null, null, null, null, '192.168.0.107', null, null, '0', null, null, '0', null, null, null, null, '2015-10-27 15:22:58', null, 'KVL21'), ('20', null, null, null, null, null, '13141232309', '1', '0', null, '0.00', '0.00', '0', null, null, null, null, null, null, null, '124.205.109.130', '124.205.109.130, 61.49.57.60', '2015-10-30 10:08:59', '0', null, null, '1', null, null, null, null, '2015-10-30 10:08:53', null, 'KiwwB'), ('21', null, null, null, null, null, '13141235307', '1', '0', null, '0.00', '0.00', '0', null, null, null, null, null, null, null, '124.205.109.130', '124.205.109.130', '2015-11-18 18:32:32', '0', '', null, '44', null, null, null, null, '2015-10-30 10:49:31', null, 'xkQ0w'), ('22', null, null, null, null, null, '13698956986', '1', '0', null, '0.00', '0.00', '0', null, null, null, null, null, null, null, '127.0.0.1', '127.0.0.1', '2015-11-17 15:15:07', '0', '', null, '1', null, null, null, null, '2015-11-17 15:15:04', null, 'GNoqb'), ('23', null, null, null, null, null, '13569865478', '1', '0', null, '0.00', '0.00', '0', null, null, null, null, null, null, null, '127.0.0.1', '127.0.0.1', '2015-11-17 15:41:08', '0', '', null, '1', null, null, null, null, '2015-11-17 15:40:53', null, 'Ikws1'), ('24', null, null, null, null, null, '13584869865', '1', '0', null, '0.00', '0.00', '0', null, null, null, null, null, null, null, '127.0.0.1', '127.0.0.1', '2015-11-17 16:40:22', '0', '', null, '1', null, null, null, null, '2015-11-17 16:40:15', null, 'HyCCs'), ('25', null, null, null, null, null, '13611364444', '1', '0', null, '0.00', '0.00', '0', null, null, null, null, null, null, null, '192.168.1.100', '192.168.1.100', '2016-03-13 17:28:31', '0', '', null, '1', null, null, null, null, '2016-03-13 17:28:21', null, 'f05nM'), ('26', null, '4f2672138947f116ecdfa6b32711e11650ad43713412df7a9d5a1747', null, null, null, '15210497262', '1', '0', null, '0.00', '0.00', '0', null, null, null, null, null, null, null, '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1', '2017-09-06 18:28:43', '0', null, '', '5', null, null, null, null, '2017-09-06 14:05:44', null, 'UWVlp');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
