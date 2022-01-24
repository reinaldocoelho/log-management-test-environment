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
) ENGINE=MyISAM DEFAULT CHARSET=latin1