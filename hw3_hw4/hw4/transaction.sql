BEGIN TRANSACTION;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

DO

$$
DECLARE
	id_user INT;
	id_tool INT;

BEGIN

WITH person_query AS (
	INSERT INTO Uzivatel (login, heslo, salt, jmeno, email, telefon, psc, mesto, ulice, cislo)
	VALUES ('jpelc', '4930587ab5b21aa30577a4f674d54e8d46b2aafa7b0f72bf01b3cbf3dead8e79', 'dQw4w9WgXcQ', 'Jakub Pelc 2', 'rick2@seznam.cz', '+420606707808', 10000, 'Praha 10', 'Evropská', '10')
	RETURNING id_uzivatel
)	SELECT id_uzivatel INTO id_user FROM person_query;


WITH tool_query AS (
	INSERT INTO Vybaveni (inventarni_cislo, nazev, majitel, cena)
	VALUES ('FEE_0001', 'NixOS Laptop', 'Jakub Pelc', 100.00)
	RETURNING id_vybaveni
) SELECT id_vybaveni INTO id_tool FROM tool_query;

INSERT INTO Pouziva (id_uzivatel, id_vybaveni)
VALUES (id_user, id_tool);

END;

$$;

COMMIT;

SELECT * FROM Uzivatel WHERE login = 'jpelc';
SELECT * FROM Vybaveni WHERE inventarni_cislo = 'FEE_0001';