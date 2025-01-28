-- Nivell 1 
-- Exercici 1  
-- La teva tasca és dissenyar i crear una taula anomenada "credit_card" que emmagatzemi detalls crucials sobre les targetes de crèdit. La nova taula ha de ser capaç d'identificar de manera única cada targeta i establir una relació adequada amb les altres dues taules ("transaction" i "company"). Després de crear la taula serà necessari que ingressis la informació del document denominat "dades_introduir_credit". Recorda mostrar el diagrama i realitzar una breu descripció d'aquest.

CREATE TABLE IF NOT EXISTS credit_card (
    id VARCHAR (20) PRIMARY KEY,                 
    iban VARCHAR(34)  NULL,          
    pan VARCHAR(34) NULL,           
    pin VARCHAR(4)  NULL,            
    cvv VARCHAR(3) NULL,            
    expiring_date VARCHAR(8) NULL);

-- Comprobació de les relacions que té la taula transaction:
  
SELECT CONSTRAINT_NAME, COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_NAME = 'transaction'
AND TABLE_SCHEMA = DATABASE();

-- He comprobat que tenía 3 fk que no corresponíen, les elimino:

ALTER TABLE transaction
DROP FOREIGN KEY transaction_ibfk_2;

ALTER TABLE transaction
DROP FOREIGN KEY transaction_ibfk_3;

ALTER TABLE transaction
DROP FOREIGN KEY transaction_ibfk_4;

-- Per poder crear les relacions entre taules correctament, activo el check de seguretat.
-- Procedeixo a crear totels les relacions amb codi:

SET FOREIGN_KEY_checks=0;

ALTER TABLE transaction
ADD CONSTRAINT fk_credit_card
FOREIGN KEY (credit_card_id) REFERENCES credit_card(id);

ALTER TABLE transaction
ADD CONSTRAINT fk_company
FOREIGN KEY (company_id) REFERENCES company(id);

ALTER TABLE transaction
ADD CONSTRAINT fk_data_user
FOREIGN KEY (user_id) REFERENCES user_id(id);

SET FOREIGN_KEY_checks=1;

-- Una vegada creades totes les relacions correctament, procedeixo a tancar el check de seguretat:

-- Exercici 2
-- El departament de Recursos Humans ha identificat un error en el número de compte de l'usuari amb ID CcU-2938. La informació que ha de mostrar-se per a aquest registre és: R323456312213576817699999. Recorda mostrar que el canvi es va realitzar.

UPDATE credit_card
SET iban = 'R323456312213576817699999'
WHERE id = 'CcU-2938';

-- Comprobació de l'actualiztació del error en el número de compte de l'usuari:

SELECT id, iban
FROM credit_card
WHERE id = 'CcU-2938';

-- Exercici 3
-- En la taula "transaction" ingressa un nou usuari amb la següent informació.

INSERT INTO transaction (id, credit_card_id, company_id, user_id, lat, longitude, amount, declined)
VALUES ('108B1D1D-5B23-A76C-55EF-C568E49A99DD', 'CcU-9999', 'b-9999', 9999, 829.999, -117.999, 111.11, 0);


SELECT * FROM transaction WHERE id = '108B1D1D-5B23-A76C-55EF-C568E49A99DD';

-- - Exercici 4
-- Des de recursos humans et sol·liciten eliminar la columna "pan" de la taula credit_*card. Recorda mostrar el canvi realitzat.

ALTER TABLE credit_card
DROP COLUMN pan;

-- Comprobació de que la columna "pan" s'ha eliminat correctament:

DESCRIBE credit_card;


