CREATE USER 'flutter_shop'@'localhost' identified by 'flutter_shop';
GRANT ALL PRIVILEGES ON FLUTTER_SHOP.* TO 'flutter_shop'@'%' identified by 'flutter_shop';
flush privileges;


CREATE DATABASE FLUTTER_SHOP;

DROP TABLE FLUTTER_SHOP.USER;

CREATE TABLE FLUTTER_SHOP.USER (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(200) NOT NULL UNIQUE,
    name VARCHAR(200) NOT NULL,
    address VARCHAR(200) NOT NULL,
    password VARCHAR(200) NOT NULL,
    phoneNumber VAWRCHAR(200) DEFAULT ''
);

CREATE TABLE FLUTTER_SHOP.CART (
    userId INT NOT NULL PRIMARY KEY,
    items VARCHAR(200) NOT NULL
);

CREATE TABLE FLUTTER_SHOP.ITEM (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description VARCHAR(200) NOT NULL,
    price INT NOT NULL,
    image VARCHAR(200) NOT NULL,
    detailContents VARCHAR(200) NOT NULL,
    createAt VARCHAR(200) NOT NULL,
    updateAt VARCHAR(200) NOT NULL
);

INSERT INTO FLUTTER_SHOP.ITEM (title, description, price, image, detailContents, createAt, updateAt) VALUES (
    '뼈다귀 모양 베개', 
    '우리 귀여운 강아지에게 꿀잠을!!!', 
    10000, 
    'http://thumbnail.10x10.co.kr/webimage/image/basic600/137/B001377515.jpg', 
    '[\"아이에게 꿀잠을 선사할 수 있는 베개입니다.\",\"뼈다귀 모양이므로 강아지에게 뼈다귀를 뜯는 꿈을 꿀 수 있도록 합니다.\",\"가나다라 마바사 아자차카 타파하\",\"\",\"테스트 라인 입니다\",\"테스트 라인 입니다\",\"테스트 라인 입니다\",\"테스트 라인 입니다\",\"테스트 라인 입니다\"]',
    '',
    ''
);

INSERT INTO FLUTTER_SHOP.ITEM (title, description, price, image, detailContents, createAt, updateAt) VALUES (
    '귀여운 강아지 신발',
    '소중한 아기의 발바닥을 보호합시다',
    12000,
    'https://mi7.rightinthebox.com/images/384x384/201307/khabye1372647520194.jpg',
    '[\"아이에게 꿀잠을 선사할 수 있는 베개입니다.\",\"뼈다귀 모양이므로 강아지에게 뼈다귀를 뜯는 꿈을 꿀 수 있도록 합니다.\",\"가나다라 마바사 아자차카 타파하\",\"테스트 라인 입니다\",\"테스트 라인 입니다\",\"테스트 라인 입니다\",\"테스트 라인 입니다\",\"테스트 라인 입니다\"]',
    '',
    ''
);