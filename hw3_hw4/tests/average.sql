/* Spočítá průměrnou cenu vybavení, které je buďto Canon EOS 5D, Canon EOS 6D nebo Canon EOS 7D. */

SELECT AVG(cena) FROM Vybaveni
	WHERE nazev IN ('Canon EOS 5D', 'Canon EOS 6D', 'Canon EOS 7D') AND cena IS NOT NULL;