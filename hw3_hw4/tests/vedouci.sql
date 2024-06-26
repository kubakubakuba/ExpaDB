/* Vylistování všech vedoucích (a skupin které vedou), kteří nemají vyplněno telefonní číslo. */

SELECT Uzivatel.login, Uzivatel.jmeno, Skupina.jmeno AS skupina_jmeno FROM Uzivatel
	INNER JOIN Vedouci ON Uzivatel.id_uzivatel = Vedouci.id_uzivatel
	INNER JOIN Skupina ON Vedouci.vede = Skupina.id_skupina
	WHERE Uzivatel.telefon IS NULL
	ORDER BY Uzivatel.login ASC LIMIT 10;