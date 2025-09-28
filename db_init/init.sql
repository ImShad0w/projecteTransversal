SET NAMES utf8mb4;

-- Create the database
CREATE DATABASE IF NOT EXISTS quiz
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;

GRANT ALL PRIVILEGES ON quiz.* TO 'admin'@'%';
FLUSH PRIVILEGES;

-- Use the database
USE quiz;

-- Drop old tables if needed
DROP TABLE IF EXISTS respostes;
DROP TABLE IF EXISTS preguntes;
DROP TABLE IF EXISTS users;

-- Table for questions (without image)
CREATE TABLE preguntes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    pregunta TEXT NOT NULL,
    resposta_correcta INT NOT NULL -- stores the index (0,1,2,3)
);

-- Table for answers (with image now)
CREATE TABLE respostes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    pregunta_id INT NOT NULL,
    resposta TEXT NOT NULL,
    imatge VARCHAR(255) DEFAULT NULL,
    INDEX (pregunta_id),
    FOREIGN KEY (pregunta_id) REFERENCES preguntes(id) ON DELETE CASCADE
);

-- Users table
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

-- Insert admin user
INSERT INTO users (username, password) VALUES ('admin', '1234');

-- Insert questions and answers

-- Question 1
INSERT INTO preguntes (id, pregunta, resposta_correcta) VALUES
(1, 'Quina marca de cotxes utilitza el lema ''Ultimate Driving Machine''?', 0);
INSERT INTO respostes (pregunta_id, resposta, imatge) VALUES
(1, 'BMW', 'https://exemple.com/bmw.jpg'),
(1, 'Mercedes-Benz', 'https://exemple.com/bmw.jpg'),
(1, 'Audi', 'https://exemple.com/bmw.jpg'),
(1, 'Lexus', 'https://exemple.com/bmw.jpg');

-- Question 2
INSERT INTO preguntes (id, pregunta, resposta_correcta) VALUES
(2, 'Quina marca de beguda utilitza l’eslògan ''Open Happiness''?', 1);
INSERT INTO respostes (pregunta_id, resposta, imatge) VALUES
(2, 'Pepsi', 'https://exemple.com/cocacola.jpg'),
(2, 'Coca-Cola', 'https://exemple.com/cocacola.jpg'),
(2, 'Fanta', 'https://exemple.com/cocacola.jpg'),
(2, 'Sprite', 'https://exemple.com/cocacola.jpg');

-- Question 3
INSERT INTO preguntes (id, pregunta, resposta_correcta) VALUES
(3, 'Quina marca de tecnologia utilitza el logotip d’una poma mossegada?', 1);
INSERT INTO respostes (pregunta_id, resposta, imatge) VALUES
(3, 'Samsung', 'https://exemple.com/apple.jpg'),
(3, 'Apple', 'https://exemple.com/apple.jpg'),
(3, 'Huawei', 'https://exemple.com/apple.jpg'),
(3, 'Sony', 'https://exemple.com/apple.jpg');

-- Question 4
INSERT INTO preguntes (id, pregunta, resposta_correcta) VALUES
(4, 'Quina marca de menjar ràpid és famosa pel lema ''I’m Lovin’ It''?', 1);
INSERT INTO respostes (pregunta_id, resposta, imatge) VALUES
(4, 'Burger King', 'https://exemple.com/mcdonalds.jpg'),
(4, 'McDonald’s', 'https://exemple.com/mcdonalds.jpg'),
(4, 'KFC', 'https://exemple.com/mcdonalds.jpg'),
(4, 'Subway', 'https://exemple.com/mcdonalds.jpg');

-- Question 5
INSERT INTO preguntes (id, pregunta, resposta_correcta) VALUES
(5, 'Quina marca d’esport utilitza l’eslògan ''Just Do It''?', 2);
INSERT INTO respostes (pregunta_id, resposta, imatge) VALUES
(5, 'Adidas', 'https://exemple.com/nike.jpg'),
(5, 'Puma', 'https://exemple.com/nike.jpg'),
(5, 'Nike', 'https://exemple.com/nike.jpg'),
(5, 'Reebok', 'https://exemple.com/nike.jpg');

-- Question 6
INSERT INTO preguntes (id, pregunta, resposta_correcta) VALUES
(6, 'Quina marca de cafè és coneguda pel logotip verd amb una sirena?', 2);
INSERT INTO respostes (pregunta_id, resposta, imatge) VALUES
(6, 'Costa Coffee', 'https://exemple.com/starbucks.jpg'),
(6, 'Nespresso', 'https://exemple.com/starbucks.jpg'),
(6, 'Starbucks', 'https://exemple.com/starbucks.jpg'),
(6, 'Dunkin’', 'https://exemple.com/starbucks.jpg');

-- Question 7
INSERT INTO preguntes (id, pregunta, resposta_correcta) VALUES
(7, 'Quina marca de cotxes té com a lema ''Vorsprung durch Technik''?', 0);
INSERT INTO respostes (pregunta_id, resposta, imatge) VALUES
(7, 'Audi', 'https://exemple.com/audi.jpg'),
(7, 'Volkswagen', 'https://exemple.com/audi.jpg'),
(7, 'Porsche', 'https://exemple.com/audi.jpg'),
(7, 'Opel', 'https://exemple.com/audi.jpg');

-- Question 8
INSERT INTO preguntes (id, pregunta, resposta_correcta) VALUES
(8, 'Quina marca de moda té com a logotip dues lletres entrellaçades ''CC''?', 1);
INSERT INTO respostes (pregunta_id, resposta, imatge) VALUES
(8, 'Prada', 'https://exemple.com/chanel.jpg'),
(8, 'Chanel', 'https://exemple.com/chanel.jpg'),
(8, 'Gucci', 'https://exemple.com/chanel.jpg'),
(8, 'Louis Vuitton', 'https://exemple.com/chanel.jpg');

-- Question 9
INSERT INTO preguntes (id, pregunta, resposta_correcta) VALUES
(9, 'Quina marca de consoles és coneguda pel logotip blau amb botons de comandament?', 1);
INSERT INTO respostes (pregunta_id, resposta, imatge) VALUES
(9, 'Xbox', 'https://exemple.com/playstation.jpg'),
(9, 'PlayStation', 'https://exemple.com/playstation.jpg'),
(9, 'Nintendo', 'https://exemple.com/playstation.jpg'),
(9, 'Sega', 'https://exemple.com/playstation.jpg');

-- Question 10
INSERT INTO preguntes (id, pregunta, resposta_correcta) VALUES
(10, 'Quina marca de telèfons té com a eslògan ''Do What You Can’t''?', 0);
INSERT INTO respostes (pregunta_id, resposta, imatge) VALUES
(10, 'Samsung', 'https://exemple.com/samsung.jpg'),
(10, 'Xiaomi', 'https://exemple.com/samsung.jpg'),
(10, 'OnePlus', 'https://exemple.com/samsung.jpg'),
(10, 'Google', 'https://exemple.com/samsung.jpg');

-- Question 11
INSERT INTO preguntes (id, pregunta, resposta_correcta) VALUES
(11, 'Quina marca d’aigua embotellada té com a lema ''Live Young''?', 0);
INSERT INTO respostes (pregunta_id, resposta, imatge) VALUES
(11, 'Evian', 'https://exemple.com/evian.jpg'),
(11, 'Perrier', 'https://exemple.com/evian.jpg'),
(11, 'Vichy Catalan', 'https://exemple.com/evian.jpg'),
(11, 'San Pellegrino', 'https://exemple.com/evian.jpg');

-- Question 12
INSERT INTO preguntes (id, pregunta, resposta_correcta) VALUES
(12, 'Quina marca de xocolata utilitza l’eslògan ''Have a Break, Have a ...''?', 0);
INSERT INTO respostes (pregunta_id, resposta, imatge) VALUES
(12, 'KitKat', 'https://exemple.com/kitkat.jpg'),
(12, 'Snickers', 'https://exemple.com/kitkat.jpg'),
(12, 'Mars', 'https://exemple.com/kitkat.jpg'),
(12, 'Twix', 'https://exemple.com/kitkat.jpg');

-- Question 13
INSERT INTO preguntes (id, pregunta, resposta_correcta) VALUES
(13, 'Quina marca de roba esportiva té com a lema ''Impossible is Nothing''?', 2);
INSERT INTO respostes (pregunta_id, resposta, imatge) VALUES
(13, 'Puma', 'https://exemple.com/adidas.jpg'),
(13, 'Nike', 'https://exemple.com/adidas.jpg'),
(13, 'Adidas', 'https://exemple.com/adidas.jpg'),
(13, 'Under Armour', 'https://exemple.com/adidas.jpg');

-- Question 14
INSERT INTO preguntes (id, pregunta, resposta_correcta) VALUES
(14, 'Quina marca de gelats és coneguda pel nom italià i logotip blau?', 1);
INSERT INTO respostes (pregunta_id, resposta, imatge) VALUES
(14, 'Ben & Jerry’s', 'https://exemple.com/haagen-dazs.jpg'),
(14, 'Häagen-Dazs', 'https://exemple.com/haagen-dazs.jpg'),
(14, 'Carte d’Or', 'https://exemple.com/haagen-dazs.jpg'),
(14, 'Gelato Italiano', 'https://exemple.com/haagen-dazs.jpg');

-- Question 15
INSERT INTO preguntes (id, pregunta, resposta_correcta) VALUES
(15, 'Quina marca de banc utilitza el lema ''Because you’re worth it''?', 3);
INSERT INTO respostes (pregunta_id, resposta, imatge) VALUES
(15, 'Santander', 'https://exemple.com/loreal.jpg'),
(15, 'BBVA', 'https://exemple.com/loreal.jpg'),
(15, 'CaixaBank', 'https://exemple.com/loreal.jpg'),
(15, 'Cap d’aquestes', 'https://exemple.com/loreal.jpg');

-- Question 16
INSERT INTO preguntes (id, pregunta, resposta_correcta) VALUES
(16, 'Quina marca de motocicletes és coneguda pel logotip amb ales?', 1);
INSERT INTO respostes (pregunta_id, resposta, imatge) VALUES
(16, 'Harley-Davidson', 'https://exemple.com/honda.jpg'),
(16, 'Honda', 'https://exemple.com/honda.jpg'),
(16, 'Yamaha', 'https://exemple.com/honda.jpg'),
(16, 'Ducati', 'https://exemple.com/honda.jpg');

-- Question 17
INSERT INTO preguntes (id, pregunta, resposta_correcta) VALUES
(17, 'Quina marca de càmeres és famosa pel lema ''Capture the Future''?', 2);
INSERT INTO respostes (pregunta_id, resposta, imatge) VALUES
(17, 'Canon', 'https://exemple.com/sony.jpg'),
(17, 'Nikon', 'https://exemple.com/sony.jpg'),
(17, 'Sony', 'https://exemple.com/sony.jpg'),
(17, 'Fujifilm', 'https://exemple.com/sony.jpg');

-- Question 18
INSERT INTO preguntes (id, pregunta, resposta_correcta) VALUES
(18, 'Quina marca de perfums utilitza el número ''5'' en el seu producte icònic?', 1);
INSERT INTO respostes (pregunta_id, resposta, imatge) VALUES
(18, 'Dior', 'https://exemple.com/chanel5.jpg'),
(18, 'Chanel', 'https://exemple.com/chanel5.jpg'),
(18, 'Gucci', 'https://exemple.com/chanel5.jpg'),
(18, 'Armani', 'https://exemple.com/chanel5.jpg');

-- Question 19
INSERT INTO preguntes (id, pregunta, resposta_correcta) VALUES
(19, 'Quina marca de refrescos té com a color principal el taronja?', 2);
INSERT INTO respostes (pregunta_id, resposta, imatge) VALUES
(19, 'Sprite', 'https://exemple.com/fanta.jpg'),
(19, 'Pepsi', 'https://exemple.com/fanta.jpg'),
(19, 'Fanta', 'https://exemple.com/fanta.jpg'),
(19, '7Up', 'https://exemple.com/fanta.jpg');

-- Question 20
INSERT INTO preguntes (id, pregunta, resposta_correcta) VALUES
(20, 'Quina marca de joguines és coneguda pels seus blocs de construcció?', 1);
INSERT INTO respostes (pregunta_id, resposta, imatge) VALUES
(20, 'Playmobil', 'https://exemple.com/lego.jpg'),
(20, 'Lego', 'https://exemple.com/lego.jpg'),
(20, 'Mattel', 'https://exemple.com/lego.jpg'),
(20, 'Hasbro', 'https://exemple.com/lego.jpg');
