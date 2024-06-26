/* Zobrazí skupiny, které mají průměrnou cenu vybavení vyšší než 25 500. */

SELECT Skupina.jmeno, AVG(Vybaveni.cena) AS prumerna_cena FROM Skupina
	JOIN MaPrirazeno ON Skupina.id_skupina = MaPrirazeno.id_skupina
	JOIN Vybaveni ON MaPrirazeno.id_vybaveni = Vybaveni.id_vybaveni
	GROUP BY Skupina.jmeno
	HAVING AVG(Vybaveni.cena) > 25500 ORDER BY prumerna_cena DESC;