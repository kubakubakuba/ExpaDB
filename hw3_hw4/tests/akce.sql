/* Výpis všech akcí, které se konaly v prvním týdnu v dubnu (vždy mezi půlnocí a 8:00), s uživateli, kterými byly vytvořeny. */

SELECT Akce.nazev, Akce.cas, Uzivatel.jmeno AS zalozil FROM Akce
	INNER JOIN Vedouci ON Akce.created_by = Vedouci.id_uzivatel
	INNER JOIN Uzivatel ON Vedouci.id_uzivatel = Uzivatel.id_uzivatel
	WHERE Akce.cas >= '2024-04-01' AND Akce.cas <= '2024-04-07' AND EXTRACT(HOUR FROM Akce.cas) >= 0 AND EXTRACT(HOUR FROM Akce.cas) < 8
	ORDER BY Akce.cas ASC;