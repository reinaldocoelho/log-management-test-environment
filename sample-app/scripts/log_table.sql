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
) ENGINE=MyISAM DEFAULT CHARSET=latin1

/*
#Fields: date time s-computername s-ip cs-method cs-uri-stem cs-uri-query s-port c-ip cs(Referer) cs-host sc-status time-taken
2022-01-25 14:17:49 FOCA-AVELL 127.0.0.1 GET / - 80 127.0.0.1 - foca.localhost.com.br 302 39482
grok_patterns = ["%{TIMESTAMP_ISO8601:log_date} %{NOTSPACE:server_name} %{IPV4:server_ipv4} %{WORD:http_method} %{NOTSPACE:uri_path} %{NOTSPACE:uri_query} %{NUMBER:server_port} %{IPV4:user_ipv4} %{NOTSPACE:referer} %{NOTSPACE:host_uri} %{NUMBER:http_status} %{NUMBER:time_taken}"]
*/