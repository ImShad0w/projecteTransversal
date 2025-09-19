SET NAMES utf8mb4;

-- Create the database
CREATE DATABASE IF NOT EXISTS quiz
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;

GRANT ALL PRIVILEGES ON quiz.* TO 'admin'@'%';
FLUSH PRIVILEGES;

-- Use the database
USE quiz;

-- Table for questions
CREATE TABLE preguntes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    pregunta TEXT NOT NULL,
    resposta_correcta INT NOT NULL, -- stores the index (0,1,2,3)
    imatge VARCHAR(255) DEFAULT NULL
);

-- Table for answers (linked to questions)
CREATE TABLE respostes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    pregunta_id INT NOT NULL,
    resposta TEXT NOT NULL,
    INDEX (pregunta_id),
    FOREIGN KEY (pregunta_id) REFERENCES preguntes(id) ON DELETE CASCADE
);

-- Insert data from JSON

-- Question 1
INSERT INTO preguntes (id, pregunta, resposta_correcta, imatge)
VALUES (1, 'Quina marca de cotxes utilitza el lema ''Ultimate Driving Machine''?', 0, 'https://exemple.com/bmw.jpg');
INSERT INTO respostes (pregunta_id, resposta) VALUES
(1, 'BMW'), (1, 'Mercedes-Benz'), (1, 'Audi'), (1, 'Lexus');

-- Question 2
INSERT INTO preguntes (id, pregunta, resposta_correcta, imatge)
VALUES (2, 'Quina marca de beguda utilitza l’eslògan ''Open Happiness''?', 1, 'https://exemple.com/cocacola.jpg');
INSERT INTO respostes (pregunta_id, resposta) VALUES
(2, 'Pepsi'), (2, 'Coca-Cola'), (2, 'Fanta'), (2, 'Sprite');

-- Question 3
INSERT INTO preguntes (id, pregunta, resposta_correcta, imatge)
VALUES (3, 'Quina marca de tecnologia utilitza el logotip d’una poma mossegada?', 1, 'https://exemple.com/apple.jpg');
INSERT INTO respostes (pregunta_id, resposta) VALUES
(3, 'Samsung'), (3, 'Apple'), (3, 'Huawei'), (3, 'Sony');

-- Question 4
INSERT INTO preguntes (id, pregunta, resposta_correcta, imatge)
VALUES (4, 'Quina marca de menjar ràpid és famosa pel lema ''I’m Lovin’ It''?', 1, 'https://exemple.com/mcdonalds.jpg');
INSERT INTO respostes (pregunta_id, resposta) VALUES
(4, 'Burger King'), (4, 'McDonald’s'), (4, 'KFC'), (4, 'Subway');

-- Question 5
INSERT INTO preguntes (id, pregunta, resposta_correcta, imatge)
VALUES (5, 'Quina marca d’esport utilitza l’eslògan ''Just Do It''?', 2, 'https://exemple.com/nike.jpg');
INSERT INTO respostes (pregunta_id, resposta) VALUES
(5, 'Adidas'), (5, 'Puma'), (5, 'Nike'), (5, 'Reebok');

-- Question 6
INSERT INTO preguntes (id, pregunta, resposta_correcta, imatge)
VALUES (6, 'Quina marca de cafè és coneguda pel logotip verd amb una sirena?', 2, 'https://exemple.com/starbucks.jpg');
INSERT INTO respostes (pregunta_id, resposta) VALUES
(6, 'Costa Coffee'), (6, 'Nespresso'), (6, 'Starbucks'), (6, 'Dunkin’');

-- Question 7
INSERT INTO preguntes (id, pregunta, resposta_correcta, imatge)
VALUES (7, 'Quina marca de cotxes té com a lema ''Vorsprung durch Technik''?', 0, 'https://exemple.com/audi.jpg');
INSERT INTO respostes (pregunta_id, resposta) VALUES
(7, 'Audi'), (7, 'Volkswagen'), (7, 'Porsche'), (7, 'Opel');

-- Question 8
INSERT INTO preguntes (id, pregunta, resposta_correcta, imatge)
VALUES (8, 'Quina marca de moda té com a logotip dues lletres entrellaçades ''CC''?', 1, 'https://exemple.com/chanel.jpg');
INSERT INTO respostes (pregunta_id, resposta) VALUES
(8, 'Prada'), (8, 'Chanel'), (8, 'Gucci'), (8, 'Louis Vuitton');

-- Question 9
INSERT INTO preguntes (id, pregunta, resposta_correcta, imatge)
VALUES (9, 'Quina marca de consoles és coneguda pel logotip blau amb botons de comandament?', 1, 'https://exemple.com/playstation.jpg');
INSERT INTO respostes (pregunta_id, resposta) VALUES
(9, 'Xbox'), (9, 'PlayStation'), (9, 'Nintendo'), (9, 'Sega');

-- Question 10
INSERT INTO preguntes (id, pregunta, resposta_correcta, imatge)
VALUES (10, 'Quina marca de telèfons té com a eslògan ''Do What You Can’t''?', 0, 'https://exemple.com/samsung.jpg');
INSERT INTO respostes (pregunta_id, resposta) VALUES
(10, 'Samsung'), (10, 'Xiaomi'), (10, 'OnePlus'), (10, 'Google');

-- Question 11
INSERT INTO preguntes (id, pregunta, resposta_correcta, imatge)
VALUES (11, 'Quina marca d’aigua embotellada té com a lema ''Live Young''?', 0, 'https://exemple.com/evian.jpg');
INSERT INTO respostes (pregunta_id, resposta) VALUES
(11, 'Evian'), (11, 'Perrier'), (11, 'Vichy Catalan'), (11, 'San Pellegrino');

-- Question 12
INSERT INTO preguntes (id, pregunta, resposta_correcta, imatge)
VALUES (12, 'Quina marca de xocolata utilitza l’eslògan ''Have a Break, Have a ...''?', 0, 'https://exemple.com/kitkat.jpg');
INSERT INTO respostes (pregunta_id, resposta) VALUES
(12, 'KitKat'), (12, 'Snickers'), (12, 'Mars'), (12, 'Twix');

-- Question 13
INSERT INTO preguntes (id, pregunta, resposta_correcta, imatge)
VALUES (13, 'Quina marca de roba esportiva té com a lema ''Impossible is Nothing''?', 2, 'https://exemple.com/adidas.jpg');
INSERT INTO respostes (pregunta_id, resposta) VALUES
(13, 'Puma'), (13, 'Nike'), (13, 'Adidas'), (13, 'Under Armour');

-- Question 14
INSERT INTO preguntes (id, pregunta, resposta_correcta, imatge)
VALUES (14, 'Quina marca de gelats és coneguda pel nom italià i logotip blau?', 1, 'https://exemple.com/haagen-dazs.jpg');
INSERT INTO respostes (pregunta_id, resposta) VALUES
(14, 'Ben & Jerry’s'), (14, 'Häagen-Dazs'), (14, 'Carte d’Or'), (14, 'Gelato Italiano');

-- Question 15
INSERT INTO preguntes (id, pregunta, resposta_correcta, imatge)
VALUES (15, 'Quina marca de banc utilitza el lema ''Because you’re worth it''?', 3, 'https://exemple.com/loreal.jpg');
INSERT INTO respostes (pregunta_id, resposta) VALUES
(15, 'Santander'), (15, 'BBVA'), (15, 'CaixaBank'), (15, 'Cap d’aquestes');

-- Question 16
INSERT INTO preguntes (id, pregunta, resposta_correcta, imatge)
VALUES (16, 'Quina marca de motocicletes és coneguda pel logotip amb ales?', 1, 'https://exemple.com/honda.jpg');
INSERT INTO respostes (pregunta_id, resposta) VALUES
(16, 'Harley-Davidson'), (16, 'Honda'), (16, 'Yamaha'), (16, 'Ducati');

-- Question 17
INSERT INTO preguntes (id, pregunta, resposta_correcta, imatge)
VALUES (17, 'Quina marca de càmeres és famosa pel lema ''Capture the Future''?', 2, 'https://exemple.com/sony.jpg');
INSERT INTO respostes (pregunta_id, resposta) VALUES
(17, 'Canon'), (17, 'Nikon'), (17, 'Sony'), (17, 'Fujifilm');

-- Question 18
INSERT INTO preguntes (id, pregunta, resposta_correcta, imatge)
VALUES (18, 'Quina marca de perfums utilitza el número ''5'' en el seu producte icònic?', 1, 'https://exemple.com/chanel5.jpg');
INSERT INTO respostes (pregunta_id, resposta) VALUES
(18, 'Dior'), (18, 'Chanel'), (18, 'Gucci'), (18, 'Armani');

-- Question 19
INSERT INTO preguntes (id, pregunta, resposta_correcta, imatge)
VALUES (19, 'Quina marca de refrescos té com a color principal el taronja?', 2, 'https://exemple.com/fanta.jpg');
INSERT INTO respostes (pregunta_id, resposta) VALUES
(19, 'Sprite'), (19, 'Pepsi'), (19, 'Fanta'), (19, '7Up');

-- Question 20
INSERT INTO preguntes (id, pregunta, resposta_correcta, imatge)
VALUES (20, 'Quina marca de joguines és coneguda pels seus blocs de construcció?', 1, 'https://exemple.com/lego.jpg');
INSERT INTO respostes (pregunta_id, resposta) VALUES
(20, 'Playmobil'), (20, 'Lego'), (20, 'Mattel'), (20, 'Hasbro');
