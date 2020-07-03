CREATE DATABASE IF NOT EXISTS `sx_database`; -- Extra, you have to remove it if you use another database
USE `sx_database`; -- Extra, you have to change it if you use another database
CREATE TABLE sx_adminclients ( 
    ID int NOT NULL AUTO_INCREMENT,
    fristtime boolean DEFAULT false,
    identifier varchar(255),
    language_user varchar(255) DEFAULT "en",
    username varchar(255),
    sx_group int DEFAULT 0,
    connection int DEFAULT 0,
    banned_date DATETIME DEFAULT NOW(),
    TempBanned int DEFAULT 0,
    permanentBan boolean DEFAULT false,
	  reason varchar(255),
    warn int DEFAULT 0, 
    frist_connection boolean DEFAULT false, 
    disconnect_x varchar(255),
    disconnect_y varchar(255),
    disconnect_z varchar(255),
    PRIMARY KEY(ID)
);

