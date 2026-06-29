CREATE TABLE Czlonek (
    ID integer  NOT NULL,
    Imie varchar2(50)  NOT NULL,
    Nazwisko varchar2(50)  NOT NULL,
    Email varchar2(50)  NOT NULL,
    Rodzaje_Czlonkostwa_ID integer  NOT NULL,
    CONSTRAINT Czlonek_pk PRIMARY KEY (ID)
) ;


CREATE TABLE Pole_Golfowe (
    ID integer  NOT NULL,
    Nazwa varchar2(50)  NOT NULL,
    Wielkosc integer  NOT NULL,
    LiczbaDolkow integer  NOT NULL,
    Status_ID integer  NOT NULL,
    CONSTRAINT Pole_Golfowe_pk PRIMARY KEY (ID)
) ;


CREATE TABLE Pracownik (
    ID integer  NOT NULL,
    Imie varchar2(50)  NOT NULL,
    Nazwisko varchar2(50)  NOT NULL,
    Hiredate date  NOT NULL,
    Pensja integer  NOT NULL,
    Stanowisko_ID integer  NOT NULL,
    CONSTRAINT Pracownik_pk PRIMARY KEY (ID)
) ;


CREATE TABLE Rezerwacja (
    ID integer  NOT NULL,
    Czlonek_ID integer  NOT NULL,
    Pole_Golfowe_ID integer  NOT NULL,
    DataStart date  NOT NULL,
    DataEnd date  NOT NULL,
    Pracownik_ID integer  NOT NULL,
    CONSTRAINT Rezerwacja_pk PRIMARY KEY (ID)
) ;


CREATE TABLE Rodzaje_Czlonkostwa (
    ID integer  NOT NULL,
    Nazwa varchar2(50)  NOT NULL,
    OplataRoczna integer  NOT NULL,
    CONSTRAINT Rodzaje_Czlonkostwa_pk PRIMARY KEY (ID)
) ;


CREATE TABLE Sprzet_Golfowy (
    ID integer  NOT NULL,
    Nazwa varchar2(50)  NOT NULL,
    CenaZaDzien integer  NOT NULL,
    Ilosc integer  NOT NULL,
    CONSTRAINT Sprzet_Golfowy_pk PRIMARY KEY (ID)
) ;


CREATE TABLE Stanowisko (
    ID integer  NOT NULL,
    Nazwa varchar2(50)  NOT NULL,
    CONSTRAINT Stanowisko_pk PRIMARY KEY (ID)
) ;


CREATE TABLE Status (
    ID integer  NOT NULL,
    Nazwa varchar2(50)  NOT NULL,
    CONSTRAINT Status_pk PRIMARY KEY (ID)
) ;


CREATE TABLE Turniej (
    ID integer  NOT NULL,
    Nazwa varchar2(50)  NOT NULL,
    Pole_Golfowe_ID integer  NOT NULL,
    DateStart date  NOT NULL,
    DateEnd date  NOT NULL,
    MaxLiczbaUczestnikow integer  NOT NULL,
    Organizator_ID integer  NOT NULL,
    Nagroda varchar2( 50)  NOT NULL,
    CONSTRAINT Turniej_pk PRIMARY KEY (ID)
) ;


CREATE TABLE Uczesnictwo_Turniej (
    Czlonek_ID integer  NOT NULL,
    Turniej_ID integer  NOT NULL,
    Zajete_TOPMiejse integer  NULL,
    CONSTRAINT Uczesnictwo_Turniej_pk PRIMARY KEY (Turniej_ID,Czlonek_ID)
) ;


CREATE TABLE Wypozyczenie_Sprzetu (
    ID integer  NOT NULL,
    Sprzet_Golfowy_ID integer  NOT NULL,
    Czlonek_ID integer  NOT NULL,
    Pracownik_ID integer  NOT NULL,
    DateStart date  NOT NULL,
    DateEnd date  NOT NULL,
    CONSTRAINT Wypozyczenie_Sprzetu_pk PRIMARY KEY (ID)
) ;


ALTER TABLE Czlonek ADD CONSTRAINT Czlonek_Rodzaje_Czlonkostwa
    FOREIGN KEY (Rodzaje_Czlonkostwa_ID)
    REFERENCES Rodzaje_Czlonkostwa (ID);


ALTER TABLE Pole_Golfowe ADD CONSTRAINT Pola_Golfowe_Status
    FOREIGN KEY (Status_ID)
    REFERENCES Status (ID);

ALTER TABLE Pracownik ADD CONSTRAINT Pracownicy_Stanowiska
    FOREIGN KEY (Stanowisko_ID)
    REFERENCES Stanowisko (ID);


ALTER TABLE Rezerwacja ADD CONSTRAINT Rezerwacje_Czlonkowie
    FOREIGN KEY (Czlonek_ID)
    REFERENCES Czlonek (ID);


ALTER TABLE Rezerwacja ADD CONSTRAINT Rezerwacje_Pracownicy
    FOREIGN KEY (Pracownik_ID)
    REFERENCES Pracownik (ID);


ALTER TABLE Rezerwacja ADD CONSTRAINT Rzerwacje_Pola_Golfowe
    FOREIGN KEY (Pole_Golfowe_ID)
    REFERENCES Pole_Golfowe (ID);


ALTER TABLE Turniej ADD CONSTRAINT Turniej_Pole_Golfowe
    FOREIGN KEY (Pole_Golfowe_ID)
    REFERENCES Pole_Golfowe (ID);


ALTER TABLE Turniej ADD CONSTRAINT Turnieje_Pracownicy
    FOREIGN KEY (Organizator_ID)
    REFERENCES Pracownik (ID);


ALTER TABLE Uczesnictwo_Turniej ADD CONSTRAINT Uczesnictwo_Turniej_Czlonek
    FOREIGN KEY (Czlonek_ID)
    REFERENCES Czlonek (ID);


ALTER TABLE Uczesnictwo_Turniej ADD CONSTRAINT Uczesnictwo_Turniej_Turnieje
    FOREIGN KEY (Turniej_ID)
    REFERENCES Turniej (ID);


ALTER TABLE Wypozyczenie_Sprzetu ADD CONSTRAINT Wypozyczenie_Sprzetu_Czlonek
    FOREIGN KEY (Czlonek_ID)
    REFERENCES Czlonek (ID);


ALTER TABLE Wypozyczenie_Sprzetu ADD CONSTRAINT Wypozyczenie_Sprzetu_Pracownik
    FOREIGN KEY (Pracownik_ID)
    REFERENCES Pracownik (ID);


ALTER TABLE Wypozyczenie_Sprzetu ADD CONSTRAINT Wypozyczenie_Sprzetu_Sprzet_Golfowy
    FOREIGN KEY (Sprzet_Golfowy_ID)
    REFERENCES Sprzet_Golfowy (ID);


INSERT INTO Stanowisko (ID, Nazwa) 
VALUES (1, 'Recepcjonista');
INSERT INTO Stanowisko (ID, Nazwa) 
VALUES (2, 'Organizator Turniejow');
INSERT INTO Stanowisko (ID, Nazwa) 
VALUES (3, 'Menadzer');


INSERT INTO Status (ID, Nazwa) 
VALUES (1, 'Otwarte');
INSERT INTO Status (ID, Nazwa) 
VALUES (2, 'W konserwacji');
INSERT INTO Status (ID, Nazwa) 
VALUES (3, 'Zarezerwowane pod turniej');


INSERT INTO Rodzaje_Czlonkostwa (ID, Nazwa, OplataRoczna) 
VALUES (1, 'Standard', 2000);
INSERT INTO Rodzaje_Czlonkostwa (ID, Nazwa, OplataRoczna) 
VALUES (2, 'VIP', 5000);
INSERT INTO Rodzaje_Czlonkostwa (ID, Nazwa, OplataRoczna) 
VALUES (3, 'Junior', 1000);


INSERT INTO Sprzet_Golfowy (ID, Nazwa, CenaZaDzien, Ilosc) 
VALUES (1, 'Zestaw kijow Pro', 100, 10);
INSERT INTO Sprzet_Golfowy (ID, Nazwa, CenaZaDzien, Ilosc) 
VALUES (2, 'Zestaw kijow Standard', 50, 20);
INSERT INTO Sprzet_Golfowy (ID, Nazwa, CenaZaDzien, Ilosc) 
VALUES (3, 'Meleks', 150, 5);
INSERT INTO Sprzet_Golfowy (ID, Nazwa, CenaZaDzien, Ilosc) 
VALUES (4, 'Wozek na kijki', 30, 15);


INSERT INTO Pracownik (ID, Imie, Nazwisko, Hiredate, Pensja, Stanowisko_ID) 
VALUES (1, 'Jan', 'Kowalski', TO_DATE('2020-05-10', 'YYYY-MM-DD'), 4200, 1); 
INSERT INTO Pracownik (ID, Imie, Nazwisko, Hiredate, Pensja, Stanowisko_ID) 
VALUES (2, 'Anna', 'Nowak', TO_DATE('2019-03-15', 'YYYY-MM-DD'), 5500, 2); 
INSERT INTO Pracownik (ID, Imie, Nazwisko, Hiredate, Pensja, Stanowisko_ID) 
VALUES (3, 'Piotr', 'Wisniewski', TO_DATE('2021-08-20', 'YYYY-MM-DD'), 5000, 2); 
INSERT INTO Pracownik (ID, Imie, Nazwisko, Hiredate, Pensja, Stanowisko_ID) 
VALUES (4, 'Tomasz', 'Krol', TO_DATE('2022-01-10', 'YYYY-MM-DD'), 4000, 1); 
INSERT INTO Pracownik (ID, Imie, Nazwisko, Hiredate, Pensja, Stanowisko_ID) 
VALUES (5, 'Maria', 'Zawadzka', TO_DATE('2018-11-01', 'YYYY-MM-DD'), 9500, 3);


INSERT INTO Czlonek (ID, Imie, Nazwisko, Email, Rodzaje_Czlonkostwa_ID) 
VALUES (1, 'Adam', 'Malysz', 'adam@test.pl', 2);
INSERT INTO Czlonek (ID, Imie, Nazwisko, Email, Rodzaje_Czlonkostwa_ID) 
VALUES (2, 'Robert', 'Lewandowski', 'robert@test.pl', 2);
INSERT INTO Czlonek (ID, Imie, Nazwisko, Email, Rodzaje_Czlonkostwa_ID) 
VALUES (3, 'Iga', 'Swiatek', 'iga@test.pl', 1);
INSERT INTO Czlonek (ID, Imie, Nazwisko, Email, Rodzaje_Czlonkostwa_ID) 
VALUES (4, 'Kamil', 'Stoch', 'kamil@test.pl', 1);
INSERT INTO Czlonek (ID, Imie, Nazwisko, Email, Rodzaje_Czlonkostwa_ID) 
VALUES (5, 'Piotr', 'Zyla', 'piotr@test.pl', 3);


INSERT INTO Pole_Golfowe (ID, Nazwa, Wielkosc, LiczbaDolkow, Status_ID) 
VALUES (1, 'Mistrzowskie', 120, 18, 1);
INSERT INTO Pole_Golfowe (ID, Nazwa, Wielkosc, LiczbaDolkow, Status_ID) 
VALUES (2, 'Treningowe', 60, 9, 1);
INSERT INTO Pole_Golfowe (ID, Nazwa, Wielkosc, LiczbaDolkow, Status_ID) 
VALUES (3, 'Lesne', 110, 18, 2);


INSERT INTO Turniej (ID, Nazwa, Pole_Golfowe_ID, DateStart, DateEnd, MaxLiczbaUczestnikow, Organizator_ID, Nagroda) 
VALUES (1, 'Puchar Prezesa', 1, TO_DATE('2024-05-01', 'YYYY-MM-DD'), TO_DATE('2024-05-02', 'YYYY-MM-DD'), 20, 3, '10000 PLN');
INSERT INTO Turniej (ID, Nazwa, Pole_Golfowe_ID, DateStart, DateEnd, MaxLiczbaUczestnikow, Organizator_ID, Nagroda) 
VALUES (2, 'Turniej Wiosenny', 3, TO_DATE('2024-04-15', 'YYYY-MM-DD'), TO_DATE('2024-04-15', 'YYYY-MM-DD'), 10, 2, '2000 PLN');
INSERT INTO Turniej (ID, Nazwa, Pole_Golfowe_ID, DateStart, DateEnd, MaxLiczbaUczestnikow, Organizator_ID, Nagroda) 
VALUES (3, 'Mistrzostwa Klubu', 1, TO_DATE('2024-08-20', 'YYYY-MM-DD'), TO_DATE('2024-08-22', 'YYYY-MM-DD'), 50, 3, 'Nowy Samochod');


INSERT INTO Rezerwacja (ID, Czlonek_ID, Pole_Golfowe_ID, DataStart, DataEnd, Pracownik_ID)
VALUES (1, 1, 1, TO_DATE('2024-06-10 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-10 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1);
INSERT INTO Rezerwacja (ID, Czlonek_ID, Pole_Golfowe_ID, DataStart, DataEnd, Pracownik_ID)
VALUES (2, 2, 1, TO_DATE('2024-06-11 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-11 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 4);
INSERT INTO Rezerwacja (ID, Czlonek_ID, Pole_Golfowe_ID, DataStart, DataEnd, Pracownik_ID)
VALUES (3, 3, 2, TO_DATE('2024-06-12 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-12 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1);
INSERT INTO Rezerwacja (ID, Czlonek_ID, Pole_Golfowe_ID, DataStart, DataEnd, Pracownik_ID)
VALUES (4, 1, 2, TO_DATE('2024-06-15 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-15 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 4);


INSERT INTO Wypozyczenie_Sprzetu (ID, Sprzet_Golfowy_ID, Czlonek_ID, Pracownik_ID, DateStart, DateEnd) 
VALUES (1, 3, 1, 1, TO_DATE('2024-06-10', 'YYYY-MM-DD'), TO_DATE('2024-06-10', 'YYYY-MM-DD'));
INSERT INTO Wypozyczenie_Sprzetu (ID, Sprzet_Golfowy_ID, Czlonek_ID, Pracownik_ID, DateStart, DateEnd) 
VALUES (2, 1, 1, 1, TO_DATE('2024-06-10', 'YYYY-MM-DD'), TO_DATE('2024-06-10', 'YYYY-MM-DD'));
INSERT INTO Wypozyczenie_Sprzetu (ID, Sprzet_Golfowy_ID, Czlonek_ID, Pracownik_ID, DateStart, DateEnd) 
VALUES (3, 2, 4, 4, TO_DATE('2024-06-11', 'YYYY-MM-DD'), TO_DATE('2024-06-12', 'YYYY-MM-DD'));
INSERT INTO Wypozyczenie_Sprzetu (ID, Sprzet_Golfowy_ID, Czlonek_ID, Pracownik_ID, DateStart, DateEnd) 
VALUES (4, 4, 5, 1, TO_DATE('2024-06-15', 'YYYY-MM-DD'), TO_DATE('2024-06-15', 'YYYY-MM-DD'));


INSERT INTO Uczesnictwo_Turniej (Turniej_ID, Czlonek_ID, Zajete_TOPMiejse) 
VALUES (1, 1, 1);
INSERT INTO Uczesnictwo_Turniej (Turniej_ID, Czlonek_ID, Zajete_TOPMiejse) 
VALUES (1, 2, 2);
INSERT INTO Uczesnictwo_Turniej (Turniej_ID, Czlonek_ID, Zajete_TOPMiejse) 
VALUES (1, 3, 3);
INSERT INTO Uczesnictwo_Turniej (Turniej_ID, Czlonek_ID, Zajete_TOPMiejse) 
VALUES (1, 4, NULL);


INSERT INTO Uczesnictwo_Turniej (Turniej_ID, Czlonek_ID, Zajete_TOPMiejse) 
VALUES (2, 5, 1);
INSERT INTO Uczesnictwo_Turniej (Turniej_ID, Czlonek_ID, Zajete_TOPMiejse) 
VALUES (2, 4, 2);
INSERT INTO Uczesnictwo_Turniej (Turniej_ID, Czlonek_ID, Zajete_TOPMiejse) 
VALUES (2, 3, NULL);

COMMIT;