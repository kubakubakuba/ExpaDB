/* Vypíše login, jméno, id skupiny a jméno skupiny uživatelů, kteří jsou v nějaké skupině. Pokud uživatel není v žádné skupině, vypíše se NULL. */

SELECT U.login, U.jmeno, S.jmeno AS skupina_jmeno
FROM Uzivatel U
LEFT OUTER JOIN Ucastnik UC ON U.id_uzivatel = UC.id_uzivatel
LEFT OUTER JOIN Skupina S ON UC.soucasti_skupiny = S.id_skupina
ORDER BY U.id_uzivatel ASC LIMIT 15;
