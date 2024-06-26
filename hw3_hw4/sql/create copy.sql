CREATE TABLE Uzivatel (
	id_uzivatel SERIAL PRIMARY KEY,
	login VARCHAR(64) NOT NULL,
	heslo VARCHAR(128) NOT NULL,
	salt VARCHAR(32) NOT NULL,
	jmeno VARCHAR(64),
	email VARCHAR(64),
	telefon VARCHAR(23),
	psc INTEGER CHECK (psc >= 10000 AND psc <= 99999),
	mesto VARCHAR(64),
	ulice VARCHAR(64),
	cislo VARCHAR(16),
	UNIQUE (login)
);

CREATE TABLE Skupina (
	id_skupina SERIAL PRIMARY KEY,
	jmeno VARCHAR(64) NOT NULL,
	UNIQUE (jmeno)
);

/* ON DELETE SET je použito, protože pokud smažeme uživatele, tak záznam v tabulce vedoucích ztrácí smysl. */
/* ON UPDATE CASCADE je použito, protože pokud změníme skupinu kterou vedoucí vede, musíme také změnit skupinu v tabulce vedoucích. */
/* ON DELETE SET NULL je použito, protože pokud smažeme skupinu, tak vedoucí již žádnou skupinu nevede. */
CREATE TABLE Vedouci (
	id_uzivatel INTEGER PRIMARY KEY,
	vede INT,
	FOREIGN KEY (id_uzivatel) REFERENCES Uzivatel ON DELETE CASCADE,
	FOREIGN KEY (vede) REFERENCES Skupina(id_skupina) ON UPDATE CASCADE ON DELETE SET NULL
);

/* ON DELETE a ON UPDATE CASCADE je podobné jako u tabulky Vedouci. ON DELETE SET NULL - účastník již není součástí žádné skupiny. */
CREATE TABLE Ucastnik (
	id_uzivatel INTEGER PRIMARY KEY,
	soucasti_skupiny INT NOT NULL,
	FOREIGN KEY (id_uzivatel) REFERENCES Uzivatel ON DELETE CASCADE,
	FOREIGN KEY (soucasti_skupiny) REFERENCES Skupina(id_skupina) ON UPDATE CASCADE ON DELETE SET NULL
);

/* Po smazání uživatele nastavíme autora akcí na null. */
CREATE TABLE Akce (
	id_akce SERIAL PRIMARY KEY,
	created_by INTEGER NOT NULL,
	nazev VARCHAR(64) NOT NULL,
	cas TIMESTAMP NOT NULL,
	popis TEXT,
	UNIQUE (nazev, cas),
	FOREIGN KEY (created_by) REFERENCES Vedouci(id_uzivatel) ON DELETE SET NULL
);

/* Při smazání akce, smažeme i záznam v tabulce Prednaska. */
CREATE TABLE Prednaska (
	id_akce INTEGER PRIMARY KEY,
	FOREIGN KEY (id_akce) REFERENCES Akce ON DELETE CASCADE,
	misto VARCHAR(64) NOT NULL
);

/* Při smazání akce, smažeme i záznam v tabulce Prednasejici. */
CREATE TABLE Prednasejici (
	id_prednasejici SERIAL PRIMARY KEY,
	jmeno VARCHAR(64) NOT NULL,
	id_akce INTEGER NOT NULL,
	FOREIGN KEY (id_akce) REFERENCES Prednaska ON DELETE CASCADE,
	UNIQUE (jmeno, id_akce)
);

/* Při smazání akce, smažeme i záznam v tabulce Workshop. */
CREATE TABLE Workshop (
	id_akce INTEGER PRIMARY KEY,
	FOREIGN KEY (id_akce) REFERENCES Akce ON DELETE CASCADE,
	misto VARCHAR(64) NOT NULL
);

/* Při smazání akce, smažeme i záznam v tabulce Program. */
CREATE TABLE Program (
	id_program SERIAL PRIMARY KEY,
	cas_polozky TIMESTAMP NOT NULL,
	nazev VARCHAR(64) NOT NULL,
	id_akce INTEGER NOT NULL,
	FOREIGN KEY (id_akce) REFERENCES Workshop ON DELETE CASCADE,
	UNIQUE (cas_polozky, id_akce)
);

CREATE TABLE Vybaveni (
	id_vybaveni SERIAL PRIMARY KEY,
	inventarni_cislo VARCHAR(64) NOT NULL,
	nazev VARCHAR(64) NOT NULL,
	majitel VARCHAR(64) NOT NULL,
	cena DECIMAL(10,2),
	UNIQUE (inventarni_cislo),
	UNIQUE (nazev, majitel)
);

/* Při změně / smazání skupiny nebo vybavení, musíme smazat i záznam v tabulce MaPrirazeno. */
CREATE TABLE MaPrirazeno (
	id_skupina INTEGER NOT NULL,
	id_vybaveni INTEGER NOT NULL,
	FOREIGN KEY (id_skupina) REFERENCES Skupina ON DELETE CASCADE,
	FOREIGN KEY (id_vybaveni) REFERENCES Vybaveni ON DELETE CASCADE,
	PRIMARY KEY (id_skupina, id_vybaveni)
);

/* Při smazání uživatele nebo vybaveni, smažeme i záznam v tabulce Pouziva. */
CREATE TABLE Pouziva (
	id_uzivatel INTEGER NOT NULL,
	id_vybaveni INTEGER NOT NULL,
	FOREIGN KEY (id_uzivatel) REFERENCES Uzivatel ON DELETE CASCADE,
	FOREIGN KEY (id_vybaveni) REFERENCES Vybaveni ON DELETE CASCADE,
	PRIMARY KEY (id_uzivatel, id_vybaveni)
);

/* Při smazání akce nebo uživatele, smažeme i záznam v tabulce SePrihlasujeNa. */
CREATE TABLE SePrihlasujeNa (
	id_uzivatel INTEGER NOT NULL,
	id_akce INTEGER NOT NULL,
	FOREIGN KEY (id_uzivatel) REFERENCES Ucastnik ON DELETE CASCADE,
	FOREIGN KEY (id_akce) REFERENCES Workshop ON DELETE CASCADE,
	PRIMARY KEY (id_uzivatel, id_akce)
);

/* Při smazání vedoucího nebo akce, smažeme i záznam v tabulce Organizuje. */
CREATE TABLE Organizuje (
	id_uzivatel INTEGER NOT NULL,
	id_akce INTEGER NOT NULL,
	FOREIGN KEY (id_uzivatel) REFERENCES Vedouci ON DELETE CASCADE,
	FOREIGN KEY (id_akce) REFERENCES Workshop ON DELETE CASCADE,
	PRIMARY KEY (id_uzivatel, id_akce)
);

/* Při smazání účastníka nebo akce, smažeme i záznam v tabulce PomahaOrganizovat. */
CREATE TABLE PomahaOrganizovat (
	id_uzivatel INTEGER NOT NULL,
	id_akce INTEGER NOT NULL,
	FOREIGN KEY (id_uzivatel) REFERENCES Ucastnik ON DELETE CASCADE,
	FOREIGN KEY (id_akce) REFERENCES Workshop ON DELETE CASCADE,
	PRIMARY KEY (id_uzivatel, id_akce)
);

/* Při smazání akce nebo skupiny smažeme i záznam v tabulce JePovinna. */
CREATE TABLE JePovinna (
	id_akce INTEGER NOT NULL,
	id_skupina INTEGER NOT NULL,
	FOREIGN KEY (id_akce) REFERENCES Akce ON DELETE CASCADE,
	FOREIGN KEY (id_skupina) REFERENCES Skupina ON DELETE CASCADE,
	PRIMARY KEY (id_akce, id_skupina)
);

/* Při smazání vedoucího - podřízeného nebo nadřízeného, smažeme i záznam v tabulce JeVedoucim. */
CREATE TABLE JeVedoucim (
	nadrizeny INTEGER NOT NULL,
	podrizeny INTEGER NOT NULL,
	FOREIGN KEY (nadrizeny) REFERENCES Vedouci(id_uzivatel) ON DELETE CASCADE,
	FOREIGN KEY (podrizeny) REFERENCES Vedouci(id_uzivatel) ON DELETE CASCADE,
	PRIMARY KEY (nadrizeny, podrizeny)
);

/* Při smazání účastníka nebo akce, smažeme i záznam v tabulce SeUcastni. */
CREATE TABLE SeUcastni (
	id_uzivatel INTEGER NOT NULL,
	id_akce INTEGER NOT NULL,
	FOREIGN KEY (id_uzivatel) REFERENCES Ucastnik ON DELETE CASCADE,
	FOREIGN KEY (id_akce) REFERENCES Akce ON DELETE CASCADE,
	PRIMARY KEY (id_uzivatel, id_akce)
);