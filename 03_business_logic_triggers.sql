-- TRG 1
CREATE OR REPLACE TRIGGER TRG_Rezerwacja
BEFORE INSERT OR UPDATE ON Rezerwacja
FOR EACH ROW
DECLARE
    v_status_nazwa VARCHAR2(50);
BEGIN

    SELECT STATUS.Nazwa INTO v_status_nazwa
    FROM POLE_GOLFOWE
    JOIN STATUS ON POLE_GOLFOWE.Status_ID = STATUS.ID
    WHERE POLE_GOLFOWE.ID = :new.Pole_Golfowe_ID;

    IF v_status_nazwa = 'W konserwacji' THEN
        RAISE_APPLICATION_ERROR(-20101, 'Błąd: To pole golfowe jest obecnie w konserwacji!');
    END IF;

    IF :new.DataEnd <= :new.DataStart THEN
        RAISE_APPLICATION_ERROR(-20102, 'Błąd: Data zakończenia rezerwacji musi być późniejsza niż rozpoczęcia.');
    END IF;

    IF UPDATING THEN
        dbms_output.put_line('UWAGA: Zmodyfikowano rezerwację o ID: ' || :new.ID);
    END IF;
END;
/


-- TEST 1.1
INSERT INTO Rezerwacja (ID, Czlonek_ID, Pole_Golfowe_ID, DataStart, DataEnd, Pracownik_ID)
VALUES (5, 1, 3, TO_DATE('2024-07-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-07-01 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1);

-- TEST 1.2
INSERT INTO Rezerwacja (ID, Czlonek_ID, Pole_Golfowe_ID, DataStart, DataEnd, Pracownik_ID)
VALUES (6, 1, 1, TO_DATE('2024-07-01 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-07-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1);

-- TEST 1.3
UPDATE Rezerwacja
SET DataEnd = TO_DATE('2024-06-10 15:00:00', 'YYYY-MM-DD HH24:MI:SS')
WHERE ID = 1;
COMMIT;

-- TRG 2
CREATE OR REPLACE TRIGGER TRG_Sprzet
BEFORE DELETE ON Sprzet_Golfowy
FOR EACH ROW
BEGIN
    IF DELETING THEN

        IF :old.Ilosc > 0 THEN
            RAISE_APPLICATION_ERROR(-20103, 'Błąd: Nie można usunąć sprzętu. Wciąż są sztuki na magazynie!');

        ELSIF :old.CenaZaDzien >= 100 THEN
            RAISE_APPLICATION_ERROR(-20104, 'Błąd: Wymagana autoryzacja menadżera do usunięcia.');

        ELSE
            dbms_output.put_line('Pomyślnie usunięto stary sprzęt z systemu: ' || :old.Nazwa);
        END IF;
    END IF;
END;
/

-- TETS 2.1
DELETE FROM Sprzet_Golfowy
WHERE ID = 1;

-- TEST 2.2
INSERT INTO Sprzet_Golfowy (ID, Nazwa, CenaZaDzien, Ilosc)
VALUES (9, 'Ubrania', 200, 0);
COMMIT;

DELETE FROM Sprzet_Golfowy
WHERE ID = 9;
COMMIT;

-- TEST 2.3
INSERT INTO Sprzet_Golfowy (ID, Nazwa, CenaZaDzien, Ilosc)
VALUES (10, 'Zepsuty wozek', 10, 0);
COMMIT;

DELETE FROM Sprzet_Golfowy WHERE ID = 10;
COMMIT;

-- TRG 3
CREATE OR REPLACE TRIGGER TRG_Wypozyczenie
AFTER INSERT OR DELETE ON Wypozyczenie_Sprzetu
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        UPDATE Sprzet_Golfowy
        SET Ilosc = Ilosc - 1
        WHERE ID = :new.Sprzet_Golfowy_ID;
        dbms_output.put_line('Zarejestrowano wydanie sprzętu ID: ' || :new.Sprzet_Golfowy_ID || '. Stan magazynowy pomniejszony.');

    ELSIF DELETING THEN
        UPDATE Sprzet_Golfowy
        SET Ilosc = Ilosc + 1
        WHERE ID = :old.Sprzet_Golfowy_ID;
        dbms_output.put_line('Zwrócono sprzęt ID: ' || :old.Sprzet_Golfowy_ID || ' na stan.');
    END IF;
END;
/

-- TEST 3.1
INSERT INTO Wypozyczenie_Sprzetu (ID, Sprzet_Golfowy_ID, Czlonek_ID, Pracownik_ID, DateStart, DateEnd)
VALUES (10, 4, 1, 1, DATE '2024-07-01', DATE '2024-07-05');
COMMIT;

--TEST 3.2
DELETE FROM Wypozyczenie_Sprzetu
WHERE ID = 10;
COMMIT;

-- TRG 4
CREATE OR REPLACE TRIGGER TRG_Cennik
AFTER UPDATE ON Sprzet_Golfowy
FOR EACH ROW
DECLARE
    v_roznica NUMBER;
BEGIN
    v_roznica := :new.CenaZaDzien - :old.CenaZaDzien;

    IF v_roznica > 0 THEN
        dbms_output.put_line('Podniesiono cenę za ' || :new.Nazwa || ' o ' || v_roznica || ' PLN.');
    ELSIF v_roznica < 0 THEN
        dbms_output.put_line('Obniżono cenę za ' || :new.Nazwa || ' o ' || ABS(v_roznica) || ' PLN.');
    END IF;
END;
/

-- TEST 4.1
UPDATE Sprzet_Golfowy
SET CenaZaDzien = 250
WHERE ID = 3;
COMMIT;

-- TEST 4.2
UPDATE Sprzet_Golfowy
SET CenaZaDzien = 150
WHERE ID = 3;
COMMIT;