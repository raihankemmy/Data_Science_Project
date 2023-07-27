SELECT * FROM store
SELECT * FROM product
SELECT * FROM customer
SELECT * FROM transaction

SELECT DISTINCT(`Marital Status`) FROM customer
DELETE FROM customer WHERE `Marital Status` = ''


# Merge Data
SELECT a.`Date`, a.`TransactionID`, a.`CustomerID`, a.`ProductID`, a.`StoreID`, a.`Qty`, a.`TotalAmount`, 
		 b.`StoreName`, b.`GroupStore`, b.`Type`, b.`Latitude`, b.`Longitude`, 
		 c.`Age`, c.`Gender`, c.`Marital Status`, c.`Income`,
		 d.`Product Name`, d.`Price`
FROM transaction a
INNER JOIN store b ON a.StoreID = b.StoreID
INNER JOIN customer c ON a.CustomerID = c.CustomerID
INNER JOIN product d ON a.ProductID = d.ProductID
ORDER BY 1, 2, 3, 4, 5


# Berapa rata-rata umur customer jika dilihat dari marital statusnya ?
SELECT `Marital Status`, AVG(`Age`) AS Age FROM customer
GROUP BY `Marital Status`


#  Berapa rata-rata umur customer jika dilihat dari gender nya ?
SELECT 
CASE 
	WHEN `Gender`= 0 THEN 'Wanita'
	WHEN `Gender` = 1 THEN 'Pria'
END AS `Gender`, AVG(`Age`) AS Age FROM customer
GROUP BY `Gender`


# Tentukan nama store dengan total quantity terbanyak !
SELECT a.`StoreName`, subquery.`Qty` AS 'Qty'
FROM store a
INNER JOIN (
    SELECT b.`StoreID`, SUM(b.`Qty`) AS 'Qty'
    FROM transaction b
    GROUP BY b.`StoreID`
) AS subquery ON a.`StoreID` = subquery.`StoreID`
WHERE subquery.`Qty` = (
    SELECT MAX(`Qty`) 
    FROM (
        SELECT SUM(b.`Qty`) AS 'Qty'
        FROM transaction b
        GROUP BY b.`StoreID`
    ) AS sub
)


# Tentukan nama produk terlaris dengan total amount terbanyak !
SELECT a.`Product Name`, subquery.`TotalAmount` AS 'TotalAmount'
FROM product a
INNER JOIN (
    SELECT b.`ProductID`, SUM(b.`TotalAmount`) AS 'TotalAmount'
    FROM transaction b
    GROUP BY b.`ProductID`
) AS subquery ON a.`ProductID` = subquery.`ProductID`
WHERE subquery.`TotalAmount` = (
    SELECT MAX(`TotalAmount`) 
    FROM (
        SELECT SUM(b.`TotalAmount`) AS 'TotalAmount'
        FROM transaction b
        GROUP BY b.`ProductID`
    ) AS sub
)
