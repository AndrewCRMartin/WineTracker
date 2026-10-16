CREATE TABLE producers (
   prodid INT PRIMARY KEY,
   name CHAR(30)
);

CREATE TABLE winenames (
   winenameid INT PRIMARY KEY,
   name       CHAR(80)
);

CREATE TABLE types (
   typeid   INT PRIMARY KEY,
   name     CHAR(10)
);

CREATE TABLE locations (
   locid    INT PRIMARY KEY,
   name     CHAR(20)
);

CREATE TABLE status (
   statusid INT PRIMARY KEY,
   name     CHAR(10)
);

CREATE TABLE sizes (
   sizeid INT PRIMARY KEY,
   name   CHAR(8)
);

CREATE TABLE region (
   regionid INT PRIMARY KEY,
   name     CHAR(30)
);

CREATE TABLE vendor (
   vendorid INT PRIMARY KEY,
   name     CHAR(30)
);

create table collection (
   collectionid INT PRIMARY KEY,
   winenameid   INT,
   prodid       INT,
   typeid       INT,
   locid        INT,
   statusid     INT,
   regionid     INT,
   vendorid     INT,
   sizeid       INT,
   bottles      INT,
   vintage      char(8),
   price        REAL,
   cprice       REAL,
   updated      char(20),
   bracket      char(20),
   drink        char(20),
   notes        char(80),
   scores       char(80),
   CONSTRAINT fk_collection_winenames FOREIGN KEY (winenameid)
              REFERENCES winenames (winenameid),
   CONSTRAINT fk_collection_producers FOREIGN KEY (prodid)
              REFERENCES producers (prodid),
   CONSTRAINT fk_collection_types FOREIGN KEY (typeid)
              REFERENCES types (typeid),
   CONSTRAINT fk_collection_sizes FOREIGN KEY (sizeid)
              REFERENCES sizes (sizeid),
   CONSTRAINT fk_collection_locations FOREIGN KEY (locid)
              REFERENCES locations (locid),
   CONSTRAINT fk_collection_status FOREIGN KEY (statusid)
              REFERENCES status (statusid),
   CONSTRAINT fk_collection_vendor FOREIGN KEY (vendorid)
              REFERENCES vendor (vendorid),
   CONSTRAINT fk_collection_region FOREIGN KEY (regionid)
              REFERENCES region (regionid)
);


-- -- Static definitions -- --

-- Put a default value into each table
INSERT INTO producers VALUES (0, '');
INSERT INTO winenames VALUES (0, '');
INSERT INTO types  VALUES (0, '');
INSERT INTO locations VALUES (0, '');
INSERT INTO status VALUES (0, '');
INSERT INTO region VALUES (0, '');
INSERT INTO vendor VALUES (0, '');

-- Status
INSERT INTO status VALUES (1, 'At home');
INSERT INTO status VALUES (2, 'In bond');
INSERT INTO status VALUES (3, 'Tax paid');

-- Size
INSERT INTO sizes VALUES (1, 'Bottle');
INSERT INTO sizes VALUES (2, 'Half');
INSERT INTO sizes VALUES (3, 'Magnum');

