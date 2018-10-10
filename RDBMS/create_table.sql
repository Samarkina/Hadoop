CREATE DATABASE IF NOT EXISTS rdbms;
USE rdbms;

DROP TABLE IF EXISTS hiveTopCategories;
CREATE TABLE hiveTopCategories (
    productCategory VARCHAR(64) NOT NULL,
    cnt INT,
    PRIMARY KEY (productCategory)
);

DROP TABLE IF EXISTS hiveTopProducts;
CREATE TABLE hiveTopProducts (
    productName VARCHAR(64) NOT NULL,
    productCategory VARCHAR(64) NOT NULL,
    cnt INT,
    rownum INT,
    PRIMARY KEY (productName, productCategory)
);

DROP TABLE IF EXISTS hiveTopCountries;
CREATE TABLE hiveTopCountries (
    country_name VARCHAR(64) NOT NULL,
    total FLOAT(2),
    PRIMARY KEY (country_name)
);

DROP TABLE IF EXISTS sparkTopCategories;
CREATE TABLE sparkTopCategories (
    productCategory VARCHAR(64) NOT NULL,
    cnt INT,
    PRIMARY KEY (productCategory)
);

DROP TABLE IF EXISTS sparkTopProducts;
CREATE TABLE sparkTopProducts (
    productName VARCHAR(64) NOT NULL,
    productCategory VARCHAR(64) NOT NULL,
    cnt INT,
    rownum INT,
    PRIMARY KEY (productName, productCategory)
);

DROP TABLE IF EXISTS sparkTopCountries;
CREATE TABLE sparkTopCountries (
    country_name VARCHAR(64) NOT NULL,
    total FLOAT(2),
    PRIMARY KEY (country_name)
);

