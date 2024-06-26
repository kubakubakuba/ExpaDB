--CREATE OR REPLACE VIEW Objektiv AS
--	SELECT *
--	FROM Vybaveni
--	WHERE nazev LIKE '%f/%';

--SELECT * FROM Objektiv WHERE nazev LIKE 'Sony%' ORDER BY id_vybaveni ASC LIMIT 10;

--DROP VIEW Objektiv;

CREATE OR REPLACE VIEW Objektiv AS
SELECT 
	id_vybaveni,
	nazev,
	majitel,
	cena,
	inventarni_cislo,
	SUBSTRING(nazev FROM '(\d+)mm') AS ohniskova_vzdalenost,
	SUBSTRING(nazev FROM 'f/(\d+(\.\d+)?)') AS f
FROM
	Vybaveni
WHERE 
	nazev LIKE '%f/%';

SELECT * FROM Objektiv WHERE nazev LIKE 'Sony%' ORDER BY id_vybaveni ASC LIMIT 10;

--DROP VIEW Objektiv;