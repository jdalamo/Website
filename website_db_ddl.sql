USE website_db;

-- Tables
DROP TABLE Drone_Videos;
DROP TABLE Drone_Albums;

DROP TABLE Music_Videos;
DROP TABLE Music_Albums;

CREATE TABLE Drone_Albums (
   album_id     INTEGER         NOT NULL PRIMARY KEY,
   album_name   VARCHAR(30)     NOT NULL
);

CREATE TABLE Music_Albums (
   album_id     INTEGER         NOT NULL PRIMARY KEY,
   album_name   VARCHAR(30)     NOT NULL
);

CREATE TABLE Drone_Videos (
   vid_id       INTEGER         NOT NULL PRIMARY KEY,
   vid_name     VARCHAR(60)     NOT NULL,
   city         VARCHAR(30)     NOT NULL,
   us_state     VARCHAR(30),
   country      VARCHAR(30)     NOT NULL,
   shot_date    DATE            NOT NULL,
   link         VARCHAR(100)    NOT NULL,
   favorite     BOOLEAN         NOT NULL,
   album_id     INTEGER         NOT NULL,
   CONSTRAINT   d_album_fk      FOREIGN KEY     (album_id)     REFERENCES     Drone_Albums     (album_id)
);

CREATE TABLE Music_Videos (
   vid_id       INTEGER         NOT NULL PRIMARY KEY,
   vid_name     VARCHAR(60)     NOT NULL,
   shot_date    DATE            NOT NULL,
   link         VARCHAR(60)     NOT NULL,
   favorite     BOOLEAN         NOT NULL,
   album_id     INTEGER         NOT NULL,
   CONSTRAINT   m_album_fk      FOREIGN KEY     (album_id)     REFERENCES     Music_Albums     (album_id)
);

COMMIT;


-- Views
CREATE OR REPLACE VIEW drone_album_view AS
SELECT a.album_name, v.link, v.favorite
FROM Drone_Albums a LEFT JOIN Drone_Videos v
ON a.album_id = v.album_id;

CREATE OR REPLACE VIEW music_album_view AS
SELECT a.album_name, v.link, v.favorite
FROM Music_Albums a LEFT JOIN Music_Videos v
ON a.album_id = v.album_id;

COMMIT;


-- Drone Album Inserts
INSERT INTO Drone_Albums
VALUES
(1, 'sa_summer_2019');

INSERT INTO Drone_Albums
VALUES
(2, 'austin_summer_2019');

INSERT INTO Drone_Albums
VALUES
(3, 'spain_summer_2019');

INSERT INTO Drone_Albums
VALUES
(4, 'la_winter_2019/2020');

COMMIT;


-- Music Album Inserts
INSERT INTO Music_Albums
VALUES
(1, 'piano');

INSERT INTO Music_Albums
VALUES
(2, 'ukulele');

COMMIT;


-- Drone Video Inserts
INSERT INTO Drone_Videos
VALUES
(1, 'Elm Creek Skyline', 'San Antonio', 'Texas', 'US', '2019-06-26', 'https://www.youtube.com/embed/zj0bRBR87-4?loop=1&playlist=zj0bRBR87-4', false, 1);

INSERT INTO Drone_Videos
VALUES
(2, 'Brackenridge River Pan', 'San Antonio', 'Texas', 'US', '2019-06-30', 'https://www.youtube.com/embed/umcR9_Ahdq0?loop=1&playlist=umcR9_Ahdq0', false, 1);

INSERT INTO Drone_Videos
VALUES
(3, 'Brackenridge Ducks', 'San Antonio', 'Texas', 'US', '2019-06-30', 'https://www.youtube.com/embed/d4cnCwjklO8?loop=1&playlist=d4cnCwjklO8', false, 1);

INSERT INTO Drone_Videos
VALUES
(4, 'Brackenridge Bridge Through', 'San Antonio', 'Texas', 'US', '2019-06-26', 'https://www.youtube.com/embed/Q2Fs1cd1YVo?loop=1&playlist=Q2Fs1cd1YVo', false, 1);

INSERT INTO Drone_Videos
VALUES
(5, 'Brackenridge Bridge Side', 'San Antonio', 'Texas', 'US', '2019-06-26', 'https://www.youtube.com/embed/yNDcHH9ZSy8?loop=1&playlist=yNDcHH9ZSy8', true, 1);

INSERT INTO Drone_Videos
VALUES
(6, 'Witte Pan', 'San Antonio', 'Texas', 'US', '2019-06-26', 'https://www.youtube.com/embed/FvIoX29cGbM?loop=1&playlist=FvIoX29cGbM', true, 1);

INSERT INTO Drone_Videos
VALUES
(7, 'Flood Control Pan', 'San Antonio', 'Texas', 'US', '2019-07-04', 'https://www.youtube.com/embed/TXDAXcMSbtk?loop=1&playlist=TXDAXcMSbtk', true, 1);

INSERT INTO Drone_Videos
VALUES
(8, 'Flood Control Descent', 'San Antonio', 'Texas', 'US', '2019-07-04', 'https://www.youtube.com/embed/0Du7EtxOWhA?loop=1&playlist=0Du7EtxOWhA', false, 1);

INSERT INTO Drone_Videos
VALUES
(9, 'Greenbelt Creek', 'Austin', 'Texas', 'US', '2019-07-05', 'https://www.youtube.com/embed/JWtnSwaC-3M?loop=1&playlist=JWtnSwaC-3M', false, 2);

INSERT INTO Drone_Videos
VALUES
(10, 'Greenbelt Skyline', 'Austin', 'Texas', 'US', '2019-07-05', 'https://www.youtube.com/embed/D5H7FkoKuek?loop=1&playlist=D5H7FkoKuek', true, 2);

INSERT INTO Drone_Videos
VALUES
(11, 'Barcelona Soccer Skyline', 'Barcelona', NULL, 'Spain', '2019-07-15', 'https://www.youtube.com/embed/Z6HCpnHMf9U?loop=1&playlist=Z6HCpnHMf9U', false, 3);

INSERT INTO Drone_Videos
VALUES
(12, 'Barcelona Soccer Side', 'Barcelona', NULL, 'Spain', '2019-07-15', 'https://www.youtube.com/embed/F1sc9_Ik3WU?loop=1&playlist=F1sc9_Ik3WU', false, 3);

INSERT INTO Drone_Videos
VALUES
(13, 'Sitges Coast', 'Sitges', NULL, 'Spain', '2019-07-15', 'https://www.youtube.com/embed/cmgXBJih6Sk?loop=1&playlist=cmgXBJih6Sk', false, 3);

INSERT INTO Drone_Videos
VALUES
(14, 'Sitges Facade', 'Sitges', NULL, 'Spain', '2019-07-15', 'https://www.youtube.com/embed/_XuB-dqz8cA?loop=1&playlist=_XuB-dqz8cA', false, 3);

INSERT INTO Drone_Videos
VALUES
(15, 'Sitges Rocks', 'Sitges', NULL, 'Spain', '2019-07-15', 'https://www.youtube.com/embed/0ULDxytMKpM?loop=1&playlist=0ULDxytMKpM', true, 3);

INSERT INTO Drone_Videos
VALUES
(16, 'Sitges Clocktower', 'Sitges', NULL, 'Spain', '2019-07-15', 'https://www.youtube.com/embed/8ME5SyG10Ek?loop=1&playlist=8ME5SyG10Ek', true, 3);

INSERT INTO Drone_Videos
VALUES
(17, 'Poblenou Gym', 'Barcelona', NULL, 'Spain', '2019-07-16', 'https://www.youtube.com/embed/XixFfwIWVsI?loop=1&playlist=XixFfwIWVsI', false, 3);

INSERT INTO Drone_Videos
VALUES
(18, 'Poblenou Reveal', 'Barcelona', NULL, 'Spain', '2019-07-16', 'https://www.youtube.com/embed/olKPpL33Yqk?loop=1&playlist=olKPpL33Yqk', true, 3);

INSERT INTO Drone_Videos
VALUES
(19, 'Woodlawn Tower', 'San Antonio', 'Texas', 'US', '2019-07-20', 'https://www.youtube.com/embed/8IJdYXMGgWY?loop=1&playlist=8IJdYXMGgWY', false, 1);

INSERT INTO Drone_Videos
VALUES
(20, 'Woodlawn Dam', 'San Antonio', 'Texas', 'US', '2019-07-20', 'https://www.youtube.com/embed/6VuYVQMjAQc?loop=1&playlist=6VuYVQMjAQc', false, 1);

INSERT INTO Drone_Videos
VALUES
(21, 'Los Angeles, December 2019', 'Los Angeles', 'California', 'US', '2019-12-30', 'https://www.youtube.com/embed/HhejXWZj1oc', true, 4);

COMMIT;


-- Music Video Inserts
INSERT INTO Music_Videos
VALUES
(1, 'Wish You Were Here', '2020-04-13', 'https://www.youtube.com/embed/Jz2N8sEZ6J0', true, 2);

INSERT INTO Music_Videos
VALUES
(2, 'The Night King', '2020-04-18', 'https://www.youtube.com/embed/NXsn6w8EVmE', false, 1);

COMMIT;