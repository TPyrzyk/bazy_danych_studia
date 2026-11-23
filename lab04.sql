use infio_pyrzykt;
# ZADANIE 1
create table pracownik(id_pracownika int primary key auto_increment, imie varchar(40) not null, nazwisko varchar(60) not null, data_urodzenia date not null);
insert into pracownik(imie, nazwisko, data_urodzenia) values ('Jan','Kowalski', '1900-05-01'), ('Jan','Kowalski', '1900-05-01'), ('Jan','Kowalski', '1900-05-01');
update pracownik set data_urodzenia = '1996-06-15' where id_pracownika = 1;

# ZADANIE 2
create table zadanie(id_zadania int primary key auto_increment, nazwa_zadania varchar(150), priorytet varchar(20), opis text, pracownik int, constraint fk_pracownik foreign key(pracownik) references pracownik(id_pracownika) on delete set null);
alter table zadanie alter column  priorytet set default "normalny";
insert into zadanie (nazwa_zadania, priorytet, pracownik) values ('test1', 'test1', 1), ('test1', 'test1', 2), ('test1', 'test1', 3);

# ZADANIE 3
create table projekt (id_projektu int primary key not null auto_increment, nazwa_projektu varchar(150), data_rozpoczecia date, data_zakonczenia date);
alter table projekt add column menadzer_projektu int, add constraint fk_menadzer foreign key (menadzer_projektu) references pracownik(id_pracownika);
insert into projekt (nazwa_projektu, data_rozpoczecia, data_zakonczenia, menadzer_projektu) values ('test', '2026-11-09', "2026-11-10", 1),('test2', '2026-11-09', "2026-11-10", 2);
alter table zadanie add column projekt int, add constraint fk_zadanie_projekt foreign key (projekt) references projekt(id_projektu) on delete cascade;

# ZADANIE 4
create table sprint(id_sprintu int primary key auto_increment, numer_sprintu int unsigned not null, data_rozpoczecia date not null, data_zakonczenia date not null);
alter table zadanie add column sprint int, add constraint fk_zadanie_sprint foreign key (sprint) references sprint(id_sprintu) on delete set null;
insert into sprint (numer_sprintu, data_rozpoczecia , data_zakonczenia) values (1, "2026-11-01",'2026-11-02');
update zadanie set sprint = 1 where id_zadania in (1,2);

# ZADANIE 5
create table status (id_statusu int primary key auto_increment, nazwa_statusu varchar(20) not null);
insert into status (nazwa_statusu) values ('Do zrobienia'), ('w toku'), ('Zakonczone');

# ZADANIE 6
CREATE TABLE zadanie_has_status (id_zdarzenia INT PRIMARY KEY AUTO_INCREMENT, id_zadania INT NOT NULL, id_statusu INT NOT NULL, data_zdarzenia TIMESTAMP DEFAULT CURRENT_TIMESTAMP, CONSTRAINT fk_zhs_zadanie FOREIGN KEY (id_zadania) REFERENCES zadanie(id_zadania) ON DELETE CASCADE, CONSTRAINT fk_zhs_status FOREIGN KEY (id_statusu) REFERENCES status(id_statusu) ON DELETE CASCADE);
INSERT INTO zadanie_has_status (id_zadania, id_statusu) VALUES (1, 1), (1, 2), (2, 1); 
DELETE FROM projekt WHERE id_projektu = 1;
DROP TABLE sprint;


select * from pracownik;
SELECT CONSTRAINT_NAME, TABLE_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_TYPE = 'FOREIGN KEY' AND TABLE_NAME = 'zadanie';
Select constraint_name, table_name from information_schema.table_constraints where constraint_type = 'FOREIGN KEY' and table_name = 'projekt';

#---------------------------------------------------------

# ZADANIE 1
alter table projekt drop foreign key fk_menadzer;
alter table zadanie drop foreign key fk_pracownik;
alter table pracownik modify id_pracownika int not null;
alter table pracownik drop primary key;
alter table pracownik add primary key (id_pracownika);
alter table pracownik modify id_pracownika int not null auto_increment;
alter table zadanie add constraint fk_zadanie_pracownik foreign key (pracownik) references pracownik(id_pracownika) on delete set null;
alter table projekt add constraint fk_menadzer foreign key (menadzer_projektu) references pracownik(id_pracownika);

# ZADANIE 2
describe zadanie;
describe projekt;
alter table zadanie add column godziny_szacowane int default 8;
update zadanie set godziny_szacowane  = 4 where id_zadania = 1;
update zadanie set godziny_szacowane  = 12 where id_zadania = 2;
update zadanie set godziny_szacowane  = 16 where id_zadania = 3;
alter table zadanie alter column godziny_szacowane set default 6;
insert into zadanie (nazwa_zadania) values ('Zadanie testowe');
select * from zadanie where nazwa_zadania = 'Zadanie testowe';
delete from zadanie where nazwa_zadania = 'Zadanie testowe';

# ZADANIE 3
alter table projekt add column opis_kratki varchar(50) null;
alter table projekt modify column opis_kratki varchar(200);
update projekt set opis_kratki = 'MVP' where id_projektu = 1;
update projekt set opis_kratki = 'pilne wdrożenie' where id_projektu = 2;
alter table projekt drop column opis_kratki;

# ZADANIE 4
alter table zadanie drop foreign key fk_zadanie_projekt;
alter table zadanie add constraint fr_zadanie_projekt foreign key(projekt) references projekt(id_projektu) on delete set null;
delete from projekt where id_projektu = 1;
select * from zadanie;

#===========================================
# ZADANIE 1
CREATE TABLE CLIENT as SELECT * from company_2025.CLIENT;
CREATE TABLE `ORDER` as SELECT * from company_2025.`ORDER`;
CREATE TABLE EMPLOYEE as SELECT * from company_2025.EMPLOYEE;

select * from `ORDER`;
select * from `ORDER` where ORDER_STATUS = 5;
select ORDER_ID, ORDER_STATUS from `ORDER` where  CLIENT_ID = 1 or CLIENT_ID = 3 or CLIENT_ID = 5;

# ZADANIE 2
select * from EMPLOYEE;
select * from CLIENT;

select * from EMPLOYEE where FIRST_NAME = "Agnieszka" and pensja = 3900;
select * from EMPLOYEE where pensja > 5000 and pensja < 7000;
select * from CLIENT where SHORT_NAME like '%eco%' and is_company = 1;

# ZADANIE 3
select * from `ORDER` where MONTH(order_date) in (6,7);
select * from CLIENT where TAX_IDENTIFIER is not null order by short_name asc;
select * from EMPLOYEE order by birth_date asc limit 5;

# ZADANIE 4
select FIRST_NAME from EMPLOYEE disc;
select CONCAT(FIRST_NAME, ' ', LAST_NAME) as polaczona_kolumna from EMPLOYEE where LAST_NAME like 'Ko%';
select LAST_NAME, pensja from EMPLOYEE where YEAR(DATE_OF_EMPLOYMENT) in (2010,2014);

# ZADANIE 5
select pensja, pensja * 0.75 as pensja_netto, pensja*0.25 as podatek from EMPLOYEE; 
select * from CLIENT where TAX_IDENTIFIER IS NULL;
select short_name from CLIENT where short_name like 'K%' or short_name like '%ski' order by short_name desc;