--creation de la base de données EcommerceDB
CREATE DATABASE EcommerceDB;

--Utiliser la base de données EcommerceDB
USE EcommerceDB;

--Créer la table sales avec les types de données initiaux
CREATE TABLE sales (
    InvoiceNo VARCHAR(50),
    StockCode VARCHAR(50),
    Description TEXT,
    Quantity INT,
    InvoiceDate DATETIME,
    UnitPrice FLOAT,
    CustomerID FLOAT,
    Country VARCHAR(100)
);

--Importer les données depuis le fichier CSV
BULK INSERT sales
FROM 'C:\data\data.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

--Afficher les 10 premières lignes de la table sales
DROP TABLE sales;

--Recréer la table sales avec les types de données corrects
CREATE TABLE sales (
    InvoiceNo VARCHAR(50),
    StockCode VARCHAR(50),
    Description VARCHAR(255),
    Quantity VARCHAR(50),   -- 🔥 CHANGÉ
    InvoiceDate VARCHAR(50),
    UnitPrice VARCHAR(50),
    CustomerID VARCHAR(50),
    Country VARCHAR(100)
);

--Importer les données depuis le fichier CSV
BULK INSERT sales
FROM 'C:\data\data.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    CODEPAGE = '65001',
    TABLOCK
);

--Afficher les 10 premières lignes de la table sales
SELECT TOP 10 * FROM sales;

--supprimer les lignes où CustomerID est NULL ou vide
DELETE FROM sales
WHERE CustomerID IS NULL OR CustomerID = '';

--supprimer les lignes où Quantity ou UnitPrice ne contiennent pas de chiffres
DELETE FROM sales
WHERE Quantity NOT LIKE '%[0-9]%'

--Calculer le chiffre d affaires total par pays
SELECT 
    Country,
    SUM(TRY_CAST(Quantity AS INT) * TRY_CAST(UnitPrice AS FLOAT)) AS Revenue
FROM sales
GROUP BY Country
ORDER BY Revenue DESC;

--Trouver les 5 produits les plus vendus en termes de quantité 
SELECT TOP 5
    Description,
    SUM(TRY_CAST(Quantity AS INT)) AS TotalSold
FROM sales
WHERE TRY_CAST(Quantity AS INT) IS NOT NULL
GROUP BY Description
ORDER BY TotalSold DESC;

--Calculer le nombre total de ventes (distinct InvoiceNo)
SELECT COUNT(DISTINCT InvoiceNo) AS TotalSales
FROM sales;

--Calculer le chiffre d affaires moyen par client
SELECT 
    SUM(TRY_CAST(Quantity AS INT) * TRY_CAST(UnitPrice AS FLOAT)) 
    / COUNT(DISTINCT CustomerID) AS AvgRevenue
FROM sales;

--Trouver les 5 produits les plus vendus en termes de quantité
SELECT 
    Description,
    SUM(TRY_CAST(Quantity AS INT)) AS TotalSold
FROM sales
GROUP BY Description
ORDER BY TotalSold DESC;
