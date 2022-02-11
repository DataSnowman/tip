-- Serverless Views

IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'curatedtip')
BEGIN
  CREATE DATABASE curatedtip;
END;
GO
USE curatedtip
GO
IF EXISTS (SELECT NAME FROM SYS.VIEWS WHERE NAME = 'call_center')
DROP VIEW hack.call_center
GO
CREATE VIEW hack.call_center
AS SELECT *
FROM
    OPENROWSET(
        BULK 'https://synapsetiphackathon.dfs.core.windows.net/commonzone/curateddata/tiphackdelta/call_center',
        FORMAT = 'DELTA'
    ) AS call_center
GO
IF EXISTS (SELECT NAME FROM SYS.VIEWS WHERE NAME = 'catalog_returns')
DROP VIEW hack.catalog_returns
GO
CREATE VIEW hack.catalog_returns
AS SELECT *
FROM
    OPENROWSET(
        BULK 'https://synapsetiphackathon.dfs.core.windows.net/commonzone/curateddata/tiphackdelta/catalog_returns',
        FORMAT = 'DELTA'
    ) AS catalog_returns
GO
IF EXISTS (SELECT NAME FROM SYS.VIEWS WHERE NAME = 'catalog_sales')
DROP VIEW hack.catalog_sales
GO
CREATE VIEW hack.catalog_sales
AS SELECT *
FROM
    OPENROWSET(
        BULK 'https://synapsetiphackathon.dfs.core.windows.net/commonzone/curateddata/tiphackdelta/catalog_sales',
        FORMAT = 'DELTA'
    ) AS catalog_sales
GO
IF EXISTS (SELECT NAME FROM SYS.VIEWS WHERE NAME = 'customer')
DROP VIEW hack.customer
GO
CREATE VIEW hack.customer
AS SELECT *
FROM
    OPENROWSET(
        BULK 'https://synapsetiphackathon.dfs.core.windows.net/commonzone/curateddata/tiphackdelta/customer',
        FORMAT = 'DELTA'
    ) AS customer
GO
IF EXISTS (SELECT NAME FROM SYS.VIEWS WHERE NAME = 'customer_address')
DROP VIEW hack.customer_address
GO
CREATE VIEW hack.customer_address
AS SELECT *
FROM
    OPENROWSET(
        BULK 'https://synapsetiphackathon.dfs.core.windows.net/commonzone/curateddata/tiphackdelta/customer_address',
        FORMAT = 'DELTA'
    ) AS customer_address
GO
IF EXISTS (SELECT NAME FROM SYS.VIEWS WHERE NAME = 'customer_demographics')
DROP VIEW hack.customer_demographic
GO
CREATE VIEW hack.customer_demographics
AS SELECT *
FROM
    OPENROWSET(
        BULK 'https://synapsetiphackathon.dfs.core.windows.net/commonzone/curateddata/tiphackdelta/customer_demographics',
        FORMAT = 'DELTA'
    ) AS customer_demographics
GO
IF EXISTS (SELECT NAME FROM SYS.VIEWS WHERE NAME = 'date_dim')
DROP VIEW hack.date_dim
GO
CREATE VIEW hack.date_dim
AS SELECT *
FROM
    OPENROWSET(
        BULK 'https://synapsetiphackathon.dfs.core.windows.net/commonzone/curateddata/tiphackdelta/date_dim',
        FORMAT = 'DELTA'
    ) AS date_dim
GO
IF EXISTS (SELECT NAME FROM SYS.VIEWS WHERE NAME = 'inventory')
DROP VIEW hack.inventory
GO
CREATE VIEW hack.inventory
AS SELECT *
FROM
    OPENROWSET(
        BULK 'https://synapsetiphackathon.dfs.core.windows.net/commonzone/curateddata/tiphackdelta/inventory',
        FORMAT = 'DELTA'
    ) AS inventory
GO
IF EXISTS (SELECT NAME FROM SYS.VIEWS WHERE NAME = 'item')
DROP VIEW hack.item
GO
CREATE VIEW hack.item
AS SELECT *
FROM
    OPENROWSET(
        BULK 'https://synapsetiphackathon.dfs.core.windows.net/commonzone/curateddata/tiphackdelta/item',
        FORMAT = 'DELTA'
    ) AS item
GO
IF EXISTS (SELECT NAME FROM SYS.VIEWS WHERE NAME = 'promotion')
DROP VIEW hack.promotion
GO
CREATE VIEW hack.promotion
AS SELECT *
FROM
    OPENROWSET(
        BULK 'https://synapsetiphackathon.dfs.core.windows.net/commonzone/curateddata/tiphackdelta/promotion',
        FORMAT = 'DELTA'
    ) AS promotion
GO
IF EXISTS (SELECT NAME FROM SYS.VIEWS WHERE NAME = 'warehouse')
DROP VIEW hack.warehouse
GO
CREATE VIEW hack.warehouse
AS SELECT *
FROM
    OPENROWSET(
        BULK 'https://synapsetiphackathon.dfs.core.windows.net/commonzone/curateddata/tiphackdelta/warehouse',
        FORMAT = 'DELTA'
    ) AS warehouse
GO

