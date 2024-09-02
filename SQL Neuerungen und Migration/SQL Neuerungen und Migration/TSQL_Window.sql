--Mehrfach Window verwendbar
SELECT
     object_id
    ,name
    ,RID                = ROW_NUMBER()      OVER (PARTITION BY object_id ORDER BY name)
    ,PreviousColumnName = LAG(name)         OVER (PARTITION BY object_id ORDER BY name)
    ,FirstColumn        = FIRST_VALUE(name) OVER (PARTITION BY object_id ORDER BY name)
FROM sys.all_columns;

SELECT
     object_id
    ,name
    ,RID                = ROW_NUMBER()      OVER win
    ,PreviousColumnName = LAG(name)         OVER win
    ,FirstColumn        = FIRST_VALUE(name) OVER win
FROM sys.all_columns
WINDOW win AS (PARTITION BY object_id ORDER BY name);

--------------------------------------------------------------------
--Mehrere  Window definierbar
--------------------------------------------------------------------
SELECT
     object_id
    ,name
    ,RID                = ROW_NUMBER()      OVER win
    ,PreviousColumnName = LAG(name)         OVER win
    ,FirstColumn        = FIRST_VALUE(name) OVER win
FROM sys.all_columns
WINDOW win AS (PARTITION BY object_id ORDER BY name);


SELECT
     object_id
    ,name
    ,RID                = ROW_NUMBER()      OVER winasc
    ,PreviousColumnName = LAG(name)         OVER winasc
    ,NextColumnName     = LAG(name)         OVER windesc
    ,FirstColumn        = FIRST_VALUE(name) OVER winasc
FROM sys.all_columns
WINDOW  base  AS (PARTITION BY object_id)
       ,was AS (base ORDER BY name ASC)
       ,windesc AS (base ORDER BY name DESC)
ORDER BY OBJECT_ID, RID;


--------------------------------------------------------------------
--Windo mehrfach referenzierbar--------------------------------------------------------------------
SELECT
     object_id
    ,name
    ,RID                = ROW_NUMBER()      OVER winasc
    ,PreviousColumnName = LAG(name)         OVER winasc
    ,NextColumnName     = LAG(name)         OVER windesc
    ,FirstColumn        = FIRST_VALUE(name) OVER winasc
FROM sys.all_columns
WINDOW  winasc AS (base ORDER BY name ASC)
       ,base  AS (PARTITION BY object_id)
       ,windesc AS (base ORDER BY name DESC)
ORDER BY OBJECT_ID, RID;


--Ds hier geht nicht.. Mehrfache referenzierung
SELECT
     object_id
    ,name
    ,RID                = ROW_NUMBER()      OVER winasc
    ,PreviousColumnName = LAG(name)         OVER winasc
    ,NextColumnName     = LAG(name)         OVER windesc
    ,FirstColumn        = FIRST_VALUE(name) OVER winasc
FROM sys.all_columns
WINDOW  base  AS (PARTITION BY object_id)
       ,winorder AS (ORDER BY name ASC)
--     ,test AS (base winorder)
--       ,windesc AS (base ORDER BY name DESC)
ORDER BY OBJECT_ID, RID;

SELECT
     object_id
    ,name
    ,RID                = ROW_NUMBER()      OVER winasc
    ,PreviousColumnName = LAG(name)         OVER winasc
    ,NextColumnName     = LAG(name)         OVER windesc
    ,FirstColumn        = FIRST_VALUE(name) OVER winasc
FROM sys.all_columns
WINDOW  base    AS (windesc)
       ,winasc  AS (base ORDER BY name ASC)
       ,windesc AS (base ORDER BY name DESC)
ORDER BY OBJECT_ID, RID;