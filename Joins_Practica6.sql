--Unión de titulo y cantidad disponible 
SELECT c.titulo, inven.cantidad_disponible 
FROM Comics c 
JOIN Inventario inven ON c.id_comic = inven.id_comic;

ALTER TABLE Compras 
ADD cantidad int;

--consulta de detalles de compra 
SELECT 
    c.id_cliente,c.nombre,
    c.correo_electronico,com.id_compra,
    com.fecha_compra,com.total,
    cc.id_comic,co.titulo,
    co.anio, co.precio,
    cc.cantidad
FROM 
    Clients c
JOIN 
    Compras com ON c.id_cliente = com.id_cliente
JOIN 
    Comic_Compras cc ON com.id_compra = cc.id_compra
JOIN 
    Comics co ON cc.id_comic = co.id_comic;


	--consulta para obtener todas las compras
	SELECT 
    co.id_comic,
    co.titulo,
    co.anio,
    co.precio,
    inv.cantidad_disponible,
    inv.disponibilidad,
    cc.id_compra,
    cc.cantidad AS cantidad_comprada,
    com.id_cliente,
    com.fecha_compra,
    com.total
FROM 
    Comics co
LEFT JOIN 
    Inventario inv ON co.id_comic = inv.id_comic
LEFT JOIN 
    Comic_Compras cc ON co.id_comic = cc.id_comic
LEFT JOIN 
    Compras com ON cc.id_compra = com.id_compra;


	--Enlistar todos los comics con cantidad disponible 
	SELECT 
    co.id_comic,
    co.titulo,
    co.anio,
    co.precio,
    inv.cantidad_disponible,
    inv.disponibilidad
FROM 
    Comics co
LEFT JOIN 
    Inventario inv ON co.id_comic = inv.id_comic;


	--consulta de todos los comics,compras e inventario disponible
SELECT 
    co.id_comic,
    co.titulo,
    co.anio,
    co.precio,
    inv.cantidad_disponible,
    inv.disponibilidad,
    cc.id_compra,
    cc.cantidad AS cantidad_comprada
FROM 
    Comics co
LEFT JOIN 
    Inventario inv ON co.id_comic = inv.id_comic
LEFT JOIN 
    Comic_Compras cc ON co.id_comic = cc.id_comic;

	--consulta que muestre solo los clientes que compraron algo con su id
	SELECT 
    c.id_cliente,
    c.nombre AS nombre_cliente,
    com.id_compra,
    co.titulo AS nombre_comic,
    cc.cantidad AS cantidad_comprada,
    inv.cantidad_disponible
FROM 
    Clients c
JOIN 
    Compras com ON c.id_cliente = com.id_cliente
JOIN 
    Comic_Compras cc ON com.id_compra = cc.id_compra
JOIN 
    Comics co ON cc.id_comic = co.id_comic
LEFT JOIN 
    Inventario inv ON co.id_comic = inv.id_comic;
