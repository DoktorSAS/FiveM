CREATE TABLE `sx_users`(
    id int NOT NULL AUTO_INCREMENT,
    identifier varchar(255),
    pin varchar(4),
    username varchar(255),
    `password` varchar(255),
    email varchar(255),
    `language` varchar(255) DEFAULT "en",
    PRIMARY KEY(id)
);
