CREATE TABLE AGENDA(
       USUARI VARCHAR(50) NOT NULL,
       TELEFON VARCHAR(15) NOT NULL,
       PRIMARY KEY (USUARI,TELEFON),
       FOREIGN KEY (USUARI) REFERENCES DADES(USUARI));

CREATE TABLE DADES(
       USUARI VARCHAR(50) NOT NULL PRIMARY KEY,
       EMAIL VARCHAR(50),
       IMAGE VARCHAR(50));

INSERT INTO DADES (USUARI, EMAIL, IMAGE)
VALUES
('PERE', NULL, NULL);
INSERT INTO DADES (USUARI, EMAIL, IMAGE)
VALUES
('JOAN', 'szymanski@gmail.com', NULL);
INSERT INTO DADES (USUARI, EMAIL, IMAGE)
VALUES
('ANA', NULL, NULL);

INSERT INTO AGENDA (USUARI,TELEFON)
VALUES
('PERE','99544632');
INSERT INTO AGENDA (USUARI,TELEFON)
VALUES
('JOAN','23144632');
INSERT INTO AGENDA (USUARI,TELEFON)
VALUES
('PERE','99542332');
INSERT INTO AGENDA (USUARI,TELEFON)
VALUES
('ANA','23144632');

CREATE TRIGGER REPETIT
BEFORE INSERT ON AGENDA
FOR EACH ROW
WHEN EXISTS (SELECT * FROM AGENDA WHERE USUARI=NEW.USUARI AND TELEFON=NEW.TELEFON)
BEGIN
	SELECT RAISE(IGNORE);
END;

CREATE TRIGGER REPETIT2
BEFORE UPDATE OF USUARI ON AGENDA
FOR EACH ROW
WHEN EXISTS (SELECT * FROM AGENDA WHERE USUARI=NEW.USUARI AND TELEFON=OLD.TELEFON)
BEGIN
	SELECT RAISE(IGNORE);
END;


CREATE TRIGGER REPETIT3
BEFORE UPDATE OF TELEFON ON AGENDA
FOR EACH ROW
WHEN EXISTS (SELECT * FROM AGENDA WHERE USUARI=OLD.USUARI AND TELEFON=NEW.TELEFON )
BEGIN
	SELECT RAISE(IGNORE);
END;
