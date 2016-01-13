CREATE TABLE IF NOT EXISTS `entries` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `entry_id` varchar(50) NOT NULL,
  `name` varchar(20),
  `body` TEXT,
  `created_at` timestamp not null default current_timestamp,
  `updated_at` timestamp not null default current_timestamp on update current_timestamp
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
