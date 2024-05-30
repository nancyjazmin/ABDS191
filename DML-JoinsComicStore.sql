-- Inner Join 

SELECT c.id_compra,cl.nombre AS CLIENTE,c.fecha_compra,c.total
FROM Compras c
jOIN Clients cl ON c.id_cliente = cl.id_cliente;

--LEFT JOIN

SELECT c.id_compra,cl.nombre AS CLIENTE,c.fecha_compra,c.total
FROM Compras c
LEFT jOIN Clients cl ON c.id_cliente = cl.id_cliente;

--RIGHT JOIN
SELECT c.id_compra,cl.nombre AS CLIENTE,c.fecha_compra,c.total
FROM Compras c
RIGHT jOIN Clients cl ON c.id_cliente = cl.id_cliente;

--FULL JOIN
SELECT *
FROM Clients cl
FULL JOIN Compras c
ON c.id_cliente = cl.id_cliente;