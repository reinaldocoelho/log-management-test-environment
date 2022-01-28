-- ## #######################################################################
-- ## Create Access to server
-- ## #######################################################################
SELECT User FROM mysql.user;
CREATE USER IF NOT EXISTS 'user'@'%';
SET PASSWORD FOR 'user'@'%' = PASSWORD('userMon@1');
  
GRANT INSERT ON *.* 
TO 'user'@'%' 
WITH GRANT OPTION;
    
FLUSH PRIVILEGES;

-- ## #######################################################################
-- ## Set ANSI_QUOTES to create table
-- ## #######################################################################
SET sql_mode = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION,ANSI_QUOTES';

CREATE TABLE "w3c_log" (
  "timestamp" datetime DEFAULT NULL,
  "host" varchar(255) DEFAULT NULL,
  "path" varchar(255) DEFAULT NULL,
  "server_name" varchar(255) DEFAULT NULL,
  "server_ipv4" varchar(30) DEFAULT NULL,
  "server_ipv6" varchar(30) DEFAULT NULL,
  "http_status" int DEFAULT NULL,
  "http_method" varchar(15) DEFAULT NULL,
  "uri_path" varchar(255) DEFAULT NULL,
  "log_date" datetime DEFAULT NULL,
  "server_port" int DEFAULT NULL,
  "referer" varchar(255) DEFAULT NULL,
  "http_version" varchar(50) DEFAULT NULL,
  "uri_query" varchar(1000) DEFAULT NULL,
  "cookie" varchar(1000) DEFAULT NULL,
  "time_taken" int DEFAULT NULL,
  "user_name" varchar(255) DEFAULT NULL,
  "host_uri" varchar(255) DEFAULT NULL,
  "user_agent" varchar(255) DEFAULT NULL,
  "user_ipv4" varchar(30) DEFAULT NULL,
  "user_ipv6" varchar(30) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Create agregation table
  CREATE TABLE w3c_log_agregation (
      utc_log_date DATETIME NOT NULL,
      quantity INT NULL,
      max_time_taken DECIMAL(10,3) NULL, 
      PRIMARY KEY(utc_log_date)
  )
  ENGINE=MyISAM
  DEFAULT CHARSET=latin1;


-- #######################################################################
-- Create event to clean old data
-- Usando Event: https://mariadb.com/kb/en/create-event/
-- #######################################################################
CREATE OR REPLACE EVENT delete_w3c_data_event
ON SCHEDULE EVERY 23 DAY_HOUR
ON COMPLETION PRESERVE
COMMENT 'Clean up Logs at 23:00 daily!'
DO BEGIN
      DELETE FROM grafana.w3c_log WHERE timestamp < DATE_SUB(NOW(), INTERVAL 7 DAY);
      DELETE FROM grafana.w3c_log_agregation WHERE utc_log_date < DATE_SUB(NOW(), INTERVAL 7 DAY);
END;
-- #######################################################################


-- #######################################################################
-- Create event to clean old data
-- Usando Event: https://mariadb.com/kb/en/create-event/
-- #######################################################################
CREATE OR REPLACE EVENT w3c_data_agregate
ON SCHEDULE EVERY 1 MINUTE
ON COMPLETION PRESERVE
COMMENT 'Agregate w3c APP log data for monitoring!'
DO BEGIN
    INSERT INTO w3c_log_agregation(utc_log_date, quantity, max_time_taken)
    (SELECT
      FROM_UNIXTIME(UNIX_TIMESTAMP(log_date) DIV 60 * 60),
      COUNT(*),
      MAX(time_taken)
    FROM grafana.w3c_log
    WHERE
      log_date BETWEEN
        (DATE_ADD(NOW(), INTERVAL -5 MINUTE) - INTERVAL EXTRACT(SECOND FROM NOW()) SECOND)
        AND
        DATE_ADD((DATE_ADD(NOW(), INTERVAL -1 MINUTE) - INTERVAL EXTRACT(SECOND FROM NOW()) SECOND), INTERVAL 59 SECOND)
      and Host like 'APP%'
      and http_status = 200
      and uri_path NOT LIKE '/signalr%'
    GROUP BY 1
    ORDER BY log_date)
    ON DUPLICATE KEY UPDATE
      quantity = VALUES(quantity),
      max_time_taken = VALUES(max_time_taken)
    ;      
END;
-- #######################################################################
