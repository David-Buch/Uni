-- Cleanup existing tables and data
DROP TABLE IF EXISTS Districts, PostalCodes, Streets, StreetDistricts, Addresses,
  InstitutionTypes, Institutions, Countries, PopByCitizenship, PopByGender;

-- Create all tables, incl constraints
CREATE TABLE Districts(
  DKey INT PRIMARY KEY,
  Name VARCHAR(32) UNIQUE NOT NULL,
  Population INT NOT NULL,
  Area NUMERIC(10,2) NOT NULL
);

CREATE TABLE PostalCodes(
  Code INT CHECK (Code BETWEEN 8000 AND 8099),
  DKey INT REFERENCES Districts,
  PRIMARY KEY (DKey, Code)
);

CREATE TABLE Streets(
  StKey INT PRIMARY KEY,
  StreetName VARCHAR(64) NOT NULL
);

CREATE TABLE StreetDistricts(
  StKey INT REFERENCES Streets,
  DKey INT REFERENCES Districts,
  PRIMARY KEY (StKey, DKey)
);

CREATE TABLE Addresses(
  AKey INT PRIMARY KEY,
  StKey INT REFERENCES Streets NOT NULL,
  PostalCode INT CHECK (PostalCode BETWEEN 8000 AND 8099),
  StNumber VARCHAR(32) NOT NULL
);

CREATE TABLE InstitutionTypes(
  ITKey INT PRIMARY KEY,
  IType VARCHAR(64) UNIQUE NOT NULL,
  ICategory VARCHAR(64)
);

CREATE TABLE Institutions(
  IKey INT PRIMARY KEY,
  Name VARCHAR(128) NOT NULL,
  Phone VARCHAR(32),
  ITKey INT REFERENCES InstitutionTypes NOT NULL,
  AKey INT REFERENCES Addresses NOT NULL
);

CREATE TABLE Countries(
  CKey INT PRIMARY KEY,
  Name VARCHAR(64) NOT NULL,
  EUStatus CHAR(4) NOT NULL,
  UNIQUE(Name, EUStatus)
);

CREATE TABLE PopByCitizenship(
  DKey INT REFERENCES Districts,
  CKey INT REFERENCES Countries,
  PopDate DATE,
  PopCount INT NOT NULL,
  PRIMARY KEY(DKey, CKey, PopDate)
);

CREATE TABLE PopByGender(
  DKey INT REFERENCES Districts,
  Gender CHAR(1) CHECK (Gender IN('W','M','O')),
  PopDate DATE,
  PopCount INT NOT NULL,
  PRIMARY KEY(DKey, Gender, PopDate)
);
