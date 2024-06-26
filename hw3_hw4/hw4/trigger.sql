BEGIN TRANSACTION;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

CREATE TABLE UzivatelChanges (
	changes_id SERIAL PRIMARY KEY,
	id_uzivatel INTEGER NOT NULL,
	old_login VARCHAR(64),
	new_login VARCHAR(64),
	old_email VARCHAR(64),
	new_email VARCHAR(64),
	old_telefon VARCHAR(23),
	new_telefon VARCHAR(23),
	change_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (id_uzivatel) REFERENCES Uzivatel(id_uzivatel)
);

CREATE OR REPLACE FUNCTION update_uzivatel()
RETURNS TRIGGER AS $$
BEGIN
	IF OLD.login <> NEW.login THEN
		INSERT INTO UzivatelChanges (id_uzivatel, old_login, new_login)
		VALUES (OLD.id_uzivatel, OLD.login, NEW.login);
	END IF;

	IF OLD.email <> NEW.email THEN
		INSERT INTO UzivatelChanges (id_uzivatel, old_email, new_email)
		VALUES (OLD.id_uzivatel, OLD.email, NEW.email);
	END IF;

	IF OLD.telefon <> NEW.telefon THEN
		INSERT INTO UzivatelChanges (id_uzivatel, old_telefon, new_telefon)
		VALUES (OLD.id_uzivatel, OLD.telefon, NEW.telefon);
	END IF;
	
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trigger_update_uzivatel
AFTER UPDATE ON Uzivatel
FOR EACH ROW
EXECUTE FUNCTION update_uzivatel();

/* Example */

INSERT INTO Uzivatel (login, heslo, salt, jmeno, email, telefon, psc, mesto, ulice, cislo) VALUES ('test' , 'secret', 'salt', 'Testing', 'email@seznam.cz', '111222333', 10000, 'Praha 1', 'Evropská', 10);

UPDATE Uzivatel SET login = 'test2', email = 'seznam@email.cz', telefon = '444555666' WHERE login = 'test';

SELECT * FROM UzivatelChanges;
SELECT * FROM Uzivatel WHERE login = 'test2';

COMMIT;

-- revert changes

-- fix SERIAL
--SELECT setval('uzivatel_id_uzivatel_seq', (SELECT MAX(id_uzivatel) FROM Uzivatel));

--DROP TABLE UzivatelChanges CASCADE;

--DELETE FROM Uzivatel WHERE login = 'test2';