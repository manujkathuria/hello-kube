# noinspection SqlNoDataSourceInspectionForFile

CREATE TABLE `campaign_flow`
(
    `campaign_code` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
    `flow_name`     varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
    `step`          int(11)                                    NOT NULL,
    `service`       varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
    `fail_service`  varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
    PRIMARY KEY (`campaign_code`, `flow_name`, `step`),
    KEY `campaign_flow_services_master_service_name_fk` (`service`),
    KEY `campaign_flow_services_master_service_name_fk_2` (`fail_service`),
    CONSTRAINT `campaign_flow_campaign_master_campaign_code_fk` FOREIGN KEY (`campaign_code`) REFERENCES `campaign_master` (`campaign_code`),
    CONSTRAINT `campaign_flow_services_master_service_name_fk` FOREIGN KEY (`service`) REFERENCES `services_master` (`service_name`),
    CONSTRAINT `campaign_flow_services_master_service_name_fk_2` FOREIGN KEY (`fail_service`) REFERENCES `services_master` (`service_name`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_520_ci;

CREATE TABLE `campaign_internal`
(
    `application` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
    `service`     varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
    `param1`      varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
    `param2`      varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
    `param3`      varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
    `param4`      varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
    `param5`      varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
    PRIMARY KEY (`application`, `service`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_520_ci;

CREATE TABLE `campaign_master`
(
    `campaign_code`        varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
    `campaign_name`        tinytext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
    `campaign_description` text COLLATE utf8mb4_unicode_520_ci        NOT NULL,
    `campaign_start_date`  datetime                                   NOT NULL,
    `campaign_end_date`    datetime                                   NOT NULL,
    PRIMARY KEY (`campaign_code`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_520_ci;

CREATE TABLE `filter_master`
(
    `campaign_code`        varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
    `sms_blacklist_filter` tinyint(1)                                  DEFAULT NULL,
    `blacklist_filter`     tinyint(1)                                  NOT NULL,
    `whitelist_filter`     tinyint(1)                                  NOT NULL,
    `sms_blacklist_field`  varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
    `blacklist_field`      varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
    `whitelist_field`      varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
    PRIMARY KEY (`campaign_code`),
    KEY `filter_master_orchestrator_field_master_field_name_fk` (`blacklist_field`),
    KEY `filter_master_orchestrator_field_master_field_name_fk_2` (`whitelist_field`),
    CONSTRAINT `filter_master_campaign_master_campaign_code_fk` FOREIGN KEY (`campaign_code`) REFERENCES `campaign_master` (`campaign_code`),
    CONSTRAINT `filter_master_orchestrator_field_master_field_name_fk` FOREIGN KEY (`blacklist_field`) REFERENCES `orchestrator_field_master` (`field_name`),
    CONSTRAINT `filter_master_orchestrator_field_master_field_name_fk_2` FOREIGN KEY (`whitelist_field`) REFERENCES `orchestrator_field_master` (`field_name`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_520_ci;

CREATE TABLE `location_master`
(
    `campaign_code`       varchar(50) COLLATE utf8mb4_unicode_520_ci  NOT NULL,
    `location`            varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
    `site_name`           text COLLATE utf8mb4_unicode_520_ci         DEFAULT NULL,
    `offer_id`            varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
    `open_time`           varchar(6) COLLATE utf8mb4_unicode_520_ci   NOT NULL,
    `close_time`          varchar(6) COLLATE utf8mb4_unicode_520_ci   NOT NULL,
    `monitor_flag`        tinyint(1)                                  NOT NULL,
    `daily_trigger_count` int(11)                                     NOT NULL,
    `reset_days`          int(11)                                     NOT NULL,
    `total_trigger_count` int(11)                                     NOT NULL,
    PRIMARY KEY (`campaign_code`, `location`),
    CONSTRAINT `location_master_campaign_master_campaign_code_fk` FOREIGN KEY (`campaign_code`) REFERENCES `campaign_master` (`campaign_code`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_520_ci;

CREATE TABLE `orchestrator_field_master`
(
    `field_name` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
    PRIMARY KEY (`field_name`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_520_ci;

CREATE TABLE `services_master`
(
    `service_name` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
    `topic`        varchar(200) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
    `log_topic`    varchar(200) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
    PRIMARY KEY (`service_name`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_520_ci;

CREATE TABLE `smsg_master`
(
    `offer_id`      varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
    `template_id`   varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
    `version`       varchar(50) COLLATE utf8mb4_unicode_520_ci  NOT NULL,
    `service_id`    varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
    `short_code`    varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
    `auth`          longtext COLLATE utf8mb4_unicode_520_ci     DEFAULT NULL,
    `param_1`       longtext COLLATE utf8mb4_unicode_520_ci     DEFAULT NULL,
    `param_1_value` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
    `param_2`       longtext COLLATE utf8mb4_unicode_520_ci     DEFAULT NULL,
    `param_2_value` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
    `param_3`       longtext COLLATE utf8mb4_unicode_520_ci     DEFAULT NULL,
    `param_3_value` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
    `param_4`       longtext COLLATE utf8mb4_unicode_520_ci     DEFAULT NULL,
    `param_4_value` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
    `param_5`       longtext COLLATE utf8mb4_unicode_520_ci     DEFAULT NULL,
    `param_5_value` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
    PRIMARY KEY (`offer_id`),
    KEY `smsg_master_orchestrator_field_master_field_name_fk` (`param_1_value`),
    KEY `smsg_master_orchestrator_field_master_field_name_fk_2` (`param_2_value`),
    KEY `smsg_master_orchestrator_field_master_field_name_fk_3` (`param_3_value`),
    KEY `smsg_master_orchestrator_field_master_field_name_fk_4` (`param_4_value`),
    KEY `smsg_master_orchestrator_field_master_field_name_fk_5` (`param_5_value`),
    CONSTRAINT `smsg_master_orchestrator_field_master_field_name_fk` FOREIGN KEY (`param_1_value`) REFERENCES `orchestrator_field_master` (`field_name`),
    CONSTRAINT `smsg_master_orchestrator_field_master_field_name_fk_2` FOREIGN KEY (`param_2_value`) REFERENCES `orchestrator_field_master` (`field_name`),
    CONSTRAINT `smsg_master_orchestrator_field_master_field_name_fk_3` FOREIGN KEY (`param_3_value`) REFERENCES `orchestrator_field_master` (`field_name`),
    CONSTRAINT `smsg_master_orchestrator_field_master_field_name_fk_4` FOREIGN KEY (`param_4_value`) REFERENCES `orchestrator_field_master` (`field_name`),
    CONSTRAINT `smsg_master_orchestrator_field_master_field_name_fk_5` FOREIGN KEY (`param_5_value`) REFERENCES `orchestrator_field_master` (`field_name`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_520_ci;

