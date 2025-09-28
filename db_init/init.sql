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
(1, 'BMW', 'https://upload.wikimedia.org/wikipedia/commons/f/f4/BMW_logo_%28gray%29.svg'),
(1, 'Mercedes-Benz', 'https://upload.wikimedia.org/wikipedia/commons/9/90/Mercedes-Logo.svg'),
(1, 'Audi', 'https://upload.wikimedia.org/wikipedia/commons/9/92/Audi-Logo_2016.svg'),
(1, 'Lexus', 'https://upload.wikimedia.org/wikipedia/commons/7/75/Lexus.svg');

-- Question 2
INSERT INTO preguntes (id, pregunta, resposta_correcta) VALUES
(2, 'Quina marca de beguda utilitza l’eslògan ''Open Happiness''?', 1);
INSERT INTO respostes (pregunta_id, resposta, imatge) VALUES
(2, 'Pepsi', 'https://upload.wikimedia.org/wikipedia/commons/0/0f/Pepsi_logo_2014.svg'),
(2, 'Coca-Cola', 'https://upload.wikimedia.org/wikipedia/commons/c/ce/Coca-Cola_logo.svg'),
(2, 'Fanta', 'https://upload.wikimedia.org/wikipedia/commons/6/62/Fanta_logo_%282009%29.svg'),
(2, 'Sprite', 'https://upload.wikimedia.org/wikipedia/commons/b/b9/Sprite_Logo.svg');

-- Question 3
INSERT INTO preguntes (id, pregunta, resposta_correcta) VALUES
(3, 'Quina marca de tecnologia utilitza el logotip d’una poma mossegada?', 1);
INSERT INTO respostes (pregunta_id, resposta, imatge) VALUES
(3, 'Samsung', 'https://upload.wikimedia.org/wikipedia/commons/6/61/Samsung_old_logo_before_year_2015.svg'),
(3, 'Apple', 'https://upload.wikimedia.org/wikipedia/commons/f/fa/Apple_logo_black.svg'),
(3, 'Huawei', 'https://upload.wikimedia.org/wikipedia/en/0/04/Huawei_Standard_logo.svg'),
(3, 'Sony', 'https://upload.wikimedia.org/wikipedia/commons/c/ca/Sony_logo.svg');

-- Question 4
INSERT INTO preguntes (id, pregunta, resposta_correcta) VALUES
(4, 'Quina marca de menjar ràpid és famosa pel lema ''I’m Lovin’ It''?', 1);
INSERT INTO respostes (pregunta_id, resposta, imatge) VALUES
(4, 'Burger King', 'https://upload.wikimedia.org/wikipedia/commons/4/4b/Burger_King_logo_%281999%E2%80%932020%29.svg'),
(4, 'McDonald’s', 'https://upload.wikimedia.org/wikipedia/commons/3/36/McDonald%27s_Golden_Arches.svg'),
(4, 'KFC', 'https://upload.wikimedia.org/wikipedia/commons/9/91/KFC_Logo.svg'),
(4, 'Subway', 'https://upload.wikimedia.org/wikipedia/commons/5/5c/Subway_2016_logo.svg');

-- Question 5
INSERT INTO preguntes (id, pregunta, resposta_correcta) VALUES
(5, 'Quina marca d’esport utilitza l’eslògan ''Just Do It''?', 2);
INSERT INTO respostes (pregunta_id, resposta, imatge) VALUES
(5, 'Adidas', 'https://upload.wikimedia.org/wikipedia/commons/1/1b/Adidas_2022_logo.svg'),
(5, 'Puma', 'https://upload.wikimedia.org/wikipedia/commons/a/ae/Puma-logo-%28text%29.svg'),
(5, 'Nike', 'https://upload.wikimedia.org/wikipedia/commons/a/a6/Logo_NIKE.svg'),
(5, 'Reebok', 'https://upload.wikimedia.org/wikipedia/commons/5/53/Reebok_2019_logo.svg');

-- Question 6
INSERT INTO preguntes (id, pregunta, resposta_correcta) VALUES
(6, 'Quina marca de cafè és coneguda pel logotip verd amb una sirena?', 2);
INSERT INTO respostes (pregunta_id, resposta, imatge) VALUES
(6, 'Costa Coffee', 'https://upload.wikimedia.org/wikipedia/en/f/fa/Costa_Coffee_logo.svg'),
(6, 'Nespresso', 'https://upload.wikimedia.org/wikipedia/commons/2/2c/Nespresso_logo_%28wordmark%29.svg'),
(6, 'Starbucks', 'https://upload.wikimedia.org/wikipedia/sco/d/d3/Starbucks_Corporation_Logo_2011.svg'),
(6, 'Dunkin’', 'https://upload.wikimedia.org/wikipedia/commons/2/22/Dunkin%27_logo.svg');

-- Question 7
INSERT INTO preguntes (id, pregunta, resposta_correcta) VALUES
(7, 'Quina marca de cotxes té com a lema ''Vorsprung durch Technik''?', 0);
INSERT INTO respostes (pregunta_id, resposta, imatge) VALUES
(7, 'Audi', 'https://upload.wikimedia.org/wikipedia/commons/9/92/Audi-Logo_2016.svg'),
(7, 'Volkswagen', 'https://upload.wikimedia.org/wikipedia/commons/6/6d/Volkswagen_logo_2019.svg'),
(7, 'Porsche', 'https://upload.wikimedia.org/wikipedia/de/7/70/Porsche_Logo.svg'),
(7, 'Opel', 'https://upload.wikimedia.org/wikipedia/commons/7/70/Opel_Logo_2021.svg');

-- Question 8
INSERT INTO preguntes (id, pregunta, resposta_correcta) VALUES
(8, 'Quina marca de moda té com a logotip dues lletres entrellaçades ''CC''?', 1);
INSERT INTO respostes (pregunta_id, resposta, imatge) VALUES
(8, 'Prada', 'https://upload.wikimedia.org/wikipedia/commons/b/b8/Prada-Logo.svg'),
(8, 'Chanel', 'https://upload.wikimedia.org/wikipedia/commons/3/35/Chanel_logo.svg'),
(8, 'Gucci', 'https://upload.wikimedia.org/wikipedia/commons/7/79/1960s_Gucci_Logo.svg'),
(8, 'Louis Vuitton', 'https://upload.wikimedia.org/wikipedia/commons/7/76/Louis_Vuitton_logo_and_wordmark.svg');

-- Question 9
INSERT INTO preguntes (id, pregunta, resposta_correcta) VALUES
(9, 'Quina marca de consoles és coneguda pel logotip blau amb botons de comandament?', 1);
INSERT INTO respostes (pregunta_id, resposta, imatge) VALUES
(9, 'Xbox', 'https://upload.wikimedia.org/wikipedia/commons/e/e5/Xbox_Logo.svg'),
(9, 'PlayStation', 'https://upload.wikimedia.org/wikipedia/commons/0/00/PlayStation_logo.svg'),
(9, 'Nintendo', 'https://upload.wikimedia.org/wikipedia/commons/b/b3/Nintendo_red_logo.svg'),
(9, 'Sega', 'https://upload.wikimedia.org/wikipedia/commons/1/13/SEGA_logo.svg');

-- Question 10
INSERT INTO preguntes (id, pregunta, resposta_correcta) VALUES
(10, 'Quina marca de telèfons té com a eslògan ''Do What You Can’t''?', 0);
INSERT INTO respostes (pregunta_id, resposta, imatge) VALUES
(10, 'Samsung', 'https://upload.wikimedia.org/wikipedia/commons/6/61/Samsung_old_logo_before_year_2015.svg'),
(10, 'Xiaomi', 'https://upload.wikimedia.org/wikipedia/commons/2/29/Xiaomi_logo.svg'),
(10, 'OnePlus', 'https://upload.wikimedia.org/wikipedia/commons/f/f8/OP_LU_Reg_1L_RGB_red_copy-01.svg'),
(10, 'Google', 'https://upload.wikimedia.org/wikipedia/commons/c/c1/Google_%22G%22_logo.svg');

-- Question 11
INSERT INTO preguntes (id, pregunta, resposta_correcta) VALUES
(11, 'Quina marca d’aigua embotellada té com a lema ''Live Young''?', 0);
INSERT INTO respostes (pregunta_id, resposta, imatge) VALUES
(11, 'Evian', 'https://upload.wikimedia.org/wikipedia/commons/1/18/Evian_logo.svg'),
(11, 'Perrier', 'https://upload.wikimedia.org/wikipedia/commons/7/7e/Perrier_logo.svg'),
(11, 'Vichy Catalan', NULL),
(11, 'San Pellegrino', 'https://upload.wikimedia.org/wikipedia/commons/5/52/Sanpelegrino.svg');

-- Question 12
INSERT INTO preguntes (id, pregunta, resposta_correcta) VALUES
(12, 'Quina marca de xocolata utilitza l’eslògan ''Have a Break, Have a ...''?', 0);
INSERT INTO respostes (pregunta_id, resposta, imatge) VALUES
(12, 'KitKat', 'https://upload.wikimedia.org/wikipedia/commons/a/ae/KitKat_US_logo.svg'),
(12, 'Snickers', 'https://upload.wikimedia.org/wikipedia/commons/4/4c/Snickers_logo_%282000-2005%29.svg'),
(12, 'Mars', 'https://upload.wikimedia.org/wikipedia/commons/b/bb/Mars_Logo.svg'),
(12, 'Twix', 'https://upload.wikimedia.org/wikipedia/commons/4/43/Twix_brand_logo.png');

-- Question 13
INSERT INTO preguntes (id, pregunta, resposta_correcta) VALUES
(13, 'Quina marca de roba esportiva té com a lema ''Impossible is Nothing''?', 2);
INSERT INTO respostes (pregunta_id, resposta, imatge) VALUES
(13, 'Puma', 'https://upload.wikimedia.org/wikipedia/commons/a/ae/Puma-logo-%28text%29.svg'),
(13, 'Nike', 'https://upload.wikimedia.org/wikipedia/commons/a/a6/Logo_NIKE.svg'),
(13, 'Adidas', 'https://upload.wikimedia.org/wikipedia/commons/1/1b/Adidas_2022_logo.svg'),
(13, 'Under Armour', 'https://upload.wikimedia.org/wikipedia/commons/4/44/Under_armour_logo.svg');

-- Question 14
INSERT INTO preguntes (id, pregunta, resposta_correcta) VALUES
(14, 'Quina marca de gelats és coneguda pel nom italià i logotip blau?', 1);
INSERT INTO respostes (pregunta_id, resposta, imatge) VALUES
(14, 'Ben & Jerry’s', 'https://upload.wikimedia.org/wikipedia/commons/3/3c/Ben_%26_Jerry%27s.svg'),
(14, 'Häagen-Dazs', 'https://upload.wikimedia.org/wikipedia/commons/3/3c/H%C3%A4agen-Dazs_Logo.svg'),
(14, 'Carte d’Or', 'https://upload.wikimedia.org/wikipedia/fr/d/d9/Logo_Carte_d%27Or.svg'),
(14, 'Gelato Italia', 'https://upload.wikimedia.org/wikipedia/en/8/8e/Gelato_Italia_Logo.jpg');

-- Question 15
INSERT INTO preguntes (id, pregunta, resposta_correcta) VALUES
(15, 'Quina marca de banc utilitza el lema ''Because you’re worth it''?', 3);
INSERT INTO respostes (pregunta_id, resposta, imatge) VALUES
(15, 'Santander', 'https://upload.wikimedia.org/wikipedia/commons/c/c0/Santander_Bank_Polska_S.A.svg'),
(15, 'BBVA', 'https://upload.wikimedia.org/wikipedia/commons/9/98/BBVA_logo_2025.svg'),
(15, 'CaixaBank', 'https://upload.wikimedia.org/wikipedia/commons/5/54/La_Caixa_logo.svg'),
(15, 'Cap d’aquestes', NULL);
-- Question 16
INSERT INTO preguntes (id, pregunta, resposta_correcta) VALUES
(16, 'Quina marca de motocicletes és coneguda pel logotip amb ales?', 1);
INSERT INTO respostes (pregunta_id, resposta, imatge) VALUES
(16, 'Harley-Davidson', 'https://upload.wikimedia.org/wikipedia/commons/d/de/Harley-Davidson_logo.svg'),
(16, 'Honda', 'https://upload.wikimedia.org/wikipedia/commons/7/76/Honda_logo.svg'),
(16, 'Yamaha', 'https://upload.wikimedia.org/wikipedia/commons/1/1b/Yamaha_Motor_2025.svg'),
(16, 'Ducati', 'https://upload.wikimedia.org/wikipedia/commons/3/36/Ducati_red_logo.svg');

-- Question 17
INSERT INTO preguntes (id, pregunta, resposta_correcta) VALUES
(17, 'Quina marca de càmeres és famosa pel lema ''Capture the Future''?', 2);
INSERT INTO respostes (pregunta_id, resposta, imatge) VALUES
(17, 'Canon', 'https://upload.wikimedia.org/wikipedia/commons/0/0a/Canon_wordmark.svg'),
(17, 'Nikon', 'https://upload.wikimedia.org/wikipedia/commons/f/f3/Nikon_Logo.svg'),
(17, 'Sony', 'https://upload.wikimedia.org/wikipedia/commons/c/ca/Sony_logo.svg'),
(17, 'Fujifilm', 'https://upload.wikimedia.org/wikipedia/commons/a/a1/Fujifilm_logo.svg');

-- Question 18
INSERT INTO preguntes (id, pregunta, resposta_correcta) VALUES
(18, 'Quina marca de perfums utilitza el número ''5'' en el seu producte icònic?', 1);
INSERT INTO respostes (pregunta_id, resposta, imatge) VALUES
(18, 'Dior', 'https://upload.wikimedia.org/wikipedia/commons/5/56/Dior_Logo_2022.svg'),
(18, 'Chanel', 'https://upload.wikimedia.org/wikipedia/commons/3/35/Chanel_logo.svg'),
(18, 'Gucci', 'https://upload.wikimedia.org/wikipedia/commons/7/79/1960s_Gucci_Logo.svg'),
(18, 'Armani', 'https://upload.wikimedia.org/wikipedia/commons/1/13/Armani_logo.svg');

-- Question 19
INSERT INTO preguntes (id, pregunta, resposta_correcta) VALUES
(19, 'Quina marca de refrescos té com a color principal el taronja?', 2);
INSERT INTO respostes (pregunta_id, resposta, imatge) VALUES
(19, 'Sprite', 'https://upload.wikimedia.org/wikipedia/commons/b/b9/Sprite_Logo.svg'),
(19, 'Pepsi', 'https://upload.wikimedia.org/wikipedia/commons/0/0f/Pepsi_logo_2014.svg'),
(19, 'Fanta', 'https://upload.wikimedia.org/wikipedia/commons/6/62/Fanta_logo_%282009%29.svg'),
(19, '7Up', 'https://upload.wikimedia.org/wikipedia/commons/f/fb/7-up_Logo.svg');

-- Question 20
INSERT INTO preguntes (id, pregunta, resposta_correcta) VALUES
(20, 'Quina marca de joguines és coneguda pels seus blocs de construcció?', 1);
INSERT INTO respostes (pregunta_id, resposta, imatge) VALUES
(20, 'Playmobil', 'https://upload.wikimedia.org/wikipedia/commons/4/41/Playmobil_logo.svg'),
(20, 'Lego', 'https://upload.wikimedia.org/wikipedia/commons/2/24/LEGO_logo.svg'),
(20, 'Mattel', 'https://upload.wikimedia.org/wikipedia/commons/a/a6/Mattel_logo.svg'),
(20, 'Hasbro', 'https://upload.wikimedia.org/wikipedia/commons/2/27/Hasbro_logo_%281998-2009%29.svg');

