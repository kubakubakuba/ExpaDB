--fix for SERIAL values
SELECT setval('vybaveni_id_vybaveni_seq', (SELECT MAX(id_vybaveni) FROM Vybaveni));
SELECT setval('uzivatel_id_uzivatel_seq', (SELECT MAX(id_uzivatel) FROM Uzivatel));
SELECT setval('skupina_id_skupina_seq', (SELECT MAX(id_skupina) FROM Skupina));
SELECT setval('akce_id_akce_seq', (SELECT MAX(id_akce) FROM Akce));
SELECT setval('prednasejici_id_prednasejici_seq', (SELECT MAX(id_prednasejici) FROM Prednasejici));
SELECT setval('program_id_program_seq', (SELECT MAX(id_program) FROM Program));