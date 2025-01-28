-- Nivell 2
-- Exercici 1
-- Elimina de la taula transaction el registre amb ID 02C6201E-D90A-1859-B4EE-88D2986D3B02 de la base de dades.

DELETE FROM transaction
WHERE id = '02C6201E-D90A-1859-B4EE-88D2986D3B02';

-- Comprobació de que el registre s'ha eliminat correctament de la base de dades de la taula de transaction.

SELECT * FROM transaction
WHERE id = '02C6201E-D90A-1859-B4EE-88D2986D3B02';

-- Exercici 2
-- La secció de màrqueting desitja tenir accés a informació específica per a realitzar anàlisi i estratègies efectives. S'ha sol·licitat crear una vista que proporcioni detalls clau sobre les companyies i les seves transaccions. Serà necessària que creïs una vista anomenada VistaMarketing que contingui la següent informació: Nom de la companyia. Telèfon de contacte. País de residència. Mitjana de compra realitzat per cada companyia. Presenta la vista creada, ordenant les dades de major a menor mitjana de compra.

CREATE VIEW VistaMarketing AS
SELECT company_name AS nom_companyia, phone AS telefon_contacte,country AS pais, AVG(amount) AS mitjana_compres
FROM company
JOIN transaction ON company.id = transaction.company_id
WHERE declined = 0  
GROUP BY nom_companyia, telefon_contacte, pais
ORDER BY mitjana_compres DESC;

-- Es crea directament una vista filtrada a l'apartat de views

-- Exercici 3
-- Filtra la vista VistaMarketing per a mostrar només les companyies que tenen el seu país de residència en "Germany"

SELECT *
FROM vistamarketing
WHERE pais = 'Germany';