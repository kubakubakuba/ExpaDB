/* Zobrazí uživatele, kteří se přihlásili na nejvíce workshopů. */

SELECT Uzivatel.login, Uzivatel.jmeno, COUNT(*) AS pocet FROM Uzivatel
	INNER JOIN SePrihlasujeNa ON Uzivatel.id_uzivatel = SePrihlasujeNa.id_uzivatel
	GROUP BY Uzivatel.jmeno, Uzivatel.login
	ORDER BY pocet DESC
	LIMIT 10;