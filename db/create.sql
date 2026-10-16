CREATE TABLE producers (
   ProdID INT PRIMARY KEY,
   name CHAR(20)
);

CREATE TABLE winenames (
   WineNameID INT PRIMARY KEY,
   name       CHAR(80)
);

CREATE TABLE types (
   TypeID   INT PRIMARY KEY,
   name     CHAR(10)
);

CREATE TABLE locations (
   LocID    INT PRIMARY KEY,
   name     CHAR(20)
);

CREATE TABLE status (
   StatusID INT PRIMARY KEY,
   name     CHAR(10)
);

CREATE TABLE sizes (
   SizeID INT PRIMARY KEY,
   name   CHAR(8)
);

CREATE TABLE region (
   RegionID INT PRIMARY KEY,
   name     CHAR(20)
);

CREATE TABLE vendor (
   VendorID INT PRIMARY KEY,
   name     CHAR(20)
);

create table collection (
   CollectionID INT PRIMARY KEY,
   WineNameID   INT,
   ProdID       INT,
   TypeID       INT,
   LocID        INT,
   StatusID     INT,
   RegionID     INT,
   VendorID     INT,
   SizeID       INT,
   bottles      INT,
   vintage      char(8),
   price        REAL,
   cprice       REAL,
   updated      char(20),
   bracket      char(20),
   drink        char(20),
   notes        char(80),
   scores       char(80),
   CONSTRAINT fk_collection_winenames FOREIGN KEY (WineNameID)
              REFERENCES winenames (WineNameID),
   CONSTRAINT fk_collection_producers FOREIGN KEY (ProdID)
              REFERENCES producers (ProdID),
   CONSTRAINT fk_collection_types FOREIGN KEY (TypeID)
              REFERENCES types (TypeID),
   CONSTRAINT fk_collection_sizes FOREIGN KEY (SizeID)
              REFERENCES sizes (SizeID),
   CONSTRAINT fk_collection_locations FOREIGN KEY (LocID)
              REFERENCES locations (LocID),
   CONSTRAINT fk_collection_status FOREIGN KEY (StatusID)
              REFERENCES status (StatusID),
   CONSTRAINT fk_collection_vendor FOREIGN KEY (VendorID)
              REFERENCES vendor (VendorID),
   CONSTRAINT fk_collection_region FOREIGN KEY (RegionID)
              REFERENCES region (RegionID)
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

