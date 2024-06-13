CREATE VIEW VISTA_ClientesCompras AS 
SELECT c.id_cliente, c.nombre AS CLIENTE, c.correo_electronico, cm.id_compra, cm.fecha_compra, cm.total
FROM Clients c
LEFT JOIN Compras cm
ON C.id_cliente = cm.id_cliente;

