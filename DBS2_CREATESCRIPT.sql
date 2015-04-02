DROP TABLE DBS2_POSTALCODE CASCADE CONSTRAINTS;
DROP TABLE DBS2_USER CASCADE CONSTRAINTS;
DROP TABLE DBS2_CATEGORY CASCADE CONSTRAINTS;
DROP TABLE DBS2_SUBCATEGORY CASCADE CONSTRAINTS;
DROP TABLE DBS2_ADVERT CASCADE CONSTRAINTS;
DROP TABLE DBS2_SERVICE CASCADE CONSTRAINTS;
DROP TABLE DBS2_GOOD CASCADE CONSTRAINTS;
DROP TABLE DBS2_FAVORITE_ADVERT CASCADE CONSTRAINTS;
DROP TABLE DBS2_OFFER CASCADE CONSTRAINTS;
DROP TABLE DBS2_PHOTO CASCADE CONSTRAINTS;

CREATE TABLE DBS2_POSTALCODE
(
  postalcode VARCHAR2(20) PRIMARY KEY,
  xCoord NUMBER(4,0) NOT NULL,
  yCoord NUMBER(4,0) NOT NULL
);

CREATE TABLE DBS2_USER
(
  userID NUMBER(4,0) PRIMARY KEY,
  username VARCHAR2(20) NOT NULL,
  userPassword VARCHAR2(20) NOT NULL,
  postalcode VARCHAR2(20) NOT NULL,
  email VARCHAR2(100) NOT NULL,
  phoneNumber VARCHAR2(20) DEFAULT 'unknown',
  emailPref NUMBER(1,0) DEFAULT 0,
  paymentPref NUMBER(1,0) DEFAULT 0,
  receiptPref NUMBER(1,0) DEFAULT 0
);

CREATE TABLE DBS2_CATEGORY
(
  categoryID NUMBER(4,0) PRIMARY KEY,
  categoryName VARCHAR2(20) NOT NULL UNIQUE
);

CREATE TABLE DBS2_SUBCATEGORY
(
  subCategoryID NUMBER(4,0) PRIMARY KEY,
  subcategoryName VARCHAR2(20) NOT NULL UNIQUE,
  categoryID NUMBER(4,0) NOT NULL
);

CREATE TABLE DBS2_ADVERT
(
  advertID NUMBER(4,0) PRIMARY KEY,
  title VARCHAR2(500) NOT NULL,
  description VARCHAR2(200) NOT NULL,
  creationDate DATE DEFAULT sysdate,
  advertViews NUMBER(4,0) DEFAULT 0,
  serviceOrGood NUMBER(1,0) NOT NULL,
  userID NUMBER(4,0) NOT NULL,
  subcategoryID NUMBER(4,0) NOT NULL,
  similarAdvertID NUMBER(4,0)
);

CREATE TABLE DBS2_SERVICE
(
  advertID NUMBER(4,0) PRIMARY KEY,
  experience VARCHAR2(20) NOT NULL,
  employees NUMBER(4,0) NOT NULL,
  companyType VARCHAR2(20) NOT NULL
);

CREATE TABLE DBS2_GOOD
(
  advertID NUMBER(4,0) PRIMARY KEY,
  condition VARCHAR2(20) NOT NULL
);

CREATE TABLE DBS2_FAVORITE_ADVERT
(
  favoriteAdvertID NUMBER(4,0) PRIMARY KEY,
  userID NUMBER(4,0) NOT NULL,
  advertID NUMBER(4,0) NOT NULL
);

CREATE TABLE DBS2_OFFER
(
  offerID NUMBER(4,0) PRIMARY KEY,
  userID NUMBER(4,0) NOT NULL,
  advertID NUMBER(4,0) NOT NULL,
  amount NUMBER(20,2) NOT NULL
);

CREATE TABLE DBS2_PHOTO
(
  photoID NUMBER(4,0) PRIMARY KEY,
  path VARCHAR2(500) NOT NULL,
  advertID NUMBER(4,0) NOT NULL
);

ALTER TABLE DBS2_USER
  ADD CONSTRAINT FK_USER_postalcode FOREIGN KEY (postalcode) REFERENCES DBS2_POSTALCODE(postalcode);

ALTER TABLE DBS2_SUBCATEGORY
  ADD CONSTRAINT FK_SUBCATEGORY_categoryID FOREIGN KEY (categoryID) REFERENCES DBS2_CATEGORY(categoryID);
  
ALTER TABLE DBS2_ADVERT
  ADD CONSTRAINT FK_ADVERT_userID FOREIGN KEY (userID) REFERENCES DBS2_USER(userID);

ALTER TABLE DBS2_GOOD
  ADD CONSTRAINT FK_GOOD_advertID FOREIGN KEY (advertID) REFERENCES DBS2_ADVERT(advertID);
  
ALTER TABLE DBS2_FAVORITE_ADVERT
  ADD CONSTRAINT FK_FAVORITE_ADVERT_userID FOREIGN KEY (userID) REFERENCES DBS2_USER(userID);
ALTER TABLE DBS2_FAVORITE_ADVERT
  ADD CONSTRAINT FK_FAVORITE_ADVERT_advertID FOREIGN KEY (advertID) REFERENCES DBS2_ADVERT(advertID);

ALTER TABLE DBS2_OFFER
  ADD CONSTRAINT FK_OFFER_userID FOREIGN KEY (userID) REFERENCES DBS2_USER(userID);
ALTER TABLE DBS2_OFFER
  ADD CONSTRAINT FK_OFFER_advertID FOREIGN KEY (advertID) REFERENCES DBS2_ADVERT(advertID);
ALTER TABLE DBS2_OFFER
  ADD CONSTRAINT CH_OFFER_amount CHECK (amount > 0);

ALTER TABLE DBS2_PHOTO
  ADD CONSTRAINT FK_PHOTO_advertID2 FOREIGN KEY (advertID) REFERENCES DBS2_ADVERT(advertID);
  
INSERT INTO DBS2_POSTALCODE
  (postalcode, xCoord, yCoord)
VALUES
  ('5013CA', 0, 0);
  
INSERT INTO DBS2_POSTALCODE
  (postalcode, xCoord, yCoord)
VALUES
  ('1344DG', 50, 50);
  
INSERT INTO DBS2_POSTALCODE
  (postalcode, xCoord, yCoord)
VALUES
 ('1565HJ', 25, 25);
 
INSERT INTO DBS2_USER
  (userID, username, userPassword, postalcode, email,  phoneNumber)
VALUES
  (1, 'milton', 'aap', '5013CA', 'milton@live.nl', 0135433089);
  
INSERT INTO DBS2_USER
  (userID, username, userPassword, postalcode, email,  phoneNumber)
VALUES
  (2, 'zelia', 'tijger', '5013CA', 'zelia@live.nl', 0135433089);
  
INSERT INTO DBS2_USER
  (userID, username, userPassword, postalcode, email,  phoneNumber)
VALUES
  (3, 'bram,', 'hond', '1344DG', 'bram@live.nl', 013558738);
  
INSERT INTO DBS2_CATEGORY
  (categoryID, categoryName)
VALUES
  (1, 'computers');
  
INSERT INTO DBS2_CATEGORY
  (categoryID, categoryName)
VALUES
  (2, 'kleding');
  
INSERT INTO DBS2_SUBCATEGORY
  (subcategoryID, subcategoryName, categoryID)
VALUES
  (1, 'accesoires', 1);
  
INSERT INTO DBS2_SUBCATEGORY
  (subcategoryID, subcategoryName, categoryID)
VALUES
  (2, 'onderdelen', 1);
  
INSERT INTO DBS2_SUBCATEGORY
  (subcategoryID, subcategoryName, categoryID)
VALUES
  (3, 'schoenen', 2);
  
INSERT INTO DBS2_SUBCATEGORY
  (subcategoryID, subcategoryName, categoryID)
VALUES
  (4, 'broeken', 2);
  
INSERT INTO DBS2_ADVERT
  (advertID, title, description, serviceOrGood, userID, subcategoryID)
VALUES
  (1, 'goedkope koptelefoon', 'goedkope koptelefoon mooie zwarte kleur, zeer zachte ongeveer passende oorkussentjes', 0, 1, 1);

INSERT INTO DBS2_ADVERT
  (advertID, title, description, serviceOrGood, userID, subcategoryID)
VALUES
  (2, 'goedkope koptelefoon nummer 2', 'goedkope koptelefoon linkeroortje wertk zeer goed rechteroortje werkt wat minder aka helemaal niet', 0, 1, 1);
  
INSERT INTO DBS2_ADVERT
  (advertID, title, description, serviceOrGood, userID, subcategoryID)
VALUES
  (3, 'laklaars', 'kniehoge laklaars met ritssluiting, maat 38', 0, 2, 3);

INSERT INTO DBS2_ADVERT
  (advertID, title, description, serviceOrGood, userID, subcategoryID)
VALUES
  (4, 'computer reparatie', 'ik zal uw pc zeer snel repareren', 1, 3, 2);

INSERT INTO DBS2_SERVICE
  (advertID, experience, employees, companyType)
VALUES
  (4, '3 jaar', 1, '1mansbedrijf');
  
INSERT INTO DBS2_GOOD
  (advertID, condition)
VALUES
  (1, 'zo goed als nieuw');

INSERT INTO DBS2_GOOD
  (advertID, condition)
VALUES
  (2, 'zo goed als nieuw');

INSERT INTO DBS2_GOOD
  (advertID, condition)
VALUES
  (3, 'bekrast');
  
INSERT INTO DBS2_FAVORITE_ADVERT
  (favoriteAdvertID, userID, advertID)
VALUES
  (1, 1, 1);

INSERT INTO DBS2_FAVORITE_ADVERT
  (favoriteAdvertID, userID, advertID)
VALUES
  (2, 1, 2);

INSERT INTO DBS2_FAVORITE_ADVERT
  (favoriteAdvertID, userID, advertID)
VALUES
  (3, 1, 4);

INSERT INTO DBS2_OFFER
  (offerID, userID, advertID, amount)
VALUES
  (1, 1, 4, 20.25);
  
INSERT INTO DBS2_OFFER
  (offerID, userID, advertID, amount)
VALUES
  (2, 3, 1, 3.25);

INSERT INTO DBS2_PHOTO
  (photoID, path, advertID)
VALUES
  (1, 'C:\adverts\photos\crappykoptelefoon.jpg', 1);

INSERT INTO DBS2_PHOTO
  (photoID, path, advertID)
VALUES
  (2, 'C:\adverts\photos\koptelefooncraptastic.jpg', 1);

INSERT INTO DBS2_PHOTO
  (photoID, path, advertID)
VALUES
  (3, 'C:\adverts\photos\mooiekoptelefoon.jpg', 2);

INSERT INTO DBS2_PHOTO
  (photoID, path, advertID)
VALUES
  (4, 'C:\adverts\photos\mooiekoptelefoon2.jpg', 2);

INSERT INTO DBS2_PHOTO
  (photoID, path, advertID)
VALUES
  (5, 'C:\adverts\photos\laklaarszijkant.jpg', 3);