----DEMO 1---
-- Create a GraphDemo database
USE MASTER
IF NOT EXISTS (SELECT * FROM sys.databases WHERE NAME = 'GraphDb')
	
ELSE 
BEGIN
	Drop database graphdb
	CREATE DATABASE GraphDB;
END
GO

USE GraphDB;
GO

-- Create NODE tables
CREATE TABLE Persons (
  ID INTEGER PRIMARY KEY,
  name VARCHAR(100)
) AS NODE;

CREATE TABLE Restaurant (
  ID INTEGER NOT NULL,
  name VARCHAR(100),
  city VARCHAR(100)
) AS NODE;

CREATE TABLE City (
  ID INTEGER PRIMARY KEY,
  name VARCHAR(100),
  stateName VARCHAR(100)
) AS NODE;

select * from city

-- Create EDGE tables.
CREATE TABLE likes (rating INTEGER) AS EDGE;
CREATE TABLE friendsOf AS EDGE;
CREATE TABLE livesIn AS EDGE;
CREATE TABLE locatedIn AS EDGE;

select * from likes

SELECT * FROM PERSONS

-- Insert data into node tables. Inserting into a node table is same as inserting into a regular table
INSERT INTO Persons (ID, name)
    VALUES (1, 'John')
         , (2, 'Mary')
         , (3, 'Alice')
         , (4, 'Jacob')
         , (5, 'Julie');

INSERT INTO Restaurant (ID, name, city)
    VALUES (1, 'Taco Dell','Bellevue')
         , (2, 'Ginger and Spice','Seattle')
         , (3, 'Noodle Land', 'Redmond');

INSERT INTO City (ID, name, stateName)
    VALUES (1,'Bellevue','WA')
         , (2,'Seattle','WA')
         , (3,'Redmond','WA');

		 select * from persons

-- Insert into edge table. While inserting into an edge table,
-- you need to provide the $node_id from $from_id and $to_id columns.
/* Insert which restaurants each person likes */
INSERT INTO likes
    VALUES ((SELECT $node_id FROM Persons WHERE ID = 1), (SELECT $node_id FROM Restaurant WHERE ID = 1), 9)
         , ((SELECT $node_id FROM Persons WHERE ID = 2), (SELECT $node_id FROM Restaurant WHERE ID = 2), 9)
         , ((SELECT $node_id FROM Persons WHERE ID = 3), (SELECT $node_id FROM Restaurant WHERE ID = 3), 9)
         , ((SELECT $node_id FROM Persons WHERE ID = 4), (SELECT $node_id FROM Restaurant WHERE ID = 3), 9)
         , ((SELECT $node_id FROM Persons WHERE ID = 5), (SELECT $node_id FROM Restaurant WHERE ID = 3), 9);

/* Associate in which city live each person*/
INSERT INTO livesIn
    VALUES ((SELECT $node_id FROM Persons WHERE ID = 1), (SELECT $node_id FROM City WHERE ID = 1))
         , ((SELECT $node_id FROM Persons WHERE ID = 2), (SELECT $node_id FROM City WHERE ID = 2))
         , ((SELECT $node_id FROM Persons WHERE ID = 3), (SELECT $node_id FROM City WHERE ID = 3))
         , ((SELECT $node_id FROM Persons WHERE ID = 4), (SELECT $node_id FROM City WHERE ID = 3))
         , ((SELECT $node_id FROM Persons WHERE ID = 5), (SELECT $node_id FROM City WHERE ID = 1));

/* Insert data where the restaurants are located */
INSERT INTO locatedIn
    VALUES ((SELECT $node_id FROM Restaurant WHERE ID = 1), (SELECT $node_id FROM City WHERE ID =1))
         , ((SELECT $node_id FROM Restaurant WHERE ID = 2), (SELECT $node_id FROM City WHERE ID =2))
         , ((SELECT $node_id FROM Restaurant WHERE ID = 3), (SELECT $node_id FROM City WHERE ID =3));

/* Insert data into the friendOf edge */
INSERT INTO friendsOf
    VALUES ((SELECT $NODE_ID FROM Persons WHERE ID = 1), (SELECT $NODE_ID FROM Persons WHERE ID = 2))
         , ((SELECT $NODE_ID FROM Persons WHERE ID = 2), (SELECT $NODE_ID FROM Persons WHERE ID = 3))
         , ((SELECT $NODE_ID FROM Persons WHERE ID = 3), (SELECT $NODE_ID FROM Persons WHERE ID = 1))
         , ((SELECT $NODE_ID FROM Persons WHERE ID = 4), (SELECT $NODE_ID FROM Persons WHERE ID = 2))
         , ((SELECT $NODE_ID FROM Persons WHERE ID = 5), (SELECT $NODE_ID FROM Persons WHERE ID = 4));

select * from friendsof

-- Find Restaurants that John likes
SELECT p1.name, p2.name
FROM Persons p1 , likes, persons p2
WHERE MATCH (p1-(likes)->p2)
AND p1.name = 'Mary';

-- Find Restaurants that John's friends like
SELECT Restaurant.name,likes.rating
FROM Persons person1, Persons person2, likes, friendsOf, Restaurant
WHERE MATCH(person1-(friendsOf)->person2-(likes)->Restaurant)
AND person1.name='John';

-- Find people who like a restaurant in the same city they live in
SELECT Persons.name
FROM Persons, likes, Restaurant, livesIn, City, locatedIn
WHERE MATCH (Persons-(likes)->Restaurant-(locatedIn)->City AND Persons-(livesIn)->City);





------------DEMO 2 ShortestPath-----------------


use master;
GO


drop database if exists Graphdb;
GO

create database Graphdb;
GO

use graphdb
go
drop table if exists person
drop table if exists friendof

CREATE TABLE Person (
  ID INTEGER PRIMARY KEY,
  name VARCHAR(100)
) AS NODE;


CREATE TABLE friendOf AS EDGE;


INSERT INTO Person VALUES (1,'Stefan');
INSERT INTO Person VALUES (2,'Daniel');
INSERT INTO Person VALUES (3,'John');
INSERT INTO Person VALUES (4,'Mary');
INSERT INTO Person VALUES (5,'Jacob');
INSERT INTO Person VALUES (6,'Julie');
INSERT INTO Person VALUES (7,'Alice');
INSERT INTO Person VALUES (8,'Hans');
INSERT INTO Person VALUES (9,'Max');
INSERT INTO Person VALUES (10,'Susi');


INSERT INTO friendof 
VALUES 
((SELECT $node_id FROM Person WHERE ID = 2), 
 (SELECT $node_id FROM Person WHERE ID = 1));

INSERT INTO friendof 
VALUES 
((SELECT $node_id FROM Person WHERE ID = 3), 
 (SELECT $node_id FROM Person WHERE ID = 2));

INSERT INTO friendof 
VALUES 
((SELECT $node_id FROM Person WHERE ID = 4), 
 (SELECT $node_id FROM Person WHERE ID = 3));


INSERT INTO friendof 
VALUES 
((SELECT $node_id FROM Person WHERE ID = 3), 
 (SELECT $node_id FROM Person WHERE ID = 4));

INSERT INTO friendof 
VALUES 
((SELECT $node_id FROM Person WHERE ID = 5), 
 (SELECT $node_id FROM Person WHERE ID = 4));


INSERT INTO friendof 
VALUES 
((SELECT $node_id FROM Person WHERE ID = 4), 
 (SELECT $node_id FROM Person WHERE ID = 7));

 
INSERT INTO friendof 
VALUES 
((SELECT $node_id FROM Person WHERE ID = 8), 
 (SELECT $node_id FROM Person WHERE ID = 7));



INSERT INTO friendof 
VALUES 
((SELECT $node_id FROM Person WHERE ID = 10), 
 (SELECT $node_id FROM Person WHERE ID = 4));

INSERT INTO friendof 
VALUES 
((SELECT $node_id FROM Person WHERE ID = 10), 
 (SELECT $node_id FROM Person WHERE ID = 8));



  INSERT INTO friendof 
VALUES 
((SELECT $node_id FROM Person WHERE ID = 7), 
 (SELECT $node_id FROM Person WHERE ID = 3));


 
 INSERT INTO friendof 
VALUES 
((SELECT $node_id FROM Person WHERE ID = 6), 
 (SELECT $node_id FROM Person WHERE ID = 4));

  INSERT INTO friendof 
VALUES 
((SELECT $node_id FROM Person WHERE ID = 1), 
 (SELECT $node_id FROM Person WHERE ID = 3));

   INSERT INTO friendof 
VALUES 
((SELECT $node_id FROM Person WHERE ID = 7), 
 (SELECT $node_id FROM Person WHERE ID = 10));


 

 select * from friendOf



--Freunde
SELECT PersonName, Friends
FROM (  
 SELECT
       Person1.name AS PersonName, 
       STRING_AGG(Person2.name, '->') WITHIN GROUP (GRAPH PATH) AS Friends,
       LAST_VALUE(Person2.name) WITHIN GROUP (GRAPH PATH) AS LastNode
   FROM
       Person AS Person1,
       friendOf FOR PATH  AS fo,
       Person	FOR PATH  AS Person2
   WHERE MATCH(Person1-(fo)->Person2)
   AND Person1.name = 'Daniel'
) AS Q
WHERE Q.LastNode = 'Hans'



---kürzesten Wege zu allen vernetzten Freunden
SELECT
   Person1.name AS PersonName, 
   STRING_AGG(Person2.name, '->') WITHIN GROUP (GRAPH PATH) AS Friends
FROM
   Person AS Person1,
   friendOf FOR PATH AS fo,
   Person FOR PATH  AS Person2
WHERE MATCH(SHORTEST_PATH(Person1(-(fo)->Person2)+))
AND Person1.name = 'Mary'


SELECT PersonName, Friends, levels
FROM (  
   SELECT
       Person1.name AS PersonName, 
       STRING_AGG(Person2.name, '->') WITHIN GROUP (GRAPH PATH) AS Friends,
       LAST_VALUE(Person2.name) WITHIN GROUP (GRAPH PATH) AS LastNode,
       COUNT(Person2.name) WITHIN GROUP (GRAPH PATH) AS levels
   FROM
       Person AS Person1,
       friendOf FOR PATH AS fo,
       Person FOR PATH  AS Person2
   WHERE MATCH(SHORTEST_PATH(Person1(-(fo)->Person2)+))
   AND Person1.name = 'Hans'
   	) AS Q
WHERE Q.LastNode = 'Stefan'

--2 Hops entfernt
SELECT PersonName, Friends
FROM (
    SELECT
        Person1.name AS PersonName, 
        STRING_AGG(Person2.name, '->') WITHIN GROUP (GRAPH PATH) AS Friends,
        COUNT(Person2.name) WITHIN GROUP (GRAPH PATH) AS levels
    FROM
        Person AS Person1,
        friendOf FOR PATH AS fo,
        Person FOR PATH  AS Person2
    WHERE MATCH(SHORTEST_PATH(Person1(-(fo)->Person2){1,5}))
    AND Person1.name = 'Jacob'
) Q
WHERE Q.levels = 2


alter table person add Distanz int -- Entfernung von best X..so als Idee

update Person set Distanz = id % 3
update Person set Distanz = 5 where Distanz = 0



SELECT PersonName, Friends, levels
FROM (
    SELECT
        Person1.name AS PersonName, 
        STRING_AGG(Person2.name, '->') WITHIN GROUP (GRAPH PATH) AS Friends,
        sum(Person2.Distanz) WITHIN GROUP (GRAPH PATH) AS levels
    FROM
        Person AS Person1,
        friendOf FOR PATH AS fo,
        Person FOR PATH  AS Person2
    WHERE MATCH(SHORTEST_PATH(Person1(-(fo)->Person2){1,3}))
    AND Person1.name = 'Jacob'
) Q
WHERE Q.levels = 1


select * from person

