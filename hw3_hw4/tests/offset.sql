/* Zobrazí druhých 10 vybavení s cenou v rozmezí 10-15k zaokrouhlenou na celá čísla, seřazených podle ceny, jména a jména majitele. */

SELECT Vybaveni.nazev, Vybaveni.majitel, ROUND(Vybaveni.cena) AS cena FROM Vybaveni
	WHERE Vybaveni.cena >= 10000 AND Vybaveni.cena <= 15000
	ORDER BY cena, Vybaveni.nazev, Vybaveni.majitel
	LIMIT 10 OFFSET 10;