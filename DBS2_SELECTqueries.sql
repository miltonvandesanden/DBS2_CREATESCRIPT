INSERT INTO DBS2_PHOTO
  (photoID, path, advertID)
VALUES
  (5, 'C:\adverts\photos\laklaarszijkant.jpg', 3);
    
SELECT u.username AS username, p.postalcode AS postalcode, p.xCoord AS xCoord, p.yCoord AS yCoord
FROM DBS2_USER u
INNER JOIN DBS2_POSTALCODE p
ON u.postalcode = p.postalcode;

SELECT u.username AS username, advert.title AS title
FROM DBS2_USER u
INNER JOIN DBS2_FAVORITE_ADVERT fa
ON u.userID = fa.userID
INNER JOIN DBS2_ADVERT advert
ON fa.advertID = advert.advertID;

SELECT cat.categoryName AS categoryname, COUNT(advert.advertID)
FROM DBS2_CATEGORY cat
INNER JOIN DBS2_SUBCATEGORY subcat
ON cat.categoryID = subcat.categoryID
INNER JOIN DBS2_ADVERT advert
ON subcat.subcategoryID = advert.subcategoryID
GROUP BY categoryname;

SELECT u.username AS username, COUNT(advert.advertID)
FROM DBS2_USER u
INNER JOIN DBS2_ADVERT advert
ON u.userID = advert.userID
WHERE advert.advertID = (SELECT advert.advertID
                        FROM DBS2_GOOD good
                        WHERE advert.advertID = good.advertID)
GROUP BY u.username;

SELECT advert1.title AS title, COUNT(advert2.advertID) AS overeenkomende_advertenties
FROM DBS2_ADVERT advert1
INNER JOIN DBS2_ADVERT advert2
ON advert1.advertID = advert2.advertID
GROUP BY advert1.title;

SELECT u.username AS username, advert.title AS advert
FROM DBS2_USER u
LEFT OUTER JOIN DBS2_ADVERT advert
ON u.userID = advert.userID;

SELECT u.username AS username, advert.title AS advert, offer.amount
FROM DBS2_USER u, DBS2_ADVERT advert, DBS2_OFFER offer, DBS2_FAVORITE_ADVERT favorite
WHERE u.userID = advert.userID
AND advert.advertID = offer.advertID
AND u.userID = favorite.userID
AND offer.offerID IS NOT NULL
AND favorite.favoriteAdvertID IS NOT NULL;

SELECT cat.categoryName AS categorieNaam, COUNT(advert.advertID) AS aantal_advertenties
FROM DBS2_CATEGORY cat
INNER JOIN DBS2_SUBCATEGORY subcat
ON cat.categoryID = subcat.categoryID
INNER JOIN DBS2_ADVERT advert
ON subcat.subcategoryID = advert.subcategoryID
INNER JOIN DBS2_SERVICE service
ON advert.advertID = service.advertID
GROUP BY cat.categoryName;

SELECT advert.title AS advertentie, advert.creationDate AS aanmaakdatum
FROM DBS2_ADVERT advert
WHERE advert.creationDate BETWEEN to_date('01/01/2010','DD/MM/YYYY') AND to_date('31/12/2015','DD/MM/YYYY');