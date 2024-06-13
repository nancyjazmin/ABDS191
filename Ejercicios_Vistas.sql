CREATE VIEW Vista_ComprasComic AS 
SELECT co.id_comic, c.cantidad,co.titulo, c.id_compra, c.fecha_compra,c.total
FROM Comics co
LEFT JOIN Compras c
ON  co.id_comic = c.id_compra;

SELECT dbo.Comics.id_comic, dbo.Compras.cantidad, dbo.Comics.titulo, 
dbo.Compras.id_compra, 
dbo.Compras.fecha_compra, dbo.Compras.total
FROM   dbo.Comics CROSS JOIN
             dbo.Compras


CREATE VIEW Vista_ComicsComprados AS 
SELECT co.id_comic, c.nombre_cliente,c.cantidad
FROM Comics co
LEFT JOIN Compras c
ON  co.id_comic = c.id_compra;

