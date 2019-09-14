CREATE USER 'flutter_shop'@'localhost' identified by 'flutter_shop';
GRANT ALL PRIVILEGES ON FLUTTER_SHOP.* TO 'flutter_shop'@'%' identified by 'flutter_shop';
flush privileges;


CREATE DATABASE FLUTTER_SHOP;

DROP TABLE USER;

CREATE TABLE FLUTTER_SHOP.USER (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(200) NOT NULL UNIQUE,
    name VARCHAR(200) NOT NULL,
    address VARCHAR(200) NOT NULL,
    password VARCHAR(200) NOT NULL
);
