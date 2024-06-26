EXPLAIN ANALYZE
	SELECT nazev, majitel, cena, inventarni_cislo FROM Vybaveni
		WHERE cena > 1000 AND nazev IN (
			SELECT nazev FROM Vybaveni
				WHERE nazev LIKE 'Fujifilm%' OR nazev LIKE 'DJI%' OR nazev LIKE 'RED Digital Cinema%'
		)
		ORDER BY cena DESC, nazev ASC;
