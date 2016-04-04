--2. CREATE TABLE queries
CREATE TABLE People (
PID char(6) not null,
name text not null,
address text not null,
primary key (PID)
); 


INSERT INTO People (PID, name, address)
	VALUES (1, 'Sean Connery', '007 Bond Lane'),
	(2, 'Ben Affleck', 'Wayne Manor'),
	(3, 'Stephen Amell', '52 Green Rd'),
	(4, 'Steven Spielburg', '12 Juarssic Lane'),
	(5, 'M. Night Shyamalan', '6 Dead People Court'),
	(6, 'Danny Devito', '1 Short Person Rd'),
	(7, 'Terrence Young', '32 Russia Rd'),
	(8, 'Guy Hamilton', '9 Gold Court'),
	(9, 'Tobe Hooper', '6 Poltegeist Lane');


CREATE TABLE Marriage (
PID char(6) not null references people(PID),
spouseName text not null,
primary key(pid)
);


INSERT INTO Marriage (PID, spouseName)
VALUES (1, 'Micheline Roquebrune'),
	(3, 'Cassandra Jean'),
	(4, 'Kate Capshaw'),
	(5, 'Bhavna Waswani'),
	(6, 'Rhea Perlman');



CREATE TABLE Director (
PID char(6) not null references People(PID),
favoriteLensMaker text not null,
primary key(PID)
);


INSERT INTO director (PID, favoriteLensMaker)
Values (2, 'Canon'),
(4, 'IMAX'),
(5, 'Casio'),
(7, 'Kodak'),
(8, 'Panasonic');

CREATE TABLE DirectorsGuild (
PID char(6) not null references Director(PID),
directorsGuildAnniversaryDate date not null,
primary key (PID)
);


CREATE TABLE FilmSchool (
PID char(6) not null references Director(PID),
filmSchoolAttended text not null,
primary key (PID)
);


CREATE TABLE Actor (
PID char(6) not null references People(PID),
birthDate date not null,
hairColor text not null,
eyeColor text not null,
height decimal not null,
weight decimal not null,
favoriteColor text not null,
primary key(PID)
);


CREATE TABLE Movies (
MID char(6) not null,
name text not null,
mpaaNumber int not null,
domesticBoxOfficeSales decimal not null,
foreignBoxOfficeSales decimal not null,
DVDBluRaySales decimal not null,
primary key (MID)
); 


INSERT INTO Movies (MID, name, mpaaNumber, domesticBoxOfficeSales, foreignBoxOfficeSales, DVDBluRaySales)
VALUES (1, 'From Russia With Love', 1000, 7000000, 7000000, 3500),
	(2, 'Indiana Jones and the Last Crusade', 1234, 324000000, 123000000, 12000),
	(3, 'Argo', 4444, 800000000, 20000000, 25000),
	(4, 'Batman Returns', 8765, 3000000, 4500000, 10000),
	(5, 'Goldfinger', 9800, 14000000, 12000000, 8000),
	(6, 'Poltergeist', 6666, 20000000, 8000000, 15000);



CREATE TABLE CastCrewPosition (
PID char(6) not null references People(PID),
MID char(6) not null references Movies(MID),
role text not null,
primary key(PID, MID, role)
);




INSERT INTO CastCrewPosition (PID, MID, role)
VALUES (1, 1, 'James Bond'),
	(1, 2, 'Henry Jones Sr'),
	(1, 5, 'James Bond'),
	(2, 3, 'Director'),
	(2, 3, 'Tony Mendez'),
	(6, 4, 'The Penguin'),
	(4, 2, 'Director'),
	(4, 6, 'Director'),
	(9, 6, 'Director'),
	(8, 5, 'Director'),
	(7, 1, 'Director');
--3. Functional Dependencies
-- People: PID -> name, address
-- Marriage: PID -> spouseName
-- Actor: PID -> birthDate, hairColor, eyeColor, height, weight, favoriteColor
-- Director: PID -> favoriteLensMaker
-- DirectorsGuild: PID -> directorsGuildAnniversaryDate
-- FilmSchool: PID -> filmSchoolAttended
-- Movies: MID -> name, mpaaNumber, domesticBoxOfficeSales, foreignBoxOfficeSales, DVDBluRaySales
-- CastCrewPostion: (PID,MID,role)->

--4. Shows all directors who worked with actor sean connery
select p.name
from people p inner join castcrewposition c on p.pid=c.pid
where role = 'Director'
and c.mid IN (select c.mid
	      from castcrewposition c inner join people p on c.pid = p.pid
	      where p.name = 'Sean Connery')

