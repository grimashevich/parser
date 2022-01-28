DROP DATABASE IF EXISTS proxy_servers;
CREATE DATABASE proxy_servers;
USE proxy_servers;

DROP TABLE IF EXISTS proxy_type;
CREATE TABLE proxy_type
(
    id   SERIAL,
    type VARCHAR(6) UNIQUE NOT NULL
);

DROP TABLE IF EXISTS proxy_servers;
CREATE TABLE proxy_servers
(
    id SERIAL,
    proxy_type_id BIGINT UNSIGNED,
    ip VARCHAR(15) UNIQUE NOT NULL,
    port SMALLINT UNSIGNED NOT NULL,
    fall_count TINYINT UNSIGNED DEFAULT 0,
    created_at      DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (proxy_type_id) REFERENCES proxy_type (id)
);

DROP TABLE IF EXISTS used_ip;
CREATE TABLE used_ip
(
    id SERIAL,
    proxy_server_id BIGINT UNSIGNED,
    project_id SMALLINT UNSIGNED NOT NULL,
    timestamp int UNSIGNED DEFAULT 0,
    FOREIGN KEY (proxy_server_id) REFERENCES proxy_servers (id),
    UNIQUE INDEX (proxy_server_id, project_id)
)

INSERT INTO proxy_type (type)
VALUES ('https'), ('socks4'), ('socks5');