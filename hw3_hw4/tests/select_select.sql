/* Vypíše přes vnořený SELECT všechny kusy vybavení (nazev, majitele, cenu, inventarni cislo), která mají cenu, která je vyšší než 10000 korun, a vybavení (název) začíná na Fujifilm, DJI nebo RED Digital Cinema.*/

SELECT nazev, majitel, cena, inventarni_cislo FROM Vybaveni
	WHERE cena > 10000 AND nazev IN (
		SELECT nazev FROM Vybaveni
			WHERE nazev LIKE 'Fujifilm%' OR nazev LIKE 'DJI%' OR nazev LIKE 'RED Digital Cinema%'
	)
	ORDER BY cena DESC, nazev ASC
	LIMIT 10;
