EXPLAIN ANALYZE SELECT * FROM Vybaveni WHERE majitel LIKE 'Jan%';

CREATE INDEX idx_vybaveni_majitel ON Vybaveni (majitel);

EXPLAIN ANALYZE SELECT * FROM Vybaveni WHERE majitel LIKE 'Jan%';

DROP INDEX idx_vybaveni_majitel;