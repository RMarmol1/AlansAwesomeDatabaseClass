--RAFAEL MARMOL
--SPOTIFY DESIGN PROJECT
--CREATE TABLE/ INSERT STATEMENTS

CREATE TABLE People (
	PID char(6) NOT NULL UNIQUE,
	firstName text NOT NULL,
	lastName text NOT NULL,
	birthDate DATE NOT NULL,
	PRIMARY KEY (PID)
);

INSERT INTO People (PID, firstName, lastName, birthDate)
	VALUES ('001', 'Rafael', 'Marmol', '1996-09-17'),
	       ('002', 'Bob', 'Bobberson', '2000-05-02'),
	       ('003', 'Joe', 'Black', '1985-08-13'),
	       ('004', 'James', 'Bond', '1977-07-07'),
	       ('005', 'Jane', 'Doe', '1994-10-31');
INSERT INTO People (PID, firstName, lastName, birthDate)
	VALUES ('006', 'Saul', 'Hudson', '1963-07-23'),
		('007', 'William', 'Rose', '1962-02-06'),
		('008', 'Taylor', 'Swift', '1989-12-13'),
		('009', 'Miley', 'Cyrus', '1992-11-23'),
		('010', 'Corey', 'Taylor', '1973-12-08'),
		('011', 'Farrokh', 'Bulsara', '1946-09-05');
INSERT INTO People (PID, firstName, lastName, birthDate)
	VALUES ('012', 'Vladimir', 'Putin', '1952-10-07');


INSERT INTO People (PID, firstName, lastName, birthDate)
	VALUES ('000', 'Spotify', 'Spotify', '2008-10-07');


CREATE TABLE Users (
	UserID char(6) NOT NULL UNIQUE references people(PID),
	pass char(12) NOT NULL,
	PRIMARY KEY (UserID)
);


CREATE TABLE Usernames (
	UserID char(6) NOT NULL UNIQUE references Users(UserID),
	username char(28) NOT NULL UNIQUE,
	PRIMARY KEY (UserID)
);

INSERT INTO Users (UserID, pass)
	VALUES ('001', 'pass1'),
	       ('002', 'chocolate'),
	       ('003', 'blanco'),
	       ('005', 'aerosmith');
	       INSERT INTO Users (UserID, pass)
	VALUES ('000', 'Spotify');
INSERT INTO Users (UserID, pass)
	VALUES ('004', 'Shaken');
INSERT INTO Users (UserID, pass)
	VALUES ('012', 'c0mmun1sm');

INSERT INTO Usernames (UserID, username)
	VALUES ('001', 'Rafael Marmol'),
	       ('002', 'Bob Bobberson'),
	       ('003', 'MrBlack'),
	       ('005', 'JaniesGotAGun'); 
INSERT INTO Usernames (UserID, username)
	VALUES ('000', 'Spotify');
INSERT INTO Usernames (UserID, username)
	VALUES ('004', 'James Bond');
INSERT INTO Usernames (UserID, username)
	VALUES ('012', 'VladMan42');
	
	
CREATE TABLE Friends (
	UserID char(6) NOT NULL references Users(UserID),
	friendID char(6) NOT NULL references Usernames(UserID),
	PRIMARY KEY(UserID, friendID)
);

INSERT INTO Friends (UserID, friendID)
	VALUES ('001', '003'),
	       ('001', '005'),
	       ('003', '001'),
	       ('005', '001');

CREATE TABLE Premium (
	PremiumID char(6) NOT NULL UNIQUE references Users(UserID),
	cardNumber char(16) NOT NULL UNIQUE,
	PRIMARY KEY (PremiumID)
);

INSERT INTO Premium (PremiumID, cardNumber)
	VALUES('001', '1111111111111111'),
	      ('005', '2222222222222222');
INSERT INTO Premium (PremiumID, cardNumber)
	VALUES('004', '7777777777777777');
INSERT INTO Premium (PremiumID, cardNumber)
	VALUES('012', '6666666666666666');

CREATE TABLE Free (
	FreeID char(6) NOT NULL UNIQUE references Users(UserID),
	PRIMARY KEY(FreeID)
);

INSERT INTO Free (FreeID)
	VALUES ('002'),
	        ('003');

	        
CREATE TABLE CardInfo (
	cardNumber char(16) NOT NULL UNIQUE references Premium(cardNumber),
	firstNameOnCard text NOT NULL,
	lastNameOnCard text NOT NULL,
	billingStreetAddress char(25) NOT NULL,
	billingZip int NOT NULL,
	cardType text NOT NULL,
	securityCode char(3) NOT NULL,
	bankID char(6) NOT NULL,
	PRIMARY KEY (cardNumber)
);

INSERT INTO CardInfo (cardNumber, firstNameOnCard, lastNameOnCard, billingstreetAddress, billingZip, cardType, securityCode, bankID)
	VALUES ('1111111111111111', 'Rafael', 'Marmol', '123 Place Ave', 12601, 'Visa', '111', '001'),
	       ('2222222222222222', 'Jane', 'Doe', '234 Deer Place', 11740, 'Mastercard', '222', '001');
INSERT INTO CardInfo (cardNumber, firstNameOnCard, lastNameOnCard, billingstreetAddress, billingZip, cardType, securityCode, bankID)
	VALUES ('7777777777777777', 'James', 'Bond', '7 Spy Rd', 12601, 'American Express', '777', '002');
INSERT INTO CardInfo (cardNumber, firstNameOnCard, lastNameOnCard, billingstreetAddress, billingZip, cardType, securityCode, bankID)
	VALUES ('6666666666666666', 'Vladimir', 'Putin', '6 Communist Lane', 107207, 'Visa', '666', '004');


CREATE TABLE PaymentInfo (
	cardNumber char(16) NOT NULL references CardInfo(cardNumber),
	amountCharged decimal NOT NULL,
	studentOrNonStudent text NOT NULL,
	datePaid date NOT NULL,
	paidForMonth text NOT NULL,
	CONSTRAINT paidForMonth CHECK (paidForMonth = 'yes' OR paidForMonth = 'no'),
	CONSTRAINT studentOrNonStudent CHECK (studentOrNonStudent = 'student' OR studentOrNonStudent = 'non-student'),
	PRIMARY KEY (cardNumber, datePaid)
); 

INSERT INTO PaymentInfo (cardNumber, amountCharged, studentOrNonStudent, datepaid, paidformonth)
	VALUES	('1111111111111111', '4.99', 'student', '2015-04-01', 'yes'),
		('1111111111111111', '4.99', 'student', '2015-03-01', 'yes'),
		('2222222222222222', '9.99', 'non-student', '2015-04-01', 'no');
INSERT INTO PaymentInfo (cardNumber, amountCharged, studentOrNonStudent, datepaid, paidformonth)
	VALUES	('6666666666666666', '9.99', 'non-student', '2015-04-01', 'yes'),
		('6666666666666666', '9.99', 'non-student', '2015-03-01', 'yes'),
		('6666666666666666', '9.99', 'non-student', '2015-02-01', 'yes'),
		('7777777777777777', '9.99', 'non-student', '2015-04-01', 'no');

CREATE TABLE Zip (
	zip int NOT NULL,
	city text NOT NULL,
	state text NOT NULL,
	country text NOT NULL,
	PRIMARY KEY (zip)
);

INSERT INTO Zip (zip, city, state, country)
	VALUES (12601, 'Poughkeepsie', 'New York', 'USA'),
	       (11740, 'Greenlawn', 'New York', 'USA'),
	       (301031, 'Ackbarpur', 'Rajasthan', 'India');
INSERT INTO Zip (zip, city, state, country)
	VALUES (11763, 'Medford', 'New York', 'USA'),
		(90210, 'Beverly Hills', 'California', 'USA'),
		(75201, 'Dallas', 'Texas', 'USA'),
		(107207, 'Moscow', 'Moscow', 'Russia');


CREATE TABLE Bank (
	BankID char(6) NOT NULL UNIQUE,
	bankName text NOT NULL,
	PRIMARY KEY (BankID)
);

INSERT INTO Bank (BankID, bankName)
	VALUES ('001', 'TD Bank'),
	       ('002', 'Discover'),
	       ('003', 'Chase');
INSERT INTO Bank (BankID, bankName)
	VALUES ('004', 'Bank of Russia');


CREATE TABLE Playlists (
	PlaylistID char(6) NOT NULL UNIQUE,
	playlistName text NOT NULL,
	createdBy char(6) NOT NULL references Users(UserID),
	PRIMARY KEY(PlaylistID)
);

INSERT INTO Playlists (PlaylistID, PlaylistName, createdBy)
	VALUES ('001', 'Classic Rock', '001'),
	       ('002', 'Fun times', '005'),
	       ('003', 'Metallica Playlist', '001');
INSERT INTO Playlists (PlaylistID, PlaylistName, createdBy)
	VALUES ('000', 'No Playlist', '000');


CREATE TABLE Musicians (
	MusicianID char(6) NOT NULL UNIQUE references People(PID),
	stageName text NOT NULL,
	PRIMARY KEY (MusicianID)
);

INSERT INTO Musicians (MusicianID, stageName)
	VALUES	('006', 'Slash'),
		('007', 'Axl Rose'),
		('008', 'Taylor Swift'),
		('009', 'Miley Cyrus'),
		('010', 'Corey Taylor'),
		('011', 'Freddie Mercury');

CREATE TABLE PlaysFor (
	MusicianID char(6) NOT NULL references Musicians(MusicianID),
	ArtistID char(6) NOT NULL references Artists(ArtistID),
	role text NOT NULL,
	PRIMARY KEY (MusicianID, ArtistID)
); 

INSERT INTO Playsfor (musicianid, artistid, role)
	VALUES	('006','016', 'Lead Guitarist'),
		('007','016', 'Lead Singer'),
		('008','004', 'Lead Singer'),
		('009','018', 'Lead Singer'),
		('010','009', 'Lead Singer'),
		('011','015', 'Lead Singer');


CREATE TABLE Artists (
	ArtistID char(6) NOT NULL UNIQUE,
	artistName text NOT NULL,
	PRIMARY KEY (ArtistID)
);

INSERT INTO Artists (ArtistID, artistName)
	VALUES ('001', 'Metallica'),
	       ('002', 'Avenged Sevenfold'),
	       ('003', 'Foo Fighters'),
	       ('004', 'Taylor Swift'),
	       ('005', 'Skrillex'),
	       ('006', 'Blake Shelton'),
	       ('007', 'Blink-182'),
	       ('008', 'Nickelback'),
	       ('009', 'Slipknot'),
	       ('010', 'The Who'),
	       ('011', 'Elvis Presley'),
	       ('012', 'The Beatles'),
	       ('013', 'Night Moves'),
	       ('014', 'Night Moves'),
	       ('015', 'Queen'),
	       ('016', 'Guns n Roses'),
	       ('017', 'Pink Floyd');
INSERT INTO Artists (ArtistID, artistName)
	VALUES ('018', 'Miley Cyrus');


CREATE TABLE Genres (
	GenreID char(6) UNIQUE NOT NULL,
	genre text NOT NULL,
	PRIMARY KEY(GenreID)
);

INSERT INTO Genres (GenreID, genre)
	VALUES	('001', 'Heavy Metal'),
		('002', 'Thrash Metal'),
		('003', 'Hard Rock'),
		('004', 'Metalcore'),
		('005', 'Alternative Rock'),
		('006', 'Post-grunge'),
		('007', 'Country'),
		('008', 'Pop Music'),
		('009', 'Dubstep'),
		('010', 'Punk Rock'),
		('011', 'Alternative Metal'),
		('012', 'Nu Metal'),
		('013', 'Classic Rock'),
		('014', 'Blues'),
		('015', 'Indie'),
		('016', 'Rock n Roll'),
		('017', 'Progressive Rock');


CREATE TABLE BelongsTo (
	ArtistID char(6) NOT NULL references Artists(ArtistID),
	GenreID char(6) NOT NULL references Genres(GenreID),
	PRIMARY KEY (ArtistID, GenreID)
);

INSERT INTO BelongsTo (ArtistID, GenreID)
	VALUES	('001', '001'),
		('001', '002'),
		('002', '001'),
		('002', '003'),
		('002', '004'),
		('003', '003'),
		('003', '005'),
		('003', '006'),
		('004', '007'),
		('004', '008'),
		('005', '009'),
		('006', '007'),
		('007', '005'),
		('007', '010'),
		('008', '003'),
		('008', '006'),
		('009', '001'),
		('009', '011'),
		('009', '012'),
		('010', '003'),
		('010', '013'),
		('011', '007'),
		('011', '014'),
		('011', '016'),
		('012', '008'),
		('012', '013'),
		('013', '007'),
		('013', '015'),
		('014', '015'),
		('014', '009'),
		('015', '013'),
		('016', '001'),
		('016', '003'),
		('017', '017'),
		('018', '008');


CREATE TABLE Albums (
	AlbumID char(6) UNIQUE NOT NULL,
	albumName text NOT NULL,
	yearReleased char(4) NOT NULL
);

INSERT INTO Albums (AlbumID, albumName, yearReleased)
	VALUES	('001', 'Metallica', 1991),
		('002', 'Master of Puppets', 1986),
		('003', '1989', 2014),
		('004', 'Bangerz', 2013),
		('005', 'Greatest Hits', 1981),
		('006', 'Greatest Hits', 2004),
		('007', 'A Night at the Opera', 1975),
		('008', 'Pennied Days', 2016),
		('009', 'TransDance GC1', 2013),
		('010', '.5: The Gray Chapter', 2014),
		('011', 'With the Beatles', 1963),
		('012', 'The Dark Side of the Moon', 1973);

INSERT INTO Albums (AlbumID, albumName, yearReleased)
	VALUES	('013', 'Greatest Rock Hits', 2016);
	INSERT INTO Albums (AlbumID, albumName, yearReleased)
	VALUES	('014', 'Single', 2014);
		select * from albums
CREATE TABLE Songs(
	SongID char(6) UNIQUE NOT NULL,
	songName text NOT NULL,
	PRIMARY KEY(SongID)
);

INSERT INTO Songs (SongID, songName)
	VALUES	('001', 'Money'),
		('002', 'Money'),
		('003', 'The Devil In I'),
		('004', 'Enter Sandman'),
		('005', 'Blank Space'),
		('006', 'Wrecking Ball'),
		('007', 'Shake It Off'),
		('008', 'Bohemian Rhapsody'),
		('009', 'Master of Puppets'),
		('010', 'We Will Rock You');

CREATE TABLE Makes (
	ArtistID char(6) NOT NULL references Artists(ArtistID),
	AlbumID char(6) NOT NULL references Albums(AlbumID),
	PRIMARY KEY (ArtistID, AlbumID)
);

INSERT INTO Makes (ArtistID, AlbumID)
	VALUES 	('001','001'),
		('001','002'),
		('004','003'),
		('004','004'),
		('015','005'),
		('016','006'),
		('015','007'),
		('013','008'),
		('014','009'),
		('009','010'),
		('012','011'),
		('017','012');
INSERT INTO Makes (ArtistID, AlbumID)
	VALUES 	('001','013'),
		('015','013'),
		('016','013'),
		('017','013'),
		('009','014');


CREATE TABLE Features (
	AlbumID char(6) NOT NULL references Albums(AlbumID),
	SongID char(6) NOT NULL references Songs(SongID),
	PRIMARY KEY(AlbumID, SongID)
);

INSERT INTO Features (AlbumID, SongID)
	VALUES	('011', '001'),
		('012', '002'),
		('010', '003'),
		('001', '004'),
		('003', '005'),
		('004', '006'),
		('003', '007'),
		('005', '008'),
		('007', '008'),
		('002', '009'),
		('005', '010');

INSERT INTO Features (AlbumID, SongID)
	VALUES	('013', '004'),
		('013', '008'),
		('013', '009'),
		('013', '010'),
		('014', '003');

SELECT albumName, songName
FROM features f INNER JOIN albums a ON a.albumid = f.albumid
		INNER JOIN songs s ON f.songid = s.songid
ORDER BY albumName ASC


CREATE TABLE Contains (
	PlaylistID char(6) NOT NULL references Playlists(PlaylistID),
	SongID char(6) NOT NULL references Songs(SongID),
	PRIMARY KEY(PlaylistID,SongID)
);

INSERT INTO Contains (PlaylistID, SongID)
	VALUES	('001', '001'),
		('001', '002'),
		('001', '004'),
		('001', '008'),
		('001', '009'),
		('001', '010'),
		('003', '004'),
		('003', '009'),
		('002', '005'),
		('002', '006'),
		('002', '007');

CREATE TABLE ListeningLog (
	UserID char(6) NOT NULL references Users(UserID),
	SongID char(6) NOT NULL references Songs(SongID),
	PlaylistID char(6) NOT NULL references Playlists(PlaylistID),
	dateListenedTo timestamp NOT NULL,
	listeningLocationZip int NOT NULL references Zip(zip),
	PRIMARY KEY (UserID, dateListenedTo)
); 



INSERT INTO ListeningLog (UserID, SongID, PlaylistID, dateListenedTo, listeningLocationZip)
	VALUES	('001', '003', '000', '2015-04-22 14:08:32', 12601),
		('001', '004', '003', '2015-04-22 14:02:01', 12601),
		('001', '007', '000', '2015-04-22 13:59:22', 12601),
		('005', '006', '002', '2015-04-21 09:42:15', 301031);
INSERT INTO ListeningLog (UserID, SongID, PlaylistID, dateListenedTo, listeningLocationZip)
	VALUES	('004', '010', '000', '2015-04-23 02:15:07', 301031);
INSERT INTO ListeningLog (UserID, SongID, PlaylistID, dateListenedTo, listeningLocationZip)
	VALUES	('012', '007', '000', '2015-04-23 14:40:00', 107207),
		('012', '007', '000', '2015-04-23 14:37:00', 107207),
		('012', '007', '000', '2015-04-23 14:34:00', 107207),
		('012', '007', '000', '2015-04-23 14:31:00', 107207),
		('005', '001', '000', '2014-07-04 17:22:22', 11763);
INSERT INTO ListeningLog (UserID, SongID, PlaylistID, dateListenedTo, listeningLocationZip)
	VALUES	('001', '007', '000', '2016-04-23 12:40:00', 11763);



CREATE TABLE Follows (
	UserID char(6) NOT NULL references Users(UserID),
	ArtistID char(6) NOT NULL references Artists(ArtistID),
	PRIMARY KEY(UserId, ArtistID)
);




INSERT INTO Follows (UserID, ArtistID)
	VALUES	('001', '001'),
		('001', '002'),
		('001', '003'),
		('001', '009'),
		('001', '016'),
		('001', '017'),
		('002', '006'),
		('002', '008'),
		('002', '010'),
		('002', '011'),
		('003', '012'),
		('003', '015'),
		('003', '016'),
		('003', '017'),
		('005', '004'),
		('005', '007'),
		('005', '018');




--Stored procedures
create or replace function ReturnCountry(int) returns text as 
$$
declare
   zip_input int       := $1;
 
begin
   return (
      select country
      from   zip
       where  zip = zip_input);
  
end;
$$ 
language plpgsql;
--select returncountry(12601);

create or replace function showGenres(text) returns setof text as 
$$
declare
   artist_input text       := $1;
 
begin
   return query(
      select genre
      from   belongsTo b INNER JOIN artists a ON b.artistID = a.artistID
			INNER JOIN genres g ON b.genreID = g.genreID
	where artistName = artist_input
       );
  
end;
$$ 
language plpgsql;

--select showgenres('Guns n Roses');


create or replace function showRelatedArtistsFor(text) returns setof text as 
$$
declare
   artist_input text       := $1;
 
begin
   return query(
      select distinct artistName
      from   belongsTo b INNER JOIN artists a ON b.artistID = a.artistID
			INNER JOIN genres g ON b.genreID = g.genreID
       where  genre IN (select showgenres(artist_input))
       );
  
end;
$$ 
language plpgsql;

--select showrelatedartistsfor('Guns n Roses');

create or replace function lastDateListened(text) returns date as 
$$
declare
   user_input text       := $1;
 
begin
   return (
      select datelistenedto
      from   listeninglog
      where userid = user_input
      order by datelistenedto DESC
      limit 1

       );
  
end;
$$ 
language plpgsql;

--select lastdatelistened('001');

select * from userinfo;

create or replace function showUserNameFor(text) returns text as 
$$
declare
   user_input text       := $1;
 
begin
   return (
      select username
      from   usernames
      where userid = user_input
       );
  
end;
$$ 
language plpgsql;
--select showusernamefor('012');

drop function showdiscographyfor(text)
create or replace function showDiscographyFor(text) returns setof text as 
$$
declare
   artist_input text       := $1;
 
begin
   return query(
      select albumName
      from   makes m INNER JOIN artists a ON m.artistid = a.artistid
		     INNER JOIN albums al ON m.albumid = al.albumid
      where artistName = artist_input
       );
  
end;
$$ 
language plpgsql;

--select showdiscographyfor('Slipknot');

drop function getpremiumid(character)
create or replace function getpremiumid(character) returns character as 
$$
declare
   char_input character(16)       := $1;
 
begin
   return (select distinct premiumid
		from premium p INNER JOIN cardinfo c ON p.cardnumber = c.cardnumber
				INNER JOIN paymentinfo pi ON c.cardnumber = pi.cardnumber
			WHERE pi.cardnumber = char_input);
  
end;
$$ 
language plpgsql;

--select getPremiumID('005');


--VIEWS

CREATE OR REPLACE VIEW UserInfo as
select u.userid, firstName, lastName, username, pass, cardnumber
from users u INNER JOIN people p ON u.userid = p.pid
		LEFT OUTER JOIN premium pr ON u.userid = pr.premiumid
		LEFT OUTER JOIN free f ON u.userid = f.freeid
		INNER JOIN usernames n ON u.userid = n.userid
ORDER BY u.userid ASC;


CREATE OR REPLACE VIEW FriendsList as
select showusernamefor(u.userid) as User, showusernamefor(friendid) as Friend
from friends f INNER JOIN users u ON f.userid = u.userid
		INNER JOIN usernames n ON n.userid = u.userid
ORDER BY User ASC;


CREATE OR REPLACE VIEW MostPopularSong as
select songName, count(songName) as timeslistenedto
from listeninglog l INNER JOIN songs s ON l.songid = s.songid
group by songName
order by count(songName) desc
limit 1;



CREATE OR REPLACE VIEW MusicLibrary as
select distinct artistName, albumName, yearReleased, songName
from artists a INNER JOIN belongsto b ON b.artistid = a.artistid
		INNER JOIN genres g ON b.genreid = g.genreid
		INNER JOIN makes m ON m.artistid = a.artistid
		INNER JOIN albums al ON al.albumid = m.albumid
		INNER JOIN features f ON f.albumid = al.albumid
		INNER JOIN songs s ON s.songid = f.songid
ORDER BY artistName ASC;


--Reports: Interesting Queries
--probable dead users
SELECT distinct firstName, lastName, username, lastDateListened(u.userid)
FROM listeninglog l INNER JOIN Users u ON l.userid = u.userid
		INNER JOIN people p ON p.pid = u.userid
		INNER JOIN usernames n ON u.userid = n.userid
WHERE (DATE_PART('year', current_date::date) - DATE_PART('year', lastdatelistened(l.userid)::date)) >= 1
AND (DATE_PART('month', current_date::date) - DATE_PART('month', lastdatelistened(l.userid)::date)) >= 0
AND (DATE_PART('month', current_date::date) - DATE_PART('month', lastdatelistened(l.userid)::date)) <= 11;

--proabable card theft
SELECT firstname, lastname, username, p.cardNumber, ReturnCountry(listeningLocationZIp) as DifferentCountryThanBilling, datelistenedTo
FROM listeninglog l  INNER JOIN users u ON l.userid = u.userid
		INNER JOIN premium p ON u.userid = p.premiumid
		INNER JOIN cardinfo c ON p.cardNUmber = c.cardnumber
		INNER JOIN people pl ON pl.pid = u.userid
		INNER JOIN usernames n ON n.userid = u.userid
WHERE ReturnCountry(listeningLocationZip) != ReturnCountry(billingZip);




---Security
create role database_admin;
grant select,insert,update
 on all tables in schema public 
to database_admin;

create role premium_user;
grant select ON paymentinfo, friends, usernames, playlists, artists, albums, songs
to premium_user;
grant update  ON cardinfo
to premium_user;
grant insert, update, delete ON friends, follows, playlists, contains
to premium_user;

create role free_user;
grant select ON friends, usernames, playlists, artists, albums, songs
to free_user;
grant insert, update, delete ON friends, follows, playlists, contains
to free_user;





----Triggers

drop function checkpayment()
CREATE OR REPLACE FUNCTION checkPayment() RETURNS trigger AS 
$$
declare
yn text;
card char(16);
id char(6);
    BEGIN
	
        IF TG_OP = 'INSERT' then
	yn = NEW.paidformonth;
	card = NEW.cardnumber;
	id = (Select getpremiumid(card));

           IF (yn = 'no') THEN
		DELETE FROM paymentinfo
		WHERE cardnumber = card;
		DELETE FROM cardinfo
		WHERE cardnumber = card;
		DELETE FROM premium
		WHERE premiumid = id;
		INSERT INTO free (freeid)
		VALUES (id);
		return new;
		END IF;
		 END IF;
	IF TG_OP = 'DELETE' then
		return old;
       
        END IF;
        return null;
        
    END;
$$
    LANGUAGE plpgsql;

CREATE TRIGGER checkPayment AFTER INSERT OR UPDATE OR DELETE ON paymentinfo
    FOR EACH ROW EXECUTE PROCEDURE checkPayment();
    
--INSERT INTO PaymentInfo (cardNumber, amountCharged, studentOrNonStudent, datepaid, paidformonth)
--	VALUES	('1111111111111111', '9.99', 'non-student', '2016-04-01', 'no');



CREATE OR REPLACE FUNCTION replaceBandMember() RETURNS trigger AS 
$$
    BEGIN
        IF TG_OP = 'INSERT' then
           
		IF ( NEW.role IN (select role from playsfor where artistid = NEW.artistID) ) then
		DELETE FROM playsfor 
		WHERE artistid = NEW.artistid 
		AND role = NEW.role
		AND musicianid != NEW.musicianid;
		return new;
		END IF;
		 
       
        END IF;
        return null;
        
    END;
$$
    LANGUAGE plpgsql;
drop trigger replacebandmember on playsfor
CREATE TRIGGER replacebandmember AFTER INSERT ON playsfor
    FOR EACH ROW EXECUTE PROCEDURE replacebandmember();

    

--INSERT INTO playsfor (musicianid, artistid, role)
--VALUES ('010', '016' ,'Lead Singer');





