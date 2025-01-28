-- Nivell 3
-- Exercici 1

-- La setmana vinent tindràs una nova reunió amb els gerents de màrqueting. Un company del teu equip va realitzar modificacions en la base de dades, però no recorda com les va realitzar.

CREATE TABLE IF NOT EXISTS user (
        id INT PRIMARY KEY,
        name VARCHAR(100),
        surname VARCHAR(100),
        phone VARCHAR(150),
        email VARCHAR(150),
        birth_date VARCHAR(100),
        country VARCHAR(150),
        city VARCHAR(150),
        postal_code VARCHAR(100),
        address VARCHAR(255));
        
RENAME TABLE user TO data_user;

SET FOREIGN_KEY_checks=0; 
ALTER TABLE transaction
	ADD CONSTRAINT fk_data_user_id FOREIGN KEY (user_id) REFERENCES data_user (id);

ALTER TABLE company
DROP COLUMN website;


ALTER TABLE data_user
RENAME COLUMN email TO personal_email;

ALTER TABLE credit_card ADD COLUMN fecha_actual DATE;


-- Exercici 2
-- L'empresa també et sol·licita crear una vista anomenada "InformeTecnico" que contingui la següent informació:

-- ID de la transacció
-- Nom de l'usuari/ària
-- Cognom de l'usuari/ària
-- IBAN de la targeta de crèdit usada.
-- Nom de la companyia de la transacció realitzada.
-- Assegura't d'incloure informació rellevant de totes dues taules i utilitza àlies per a canviar de nom columnes segons sigui necessari.
-- Mostra els resultats de la vista, ordena els resultats de manera descendent en funció de la variable ID de transaction.

CREATE VIEW InformeTecnico AS
SELECT transaction.id AS ID_transacció,name AS Nom_Usuari, surname AS Cognom_Usuari,iban AS IBAN_Targeta,company_name AS Nom_Companyia
FROM transaction 
JOIN data_user ON transaction.user_id = data_user.id
JOIN credit_card ON transaction.credit_card_id = credit_card.id
JOIN company ON transaction.company_id = company.id
ORDER BY transaction.id DESC;

-- Es crea directament una vista filtrada a l'apartat de views